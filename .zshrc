# Zsh Autocompletion
# ------------------
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# History Configuration
# ---------------------
HISTFILE="${HOME}/.zsh-history"
HISTSIZE=500000
SAVEHIST=500000
setopt appendhistory
setopt INC_APPEND_HISTORY  
setopt SHARE_HISTORY

export APPLIED2_PATH="$HOME/applied2/applied2"
export PATH=$PATH:$APPLIED2_PATH/tools/scripts/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/home/yoavshmariahu/.local/bin

# Useful Aliases
# --------------
alias awslogin="$APPLIED2_PATH/tools/scripts/bin/awslogin"
alias kc="$APPLIED2_PATH/tools/scripts/bin/kc"
alias kce="$APPLIED2_PATH/tools/scripts/bin/kce"
alias kcl="$APPLIED2_PATH/tools/scripts/bin/kcl"
alias kc_get_pod="$APPLIED2_PATH/tools/scripts/bin/kc_get_pod"
alias ddr="$APPLIED2_PATH/dev/containers/dev/remove.sh"
alias dds="$APPLIED2_PATH/dev/containers/dev/start.sh"
alias ddi="$APPLIED2_PATH/dev/containers/dev/into.sh"
alias login="$APPLIED2_PATH/tools/scripts/provider_login.sh"
alias pretty="python3 -m json.tool"

ddrsi() {
    ddr && dds && ddi
}
assume() {
    read -d '' AWS_CREDENTIALS
    export AWS_ACCESS_KEY_ID=$(echo "${AWS_CREDENTIALS}" | jq -r .Credentials.AccessKeyId)
    export AWS_SECRET_ACCESS_KEY=$(echo "${AWS_CREDENTIALS}" | jq -r .Credentials.SecretAccessKey)
    export AWS_SESSION_TOKEN=$(echo "${AWS_CREDENTIALS}" | jq -r .Credentials.SessionToken)
}

kfg() {
    desc="Lightweight CLI tool to manage kubectl configs outside of dev docker"

    kube_config_prefix="/media/syndual/cloud_public/config/kubeconfig_"
    if [ $# -eq 0 ]; then
	env_name=${KUBECONFIG#s}
	echo "Current Kubectl config: ${env_name}"
	return
    fi
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	echo $desc
	echo "\nkfg Usage\n---------"
	echo " $ kfg [no args]: show current configuration"
	echo " $ kfg <config-name>: set kubectl context to config-name. e.g. kfg simian-example-infra-1-aws"
	echo " $ kfg list <config-name-prefix>: show available configs by the given prefix"
	return
    fi
    if [[ $# -eq 2 && "${1}" == "list" ]]; then
	find /media/syndual/cloud_public/config/ -name "kubeconfig_${2}*" | cut -c 47-
	return
    fi
    config_file="${kube_config_prefix}${1}"
    if [ ! -f "$config_file" ]; then
	echo "ERROR: could not find config file for context ${1}"
	echo "File Not Found: ${config_file}"
	return
    fi
    export KUBECONFIG="${config_file}"
}

# GCP CLI Auth Configs
# --------------------

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/lib/google-cloud-sdk/path.zsh.inc' ]; then . '/usr/lib/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/lib/google-cloud-sdk/completion.zsh.inc' ]; then . '/usr/lib/google-cloud-sdk/completion.zsh.inc'; fi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Shell Prompt
PROMPT='%(?.%F{blue}.%F{red}%? )[%T %W] $ %f'

# Go Configs
# ----------
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOBIN

# Power10k Setup
# --------------

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
