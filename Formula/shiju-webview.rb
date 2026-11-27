class ShijuWebview < Formula
  desc "Cross-platform WebView window for VibeWindow"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-webview-aarch64-apple-darwin.tar.gz"
      sha256 "70005c5e4f9eea5f95783b5cdd5475e1aee3a3d27d4fbca099ee2faeeafcf88b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-webview-x86_64-apple-darwin.tar.gz"
      sha256 "428509ee556cac0573724820e23da90cb23eeaa766cdc0136551c983a824ef6a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-webview-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "cca682c9f40a7ace7be9a1d8b686c20fae5ee3580e48953edae6add94428dc30"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-webview-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "28cbd87ad04b2d996316553b5ee703c1f808d55127e610b3b4c810c04890784f"
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
