class VwWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-webview-aarch64-apple-darwin.tar.xz"
      sha256 "aaa2e3115b57f7aa8857025b2609286c1a87c49d227679db78ac4de4dcad86b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-webview-x86_64-apple-darwin.tar.xz"
      sha256 "293638668b82912f64dbd66adbb88eb0f1e5b3f51dc48c2781115e8aa9c387a5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-webview-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a1d1f14c108c9dee7099635ae6c14c9d039cc5aa2f5c02fb3cf2fd6ab7e03928"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-webview-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9e3869542fc8c77bfb56b2dcef8c4f7dff274c21a448b84a36d7713c14656437"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
    bin.install "vw-webview" if OS.mac? && Hardware::CPU.arm?
    bin.install "vw-webview" if OS.mac? && Hardware::CPU.intel?
    bin.install "vw-webview" if OS.linux? && Hardware::CPU.arm?
    bin.install "vw-webview" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
