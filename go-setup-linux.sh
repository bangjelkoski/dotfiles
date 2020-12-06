#!/bin/bash
set -e

GVERSION="1.14"
GFILE="go$GVERSION.linux-amd64.tar.gz"
RC=".zshrc"

GOPATH="$HOME/go"
GOROOT="/usr/local/go"
if [ -d $GOROOT ] 
then
    echo "Installation directories already exist $GOROOT"
else
	mkdir -p "$GOROOT"
	chmod 775 "$GOROOT"

	wget --no-verbose https://storage.googleapis.com/golang/$GFILE -O $TMPDIR/$GFILE
	
	if [ $? -ne 0 ]; then
	    echo "Go download failed! Exiting."
	    exit 1
	fi
	
	tar -C "/usr/local" -xzf $TMPDIR/$GFILE
fi


cp -f "$HOME/$RC" "$HOME/$RC.bkp"

touch "$HOME/$RC"
{
    echo ''
    echo '# GOLANG'
    echo 'export GOROOT='$GOROOT
    echo 'export GOPATH='$GOPATH
    echo 'export GOBIN=$GOPATH/bin'
    echo 'export PATH=$PATH:$GOROOT/bin:$GOBIN'
    echo ''
} >> "$HOME/$RC"
echo "GOROOT set to $GOROOT"

mkdir -p "$GOPATH" "$GOPATH/src" "$GOPATH/pkg" "$GOPATH/bin" "$GOPATH/out"
chmod 775 "$GOPATH" "$GOPATH/src" "$GOPATH/pkg" "$GOPATH/bin" "$GOPATH/out"
echo "GOPATH set to $GOPATH"

rm -f $TMPDIR/$GFILE
