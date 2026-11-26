class ShijuDesktop < Formula
  desc "Desktop application for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-desktop-aarch64-apple-darwin.tar.gz"
      sha256 "5b7a0abe730e7d9fcd5c4bb48e495db543872c9fed036ece9e0e9e97bf939eee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-desktop-x86_64-apple-darwin.tar.gz"
      sha256 "30361f7472eb21bc3e819c58d41f6ca019eee97b9d09b467ce14683b28dfd2de"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-desktop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9866531c9b45ac2c347df871bd52d53e0c357dab5e36cc854ec58c0367a7b547"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-desktop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d69328a48f0c1548e89901adcdbafc11234758ee13bf3d73d967dde62589a5d7"
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
