class VwDesktop < Formula
  desc "Desktop application for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-desktop-aarch64-apple-darwin.tar.xz"
      sha256 "0b0d1cb43cf4b6de20622a6dc546205c620ed8b4d8a63560746c3bf036fa1f77"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-desktop-x86_64-apple-darwin.tar.xz"
      sha256 "082b16cf0b6a15830542d63feb2c9e953d792fa4233fdf3c932ccb61b2d9157a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-desktop-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2c59d0ea69b52b407f9fb39859969c2b9f06d05b4998706150b1c7326cf2082b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-desktop-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "41bbf43463e2c6e1a65084b7bd8cbf3e90d5ebc143c76047172265439d190c37"
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
