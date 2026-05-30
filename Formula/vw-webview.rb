class VwWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-webview-aarch64-apple-darwin.tar.xz"
      sha256 "e5444826a2baa437792e9e862e025590a52523f55a763c6fc97368266aab1c66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-webview-x86_64-apple-darwin.tar.xz"
      sha256 "96b87c2ad7600b03f7cf0d44eaf7d9bde021c2cd356fed1d68083ced2d28e329"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-webview-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "99c95cd1b034f5d4c39053e4b7f094066ad6a2dc9cb86c85ee1abeaa9f9d074a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-webview-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8d7442f7a1022d4ecda9e1d32bee64eb122d005f7e265ed4856f1b8160fba2e6"
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
