class VwAcp < Formula
  desc "Agent Client Protocol bridge for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-acp-aarch64-apple-darwin.tar.xz"
      sha256 "a87b71133beadfd42261a21034055f07f4ea172def9d936fcd1dde91c8c39050"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-acp-x86_64-apple-darwin.tar.xz"
      sha256 "569af86f2b3852444585b67d32ca51a971043ac8454d50cf0e12bf85cd8c3da5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-acp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "909d53d05a724b228e14321ed23f7ffc25afde03c209ae31fc024518e989d334"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.2.3/vw-acp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbdb6016401a88b1b381eac59f2656a9bd941a6bfff30773d8c86d8e42f15266"
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
