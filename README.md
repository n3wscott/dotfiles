# dotfiles
.vimrc, .bashrc, .aliases, etc...

I symlink most of these fils into `~` from this directory:

```bash
ln -s .profile ~/
ln -s .tm_properties ~/
ln -s .vimrc ~/

```

I use the prompt part by adding the following to `~/.profile`:

```bash

PS1_COLOR=82
PS1_SYM_OK="(╯°□°)╯︵ "
PS1_SYM_ERR="¯\(°_o)/¯"

source ~/dotfiles/.bash_ps1

```

