class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.2/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "d091b11242146c3360b4d14c2452670f24e28db67baabc4e21a5bd7a5f486421"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.2/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "c55c4028258a36fcd554111eb9e0af513a62533e219c4aec7dcb6b8b58eaea91"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.2/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "974de88d307ea675fa5fe486dc8e8288c59e592bd81cc34130247fb1216f3d7a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.2/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fbdeb1af193451de021edd33ff91a5611a86193480d55dfb6601e82b9d3a52d"
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
