// Package jobman implements implements the jobman CLI.
package jobman

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"

	homedir "github.com/mitchellh/go-homedir"
	"github.com/spf13/viper"
)

var cfgFile string

var rootcmd = &cobra.Command{
	Use:   "jobman",
	Short: "A brief description of your application",
	Long: `A longer description that spans multiple lines and likely contains
examples and usage of using your application. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	//	the bare `jobman` command is an alias for `jobman run`
	Run: Run,
}

// Execute adds all child commands to the root command and sets flags appropriately.
func Execute() {
	if err := rootcmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func init() {
	cobra.OnInitialize(initConfig)

	// rootcmd.PersistentFlags().StringVar(&cfgFile, "user-config-file", "", "user-level config file path (default is $HOME/.jobman.yaml)")
	// rootcmd.PersistentFlags().StringVar(&cfgFile, "project-config-file", "", "project-level config file path (default is ./.jobman.yaml)")
	// rootcmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.jobman.yaml)")
	// rootcmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.jobman.yaml)")
	// rootcmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.jobman.yaml)")
	// rootcmd.PersistentFlags().StringVar(&cfgFile, "config", "", "config file (default is $HOME/.jobman.yaml)")

	// rootcmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")

	// *`-log-level`
	// *`-verbose`
	// *`-quiet`
	// *`-json`
}

// initConfig reads in config file and ENV variables if set.
func initConfig() {
	if cfgFile != "" {
		// Use config file from the flag.
		viper.SetConfigFile(cfgFile)
	} else {
		// Find home directory.
		home, err := homedir.Dir()
		if err != nil {
			fmt.Println(err)
			os.Exit(1)
		}

		// Search config in home directory with name ".jobman" (without extension).
		viper.AddConfigPath(home)
		viper.SetConfigName(".jobman")
	}

	viper.AutomaticEnv() // read in environment variables that match

	// If a config file is found, read it in.
	if err := viper.ReadInConfig(); err == nil {
		fmt.Println("Using config file:", viper.ConfigFileUsed())
	}
}
