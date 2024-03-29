// Package autocomplete generates shell autocomplete scripts for jobman.
package main

import (
	"os"
)

func genAutocomplete() {
	// TODO: implement
	os.Create("docs/completions/bash/jobman")
	os.Create("docs/completions/powershell/jobman")
	os.Create("docs/completions/zsh/_jobman")
}

func main() {
	genAutocomplete()
}

// package jobman

// import (
// 	"log"
// 	"os"
// 	"path/filepath"

// 	"github.com/spf13/cobra/doc"
// )

// func main() {
// 	header := &doc.GenManHeader{
// 		Title:   "jobman",
// 		Section: "1",
// 	}
// 	manPath := filepath.Join(".", "man")
// 	err := os.MkdirAll(manPath, os.ModePerm)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	err = doc.GenManTree(JobmanRootCmd, header, manPath)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// }

// package jobman

// import (
// 	"fmt"
// 	"os"
// 	"strings"

// 	"github.com/cockroachdb/cockroach/pkg/build"
// 	"github.com/cockroachdb/errors/oserror"
// 	"github.com/spf13/cobra"
// 	"github.com/spf13/cobra/doc"
// )

// var manPath string

// var genManCmd = &cobra.Command{
// 	Use:   "man",
// 	Short: "generate man pages for CockroachDB",
// 	Long: `This command generates man pages for CockroachDB.
// By default, this places man pages into the "man/man1" directory under the
// current directory. Use "--path=PATH" to override the output directory. For
// example, to install man pages globally on many Unix-like systems,
// use "--path=/usr/local/share/man/man1".
// `,
// 	Args: cobra.NoArgs,
// 	RunE: clierrorplus.MaybeDecorateError(runGenManCmd),
// }

// func runGenManCmd(cmd *cobra.Command, args []string) error {
// 	info := build.GetInfo()
// 	header := &doc.GenManHeader{
// 		Section: "1",
// 		Manual:  "CockroachDB Manual",
// 		Source:  fmt.Sprintf("CockroachDB %s", info.Tag),
// 	}

// 	if !strings.HasSuffix(manPath, string(os.PathSeparator)) {
// 		manPath += string(os.PathSeparator)
// 	}

// 	if _, err := os.Stat(manPath); err != nil {
// 		if oserror.IsNotExist(err) {
// 			if err := os.MkdirAll(manPath, 0755); err != nil {
// 				return err
// 			}
// 		} else {
// 			return err
// 		}
// 	}

// 	if err := doc.GenManTree(cmd.Root(), header, manPath); err != nil {
// 		return err
// 	}

// 	// TODO(cdo): The man page generated by the cobra package doesn't include a list of commands, so
// 	// one has to notice the "See Also" section at the bottom of the page to know which commands
// 	// are supported. I'd like to make this better somehow.

// 	fmt.Println("Generated CockroachDB man pages in", manPath)
// 	return nil
// }

// var autoCompletePath string

// var genAutocompleteCmd = &cobra.Command{
// 	Use:   "autocomplete [shell]",
// 	Short: "generate autocompletion script for CockroachDB",
// 	Long: `Generate autocompletion script for CockroachDB.
// If no arguments are passed, or if 'bash' is passed, a bash completion file is
// written to ./cockroach.bash. If 'fish' is passed, a fish completion file
// is written to ./cockroach.fish. If 'zsh' is passed, a zsh completion file is written
// to ./_cockroach. Use "--out=/path/to/file" to override the output file location.
// Note that for the generated file to work on OS X with bash, you'll need to install
// Homebrew's bash-completion package (or an equivalent) and follow the post-install
// instructions.
// `,
// 	Args:      cobra.OnlyValidArgs,
// 	ValidArgs: []string{"bash", "zsh", "fish"},
// 	RunE:      clierrorplus.MaybeDecorateError(runGenAutocompleteCmd),
// }

// func runGenAutocompleteCmd(cmd *cobra.Command, args []string) error {
// 	var shell string
// 	if len(args) > 0 {
// 		shell = args[0]
// 	} else {
// 		shell = "bash"
// 	}

// 	var err error
// 	switch shell {
// 	case "bash":
// 		if autoCompletePath == "" {
// 			autoCompletePath = "cockroach.bash"
// 		}
// 		err = cmd.Root().GenBashCompletionFile(autoCompletePath)
// 	case "fish":
// 		if autoCompletePath == "" {
// 			autoCompletePath = "cockroach.fish"
// 		}
// 		err = cmd.Root().GenFishCompletionFile(autoCompletePath, true /* include description */)
// 	case "zsh":
// 		if autoCompletePath == "" {
// 			autoCompletePath = "_cockroach"
// 		}
// 		err = cmd.Root().GenZshCompletionFile(autoCompletePath)
// 	}
// 	if err != nil {
// 		return err
// 	}
// package jobman

// import (
// 	"log"
// 	"os"
// 	"path/filepath"

// 	"github.com/spf13/cobra/doc"
// )

// func main() {
// 	header := &doc.GenManHeader{
// 		Title:   "jobman",
// 		Section: "1",
// 	}
// 	manPath := filepath.Join(".", "man")
// 	err := os.MkdirAll(manPath, os.ModePerm)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// 	err = doc.GenManTree(JobmanRootCmd, header, manPath)
// 	if err != nil {
// 		log.Fatal(err)
// 	}
// }

// package jobman

// import (
// 	"fmt"
// 	"os"
// 	"strings"

// 	"github.com/cockroachdb/cockroach/pkg/build"
// 	"github.com/cockroachdb/errors/oserror"
// 	"github.com/spf13/cobra"
// 	"github.com/spf13/cobra/doc"
// )

// var manPath string

// var genManCmd = &cobra.Command{
// 	Use:   "man",
// 	Short: "generate man pages for CockroachDB",
// 	Long: `This command generates man pages for CockroachDB.
// By default, this places man pages into the "man/man1" directory under the
// current directory. Use "--path=PATH" to override the output directory. For
// example, to install man pages globally on many Unix-like systems,
// use "--path=/usr/local/share/man/man1".
// `,
// 	Args: cobra.NoArgs,
// 	RunE: clierrorplus.MaybeDecorateError(runGenManCmd),
// }

// func runGenManCmd(cmd *cobra.Command, args []string) error {
// 	info := build.GetInfo()
// 	header := &doc.GenManHeader{
// 		Section: "1",
// 		Manual:  "CockroachDB Manual",
// 		Source:  fmt.Sprintf("CockroachDB %s", info.Tag),
// 	}

// 	if !strings.HasSuffix(manPath, string(os.PathSeparator)) {
// 		manPath += string(os.PathSeparator)
// 	}

// 	if _, err := os.Stat(manPath); err != nil {
// 		if oserror.IsNotExist(err) {
// 			if err := os.MkdirAll(manPath, 0755); err != nil {
// 				return err
// 			}
// 		} else {
// 			return err
// 		}
// 	}

// 	if err := doc.GenManTree(cmd.Root(), header, manPath); err != nil {
// 		return err
// 	}

// 	// TODO(cdo): The man page generated by the cobra package doesn't include a list of commands, so
// 	// one has to notice the "See Also" section at the bottom of the page to know which commands
// 	// are supported. I'd like to make this better somehow.

// 	fmt.Println("Generated CockroachDB man pages in", manPath)
// 	return nil
// }

// var autoCompletePath string

// var genAutocompleteCmd = &cobra.Command{
// 	Use:   "autocomplete [shell]",
// 	Short: "generate autocompletion script for CockroachDB",
// 	Long: `Generate autocompletion script for CockroachDB.
// If no arguments are passed, or if 'bash' is passed, a bash completion file is
// written to ./cockroach.bash. If 'fish' is passed, a fish completion file
// is written to ./cockroach.fish. If 'zsh' is passed, a zsh completion file is written
// to ./_cockroach. Use "--out=/path/to/file" to override the output file location.
// Note that for the generated file to work on OS X with bash, you'll need to install
// Homebrew's bash-completion package (or an equivalent) and follow the post-install
// instructions.
// `,
// 	Args:      cobra.OnlyValidArgs,
// 	ValidArgs: []string{"bash", "zsh", "fish"},
// 	RunE:      clierrorplus.MaybeDecorateError(runGenAutocompleteCmd),
// }

// func runGenAutocompleteCmd(cmd *cobra.Command, args []string) error {
// 	var shell string
// 	if len(args) > 0 {
// 		shell = args[0]
// 	} else {
// 		shell = "bash"
// 	}

// 	var err error
// 	switch shell {
// 	case "bash":
// 		if autoCompletePath == "" {
// 			autoCompletePath = "cockroach.bash"
// 		}
// 		err = cmd.Root().GenBashCompletionFile(autoCompletePath)
// 	case "fish":
// 		if autoCompletePath == "" {
// 			autoCompletePath = "cockroach.fish"
// 		}
// 		err = cmd.Root().GenFishCompletionFile(autoCompletePath, true /* include description */)
// 	case "zsh":
// 		if autoCompletePath == "" {
// 			autoCompletePath = "_cockroach"
// 		}
// 		err = cmd.Root().GenZshCompletionFile(autoCompletePath)
// 	}
// 	if err != nil {
// 		return err
// 	}

// 	fmt.Printf("Generated %s completion file: %s\n", shell, autoCompletePath)
// 	return nil
// }
