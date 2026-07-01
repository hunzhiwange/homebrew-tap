class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.0/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "03e18769461c1840fd5dfe60abea73d30349d587bcaf8aea8f32d1a8d0121796"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.0/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "ddb54c83e6670201dc283efdd7b856c638e95eea8f813f95e8e4fbbde9a43de4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.0/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2fe746a048c058b1deba20a3db6b98a633dd2e6d026d07319ecd624164d755b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.0/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af117dc9e9cd1d6349eae824e519648015d10f6df9fc20d9b471870d0e8fb424"
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
