#!/bin/bash

export GOPATH=$HOME
export PATH=$PATH:$GOPATH/bin

GO_INSTALL_LIST=$(echo '
github.com/motemen/ghq
github.com/awa-manju/othello
' | xargs)

go get $GO_INSTALL_LIST
