# ~/.zshrc

# MATHEW'S ALIASES
alias c='clear'
alias r='. ranger'
alias rm='rm -iv'
alias open='xdg-open 2>/dev/null'
alias python='python3'  # because this is pissing me off
alias p='clear && cd ~/Desktop/Notes/Personal\ Notes'
alias v='clear && cd ~/Desktop/Notes/Veeva\ Notes'
alias w='clear && cd ~/Desktop/Workspace'
alias n='cd ~/Desktop/Notes'
alias u='cd ~/Desktop/Notes && ./update'
alias vault='clear && cd ~/Desktop/Workspace/vault-gradle'
alias t='cd ~/Desktop/Notes/Veeva\ Notes/Jira\ Notes && vim todo.n'
alias nvim='./nvim-macos/bin/nvim'
alias j='cd ~/Desktop/Notes/Veeva\ Notes/Jira\ Notes && . ranger'
alias tetris='tetris -a -l 1'
alias pacman='myman'
alias grep='grep --color'
alias appsep='ssh -i ~/.ssh/id_rsa_terra ec2-user@appsepvmc.vaultdev.com'
alias buildNPM='./gradlew :vmc:npmBuild'
alias hotDeployVMC='./gradlew :vmc:hotDeploy'


# export LSCOLORS="cxfxcxdxBxegecabagacad"
export LSCOLORS="CxfxcxdxBxegecabagacad"
alias ls='ls --color=auto'

# MATHEW'S FUNCTIONS
function pcp () {
	cat $1 | pbcopy
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
		sudo ssh -p 2222 -i ~/.vagrant.d/insecure_private_key root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -L 4567:127.0.0.1:4567 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no
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
welcome

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
prompt=' %{$fg[green]%}$(prompt_git)  %{$fg[cyan]%}%~%{$reset_color%} '

# Important Aliases
alias vvlocal='sudo ssh -p 2222 -i ~/.vagrant.d/insecure_private_key root@my.vaultdev.com -L 443:127.0.0.1:8443 -L 80:127.0.0.1:8080 -L 4567:127.0.0.1:4567 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'

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
	./gradlew hotDeploy
}

# copy veevaBrokerPlugin over
function updatePlugin() {
	cd ~/Desktop/workspace/vault-docker/Docker/activemq/veevaBrokerPlugins
	mvn clean install
	cp ~/Desktop/Workspace/vault-docker/Docker/activemq/veevaBrokerPlugins/target/veevaBrokerPlugins-1.1.jar ~/Desktop/Workspace/vault-gradle/.
	echo "copied veevaBrokerPlugins-1.1.jar into /vault-gradle"
}

function pbcp() {
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
