class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "24c06d68216285e5e2fb8268e0e8fddac42d3ee71749b48f50e97f53f256f1f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "0ad3394bae9565ce607ae361151e8e5bde208958d7666e2158af1e9c855fe9d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa93407e9994d9056093b3d8dfae1ebb029f0350eba26d10df53129ab7d43393"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "af97c9f774ff89597202e46bd3ae4b37073828e210f52e3b3bf8ab3dab974a30"
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
      bin.install "acp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "acp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "acp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "acp"
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
