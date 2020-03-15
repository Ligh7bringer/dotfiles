# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/sgeor/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SYMBOL="λ "
SPACESHIP_USER_SHOW=always
# POWERLEVEL9K_DISABLE_RPROMPT=true
# POWERLEVEL9K_PROMPT_ON_NEWLINE=true
# POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="λ "
# POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
# POWERLEVEL9K_VIRTUALENV_BACKGROUND=107
# POWERLEVEL9K_VIRTUALENV_FOREGROUND='white'
# POWERLEVEL9K_MODE="nerdfont-complete"

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  notify
  virtualenv
  zsh-256color
  colorize
  #globalias
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Aliases
alias zshconfig="subl ~/.zshrc"
alias ohmyzsh="subl ~/.oh-my-zsh"
alias zshsrc="source ~/.zshrc"
alias vmk="virtualenv .venv"
alias vact="source .venv/bin/activate"
alias dact="deactivate"
alias lc='colorls -l --sd'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias pacup="sudo pacman -Syu"
alias pacr="sudo pacman -R"
alias paci="sudo pacman -S"
alias nvr="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias vkr="__NV_PRIME_RENDER_OFFLOAD=1"
alias ff="find . -name $1"
alias nvcc="/opt/cuda/bin/nvcc"
alias cudadbg="CUDNN_LOGINFO_DBG=1 CUDNN_LOGDEST_DBG=stderr"

# Functions
function up {
  num=$1
  if [ -z "$num" ]
  then
    num=1
  fi
  while [ $num -ne 0  ];do
    cd ..
    num=$((num-1))
  done
}

function fontinstall {
  # copy fonts
  for var in "$@"
  do
    cp $var ~/.local/share/fonts
    ls ~/.local/share/fonts | grep -i $var
  done
  # update font cache
  fc-cache -fv
}

function mkcd {
	mkdir $1
	cd $1
}

ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# PATH
export PATH="$PATH:/home/sgeor/.local/bin"
export PATH="$PATH:/home/sgeor/.gem/ruby/2.6.0/bin"
export PATH="$PATH:/home/sgeor/bin/"
export PATH="/home/sgeor/.cache/yay/bcompare/src/install/bin:$PATH"
export PATH="/home/sgeor/.local/lib/python3.7/site-packages/:$PATH"

export ComputeCpp_DIR="/home/sgeor/computecpp"
export ComputeCpp_INCLUDE_DIRS="$ComputeCpp_DIR/include"
export PAGER="most"

source $(dirname $(gem which colorls))/tab_complete.sh

# notify when commands finish
source ~/.oh-my-zsh/custom/plugins/notify/notify.plugin.zsh
zstyle ':notify:*' error-title "Command failed in #{time_elapsed} seconds"
zstyle ':notify:*' success-title "Command finished in #{time_elapsed} seconds"
zstyle ':notify:*' error-icon "~/Pictures/thumbs_down.png"
zstyle ':notify:*' success-icon "~/Pictures/thumbs_up.png"

# Programs to run when terminal is started
# neofetch | lolcat

# added by travis gem
[ -f /home/sgeor/.travis/travis.sh ] && source /home/sgeor/.travis/travis.sh

export SYCL_HOME="/home/sgeor/sycl_workspace/"