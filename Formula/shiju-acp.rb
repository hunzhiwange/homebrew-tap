class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.8.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "5118c6a4290107f72af1862973d1f024a9e927a5476c532374d5da384f1ce309"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "e171e0131fcfcfbc0d93d45de12a69542e24d2f6de8bb33d2105cb878cb9a1ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "42b45512e727384ad1555f844660d402eafeb7d90a04058f9055572e7a17f6fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.8.3/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9cc291abc95ce17ee572a5a922fea9adc9d49bff356029179f4600c1b2a94d91"
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
