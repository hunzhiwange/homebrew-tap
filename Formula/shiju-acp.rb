class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "5c0e4037e1e80deaa5b3fc337e01de0e251f9cf5f78bd3a92054608230e22673"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "f301e413261037b8805822c569d188e827c70827a3a5bc62525a28f9f02c8887"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d2120370da60454bbdf0191de2f4295228d290942ec1334c359cd831d43c2f0a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.0/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d11b4e41574aead5331b699b82bf2590b3f59da50b49f735f948ed199a362097"
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
      bin.install "acp", "aionrs-acp"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "acp", "aionrs-acp"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "acp", "aionrs-acp"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "acp", "aionrs-acp"
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
