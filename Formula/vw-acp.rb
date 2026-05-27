class VwAcp < Formula
  desc "Agent Client Protocol bridge for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-acp-aarch64-apple-darwin.tar.xz"
      sha256 "ae9bba5078b234a7d48a4c614076765a1e8f8312bedda4c0fe21edcc52751a4b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-acp-x86_64-apple-darwin.tar.xz"
      sha256 "0ffdb4a6a28c06702cbbc3393bcf85844aef145671cf7f6f126fc8ae20b3b007"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-acp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9acc978a2e7c3206a02f7021847998b5fcf4d15ef53a52d94c534f9d12566ebd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.2/vw-acp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e57ef1ed1ed430c527faa2f73ca3768ccfa28d93173d1f7cde1600ce12af1642"
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
