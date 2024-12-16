application_name        = "my-application"                    # name that will be used when creating cloud resources
region                  = "us-east-1"                    # region to deploy resources to
notification_recipients = ["your.name@email.com.au"]          # email address for notifications

resource_tags = {
  local-tag = "local",                                        # environment specific tags added to all resources created
}

####### OAuth #######                                         # You will need to modify OAuth module if you would like to validate or authorize AAD users
aad_group_name         = "xxx"
tenant_id              = "xxx"
authorization_endpoint = "https://login.microsoftonline.com/xxx/oauth2/v2.0/authorize"
client_id              = "xxx"
client_secret          = "xxx"
issuer                 = "https://login.microsoftonline.com/xxx/v2.0"
token_endpoint         = "https://login.microsoftonline.com/xxx/oauth2/v2.0/token"
user_info_endpoint     = "https://graph.microsoft.com/oidc/userinfo"
