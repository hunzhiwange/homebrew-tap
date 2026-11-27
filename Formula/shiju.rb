class Shiju < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-aarch64-apple-darwin.tar.gz"
      sha256 "63ad50927725acfa72a0603ed78ef5b030f753854724f845cc6d8d10153a5daa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-x86_64-apple-darwin.tar.gz"
      sha256 "d73ad87d4ed3bf2ff37ee6a60cbbe839e6e7e04bf590f8562af8c60197270159"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a2f50bd9a8c244e1e6008133294c04626323ba0b80a6eccdcceec1d85f46f6f4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6cd67e2a25e1d77b8216d1ff864a63bf953ff7d9588c42caa17e9ac98ca512d5"
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
