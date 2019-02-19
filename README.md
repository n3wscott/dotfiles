# dotfiles
.vimrc, .bashrc, .aliases, etc...

I symlink most of these fils into `~`.

I use the prompt part by adding the following to `~/.profile`:

```bash

PS1_COLOR=82
PS1_SYM_OK="(╯°□°)╯︵"
PS1_SYM_ERR="   ಠ_ಠ   "

source ~/dotfiles/.bash_ps1

```