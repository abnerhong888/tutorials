# 1. check health
```
:LazyHealth
```
# 2. optional setting
```
vim.g.autoformat = false

local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 4
```
# 3. install Extra plugins (x key to enable)
```
:LazyExtra ->
	lang.clangd -> for c++ auto clangd
	dap.core -> for debug adatper protocol
	lang.cmake -> for cmake usuage 'cmake-tools.vim'
restart nvim and wait till them installed
```
# 4. set keymaps
```
local map = vim.keymap

map.set("n", "<F5>", function() require("dap").continue() end, { desc = "Debug Continue" })
map.set("n", "<F6>", function() require("dap").step_over() end, { desc = "Debug Step Over" })
map.set("n", "<F7>", function() require("dap").step_into() end, { desc = "Debug Step Into" })
map.set("n", "<F8>", function() require("dap").step_out() end, { desc = "Debug Steo Out" })
```
# 5. set cmake build dir in order to clangd can find compile_commands.json
```
:CMakeSettings ->
comment -- old build_dir = "D:\\Desktop\\CmakeTestProject\\build\\${variant:buildType}",
build_dir = "D:\\Desktop\\CmakeTestProject\\build",

:CMakeSelectBuildType -> can change build type like debug, release, minSizeRel

:CMakeGenerate! -G MinGW\ Makefiles -> use minge-c++ to build
```