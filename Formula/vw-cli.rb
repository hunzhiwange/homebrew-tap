class VwCli < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-cli-aarch64-apple-darwin.tar.xz"
      sha256 "b54091ea9f81a385a67a01896fd6e733c564129d005ccca4e3739c26e00d2157"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-cli-x86_64-apple-darwin.tar.xz"
      sha256 "832d2d6e40d5c32efb96c0cd057e8a68c8e1d79df50ef201b8b28b7485db5f07"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "33b4620c46f2edba6d4f2a6e36be89f45cf8d8d485e5e9bf105f0a6fb8d5d713"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a3b00e1272845b3b08817f1f73ce62f8fee9b3fd50552a3f29ea9fc49bb9aed7"
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
