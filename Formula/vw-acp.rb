class VwAcp < Formula
  desc "Agent Client Protocol bridge for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-acp-aarch64-apple-darwin.tar.xz"
      sha256 "af1fd489ecc4b027762fa8a8094c81b3f28f314786c350817bcba6859f1584d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-acp-x86_64-apple-darwin.tar.xz"
      sha256 "3f05c529f4f57d9751baf3d984bd72c1b3a985cd82fa50c7233eaf226db11149"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-acp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1da9ee339dd2044c804e2224bd74bb5aa368e8a2b1d5f14d26c83b8faa1db2c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-acp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "93b51ca1cf3ebd4f78ebd2eb1504e7a60f98e90b50e86a5d6c61eedd79b0291e"
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
