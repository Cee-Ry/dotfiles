# .bashrc

# add .bash_aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
eval "$(ssh-agent -s)" > /dev/null

PS1='\[\e[32m\]\u@\[\e[0m\]\[\e[35m\]\w\[\e[0m\]:\n\[\e[32m\]>> \[\e[0m\]'
