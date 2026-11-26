class ShijuWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-webview-aarch64-apple-darwin.tar.gz"
      sha256 "c654aed2640377943030703d61be2098ce690f16669a080c0d488fb017618a2e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-webview-x86_64-apple-darwin.tar.gz"
      sha256 "13b3542f49d9faaaf4460988cc3095ccd9591266fe1f8ab950e493b471164dbd"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-webview-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f32cfe3c536f09f904860a80975326ff61bc065aff0fc40245ec60478f7871ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-webview-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4f7740515a8d10d0f9f9331cec74af78ff6e69eb3ff4a76f12c51f3d055bb8bf"
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
