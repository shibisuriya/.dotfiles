# Always start gdb in 'TUI' mode.
tui enable

# Define a hook to run the program and stop at the entry point
define hook-run
    break main
end
