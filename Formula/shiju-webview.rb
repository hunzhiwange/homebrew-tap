class ShijuWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-webview-aarch64-apple-darwin.tar.gz"
      sha256 "fa424599d92258517636395bcb2cbcee67e2335fa0bea000e991d8e417ceb396"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-webview-x86_64-apple-darwin.tar.gz"
      sha256 "fa6a3c3da0481845b55466ef916beea4e3b397941ba26f57cdab9e4a21e0817e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-webview-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "290cffa8fb604cbafcbac3b71a8909e65d8bf117339a459c1617b6315e00a08c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-webview-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1957658a8d61e8e03a2d1d70b535d180d96992475679c9c4af0c64c433ec5574"
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
