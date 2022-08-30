# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Jobman < Formula
  desc "A command line job manager with flexible support for retries, timeouts, logging, notifications, and more."
  homepage "https://github.com/ryancswallace/jobman"
  version "0.0.8-alpha"
  license "MIT"

  on_macos do
    url "https://github.com/ryancswallace/jobman/releases/download/v0.0.8-alpha/jobman_0.0.8-alpha_Darwin_x86_64.tar.gz"
    sha256 "98823c7d4ddb72d10fe1dfcffbdd971ce7ef1de4f136b79b88441b7e67067112"

    def install
      bin.install "jobman"
      man1.install Dir["docs/manpage/jobman.1"]
      bash_completion.install "docs/completions/bash/jobman"
      zsh_completion.install "docs/completions/zsh/jobman"
    end

    if Hardware::CPU.arm?
      def caveats
        <<~EOS
          The darwin_arm64 architecture is not supported for the Jobman
          formula at this time. The darwin_amd64 binary may work in compatibility
          mode, but it might not be fully supported.
        EOS
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/ryancswallace/jobman/releases/download/v0.0.8-alpha/jobman_0.0.8-alpha_Linux_x86_64.tar.gz"
      sha256 "e2044222f4a4a749ed76e63dd193d2f24c4061da6e2463ddd8b2f07cdba04cbf"

      def install
        bin.install "jobman"
        man1.install Dir["docs/manpage/jobman.1"]
        bash_completion.install "docs/completions/bash/jobman"
        zsh_completion.install "docs/completions/zsh/jobman"
      end
    end
  end

  test do
    system "#{bin/jobman}"
  end
end