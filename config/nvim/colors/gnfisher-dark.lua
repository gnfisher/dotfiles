local colorbuddy = require('colorbuddy')

-- Set up your custom colorscheme if you want
colorbuddy.colorscheme("gnfisher-dark")

-- And then modify as you like
local Color = colorbuddy.Color
local colors = colorbuddy.colors
local Group = colorbuddy.Group
local groups = colorbuddy.groups
local styles = colorbuddy.styles

Group.new("@lsp.type.method", colors.gray6, nil)
Group.new("@lsp.type.property", colors.gray6, nil)
Group.new("Special", colors.gray6, nil)
