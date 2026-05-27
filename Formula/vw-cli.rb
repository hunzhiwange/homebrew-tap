class VwCli < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a2d31890d50cdff20828d1403e55bec64258f27f9c2fbc8d03092353c88882cb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-cli-x86_64-apple-darwin.tar.xz"
      sha256 "de5ccff932c62a40cb427994c488fb2874b03e0313baf747f2af02678ded056a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ad7e050b7599e7fc356f7f071a3281c64b0fb7aedfac0c0862a31cd3332ab1b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "94c61d5147e9087bdbc813aced7ed111da8db719090d9f12eed42c6528698cf5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "vibe-agent", "vibewindow" if OS.mac? && Hardware::CPU.arm?
    bin.install "vibe-agent", "vibewindow" if OS.mac? && Hardware::CPU.intel?
    bin.install "vibe-agent", "vibewindow" if OS.linux? && Hardware::CPU.arm?
    bin.install "vibe-agent", "vibewindow" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
