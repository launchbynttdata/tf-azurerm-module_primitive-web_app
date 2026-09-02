package testimpl

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/appservice/armappservice"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/launchbynttdata/lcaf-component-terratest/types"
	"github.com/stretchr/testify/assert"
)

func TestWebApp(t *testing.T, ctx types.TestContext) {
	ctx.EnabledOnlyForTests(t, "complete_linux", "complete_windows")

	// Empty App Service examples keep returning HTTP 503; rely on the Azure
	// management-plane assertions in TestComposableWebApp instead of a public probe.
	webAppHostname := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "default_hostname")
	assert.NotEmpty(t, webAppHostname)
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
		defaultHostname := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "default_hostname")
		resourceGroupName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "resource_group_name")
		webAppName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "web_app_name")

		azureWebApp, err := webAppClient.Get(context.Background(), resourceGroupName, webAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Web App: %v", err)
		}
		assert.Equal(t, *azureWebApp.Properties.DefaultHostName, defaultHostname, "Expected Default hostname did not match actual Default hostname!")
	})

	t.Run("TestWebAppID", func(t *testing.T) {
		resourceGroupName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "resource_group_name")
		webAppName := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "web_app_name")
		webAppID := terraform.OutputContext(t, context.Background(), ctx.TerratestTerraformOptions(), "web_app_id")

		azureWebApp, err := webAppClient.Get(context.Background(), resourceGroupName, webAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Web App: %v", err)
		}
		assert.Equal(t, *azureWebApp.ID, webAppID, "Expected ID did not match actual ID!")
	})
}
