# Manage Dotfiles On Unix-like

### Preface

This is a backup of my dotfiles(User Configuation). I am taking a try that manage them by git.

There are configurations for the followings now:

+ neovim: 0.6.0+ or nightly,
+ tmux 3.1a+,
+ bash 5.8+.

### Notice

#### vim or nvim?
The branch `master` keep support for nvim only. You could find common configuration for both vim and nvim in branch [`common_config_for_n_vim`](https://github.com/stark-zhang/dotfiles-on-unix-like/tree/common_config_for_n_vim), It used [coc.nvim](https://github.com/neoclide/coc.nvim) to as LSP clients and to provides more features beyond the vim8. In the new configuration, I used `nvim-lsp` as native LSP clients for higher performance.

#### if you are an user from Windows or macOS...

I cannot give a promise that all configuration could work well on all platforms. Test coverage is following:

Config | Neovim | Bash | Z-Shell | Tmux
:---: | :---: | :---: | :---: | :---:
Win | Y | N | N | N
Linux | Y | Y | Y | Y
macOS | N | N | N | N

*The configuration of Z-Shell is coming soon but I have no macOS to test. I think the configuration of nvim could work well on any unix-like system.*

*Linux Distros have been tested: CentOS 7.9, OpenSUSE Tumbleeweed, Ubuntu 20.04 LTS, RaspberryPi OS 11(raspberry Pi 4b)*

### Pre-requisites

You need to install pre-requisites before applying this configuration in you work environments.

+ Python 3.6+ for `.py` files, including shell helper and installer, which is coming soon.

+ Bash 5.8+ and Tmux 3.1a+ plus for Linux users, they should be avaliable in recent linux distros, or you could compile them manually.

+ Neovim 0.6.0+ or nightly for all platforms.

+ Git 2.18+ for all platforms.

#### Optional

You might need the optional pre-requisites for following:

+ Node.js 17.0+ for pyright(the language server for Python),
+ Gcc 7.2.0+ for cpp support,
+ [ccls(libclang-dev)](https://github.com/MaskRay/ccls) as c/c++ language servers,
+ cmake 3.18+ for something compilation.

### Usage, Customizationm Known Issues & Roadmap

Neovim: [README.md](nvim/README.md)

Others to be done soon.