class Shiju < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-aarch64-apple-darwin.tar.gz"
      sha256 "1df6e7024fe7fb9b0666e7232a84be578d5fc6854ef3a45d49079ddc31cf8593"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-x86_64-apple-darwin.tar.gz"
      sha256 "26d2db48bed73f59c4a07be3920a400c1e16fd23eee9093ae70e6920931252b3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "aa9edae0923d1370958e15db5e765dff0198df089b01a49b9ef630b9e85f9200"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1b7228612b43323335956089ad658586a8ec7aa53c22a28c64eee070c32fdb94"
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
      bin.install "shiju", "vibe-agent"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shiju", "vibe-agent"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "shiju", "vibe-agent"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shiju", "vibe-agent"
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
