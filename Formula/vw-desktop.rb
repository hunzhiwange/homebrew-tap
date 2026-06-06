class VwDesktop < Formula
  desc "Desktop application for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-desktop-aarch64-apple-darwin.tar.xz"
      sha256 "5fff8586fa8510eee885ea46f9e65f53c76737d56b739babcdbfdacf8a6830f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-desktop-x86_64-apple-darwin.tar.xz"
      sha256 "ebac686e574139e50afcced88793bab247a9c1c717ffffa57e9f2c89a3184c11"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-desktop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa33ee2940ab7eb83a6a4d805aeec0bd32a261bf832cf383d9de9d0c6f38fa59"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-desktop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "67251be18f4a4d9e30044182efa5a2e89797899d55ca4e2330232ccc01a0508a"
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
