resource "cloudflare_bot_management" "bot_management" {
  zone_id            = var.cloudflare_zone_id
  auto_update_model  = true
  ai_bots_protection = "block"
  crawler_protection = "enabled"
  enable_js          = true
  fight_mode         = true
}

resource "cloudflare_ruleset" "cache_html" {
  zone_id = var.cloudflare_zone_id
  name    = "Cache default file extensions"
  kind    = "zone"
  phase   = "http_request_cache_settings"
  rules = [
    {
      action     = "set_cache_settings"
      expression = "(http.request.uri.path.extension in {\"7z\" \"avi\" \"avif\" \"apk\" \"bin\" \"bmp\" \"bz2\" \"class\" \"css\" \"csv\" \"doc\" \"docx\" \"dmg\" \"ejs\" \"eot\" \"eps\" \"exe\" \"flac\" \"gif\" \"gz\" \"ico\" \"iso\" \"jar\" \"jpg\" \"jpeg\" \"js\" \"mid\" \"midi\" \"mkv\" \"mp3\" \"mp4\" \"ogg\" \"otf\" \"pdf\" \"pict\" \"pls\" \"png\" \"ppt\" \"pptx\" \"ps\" \"rar\" \"svg\" \"svgz\" \"swf\" \"tar\" \"tif\" \"tiff\" \"ttf\" \"webm\" \"webp\" \"woff\" \"woff2\" \"xls\" \"xlsx\" \"zip\" \"zst\"})"
      action_parameters = {
        cache = true
      }
    }
  ]
}
