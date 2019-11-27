#!/bin/sh
#

# the following lines set the SA location.
SQLANY12="/opt/sqlanywhere12"
export SQLANY12

[ -r "$HOME/.sqlanywhere12/sample_env64.sh" ] && . "$HOME/.sqlanywhere12/sample_env64.sh" 
[ -z "${SQLANYSAMP12:-}" ] && SQLANYSAMP12="/opt/sqlanywhere12/samples"
export SQLANYSAMP12

# the following lines add SA binaries to your path.
PATH="$SQLANY12/bin64:${PATH:-}"
export PATH
LD_LIBRARY_PATH="$SQLANY12/lib64:${LD_LIBRARY_PATH:-}"
export LD_LIBRARY_PATH
