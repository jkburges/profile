# aliases
alias l='ls -laGF'
alias ll=l
alias postgres_restart='sudo -u postgres PGDATA=/usr/local/pgsql/data pg_ctl restart'

alias trim="sed 's/^[[:space:]]*//;s/[[:space:]]*$//'"

alias latest_10='ll -rt | tail'

alias knife_ls_all='knife ssh 'name:imos-*' "ls -la"'
alias be='bundle exec'
alias ce='chef exec'

# Generally want to order by CPU usage.
alias top="top -o cpu"

source ${PROFILE_SRC_PATH}/.git_profile
source ${PROFILE_SRC_PATH}/.java_profile
source ${PROFILE_SRC_PATH}/.brew_profile
source ${PROFILE_SRC_PATH}/.ruby_profile

# shell variables
PS1="\u@\h:\w\[\033[31m\](\$(parse_git_branch))\[\033[00m\]$ "

export EDITOR=vi
export PATH=/usr/local/Cellar/gnu-getopt/1.1.5/bin:/usr/local/Cellar/gnu-sed/4.2.2/bin:/usr/local/opt/coreutils/libexec/gnubin:${PATH}:/usr/local/apache-maven-2.2.1/bin:/usr/local/pgsql/bin:/Applications/grails-1.3.7/bin:/usr/local/mysql/bin:/Applications/groovy-1.8.1/bin:/Applications/phantomjs-1.9.7-macosx/bin:/Applications/packer

##
# Your previous /Users/jburgess/.profile file was backed up as /Users/jburgess/.profile.macports-saved_2010-09-06_at_09:47:37
##

# MacPorts Installer addition on 2010-09-06_at_09:47:37: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Selenimum tests using chrome
export PATH=$PATH:"/Applications/Google Chrome.app/Contents/MacOS"

source "/Users/jkburges/.gvm/bin/gvm-init.sh"

# See: http://tecparatodos.com/2011/07/24/installing-ruby-on-rails-on-mac-os-x-lion/
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

google() {
    open "http://www.google.com.au/search?q=$1"
}


export VAGRANT_USE_CACHER=true
export VAGRANT_MEMORY=2048
export VAGRANT_OS_KEYPAIR_NAME=nectar

export PATH=/Applications/Vagrant/bin:$PATH

## bash history db
#
# increase the history file size to 20,000 lines
export HISTSIZE=20000
# append all commands to the history file, don't overwrite it at the start of every new session
shopt -s histappend

# Add pip installed python scripts to path
export PATH=${PATH}:/usr/local/share/python

search_and_replace_recursive() {
    local search_term="$1"
    local replace_term="$2"

    echo "Replacing '${search_term}' with '${replace_term}'..."
    grep -l -R "${search_term}" * | xargs sed -E -i "" "s/${search_term}/${replace_term}/g"
    #grep  -R "${search_term}" *  # | xargs sed -E -i "" 's/${search_term}/${replace_term}/g'
}

pulls() {
    cd /Users/jkburges/git/utilities/github
    be lib/list_pulls.rb --short | sort
    cd -
}

# Climb dir hierarchy until .git is found (or to /).
cdrt() {
    `ls .git 2>&1 > /dev/null`
    local git_dir=$?
    while [[ git_dir != 0 && `pwd` != '/' ]]; do
        pwd
        cd ..
        `ls .git 2>&1 > /dev/null`
        git_dir=$?
    done
}

# npm binaries, e.g. phantom-jasmine
export PATH=/usr/local/share/npm/bin:$PATH


# Vagrant/virtual box aliases
alias vms='VBoxManage list vms -l | egrep "^Name:|^State:" | grep -v "Host path"'

# Git shortcuts
alias gc='git clone'

# Portal overrides
export WMS_SCANNER_URL="http://10.11.12.13/wmsscanner"
export WFS_SCANNER_URL="http://10.11.12.13/wfsscanner"
export DATA_SOURCE_URL="jdbc:postgresql://localhost:5432/portal_imos123"
export GOGODUCK_URL="http://gogoduck.aodn.org.au/gogoduck"

export PATH=/usr/local/bin:${PATH}

source $(brew --prefix nvm)/nvm.sh

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/jkburges/.gvm/bin/gvm-init.sh" ]] && source "/Users/jkburges/.gvm/bin/gvm-init.sh"
