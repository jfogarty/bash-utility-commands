# ~/.bashrc: executed by bash(1) when login shell starts.

# JF: 11-apr-2017
# export GOPATH=/home/$USER/go

function displaytime() {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%d days ' $D
  [[ $H > 0 ]] && printf '%d hours ' $H
  [[ $M > 0 ]] && printf '%d minutes ' $M
  [[ $D > 0 || $H > 0 || $M > 0 ]] && printf 'and '
  printf '%d seconds\n' $S
}

function displaytime2() {
  local T=$1
  local H=$((T/60/60))
  local M=$((T/60%60))
  local S=$((T%60))
  printf "%02d:%02d:%02d\n" $H $M $S
}

alias t='. toDir'
alias path='. toPath'
alias getStartTime='STARTTIME=$(date +%s)'
alias getElapsedTime='((ELAPSED=$(date +%s) - $STARTTIME))'
alias showElapsedTime='echo "- Elapsed time: $(displaytime $ELAPSED)"'
alias elapsedTime='getElapsedTime ; showElapsedTime'

alias makeall='getStartTime ; makebook -a ; makebook -af ; elapsedTime'
alias pub='getStartTime ; makebook epub ; elapsedTime'
alias book='getStartTime ; makebook book ; elapsedTime'

alias np='tpad 0'
alias ff='find . -type f -name'
alias ll='LC_COLLATE=C ls --group-directories-first -l'
alias la='LC_COLLATE=C ls --group-directories-first'

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

export GOROOT=`go env GOROOT`
export OPENSSL_ROOT_DIR="/usr/local/openssl"
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"
export SCALA_HOME="/home/$USER/scala/scala-2.11.8"
export TEXARCH=$(uname -m | sed -e 's/i.86/i386/' -e 's/$/-linux/')
export TEXPATH=/usr/local/texlive/2016/bin/$TEXARCH
export ANACONDA_HOME="/home/john/anaconda2"

#echo [$PATH]
path -q "$TEXPATH"
path -q "$SCALA_HOME/bin"
path -q "$JAVA_HOME/bin"
path -q "$ANACONDA_HOME/bin"
path -q "/home/john/ct/book/bin"

path -eMANPATH  -aq "/usr/local/texlive/2016/texmf-dist/doc/man"
path -eINFOPATH -aq "/usr/local/texlive/2016/texmf-dist/doc/info"

echo "[.bashrc] - John's PATHs set"
