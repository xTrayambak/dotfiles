local settings = require("settings")
local downloads = require("downloads")
local lousy = require("lousy")
local adblock = require("adblock")

-- Search engine
local engines   = settings.window.search_engines
engines.brave   = "https://search.brave.com/search?q=%s&source=web"
engines.nix     = "https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=%s"
engines.default = engines.brave

-- Downloads configuration
downloads.default_dir = os.getenv("HOME") .. "/Downloads"
