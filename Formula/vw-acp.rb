class VwAcp < Formula
  desc "Agent Client Protocol bridge for VibeWindow"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-acp-aarch64-apple-darwin.tar.xz"
      sha256 "83a31c729f95224924bf52e6eee38986943d8f3bc904fa8fe5e773ae319ba660"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-acp-x86_64-apple-darwin.tar.xz"
      sha256 "a16fd93850a4768a586ac0cc8d92b4ac5f3e7a8b07d239fb1b9129151bf10ac8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-acp-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e080025cfb06aaa0dc4687918a6266e7786e8b05945fd0975616c55717498d31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-acp-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "05cdcae965bf0b84be9439ccb565f315ac7c94e0c7e7d75e3e78681f9a4f72f1"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
    bin.install "acp" if OS.mac? && Hardware::CPU.arm?
    bin.install "acp" if OS.mac? && Hardware::CPU.intel?
    bin.install "acp" if OS.linux? && Hardware::CPU.arm?
    bin.install "acp" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
