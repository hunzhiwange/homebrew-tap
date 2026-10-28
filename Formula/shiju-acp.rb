class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.12"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.12/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "9315788676e31efb7e1e5f859e6f5ed537bb27f83d7436153cd573542c0b7301"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.12/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "83d7327ce62c57835fdeb45f1609502bdb288f3ea203a28ad450dcf2d23abe56"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.12/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3f3677fa4e2f6d679cf4468dad90a107c12ebd4709eda9d8a60d259c4c05ad78"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.12/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6906de03d2e9f6493c5d05a86755c371533ea54f36f65fd836d952f46b93be4e"
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
