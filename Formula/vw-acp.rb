class VwAcp < Formula
  desc "Agent Client Protocol bridge for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-acp-aarch64-apple-darwin.tar.xz"
      sha256 "a839a60fbcdf1c7fa24d4ff65b3a6bf559eda6f45637b14827101b645b41a0bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-acp-x86_64-apple-darwin.tar.xz"
      sha256 "57141dc377d4a03da4c07bfb95bae47c1c541efba48cd9cff500ff1254d8740c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-acp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "94b40cfabc05bab595e5aeac653b4803880e074957cab7cb8947f51bf053b608"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.7/vw-acp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c9d65989a438b6d2f07438747e4ef1eff377a61337c825dfd81008c1f7fec46b"
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
    bin.install "acp" if OS.mac? && Hardware::CPU.arm?
    bin.install "acp" if OS.mac? && Hardware::CPU.intel?
    bin.install "acp" if OS.linux? && Hardware::CPU.arm?
    bin.install "acp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
