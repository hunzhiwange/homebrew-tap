class ShijuWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-webview-aarch64-apple-darwin.tar.gz"
      sha256 "32a57d1b5f16b382e95625378671202d656c829087a3c5b2a212c3b8db9d1df1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-webview-x86_64-apple-darwin.tar.gz"
      sha256 "483b4450b116059f69c21d755cef81e95402037b64029c9417ed7c4af5ef7fc3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-webview-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ce654a67fe190a4696fd65e4d2a1785ac5335f5cb419514749dc3835efcca53a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-webview-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ac2556db98c7cc02a1c29994f9a496cc623774fe693a43f9ab4cb43d4cad5979"
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
      bin.install "vw-webview"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vw-webview"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vw-webview"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vw-webview"
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
