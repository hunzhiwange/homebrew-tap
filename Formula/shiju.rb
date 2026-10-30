class Shiju < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.15"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-aarch64-apple-darwin.tar.gz"
      sha256 "9c72b100e7e3ec2ccc284d5f821e20dade39ab6eead60023e74fc6b10726239e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-x86_64-apple-darwin.tar.gz"
      sha256 "fd0b2492f40d81fc39e064eb1fa1bcf8c17e10bbe39f297ea3a0c06d56296b67"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "81b2e092789865284ee33cbcd0318a7a97a21245011c7b3f6d28dee49ecce3e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.15/shiju-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b5a860e67229fe75f4ff855da44a2c5240c91bf10d8b31e62c141d80ad67a674"
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
