# Black magic related to xterm and colors
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color'
elif [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

# We have color support; assume it's compliant with Ecma-48
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  color_prompt=yes
else
  color_prompt=no
fi

export CLICOLOR=1;
export LSCOLORS=ExFxCxDxBxegedabagacad;

################################################################################

# https://gist.github.com/778558
__git_ps1 () {
  local branch="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$branch" ]; then
    printf "%s" "${branch##refs/heads/}";
  fi
}

# Thanks to mohnish => twitter: @arrowgunz
function git_dirty_status() {
  if [ -n "$(__gitdir)" ]; then
    local dirty_status=$(git status --porcelain 2>/dev/null| wc -l)
    if test $dirty_status -gt 0; then
      echo "▶"
    else
      echo "▷"
    fi
  else
    echo ""
  fi
}

# http://tinyurl.com/4q6zehb, https://gist.github.com/778558
function git_branch {
  if [ -n "$(__gitdir)" ]; then
    git_branch=`__git_ps1 "%s"`
    echo "[${git_branch}]"
  else
    echo ""
  fi
}

function git_info {
  if [ -n "$(__gitdir)" ]; then
    git_branch=`__git_ps1 "%s"`

    local last_commit=$(time_ago `git log --pretty=format:'%at' -1 2>/dev/null;`);
    local last_mine=$(time_ago `git mine --pretty=format:'%at' -1 2>/dev/null;`);
    echo "${git_branch}: ${last_commit}/${last_mine}";
  fi
}

################################################################################
# Note: don't mess with other users promts. Don't use export PS1
# http://tinyurl.com/4kzgb7k

#  Negro       0;30     Gris Obscuro  1;30
#  Azul        0;34     Azul Claro    1;34
#  Verde       0;32     Verde Claro   1;32
#  Cyan        0;36     Cyan Claro    1;36
#  Rojo        0;31     Rojo Claro    1;31
#  Purpura     0;35     Fiuscha       1;35
#  Café        0;33     Amarillo      1;33
#  Gris Claro  0;37     Blanco        1;37

if [ "$color_prompt" = yes ]; then
  title='\e]0;\W :$(git config user.name)\a\n'
  line1='\[\e[1;34m\]\u:\[\e[1;36m\]\w'
  line2='\[\e[1;33m\]$(git_branch)\[\e[0;35m\]$(git_dirty_status)'
  line3='\[\e[1;37m\]\$ \[\e[1;00m\]'

  PS1="${title}${line1}${line2}${line3}"
else
  title='\e]0;\W :$(git config user.name)\a'
  line1='\u:\w'
  line2='$(git_branch)$(git_dirty_status)'
  line3='\$ '

  PS1="${title}${line1}${line2}${line3}"
fi

unset color_prompt
