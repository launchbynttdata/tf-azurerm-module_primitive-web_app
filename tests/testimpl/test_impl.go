package testimpl

import (
	"context"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"testing"
	"time"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/appservice/armappservice"
	"github.com/gruntwork-io/terratest/modules/retry"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestWebApp(t *testing.T, ctx types.TestContext) {
	ctx.EnabledOnlyForTests(t, "complete_linux", "complete_windows")

	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	webAppHostname := terraform.Output(t, ctx.TerratestTerraformOptions(), "default_hostname")

	status := retry.DoWithRetry(t, "Check if the web app is up and running", 6, 10*time.Second, func() (string, error) {
		res, err := http.Get(fmt.Sprintf("https://%s", webAppHostname))
		if err != nil {
			return "", err
		}
		return strconv.FormatInt(int64(res.StatusCode), 10), nil
	})

	assert.Equal(t, "200", status)
}

func TestComposableWebApp(t *testing.T, ctx types.TestContext) {
	ctx.EnabledOnlyForTests(t, "complete_linux", "complete_windows")

	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Failed to get Azure credentials: %v", err)
	}

	webAppClient, err := armappservice.NewWebAppsClient(subscriptionId, cred, nil)
	if err != nil {
		t.Fatalf("Failed to create Azure Web App client: %v", err)
	}

	t.Run("TestDefaultHostName", func(t *testing.T) {
		defaultHostname := terraform.Output(t, ctx.TerratestTerraformOptions(), "default_hostname")
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		webAppName := terraform.Output(t, ctx.TerratestTerraformOptions(), "web_app_name")

		azureWebApp, err := webAppClient.Get(context.Background(), resourceGroupName, webAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Web App: %v", err)
		}
		assert.Equal(t, *azureWebApp.Properties.DefaultHostName, defaultHostname, "Expected Default hostname did not match actual Default hostname!")
	})

	t.Run("TestWebAppID", func(t *testing.T) {
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		webAppName := terraform.Output(t, ctx.TerratestTerraformOptions(), "web_app_name")
		webAppID := terraform.Output(t, ctx.TerratestTerraformOptions(), "web_app_id")

		azureWebApp, err := webAppClient.Get(context.Background(), resourceGroupName, webAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Web App: %v", err)
		}
		assert.Equal(t, *azureWebApp.ID, webAppID, "Expected ID did not match actual ID!")
	})
}
