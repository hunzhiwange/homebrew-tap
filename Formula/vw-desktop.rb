class VwDesktop < Formula
  desc "Desktop application for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-desktop-aarch64-apple-darwin.tar.xz"
      sha256 "c50a61d7d64574766443f61e338619556294d551ef77ed4320970e60b6bbb3b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-desktop-x86_64-apple-darwin.tar.xz"
      sha256 "fbcef3c9ac0d9748dd6c60bfc75399ad15c60676ca24d8b7defb8c0c79a67eb3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-desktop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "78046fe320205b4997a48003f5db81fe3294552cddf49eb3169c21ca65795c42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-desktop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c969eedff800c1ba51aa5ce5ebd8ccf3988aef0c2556af12220416716eae7fe1"
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
