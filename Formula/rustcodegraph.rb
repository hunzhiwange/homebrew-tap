class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.2.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.8/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "2fa62bd0762cb63b238eea6955ab3c34e6c6ca22aa76f95be173d8a2d6c3cf8a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.8/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "0913fb1a2fd1f41dc50ed3556376df6b86ef68a6f087ee8d2463b22aaa8008a2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.8/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "590bb621da203add0663b6ca4f498c38b9c17d2b6197f2ebadcae6661bb6629d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.8/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "27ab6f24ddd8007359a890d8dcdfe96dbf1eb9d44cc7f1be5c60c06fd97dd0d3"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rustcodegraph"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rustcodegraph"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rustcodegraph"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rustcodegraph"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
