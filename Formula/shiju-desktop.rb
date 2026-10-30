class ShijuDesktop < Formula
  desc "Desktop application for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-desktop-aarch64-apple-darwin.tar.gz"
      sha256 "356b842354e2b8f3ba2b74efe0e7e6c2daac48e4cf536a35dd06d9f3bb856f16"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-desktop-x86_64-apple-darwin.tar.gz"
      sha256 "5073284051e6d8cd38177208a26f61c2f89f694b3ac25c68eba4f7bdcb7a5b28"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-desktop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "eb101e83e9abb47ba2afe78c08b05f81a2b32aef7b4ca2fc3c4ac23c1fb7d24e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-desktop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "46da1b0d4b8245d7f031c7357b7fe56b7b2499b009d9bb9bc0c586a51a1f89e2"
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
      bin.install "shi-ju"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shi-ju"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shi-ju"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shi-ju"
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
