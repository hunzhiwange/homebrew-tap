class VwWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-webview-aarch64-apple-darwin.tar.xz"
      sha256 "1159e158acc23ecac50dbf223e3bb2aaa234f36b41bf8c626981806795bb4a63"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-webview-x86_64-apple-darwin.tar.xz"
      sha256 "a5d798a61cedf802a75a6f5b8cd76e84107c91c5da7c71fc7a74c6caaf09050f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-webview-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "54a7c7772dabfde5fc7f29a8fe2962142bb839037605cb696013aa421d5f4040"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-webview-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5165da9d212d609c61904117f832b7b5cb572a77aef5e6fec2402742674684c7"
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
