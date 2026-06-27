class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.1/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "df0b543f9f5b4097b932a405626c3a46695ea21dadd3e98417e46aed3163a993"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.1/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "1cd1f88b946278369716ef886b55f80968084ff0bca997beb5e6a6c7309ea99b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.1/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e2ba4d1f6d8fcef47aa2a0f673fb467fdb79ab9c4db8ac7e068b46f170446127"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.1/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "6a7a147b102cdf0c6728ce3788f6c7e893b84422c3511da0326fda7fd744c3ae"
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
    bin.install "rustcodegraph" if OS.mac? && Hardware::CPU.arm?
    bin.install "rustcodegraph" if OS.mac? && Hardware::CPU.intel?
    bin.install "rustcodegraph" if OS.linux? && Hardware::CPU.arm?
    bin.install "rustcodegraph" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
