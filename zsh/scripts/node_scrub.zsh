#!/bin/zsh

# List files and directories.
echo "The following files and directories will be deleted: \n"
fd -t f 'yarn.lock' -I
fd -t f 'package-lock.json' -I
fd -t f 'pnpm-lock.yaml' -I
fd -t f '.DS_Store' -H -I

fd -t d 'node_modules' -I

# Removing files and directories.
fd -t f 'yarn.lock' -I -x rm
fd -t f 'package-lock.json' -I -x rm
fd -t f 'pnpm-lock.yaml' -I -x rm
fd -t f '.DS_Store' -H -I -x rm

fd -t d 'node_modules' -I -x rm -rf
