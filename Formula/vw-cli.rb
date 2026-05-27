class VwCli < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-cli-aarch64-apple-darwin.tar.xz"
      sha256 "903debbb905dc482cd7dce9d06bdf7220994089f65a13e6dc2973ca30631c08e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0924ce9e5df983d2bc48e0c09dafe8e15111d32df5b74edfd39fd3e93d6553f4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "428636fd58086c4b06740d50916b614cf81bfc4e368116299168b1ac227851c4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "627c411603c70822d7fa126a1a423c4d214fbb6ebf66fdeb2b5805fe562cf4f2"
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
