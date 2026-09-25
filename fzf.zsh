# =========================================================
# fzf
# =========================================================

# ---------- UI ----------
export FZF_DEFAULT_OPTS='
  --height=60%
  --layout=reverse
  --border=rounded
  --prompt="  "
  --pointer="  "
  --preview-window=right:65%:wrap:border-left
'

# ---------- Preview ----------
export _FZF_PREVIEW_CMD='bat --color=always --style=plain,numbers --line-range=:500 {}'

# =========================================================
# Ctrl+R — command history
# =========================================================

bindkey -M viins '^R' fzf-history-widget
bindkey -M vicmd '^R' fzf-history-widget

# =========================================================
# Ctrl+D — directory picker
# =========================================================

_fzf_directory_widget() {
  local result

  result=$(fd \
    --type d \
    --hidden \
    --exclude .git \
    --exclude .cache \
    . "$HOME" 2>/dev/null |
    fzf)

  if [[ -n "$result" ]]; then
    LBUFFER+="$result"
  fi

  zle reset-prompt
}

zle -N _fzf_directory_widget

bindkey -M viins '^D' _fzf_directory_widget
bindkey -M vicmd '^D' _fzf_directory_widget

# =========================================================
# Ctrl+F — file picker
# =========================================================

_fzf_file_widget() {
  local result

  result=$(fd \
    --type f \
    --hidden \
    --exclude .git \
    . |
    fzf --preview "$_FZF_PREVIEW_CMD")

  if [[ -n "$result" ]]; then
    LBUFFER+="$result"
  fi

  zle reset-prompt
}

zle -N _fzf_file_widget

bindkey -M viins '^F' _fzf_file_widget
bindkey -M vicmd '^F' _fzf_file_widget

