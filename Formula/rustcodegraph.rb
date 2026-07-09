class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.4/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "cbd75101de611a214f3adc0c89b5f633c51c5c98894eda320bbb640b15a8ab5a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.4/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "bacff5648f20122bd09067b395d0ca2981e6fd3b64b571264193736d5170f484"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.4/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6c14c42fff7b982b4de9a769ea8ae92c73270c4cc95d41d0c56faeaa222fcfcd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.4/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "89b8dec1613f070e934ef87bf0d34fbe795bca8c486492850ee27e27df42949c"
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
