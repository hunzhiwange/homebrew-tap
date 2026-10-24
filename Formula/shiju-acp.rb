class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for VibeWindow"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "d7aab2bcba1c8e6e54a74f04f33c2f71032fddb0532ac43237ed5ad273b90fda"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "ed7cc9b6577e79e83aeebc7731ff4e5fcee22dab2bf055cca5af5c893efd9d8c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6bd3ce71db2b372f286a2fc1a627e0afbd2ff0942cf0a18bce24297dee767b8c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.6/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "35d67a8f37d5ae8a513fb47cfe787e8b46d30f09a27c26651e975f09c00c32ce"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-pc-windows-gnu": {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {}
  }

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
      bin.install "acp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "acp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "acp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "acp"
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
