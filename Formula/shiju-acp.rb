class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "93bedb3e136e95f2508a5acb915ff2e36bd4cee84e2fed1cdc0720809158c491"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "d5138fb583eac257d26ca5f210cfc5637261dbd8f32bfea95980b4f9454073f1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b5a3a95d4039078f642578adbfb27663ab59942f04163a9bf477caf8fee83153"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.14/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5fe38f8f374abb5ae14c31fc78c25f0765585fc178a391b85101a736e5dd0154"
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
