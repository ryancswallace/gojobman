// Package jobman generates man pages for jobman.
package main

import (
	"log"
	"os"
	"path/filepath"

	"github.com/ryancswallace/jobman/jobman"
	"github.com/spf13/cobra/doc"
)

func genManpages() {
	header := &doc.GenManHeader{
		Title:   "jobman",
		Section: "1",
	}
	manPath := filepath.Join(".", "docs", "manpage")
	err := os.MkdirAll(manPath, os.ModePerm)
	if err != nil {
		log.Fatal(err)
	}
	err = doc.GenManTree(jobman.JobmanRootCmd, header, manPath)
	if err != nil {
		log.Fatal(err)
	}
}

func main() {
	genManpages()
}
