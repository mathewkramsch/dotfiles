# ~/.zshrc

source ~/.serveraccessrc

APPSEP_POD=1018

# MATHEW'S ALIASES
alias r='. ranger'
alias rm='rm -iv'
alias open='xdg-open 2>/dev/null'
alias python='python3'  # because this is pissing me off
alias p='clear && cd ~/Desktop/Notes/Personal\ Notes'
alias vn='clear && cd ~/Desktop/Notes/Veeva\ Notes && . ranger'
alias w='clear && cd ~/Desktop/Workspace'
alias n='cd ~/Desktop/Notes'
alias u='cd ~/Desktop/Notes && ./update.sh y'
alias v='clear && cd ~/Desktop/Workspace/vault-gradle && git branch'
alias vmc='clear && cd ~/Desktop/Workspace/vault-gradle/WzlVMC/webpack/src/components/durableQueuesAdminPage'
alias t='cd ~/Desktop/Notes/Veeva\ Notes && vim todo.n'
alias nvim='./nvim-macos/bin/nvim'
alias tetris='tetris -a -l 1'
alias pacman='myman'
alias snake='nsnake'
alias chess='./go/bin/gambit'
alias grep='grep --color'
alias appsep='ssh -i ~/.ssh/id_rsa_terra ec2-user@appsepvmc.vaultdev.com'
alias newinfra='ssh -i ~/.ssh/id_rsa_terra ec2-user@immutable1vmc.vault-infra.com'
alias dev='ssh -i ~/.ssh/id_rsa_terra ec2-user@devvmc.vaultdev.com'
alias infra='ssh -i ~/.ssh/id_rsa_terra ec2-user@infravmc.vaultdev.com'
alias gm='ssh mathew.kramsch@gm.vaultdev.com'
alias devMode='cd ~/Desktop/Workspace/vault-gradle/WzlVMC && nvm use v16.15.0 && npm run devMode:no-vm'
#alias hd='./gradlew hotDeploy'
alias hd='./gradlew hotDeploy -PhotDeploy.pvm'
alias vhd='./gradlew vmc:npmBuild && ./gradlew hotdeployui -PhotDeploy.pvm'
alias vhd2='./gradlew :vmc:hotDeploy -PhotDeploy.pvm'
#alias vhd='./gradlew :vmc:npmBuild && ./gradlew :vmc:hotDeploy'
alias cf='caffeinate -ds'
alias yabai-restart='yabai --restart-service && sketchybar --reload'

alias av1="assh appsep_${APPSEP_POD}_vault_1"
alias av2="assh appsep_${APPSEP_POD}_vault_2"

# Git shortcut aliases
alias b='git branch'
alias gs='git status'
alias gd='git diff'
alias gjs='git jstatus'
alias gc='git checkout'
alias gcp='git cherry-pick'
alias gbd='git branch -D'
alias gl='git log --pretty=format:"%C(yellow)%h%Creset - %C(green)%an%Creset, %ar : %s"'
alias glg='git log --graph --abbrev-commit --stat'

# export LSCOLORS="cxfxcxdxBxegecabagacad"
export LSCOLORS="CxfxcxdxBxegecabagacad"
alias ls='ls --color=auto'

# MATHEW'S FUNCTIONS
function pcp () {
	cat $1 | pbcopy
}

function gac() {
	if [ $# -eq 0 ]; then
		git add . && git commit
	else
		git add . && git commit -m $1
	fi
}

function gp() {
	if [ $# -eq 0 ]; then
		git push
	else
		git push --set-upstream origin $1
	fi
}

function gitshit() {
	clear
	git branch
	git status -s
	git diff --stat
	git diff
	git jstatus
}
	
build() {
	if [[ -f "gradlew" ]]; then
		./gradlew hotDeploy
	else
		echo "nah"
	fi
}

function vm() {
	clear
	cd ~/Desktop/Workspace/vagrant/prebuilt 
	if [[ $1 == "start" ]]; then
		echo "\nfiring up the vagrant"
		vagrant up
		sshpass -pMushuk17 sudo ssh -p 2222 -i ~/.vagrant.d/insecure_private_key root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -L 4567:127.0.0.1:4567 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
	elif [[ $1 == "halt" ]]; then
		echo "\n stopping the vagrant"
		vagrant halt
	fi
}

function bunnyMssgSide() {
	printf "  (\_/)   .--"
	for ((i=0; i<${#1}; i++)); do
		printf "-"
	done
	printf %b "--.\n"
	printf "  (O.o)   |  ${1}  |"
	printf "\n  (>  )'  '--"
	for ((i=0; i<${#1}; i++)); do
		printf "-"; done
	printf %b "--'\n"
}

function welcome() { echo && bunnyMssgSide "Welcome Mathew..." && echo; }

# WELCOME MESSAGE
# welcome

# SET DEFAULT EDITOR
export VISUAL=vim
export EDITOR=vim

# for gruvbox colors
source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

# italics?
export TERM="xterm-256color"

eval "$(starship init zsh)"

# Load stuff
autoload -U promptinit && promptinit
autoload -U colors && colors

# Check if Git repo
function prompt_git {
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo '»' 
  else 
    echo '›' 
  fi
}
# Load the prompt
prompt='%{$fg[green]%}$(prompt_git) %{$fg[cyan]%}%~%{$reset_color%} '

# Important Aliases
alias vvlocal='sudo ssh -p 2222 -i ~/.vagrant.d/insecure_private_key root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -L 4567:127.0.0.1:4567 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
#alias vl='sshpass -pMushuk17 sudo ssh -p 2222 -i ~/.vagrant.d/insecure_private_key root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -L 4567:127.0.0.1:4567 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias vl='pvm ssh -r -t'

# My Veeva SSH Aliases/Functions
function appsepJVM() {
	echo "going into 1019 appsep JVM"
	SSH_COMMAND='ssh -i ~/.ssh/id_rsa_terra ec2-user@appsepvmc.vaultdev.com'
	eval $SSH_COMMAND
	sudo su
	ssh vlt-us-west-2-appsep-1019-vault-07ece03c6a8ec70fa.terravault.com
	sudo su
	cd
}

# NVM Stuff (for building/deploying frontend)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PVM stuff
export DEV_TOOLS_ROOT=/Users/MathewKramsch/Desktop/Workspace/dev_tools
export PATH="${PATH}:${DEV_TOOLS_ROOT}/GitUtils/bin:${DEV_TOOLS_ROOT}/PVMUtils/bin"

# building frontend?:
function buildVMC() {
	clear
	cd ~/Desktop/Workspace/vault-gradle/WzlVMC
	nvm use v16.15.0
	nvm list
	echo "npm run clean"
	npm run clean
	echo "npm run setup"
	npm run setup
	echo "npm run build"
	npm run build
	cd ..
	./gradlew :vmc:hotDeploy -PhotDeploy.pvm
}

# copy veevaBrokerPlugin over
function updatePlugin() {
	cd ~/Desktop/workspace/vault-docker/Docker/activemq/veevaBrokerPlugins
	mvn clean install
	cp ~/Desktop/Workspace/vault-docker/Docker/activemq/veevaBrokerPlugins/target/veevaBrokerPlugins-1.1.jar ~/Desktop/Workspace/vault-gradle/.
	echo "copied veevaBrokerPlugins-1.1.jar into /vault-gradle"
}

function fcp() {
	cat $1 | pbcopy
}

# Python stuff
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
#eval "($pyenv init -)"

eval "$(pyenv init --path)"

# git diff
export DELTA_PAGER="less --mouse"

# name tabs
function title {
    echo -ne "\033]0;"$*"\007"
}

function jira {
	ticketNumber=$(git branch | grep '*' | grep mathew.kramsch | cut -d '/' -f 3 | cut -d '-' -f 2)
	ticket=DEV-$ticketNumber
	echo $ticket
	echo $ticket | tr -d '\n' | pbcopy
}

function branch {
	branch=$(git branch | grep '*' | grep mathew.kramsch | cut -d ' ' -f 2)
	echo $branch
	echo $branch | tr -d '\n' | pbcopy
}

function diff {
	if [[ $1 == "s" ]]
	then
		export DELTA_FEATURES=side-by-side
		git diff
	elif [[ $1 == "x" ]]
	then
		git -c pager.diff='less -R' diff
	else
		export DELTA_FEATURES=
		git diff
	fi
}
