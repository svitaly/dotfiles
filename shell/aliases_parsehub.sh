alias k='sanic kubectl'
alias klsw='sanic kubectl get pods --all-namespaces --output=wide'
alias kls='sanic kubectl get pods --all-namespaces'
alias cdm="cd ~/moment"
alias srdd="sanic run deploy_deterministic"
alias srd="sanic run deploy"
alias srs="sanic run stop"
alias sed="sanic env dev"
alias kill80="sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill"
