package main

import (
	"fmt"
	"os"
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

			for _, f := range args {
				fileAbs, err := filepath.Abs(f)
				if err != nil {
					fmt.Println("Failed to resolve file:", f)
					os.Exit(1)
				}
				fileInfo, err := os.Stat(fileAbs)
				if err != nil {
					fmt.Println("File does not exist:", f)
					os.Exit(1)
				}

				srcAbs := filepath.Dir(fileAbs)
				if destAbs == srcAbs {
					fmt.Println("File already in destination:", f)
					os.Exit(1)
				}

				if strings.HasPrefix(destAbs, fileAbs+string(os.PathSeparator)) {
					fmt.Println("Can't move a directory into itself:", f)
					os.Exit(1)
				}

				_ = fileInfo
			}

			fmt.Println("Files:", args)
			fmt.Println("Destination:", destAbs)
		},
	}

	rootCmd.Flags().StringVarP(&dest, "destination", "d", "", "destination")
	rootCmd.MarkFlagRequired("destination")

	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}
