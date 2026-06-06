class VwWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-webview-aarch64-apple-darwin.tar.xz"
      sha256 "1bd8ae3a3eae0b3b003b67f9a5643715d4a679c5de3b193527e88110b72615c9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-webview-x86_64-apple-darwin.tar.xz"
      sha256 "180a8ea65e70e8b7d53f1ec716f1cd205322f9d059090ce242a4fc1b3b3245de"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-webview-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fb257edc25eacf042b3ad4c25675c2e36b9ee96b08e495c0deee0cc9a5eb84df"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-webview-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "f9f9fdfc96c161264b12fbb0130e624663dcb3a925d00dc2e83c8d800cd0d908"
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
