class ShijuDesktop < Formula
  desc "Desktop application for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-desktop-aarch64-apple-darwin.tar.gz"
      sha256 "304f78c8def19a925b0d0d90eb26b4dee5707a07614679434f974b4385032705"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-desktop-x86_64-apple-darwin.tar.gz"
      sha256 "bfc8cfaa45b823cf429384d7492cbf4c2985ad4d52b5a5eaaafba3cf05703762"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-desktop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a587d72482db734006c6ecd9e031ee528fd16b583d168b6459c7d9c9862b117e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-desktop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32d648d930e3a5e6f7828daa4a73541187f3c8177cb5522dcf8be564dfa02bde"
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
