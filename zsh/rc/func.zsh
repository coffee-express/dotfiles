# Buffer operation helper

ignore-history() {
  BUFFER=" ${BUFFER}"
  CURSOR+=1
}

insert-buffer() {
  local arg
  arg="$1"
  RBUFFER="${arg}${RBUFFER}"
  CURSOR+=${#arg}
}

replace-buffer(){
  BUFFER="$1"
  CURSOR+=$#BUFFER
}


# Fuzzy finder

ff() {
  eval "${FF_CMD} ${FF_OPTIONS}"
}

ff-select-repo() {
  ghq list | ff |
	xargs -r -I{} echo "$(ghq root)/"{}
}

ff-branch-name() {
  git branch -a | ff | tail -c +3
}

ff-find-file() {
  local d="${1//~/$HOME}"
  find "${d}" 2>/dev/null |
	sed -e "s:^${d}/\?:/:" |
	ff |
	xargs -r -I{} echo "${d}"{}
}


# cli

gitroot() {
  git rev-parse --show-toplevel
}

cdroot() {
  cd "$(gitroot)" || exit
}

fsh() {
  grep ~/.ssh/config -i -e '^host' |
	sed -e 's/host //i' \
		-e '/*/d' |
	ff |
	xargs -r ssh
}

fsql() {
  sed -E 's/:[^:]+$//' ~/.pgpass | ff |
	sed -e 's/^/-h /' \
		-e 's/:/ -p /' \
		-e 's/:/ -d /' \
		-e 's/:/ -U /' |
	xarg -r psql 
}

repo() {
  cd "$(ff-select-repo)" || exit
}


# Widgets

widget-search-history-incremental() {
  replace-buffer "$(history -n 1 | tac | ff)"
  zle reset-prompt
}
zle -N widget-search-history-incremental

widget-find-snippet() {
  local c
  c="｜"
  insert-buffer "$(
    sed -e '/^#/d' -e '/^$/d' -e 's/#|/'$c'/' ~/.snippets | ff |
      sed -e 's/ *'$c'.*$//'
  )"
}
zle -N widget-find-snippet

widget-branch-name() {
  insert-buffer "$(ff-branch-name)"
  ignore-history
}
zle -N widget-branch-name

widget-find-download-file(){
  insert-buffer "$(ff-find-file ~/Downloads)"
  ignore-history
}
zle -N widget-find-download-file

widget-find-junkfile(){
  insert-buffer "$(ff-find-file ~/.cache/junkfile/)"
  ignore-history
}
zle -N widget-find-junkfile

widget-find-repo-file(){
  insert-buffer "$(ff-find-file $(ff-select-repo))"
  ignore-history
}
zle -N widget-find-repo-file

widget-find-current-repo-file(){
  insert-buffer "$(ff-find-file $(gitroot))"
  ignore-history
}
zle -N widget-find-current-repo-file

widget-find-file(){
  insert-buffer "$(ff-find-file .)"
  ignore-history
}
zle -N widget-find-file

widget-open-application () {
  find /Applications /System/Applications \
	   -maxdepth 2 -name '*.app' |
	sed -e 's:/.*/::' |
	sort |
	ff |
	xargs -r -I{} open -a '{}'
}
zle -N widget-open-application

widget-select-widgets(){
  # https://superuser.com/questions/681575/any-way-to-get-list-of-functions-defined-in-zsh-like-alias-command-for-aliases
  $(print -l ${(k)functions} | grep -E '^widget-' | fzf)
}
zle -N widget-select-widgets


# autoloads

autoload -z edit-command-line
zle -N edit-command-line

autoload smart-insert-last-word
zle -N insert-last-word smart-insert-last-word
