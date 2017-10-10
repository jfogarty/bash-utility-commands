# ~/bin/jfbashrc.sh: executed by bash(1) when login shell starts.

# JF: 28-sep-2017

function formatsecs() {
  ((h=${1}/3600))
  ((m=(${1}%3600)/60))
  ((s=${1}%60))
  printf "%02d:%02d:%02d\n" $h $m $s
}

alias t='. toDir'
alias path='. toPath'
alias getStartTime='STARTTIME=$(date +%s)'
alias getElapsedTime='((ELAPSED=$(date +%s) - $STARTTIME))'
alias showElapsedTime='echo "- Elapsed time: $(formatsecs $ELAPSED)"'
alias elapsedTime='getElapsedTime ; showElapsedTime'

# alias makeall='getStartTime ; makebook -a ; makebook -af ; elapsedTime'
alias pub='getStartTime ; makebook epub ; elapsedTime'
alias book='getStartTime ; makebook book ; elapsedTime'

alias np='tpad 0'
alias ff='find . -type f -name'
alias ll='LC_COLLATE=C ls --group-directories-first -l'
alias la='LC_COLLATE=C ls --group-directories-first'

alias killjupyter='kill $(pgrep jupyter)'
alias runjupyter='jupyter notebook'
alias b='cd ..'
alias s='sensors'

# Convenience functions for Git management
# ga . : Add changed files to changelist.
# gc "comment" : Commit changes and push to GitHub.
# gp : git push (push local changes into remote repository.
# gitforced : overwrite any local changes with a forced reset of the repo.
function gitAddStatus() {
    if [[ -n $1 ]]; then git add $@; fi
    git status
}
alias ga=gitAddStatus

function gitCommitPush() {
    if [[ -n $1 ]]; then
        local msg="$@"
        git commit -m "$msg"
        if [ $? -eq 0 ]; then
            git push
        else
            git status
            echo "*** git commit failed!"
        fi
    else
        git status
        echo "*** Please provide a message describing your commit." 
    fi 
}
alias gc=gitCommitPush
alias gp='git push'

# Overwrite any local changes with a forced reset of the repo.
alias gitforced='git fetch origin ; git reset --hard origin/master'

export MEDIA="/media/$USER"
export GOROOT=`go env GOROOT`
export GOPATH=$HOME/go
export OPENSSL_ROOT_DIR="/usr/local/openssl"
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export SCALA_HOME="$HOME/scala/scala-2.11.8"
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')
export TEXPATH=/usr/local/texlive/2016/bin/$TEXARCH
export ANACONDA_HOME="$HOME/anaconda2"
export NVM_DIR="$HOME/.nvm"

#echo [$PATH]
path -q "$TEXPATH"
path -q "$SCALA_HOME/bin"
path -q "$JAVA_HOME/bin"
path -q "$ANACONDA_HOME/bin"
#path -q "$HOME/ct/book/bin"
path -qf "$MEDIA/Data/book/bin"

path -eMANPATH  -aq "/usr/local/texlive/2016/texmf-dist/doc/man"
path -eINFOPATH -aq "/usr/local/texlive/2016/texmf-dist/doc/info"

echo "[.bashrc] - John's PATHs set [use initRvm, initNvm for tool sets]"

# Add the Ruby version manager.
function initRvm() {
    source /etc/profile.d/rvm.sh
    echo "[.bashrc] - RVM: Ruby Version Manager loaded."
}

# Add the Node Version manager.
function initNvm() {
    # - Lines auto added by raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
    echo "[.bashrc] - NVM: Node Version Manager loaded."
}

#initRvm
#initNvm
