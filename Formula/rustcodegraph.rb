class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.2.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.9/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "04469432d8dda7cea1da677718f5a2155004159b4418130cb81c874903d0ae21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.9/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "c004c38698f79130e824a0da9cf9f0ea12be474627db686e255e21e2b1921bab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.9/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e0f1ade474aa19b261396d45219e6c124a530faa864361276aebbffff7a929ab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.2.9/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e338690086d057a9aebbd025d0ca0a5667f540a92697c427f331e433f6126e76"
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
