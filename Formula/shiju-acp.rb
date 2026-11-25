class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.7.17"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.7.17/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "14e7e099c27f7ca472fa949304e20def66ee4dfa34ce57a8f4c1db0d08f3cb05"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.7.17/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "766eb8a4b5c81816e628df28dcf9bc4aa398d4e0e2041964380b764113f39aaf"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.7.17/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0e094a2e785d18d02e873112ba3832f85278a6949e2087ec2b3bf80c5b70999"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.7.17/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "652b1ea506e30a0ee4598df2c504cb4ae7a098f9facc737d4900fddd88dc0fde"
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
