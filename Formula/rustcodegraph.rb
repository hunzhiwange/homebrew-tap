class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.2.10"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.10/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "c673720d5c96aedbebcc5c586084e0c316d77cc33ad9e76824333a9a1328068b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.10/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "08f0c1cf75849894aafc908cee90815fc0234bc4d9410452359b25290d93e997"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.10/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "36ce34e215ed70854c71bf760342f5bd3c4f0f98c18e7582330abe9416b7a360"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.10/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5f858c9836faa08956711095c32908005661fdd3391c114a605023ac7ac0fbd3"
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
