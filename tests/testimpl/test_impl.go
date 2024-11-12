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

func TestFunctionApp(t *testing.T, ctx types.TestContext) {
	ctx.EnabledOnlyForTests(t, "complete", "windows_func_app")

	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	functionAppHostname := terraform.Output(t, ctx.TerratestTerraformOptions(), "default_hostname")

	status := retry.DoWithRetry(t, "Check if the function app is up and running", 6, 10*time.Second, func() (string, error) {
		res, err := http.Get(fmt.Sprintf("https://%s", functionAppHostname))
		return strconv.FormatInt(int64(res.StatusCode), 10), err
	})

	assert.Equal(t, "200", status)
}

func TestComposablePrivateFuncApp(t *testing.T, ctx types.TestContext) {
	ctx.EnabledOnlyForTests(t, "private_func_app")

	subscriptionId := os.Getenv("ARM_SUBSCRIPTION_ID")
	if len(subscriptionId) == 0 {
		t.Fatal("ARM_SUBSCRIPTION_ID environment variable is not set")
	}

	cred, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Failed to get Azure credentials: %v", err)
	}

	funcAppClient, err := armappservice.NewWebAppsClient(subscriptionId, cred, nil)
	if err != nil {
		t.Fatalf("Failed to create Azure Function App client: %v", err)
	}

	t.Run("TestDefaultHostName", func(t *testing.T) {
		defaultHostname := terraform.Output(t, ctx.TerratestTerraformOptions(), "default_hostname")
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		funcAppName := terraform.Output(t, ctx.TerratestTerraformOptions(), "function_app_name")

		azureFuncApp, err := funcAppClient.Get(context.Background(), resourceGroupName, funcAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Function App: %v", err)
		}
		assert.Equal(t, *azureFuncApp.Properties.DefaultHostName, defaultHostname, "Expected Default hostname did not match actual Default hostname!")
	})

	t.Run("TestFunctionAppID", func(t *testing.T) {

		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		funcAppName := terraform.Output(t, ctx.TerratestTerraformOptions(), "function_app_name")
		functionAppID := terraform.Output(t, ctx.TerratestTerraformOptions(), "function_app_id")

		azureFuncApp, err := funcAppClient.Get(context.Background(), resourceGroupName, funcAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Function App: %v", err)
		}
		assert.Equal(t, *azureFuncApp.ID, functionAppID, "Expected ID did not match actual ID!")
	})

	t.Run("TestFuncAppUrl", func(t *testing.T) {
		funcAppUrl := terraform.Output(t, ctx.TerratestTerraformOptions(), "function_app_url")
		resourceGroupName := terraform.Output(t, ctx.TerratestTerraformOptions(), "resource_group_name")
		funcAppName := terraform.Output(t, ctx.TerratestTerraformOptions(), "function_app_name")

		azureFuncApp, err := funcAppClient.Get(context.Background(), resourceGroupName, funcAppName, nil)
		if err != nil {
			t.Fatalf("Failed to get Azure Function App: %v", err)
		}
		assert.Equal(t, *azureFuncApp.Properties.HostNameSSLStates[0].Name, funcAppUrl, "Expected URL did not match actual URL!")
	})

}
