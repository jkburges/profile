# aliases
alias l='ls -laGF'
alias ll=l

alias trim="sed 's/^[[:space:]]*//;s/[[:space:]]*$//'"

alias latest_10='ll -rt | tail'

alias knife_ls_all='knife ssh 'name:imos-*' "ls -la"'
alias be='bundle exec'
alias ce='chef exec'

# Generally want to order by CPU usage.
alias top="top -o cpu"

alias json_format="jq -C | less -R"

source ${PROFILE_SRC_PATH}/.git_profile
source ${PROFILE_SRC_PATH}/.brew_profile
source ${PROFILE_SRC_PATH}/.ruby_profile

# shell variables
PS1="\u@\h:\w\[\033[31m\](\$(parse_git_branch))\[\033[00m\]$ "

export EDITOR=vi
export PATH=/usr/local/Cellar/mysql\@5.6/5.6.36_1/bin:/usr/local/Cellar/gnu-getopt/1.1.5/bin:/usr/local/Cellar/gnu-sed/4.2.2/bin:/usr/local/opt/coreutils/libexec/gnubin:${PATH}:/usr/local/apache-maven-2.2.1/bin:/usr/local/pgsql/bin:/Applications/grails-1.3.7/bin:/usr/local/mysql/bin:/Applications/groovy-1.8.1/bin:/Applications/phantomjs-1.9.7-macosx/bin:/Applications/packer:/Users/jkburges/Library/Python/3.6/bin:/Users/jkburges/Library/Python/3.9/bin
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

##
# Your previous /Users/jburgess/.profile file was backed up as /Users/jburgess/.profile.macports-saved_2010-09-06_at_09:47:37
##

# MacPorts Installer addition on 2010-09-06_at_09:47:37: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# Selenimum tests using chrome
export PATH=$PATH:"/Applications/Google Chrome.app/Contents/MacOS"

# See: http://tecparatodos.com/2011/07/24/installing-ruby-on-rails-on-mac-os-x-lion/
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

google() {
    open "http://www.google.com.au/search?q=$1"
}

rdp_renderer() {
    ssh -N -L 5986:$1:5986 -L 3389:$1:3389 ci-apps.biteable.com
}

mysql_forwarding() {
    ssh -N -L 3306:$1:3306 bakery.biteable.com
}

punch_firewall() {
    CIDR="`dig +short myip.opendns.com @resolver1.opendns.com`/32"
    aws ec2 authorize-security-group-ingress \
        --group-name ssh \
        --ip-permissions IpProtocol=tcp,FromPort=22,ToPort=22,IpRanges="[{CidrIp=${CIDR},Description=\"Ad-hoc SSH access for ${USER}\"}]"
    aws ec2 authorize-security-group-ingress \
        --group-name webapp_reporting \
        --ip-permissions IpProtocol=tcp,FromPort=5432,ToPort=5439,IpRanges="[{CidrIp=${CIDR},Description=\"Ad-hoc webapp reporting access for ${USER}\"}]"
}

mssh_connect() {
    IP_ADDRESS=`dig +short $1 | tail -n 1`
    INSTANCE_ID=`aws ec2 describe-instances --filter Name=ip-address,Values=${IP_ADDRESS} --query 'Reservations[].Instances[].[InstanceId]' --output text`

    shift
    mssh ubuntu@${INSTANCE_ID} "$@"
}

fetch_zymbols() {
    curl "$1" | jq -C ".zymbols | fromjson"
}

search_github() {
    open "https://github.com/search?q=$1"
}
alias sg="search_github"

export PATH=/Applications/terraform:$PATH

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

# AWS CLI command completion
complete -C '/usr/local/bin/aws_completer' aws
# complete -C '/usr/local/bin/aws2_completer' aws2
# alias aws=aws2

# docker command completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi

# heroku autocomplete setup
HEROKU_AC_BASH_SETUP_PATH=/Users/jkburges/Library/Caches/heroku/autocomplete/bash_setup && test -f $HEROKU_AC_BASH_SETUP_PATH && source $HEROKU_AC_BASH_SETUP_PATH;

export PATH=~/Library/Python/3.6/bin:/usr/local/bin:${PATH}

# go
export GOPATH=$HOME/go
export PATH=${PATH}:/usr/local/go/bin:${GOPATH}/bin

# Keep a lot of history.
export HISTSIZE="INFINITE"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Needed for GPG keychain to work
export GPG_TTY=$(tty)
