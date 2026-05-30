class VwCli < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-cli-aarch64-apple-darwin.tar.xz"
      sha256 "17b1798976484386bec44179fcbce56265ccc7f3329fbe914407d23c7ad8b9f5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-cli-x86_64-apple-darwin.tar.xz"
      sha256 "7c14af6214c2a877653c283e5f86f4c6086aa0d58fba7b582247b9a39e30d9bf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f049cd22a715dadefa0af1055028e37a2408655a1917156dde69f7cdad017076"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.6/vw-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7fddbb4b4a1b3bea4b91554aa8481e43271c96762e744f235375ec0a5d24e7bd"
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
    bin.install "vibe-agent", "vibewindow" if OS.mac? && Hardware::CPU.arm?
    bin.install "vibe-agent", "vibewindow" if OS.mac? && Hardware::CPU.intel?
    bin.install "vibe-agent", "vibewindow" if OS.linux? && Hardware::CPU.arm?
    bin.install "vibe-agent", "vibewindow" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
