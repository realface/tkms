#!/bin/sh

ROOTDIR="/usr/local/Cellar/erlang/R16B03-1/lib/erlang"
BINDIR=$ROOTDIR/erts-5.10.4/bin
EMU=beam
PROGNAME=`echo $0 | sed 's/.*\///'`

export EMU
export ROOTDIR
export BINDIR
export PROGNAME
echo $PROGNAME                  # 脚本名称
echo ${1+$@}                    # 所有的参数
echo $#                         # 参数个数

# exec "$BINDIR/erlexec" ${1+"$@"}
