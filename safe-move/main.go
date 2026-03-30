package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"

	"github.com/spf13/cobra"
)

func main() {
	var dest string

	var rootCmd = &cobra.Command{
		Use:  "safe-move FILES...",
		Args: cobra.MinimumNArgs(1),
		Run: func(cmd *cobra.Command, args []string) {
			destAbs, err := filepath.Abs(dest)
			if err != nil {
				fmt.Println("Failed to resolve destination:", dest)
				os.Exit(1)
			}
			destInfo, err := os.Stat(destAbs)
			if err != nil {
				fmt.Println("Destination does not exist:", dest)
				os.Exit(1)
			}
			if !destInfo.IsDir() {
				fmt.Println("Destination is not a directory:", dest)
				os.Exit(1)
			}

			seen := make(map[string]bool)
			files := []string{}
			for _, f := range args {
				fileAbs, err := filepath.Abs(f)
				if err != nil {
					fmt.Println("Failed to resolve file:", f)
					os.Exit(1)
				}

				if seen[fileAbs] {
					fmt.Println("Duplicate file:", f)
					os.Exit(1)
				}
				seen[fileAbs] = true

				fileInfo, err := os.Stat(fileAbs)
				if err != nil {
					fmt.Println("File does not exist:", f)
					os.Exit(1)
				}

				if destAbs == filepath.Dir(fileAbs) {
					fmt.Println("File already in destination:", f)
					os.Exit(1)
				}

				if fileInfo.IsDir() && strings.HasPrefix(destAbs, fileAbs) {
					fmt.Println("Can't move a directory into itself:", f)
					os.Exit(1)
				}

				files = append(files, fileAbs)
			}

			for _, f := range files {
				cmd := exec.Command(
					"rsync",
					"-a",
					"--partial",
					"--",
					f,
					destAbs,
				)
				cmd.Stdout = os.Stdout
				cmd.Stderr = os.Stderr

				if err := cmd.Run(); err != nil {
					fmt.Println("Copy failed:", f)
					os.Exit(1)
				}
			}

			for _, f := range files {
				cmd := exec.Command(
					"rsync",
					"-a",
					"--checksum",
					"--dry-run",
					"--",
					f,
					destAbs,
				)
				cmd.Stdout = os.Stdout
				cmd.Stderr = os.Stderr

				if err := cmd.Run(); err != nil {
					fmt.Println("Verify failed:", f)
					os.Exit(1)
				}
			}

			for i, f := range files {
				if err := os.RemoveAll(f); err != nil {
					fmt.Println("Delete failed:", f)
					os.Exit(1)
				}
				if i == 0 {
					fmt.Println("Moved:")
				}
				fmt.Println(f)
			}
		},
	}

	rootCmd.Flags().StringVarP(&dest, "destination", "d", "", "destination")
	rootCmd.MarkFlagRequired("destination")

	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}
