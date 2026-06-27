class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.5/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "1473fa13879c512f6bb0621cedf090c268648534cb63edf29650464c05c50f26"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.5/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "baea4439b65546a2cfcc9f5f1356f626963fac26de47950f5501df6a1c2b1073"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.5/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "39219a1f527edb2d25cae427e5cbd9f3036d93cecbace53438fce116974c66ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.5/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "69940944b08e6595c753aeb96d79b358803e93bd38a85f8d47808a892264ccf3"
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
