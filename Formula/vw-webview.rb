class VwWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-webview-aarch64-apple-darwin.tar.xz"
      sha256 "88d1db0c9c08f77b0917b41fc2bed07b991cb672e31ee328c064c774419641c6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-webview-x86_64-apple-darwin.tar.xz"
      sha256 "da31a24f23d7b8346a5ef63e5896df4c27f99b0c7eee956be0d72536e72af812"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-webview-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "07e9530869ac28471bffc400c1e8895b016a27e80122f31ea77e5839ebdb67f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-webview-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f22cfec64352203aeb85d114d707ce70b228d69f22dd30686348c071b234cfe8"
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
