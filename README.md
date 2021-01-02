# Manage Dotfiles On Unix-like

### Preface

This is a backup of my dotfiles(User Configuation). I am taking a try that manage them by git.

There are configurations for the followings now:

+ [VIM](https://github.com/vim/vim): The God of editors(8.2 and later)
+ [Tmux](https://github.com/tmux/tmux): The multiplexing tool for terminal(2.1 and later)
+ [Coc.nvim](https://github.com/neoclide/coc.nvim): The truely async plugin framework for VIM and NeoVIM

My target is to transplant the configurations between different distributions of Unix-like OS, such as Linux, MacOS X, BSD and etc. And I also will try to transplant it for VIM on MS Windows.

### Designs

The configuration for VIM has been designed to be modular for maintanance. And I'm trying to split the configuration of Tmux.

#### VIM Configuration

You can find all of following of this section in `./vimrc`. 

Firstly, the `vimrc.unix` is the real entry of this configuration. It provides you a VIM command `IncScript`, just like keyword `import` in Python. In this file, It imports `entry.vim`, which imports `basic.vim`, `keymap.vim`, and `plugs.vim`.

Ok, you got the architecture of VIM configuration. But how does the `IncScript` implement?

```vimscript
command! -nargs=1 IncScript exec 'so '.fnameescape(s:home."/<args>")
```

Then, there are some special variables in `entry.vim`. It declares that the path of VIM plugins must be in `$HOME/.vim/`. I use [vim-plug](https://github.com/junegunn/vim-plug) to manage my plugins and you can see familiar importations in-chain in `plugs.vim`.

#### Tmux Configration

None

#### Coc.nvim Configuration

None

### How to Use?

It's very simple.

1. Install the dependencies
	+ VIM 8.2+ and Tmux 2.1+ and Coc.nvim 0.077+
	+ Install [vim-plug](https://github.com/junegunn/vim-plug) to `$HOME/.vim/autoload`
	+ Install [Tmux Plugins Manager](https://github.com/tmux-plugins/tpm) to `$HOME/.tmux/plugins/tpm`
	+ Install Node.js 10.12+

2. Run the `install.sh`(debugging and will finished soon)

3. Apply the configurations
	+ for VIM, run `$ vim -c "PlugInstall!"` and using `CocInstall` to install coc plugins

	+ for Tmux, run `$ tmux` to go into Tmux, and press `<prefix> <S-I>` to install Tmux Plugins

<!-- EOF -->
