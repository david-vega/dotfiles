# Utils
###############################################################################
alias work='clear; cd ~/projects;'
###############################################################################

alias cls='clear; ls;'
alias create='touch'
alias exot='exit'
alias find_text='grep -Rin --color'
alias find_usages='grep -ien --color'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias reload='source ~/.bash_profile'

# Ruby
alias be='bundle exec'
alias bi='bundle install'
alias bu='bundle update'
alias braca='bundle exec rake assets:compile:all'
alias cuke="be cucumber -rfeatures -fprogress"
alias pow_log='tail -f ~/Library/Logs/Pow/access.log'
alias pow_restart='echo "Restarting pow..."; touch tmp/restart.txt'
alias reboot_db_mg='bundle exec rake db:drop:all db:create:all db:migrate db:test:prepare'
alias reboot_db_sl='bundle exec rake db:drop:all db:create:all db:schema:load db:test:prepare'
alias run_specs='bundle exec rspec —-color --format Fivemat'

# Git
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '

# Rails
alias r='rails'
alias rails_log='tail -f ./log/development.log | grep --invert-match DEBUG'
alias rails_test_log='tail -f ./log/test.log | grep --invert-match DEBUG'

# Rails 2 & 3 functions
# http://tinyurl.com/4j83zdv
# http://tinyurl.com/2dq9pkv
function sc {
  if [ -x script/console ]; then
    script/console
  else
    rake console
  fi
}

function sdbc {
  if [ -x script/dbconsole ]; then
    script/dbconsole
  else
    rake dbconsole
  fi
}

sg () {
  if [ -f ./script/rails ]; then
    rails g $@
  else
    ./script/generate $@
  fi
}

ss () {
  if [ -f ./script/rails ]; then
    rails s $@
  else
    ./script/server $@
  fi
}
