class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "a784f5b7239f21baa564b5e410371dfb251307916a04b588ee1d5d67abf8344f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "cafcd9351603eee842be37bf6dac9b5f368a46112200e4e0e3eb90e7376f29b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "96561609632758a70759a3f716805ee2d80f18c2580dae75ce40502bb35ebbde"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.1/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3904174a438578a281cfc4e007a9b99a8ef91c6f129dadc9f25ac16306d61e04"
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
