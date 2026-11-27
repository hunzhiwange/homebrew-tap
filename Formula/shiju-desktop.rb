class ShijuDesktop < Formula
  desc "Desktop application for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-desktop-aarch64-apple-darwin.tar.gz"
      sha256 "62d57e94c8b4e45cb41713fd27ef554d9e665aa7c49a02c0a37bc4c4d0103bab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-desktop-x86_64-apple-darwin.tar.gz"
      sha256 "7836675d4e88cc06159178f9659220df523a90a528334b7adf6881369262cdc7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-desktop-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "85319ab5671b3988bacc699d95c6eec8cc3431f7528b2b769f73d35b98f10833"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-desktop-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "931447774d5b658f6b2e653a36cbf2936b2792f021dc7442d68d4872ad68a504"
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
