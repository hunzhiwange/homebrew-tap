class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.0/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "70e6fefd160ce5680ea90f7f2c30c1da6d30c17ac51d07a962d83b8f1c87cba2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.0/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "1cc140e0cb0f0b7941a06468cf0a23e4e9e0680ac71cecb48cc39cb9a05eee62"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.0/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "01585a9a5cc4447371003d27007dcc9e15e23287632c1dd84183cf26fdf049e7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v1.1.0/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ab2882390c09cd3415a8dbd669961312b4dc0550d36da46cda20d3f3bf8aaba7"
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
