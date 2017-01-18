# .dotfiles

## Installation
1. clone this repo into your home directory
2. run 'bash install_script.sh'
3. set zsh as your default shell (chsh -s /bin/zsh)
4. set Meslo LG L for Powerline as your terminal font (I use 13/14pt)
5. open Vim, then run the command :PlugInstall
6. restart terminal

## Shortcuts
* tt - toggle a file tree buffer in the left pane
* gb - open a buffer listing a quick menu to hop to open buffers
* cm - comment/uncomment current line
* mm - comment/uncomment current line or block in visual mode
* st - toggle linter mode between active and passive. Active - check on file open and
  save, Passive, run only when told.
* sr - run a linter check on your code
* se - open up a buffer listing errors that the linter has found; will be empty if no
  errors
* sc - close the error buffer
* ctrl-p - open fuzzy finder, allows for searching for and opening files under your
  current file tree.
* cr - refresh the fuzzy finder to reflect latest changes in file structure and file
  names.
* ctrl-l - turn off search highlighting and redraw screen; equivalent to :noh
* ,w - save the current file



###Thanks to the following for plugin, colorscheme and syntax:
* junegunn - https://github.com/junegunn
  * vim-plug
* bling - https://github.com/bling
  * vim airline
* davidhalter - https://github.com/davidhalter
  * jedi vim
* valloric - https://github.com/valloric
  * youcompleteme
* vim-scripts - https://github.com/vim-scripts
  * a.vim
* scrooloose - https://github.com/scrooloose
  * nerdcommenter
  * nerdtree
  * syntastic
* jistr - https://github.com/jistr
  * vim-nerdtree-tabs
* xolox - https://github.com/xolox
  * vim-notes
  * vim-misc
* airblade - https://github.com/airblade
  * vim-gitgutter
* octol - https://github.com/octol
  * vim-cpp-enhanced-highlight
* wincent - https://github.com/wincent
  * terminus
* majutsushi - https://github.com/majutsushi
  * tagbar
* kien - https://github.com/kien
  * ctrlp.vim
* ivalkeen - https://github.com/ivalkeen
  * vim-ctrlp-tjump
* jeffkreeftmeijer - https://github.com/jeffkreeftmeijer
  * vim numbertoggle
* pfdevilliers - https://github.com/pfdevilliers
  * Pretty Vim Python
  
#### Special Thanks to alxyang - https://github.com/alxyang for letting me use his files as templates and for helping me get set up.
