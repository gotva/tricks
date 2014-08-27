# place this file ~/.oh-my-zsh/theme

# load some modules
autoload -U colors zsh/terminfo # Used in the colour alias below
colors
setopt prompt_subst

# check if user is root
if test "$(id -u)" = "0"; then
  local user='%{$fg[red]%}%n%{$reset_color%}'     #root
else
  local user='%{$fg[yellow]%}%n%{$reset_color%}'
fi

# check if we are on SSH or not
if [[ -n '$SSH_CLIENT' || -n '$SSH2_CLIENT' ]]; then
  local host='%{$fg[blue]%}%M%{$reset_color%}'    #SSH
else
  local host='%{$fg[yellow]%}%M%{$reset_color%}'
fi

# version of ruby
local ruby=''
if which rvm-prompt &> /dev/null; then
  ruby='[%{$fg[red]%}$(rvm current 2>/dev/null)%{$reset_color%}]'
  # ruby='[%{$fg[red]%}$(rvm-prompt i v g s)%{$reset_color%}]'
else
  if which rbenv &> /dev/null; then
    ruby='[%{$fg[red]%}$(rbenv version | sed -e "s/ (set.*$//")%{$reset_color%}]'
    # ruby='[%{$fg[red]%}$(rbenv version-name 2>/dev/null)%{$reset_color%}]'
  fi
fi

# git
local git='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="[%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}]"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[magenta]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg_bold[yellow]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%} ●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%} ●%{$reset_color%}"

local current_dir='%{$fg[green]%}%~%{$reset_color%}'
local return_code="%(?..%{$fg[red]%}%?%{$reset_color%})"
local clock='%{$fg[cyan]%}%*%{$reset_color%}'

PROMPT="┌─[${user}][${host}]${ruby}${git}[${current_dir}]
└──╼ "

RPROMPT="${return_code} [${clock}]"

# for clock reset prompt every $TMOUT seconds
#TMOUT=1
#TRAPALRM () {
#    zle reset-prompt
#}
