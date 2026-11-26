class Shiju < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-aarch64-apple-darwin.tar.gz"
      sha256 "9e1768a967658b45e4fa120f66117d573e6de93c7db1284097f7e5f6df9f2233"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-x86_64-apple-darwin.tar.gz"
      sha256 "97da21a6c7899da2130e54dedbf0d44450d2e9db7156a6ee42e154e3adef16dd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7abb47872e8cd76396bffa3625e6ef0d90ea48395f24d2a14124e68e99ba6e93"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9182ade0ed44bd80beb3f7b9c217019f992fdbbb298c29032117dfb3348a27ae"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "shiju", "vibe-agent"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shiju", "vibe-agent"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shiju", "vibe-agent"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shiju", "vibe-agent"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
