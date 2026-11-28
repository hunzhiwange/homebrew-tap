class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "2.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.1/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "5c0a93eab12326638be24f9f584b01f6d2bed51811a29c1c6f9c96b0ee064be8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.1/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "6606811283b343273d1671ac51c97d9b84c7f2a81ac78340c5bedece8b6a00a3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.1/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "15ec6d0bc5c20cb286c859c328cd5584c54eec3834ab8ba39cc381ac62e5ff9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.1/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a76b41918a460bff79045e4177085c5a31c0d185d02977645d65f506dc3e8e84"
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
