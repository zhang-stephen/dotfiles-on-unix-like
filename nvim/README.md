# Modern Configuration for Neovim 0.6.0+

*Click [here](https://blogs.stephen-zhang.cn/post/515df42a/) for documents in `zh_CN`.*

### Preface

This is a modern configuration for neovim only. You could find the common configuration for nvim 0.5.0+ and vim 8.2+ in this [branch](), which is maintained but no new features, if you have to use vim 8.2+.

The common configuration uses the [coc.nvim](https://github.com/neoclide/coc.nvim) as the bridge for cilents/servers of LSP(language server protocol), but this configuration uses the native nvim-lsp as the infrastructure for syntax-based completion, LSPs and other awesome features. The new one has better performance, better extendibility, and more readable code, it wrote by pure lua with APIs of neovim.

It configured for terminal-only and no plans to support the GUI front-end such as neovide or neovim-qt. The terminal I tested is [Windows terminal](https://github.com/microsoft/terminal). And I cannot give any promise if you want to use it on MS Windows and welcome PRs for these problem.

### Usage

Programming Language supported in this configuration:

+ `c`, `cpp`, `objective-c`, `objective-c++`
+ `make`, `cmake`
+ `bash`
+ `python3`, `lua`, `vimL`
+ `json`, `xml`, `toml`, `yaml`
+ `rust`(not ready)

#### Pre-requisites

What you need to make this configuration work is following:

+ neovim 0.6.0+ or nightly build,
+ git 2.18+,
+ cmake 3.18+,
+ Gcc 9.2.0 or later(for compilation of [ccls](https://github.com/MaskRay/ccls) and nvim-treesitter parsers),
+ Node.js 17.0+(for [pyright](https://github.com/microsoft/pyright)),
+ [Nerd Fonts](https://www.nerdfonts.com/) for terminal display(I prefer `FiraCode NF`).

#### Installation

Clone this repo and make symbolic link of `nvim/` to `~/.config/nvim`, e.g.:

```shell
$ git clone https://github.com/stark-zhang/dotfiles-on-unix-like.git --depth 1
$ ln -sf /absolute/path/to/dotfiles-on-unix-like/nvim ~/.config/nvim
```

All extensions, includes LSP servers managed by `nvim-lspinstaller` and parsers of `nvim-treesitter` should be installed automatically to `~/.local/share/nvim/`.

OK, just open your neovim and enjoy it！

#### Gallery

The statistic of startup time:

![StartUp Time](https://pics.stephen-zhang.cn/img/neovim/startupTime.png)

The Dashboard(powered by `alpha.nvim`):

![alpha-dashboard](https://pics.stephen-zhang.cn/img/neovim/dashboard.png)

Recent Files(powered by `telescope`):

![Recent Files](https://pics.stephen-zhang.cn/img/neovim/history.png)

LSP preview definition(powered by `lspsaga` & `ccls`), you could also find git information on status line and in virtual text:

![LSP preview](https://pics.stephen-zhang.cn/img/neovim/lsp_preview.png)

Outline View:

![LSP outline](https://pics.stephen-zhang.cn/img/neovim/outline.png)

And more features could be discovered by yourself!

*use [libuv](https://github.com/libuv/libuv) for demostration.*

### Customization

#### Basic Options

You could find all basic options of nvim in `lua/core/options.lua` and modify them.

#### Keymap

Use `<space>` as the `<leader>`.

Keymaps are put in 2 lua tables, `keymap.builtin` and `keymap.plugins`, in `lua/core/keymap.lua`, and are binded by library `lua/utility/keybinding`. There also are some keymaps in configurations of plugins, they are strong-correlated with the options of plugins.

#### Plugins

Use [packer.nvim](https://github.com/wbthomason/packer.nvim) as the default plugin manager and lazy-loader generators, the generated lazy-loader configuation would be put in `~/.local/share/nvim/site/lua/_compiled.lua`. You'd better remove it before change the options of plugins.

I devided all plugins into several categories: `ui` , `editor`, `lsp` and `tools`.

*This part will be completed soon*.

#### utility/logger

There is a simple implementation of logger, would help debugging.

### Known Issues

If someone used this configuration, welcome PR and issues.

+ The *italic* font displays wired on Windows Terminal with `FiraCode NF`,
+ The *italic* font not worked in tmux, if `$TERM=xterm-256color`,
+ The behaviour of extension `indent-blank.nvim` is not expected,
+ The behaviour of `utility.logger` is not expected in some situations,
+ `acclerated-jk` and `vim-eft` not worked for now.

### Roadmap

- [ ] add support for `rust`,
- [ ] format all code in lua,
- [ ] adjust the configuation of extension `indent-blank.nvim`,
- [ ] improve the logger,
- [ ] lazy-loader optimization,
- [ ] write a tool to analyze the lazy-load configuration of packer.nvim.

### References

Inspired by [ayamir/nvimdots](https://github.com/ayamir/nvimdots), used some code directly of it. I am very grateful to ayamir.
