class ShijuWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-webview-aarch64-apple-darwin.tar.gz"
      sha256 "e09c5b6beb55fa0577a6215588f7dd2a4ce6799ce3392adc8af044ab6674bbab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-webview-x86_64-apple-darwin.tar.gz"
      sha256 "bc37f2f4cce9fb5f0108102b756d8123897e071d81011b54f7c6597f8f3c5222"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-webview-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3b6ceb0b95a8a936b4491a5f2de5dbe790281a4e485d9ec26b1a134ec3e33b27"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-webview-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "51da8a89a1543d61546beb218f80d8c547a3e1d801c99045a5009bba9ad5ab6d"
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
