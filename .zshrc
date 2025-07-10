# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(aws docker docker-compose git terraform)

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='code'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
alias ll="ls -la"

# Renderer
export CHROME_PATH="/Users/jkburges/chrome/mac_arm-124.0.6358.0/chrome-mac-arm64/Google Chrome for Testing.app/Contents/MacOS/Google Chrome for Testing"
export FONT_HOST_RENDERER="https://us-east-1-biteable-assets.s3.amazonaws.com"

punch_firewall() {
  aws ec2 authorize-security-group-ingress --group-name redshift_warehouse \
  --protocol tcp --port 5439 \
  --cidr `curl -s https://ipv4.icanhazip.com`/32

  aws ec2 authorize-security-group-ingress --group-name webapp_reporting \
  --protocol tcp --port 5432 \
  --cidr `curl -s https://ipv4.icanhazip.com`/32

  aws ec2 authorize-security-group-ingress --group-name ssh \
  --protocol tcp --port 22 \
  --cidr `curl -s https://ipv4.icanhazip.com`/32
}

aws_credentials() {
  unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
  aws sts get-caller-identity --no-cli-pager > /dev/null || aws sso login
  $(aws sso get-role-credentials --role-name `aws configure get sso_role_name` \
    --account-id `aws configure get sso_account_id` \
    --access-token `cat ~/.aws/sso/cache/$(aws configure get sso_start_url \
    | tr -d '\n' | shasum  | awk '{ print $1 }').json | jq -r '.accessToken'` \
    | jq -r '.roleCredentials | {AWS_ACCESS_KEY_ID:.accessKeyId, AWS_SECRET_ACCESS_KEY:.secretAccessKey, AWS_SESSION_TOKEN:.sessionToken} | keys[] as $k | "export \($k)=\(.[$k])"')
    aws sts get-caller-identity --no-cli-pager
}

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Turn off the annoying AWS CLI pager
export AWS_PAGER=""

# Python stuff for EB CLI
eval "$(pyenv init -)"
export PATH=${HOME}/.local/bin:${PATH}
export PATH="/Users/jkburges/.ebcli-virtual-env/executables:$PATH"

# node
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export GH_PAGER=
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

export GOPATH=${HOME}/go


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/opt/homebrew/opt/ffmpeg@6/bin:$PATH"
