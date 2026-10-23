# safe-mv

safe-mv can safely move files from one directory to another,
it is a safe & smart alternative of the mv command.

Note: A directory is also a file.

## How does the mv command work?

mv first copies the source file to the destination directory
& then deletes the original.

## The problem with the mv command

A failed move operation results in partially moved files &
directories.

mv can also move multiple files or directories container
multiple files & directories from one directory another.
When mv is asked to move multiple files or a directory
having multiple files & directories, it copies the files one
by one to the destination... The problem is it deletes the
file that copies to the destination.

## How does safe-mv work?

Under the hood safe-mv uses rsync - a popular & battle
tested file transfer program.

## Why do I need safe-mv? Why can't I use

You can use rsync commands directory to move files if you
want. You can, but safe-mv is smart

## Move files between different machines

safe-mv can also move files between different machines using
ssh.

## Integrating with lf terminal file manager

Add this piece of code to your `lfrc` file (located at
`~/.config/lf/`).

```bash
cmd paste ${{
    set -f

    files=~/.local/share/lf/files

    if [[ ! -f "$files" ]] || [[ $(wc -l < "$files") -le 1 ]]; then
        return 0
    fi

    trap 'echo ""; exit 0' INT TERM

    mode=$(sed -n '1p' "$files")

    sources=()
    while IFS= read -r f; do
        sources+=("$f")
    done < <(sed '1d' "$files")

    exit_code=0

    echo ""
    if [ "$mode" = 'copy' ]; then
        safe-copy "${sources[@]}" -t . || exit_code=$?

    elif [ "$mode" = 'move' ]; then
        safe-move "${sources[@]}" -d . || exit_code=$?
        [ $exit_code -eq 0 ] && {
            rm "$files"
            lf -remote 'send clear'
        }
    fi

    echo ""
    read -k 1 "?Press any key to continue..."

    if [[ "$REPLY" != $'\n' ]]; then
	echo ""
    fi

    return 0
}}
```

## To run the project

```bash
go run main.go
```

## To build the project

```bash
go build -o ~/.local/bin/safe-move
```
