class VwDesktop < Formula
  desc "Desktop application for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-desktop-aarch64-apple-darwin.tar.xz"
      sha256 "1accb3bb6740e6ca7dd0736f63af167b83b6f9c3da00df585acf0da8112fdcfb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-desktop-x86_64-apple-darwin.tar.xz"
      sha256 "1710a388c5d1c1bc9ad731aadf6233fff0c275879a237227137c11faf1002703"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-desktop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e05b3de70303076e5c4018f13594b3ce5c536a0aff2b75feabdab2ad5aa04f24"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-desktop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2ac5880d099f2bdd307add9357c26c824a17b0600095fa63a4f3ce8ccfb22b24"
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
    bin.install "vibe-window" if OS.mac? && Hardware::CPU.arm?
    bin.install "vibe-window" if OS.mac? && Hardware::CPU.intel?
    bin.install "vibe-window" if OS.linux? && Hardware::CPU.arm?
    bin.install "vibe-window" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
