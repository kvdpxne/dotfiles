# ~/.zshrc

# =============================================================================
#  HISTORIA I BEZPIECZEŃSTWO
# =============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

# Ogólne opcje historii
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE        # Nie zapisuj poleceń poprzedzonych spacją
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS

# Bezpieczeństwo edytora linii (ochrona przed paste injection)
# setopt zle_bracketed_paste

# =============================================================================
#  BEZPIECZNE ŁADOWANIE SEKRETÓW
# =============================================================================
if [[ -f ~/.config/zsh-secrets.sh ]]; then
  source ~/.config/zsh-secrets.sh
fi

# =============================================================================
#  QT THEME
# =============================================================================
[ -f ~/.config/qt-theme.sh ] && source ~/.config/qt-theme.sh

# =============================================================================
#  PROMPT
# =============================================================================
setopt PROMPT_SUBST

function limited_path() {
  local pwd="${PWD/#$HOME/~}"
  if (( ${#pwd} > 30 )); then
    echo "...${pwd[-27]}"
  else
    echo "$pwd"
  fi
}

WHITE_FG=$'\e[38;2;255;255;255m'
RED_FG=$'\e[38;2;220;20;60m'
RESET=$'\e[0m'

precmd() {
  if [[ $EUID -eq 0 ]]; then
    PS1="%F{red}root%f@%m %F{blue}$(limited_path)%f "
  else
    PS1="${WHITE_FG}%n${RED_FG}@${WHITE_FG}%m${RESET} %F{blue}$(limited_path)%f "
  fi
}

# =============================================================================
#  LAZY LOADING DLA NVM (znacznie szybszy start powłoki)
# =============================================================================
export NVM_DIR="$HOME/.nvm"

load_nvm() {
  [ -s "/usr/share/nvm/init-nvm.sh" ] && \. "/usr/share/nvm/init-nvm.sh"
  unset -f nvm node npm
}

nvm()  { load_nvm; nvm "$@"; }
node() { load_nvm; node "$@"; }
npm()  { load_nvm; npm "$@"; }

# =============================================================================
#  UZUPEŁNIENIA (compinit) – z buforowaniem dla wydajności
# =============================================================================
# Dodaj katalog z zsh-completions do fpath (Arch Linux)
fpath=(/usr/share/zsh/plugins/zsh-completions $fpath)

autoload -Uz compinit

# Sprawdź, czy plik cache istnieje i jest młodszy niż 24 godziny
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit -C   # Pomiń sprawdzanie bezpieczeństwa, jeśli cache jest świeży
else
  compinit      # Pełne sprawdzenie, jeśli cache jest stary lub go nie ma
fi

# =============================================================================
#  WTYCZKI (source na końcu, aby nie zakłócać compinit)
# =============================================================================
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# =============================================================================
#  FUNKCJE DO ZARZĄDZANIA USŁUGAMI (zamiast aliasów)
# =============================================================================
pg() {
  case "$1" in
    start)   sudo systemctl start postgresql ;;
    stop)    sudo systemctl stop postgresql ;;
    status)  systemctl status postgresql ;;
    *)       echo "Użycie: pg {start|stop|status}" ;;
  esac
}
