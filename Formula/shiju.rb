class Shiju < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-aarch64-apple-darwin.tar.gz"
      sha256 "dfba67eb3636488a4804aa46e3121cb6371161f638f7936623bb63016cf86371"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-x86_64-apple-darwin.tar.gz"
      sha256 "7c015c1f874a8b05c0bf7385721174689ed5dd00d3599b388596764b5b549fd0"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bc10a7e7547948d44c456b05971b73fde74d0405d42492ae807f86ab911625ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8aadc39076b136cf133f2322d74437b8d960db52bf0b976528f621757bb6a90b"
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
