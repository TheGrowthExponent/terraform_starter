# terraform.auto.tfvars for shared module
# Only include variables required by shared infra (no secrets)
application_name     = "my-website"
environment          = "prod"
host_name            = "my-website.com"
cloudflare_api_token = "xxx" #"ww_rQ6L2r_eP4oJBgRiR1pglJrNwYd8C5mKYy_Hl"
cloudflare_zone_id   = "xxx"
ses_to_address       = "support@my-domain.com"
hubspot_app_token    = "pat-ap1-xxx"
