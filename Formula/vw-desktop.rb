class VwDesktop < Formula
  desc "Desktop application for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-desktop-aarch64-apple-darwin.tar.xz"
      sha256 "2cad60963746c6d9c49f16b434040630aa2283768e488ca1df38786edf0054c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-desktop-x86_64-apple-darwin.tar.xz"
      sha256 "33de7c37cfdf3acdc545380149bedef34ec740edb2f25526a2c5ca6b75b07c73"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-desktop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "62f56071fb7a9687e2cc82ece49107cb53357076f5c719f9a378dc73a29337bf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-desktop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b5068fbfe4f40d7bde41b622dec7598bdf0766b46ab8191920a710047958a16"
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
