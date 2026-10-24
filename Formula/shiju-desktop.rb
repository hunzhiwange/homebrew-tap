class ShijuDesktop < Formula
  desc "Desktop application for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-desktop-aarch64-apple-darwin.tar.gz"
      sha256 "a68d4cc2d2a73db26283f6bc1b71994722d4185771cc5b0225e7382388639511"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-desktop-x86_64-apple-darwin.tar.gz"
      sha256 "d4bd753bae6e68c2f6701529e1ae16a11c887b89303cb78b86d1eef78ad6d9de"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-desktop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "06cff54369a49fe8e94c875fabd19003eeb3a39d148d8bb509166b969ccb2c47"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-desktop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "74ea72432f7280754bfebe837efb866febb1ffe9888b79284a0b2e8823597eed"
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
