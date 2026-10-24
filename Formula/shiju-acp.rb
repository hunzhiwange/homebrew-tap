class ShijuAcp < Formula
  desc "Agent Client Protocol bridge for ShiJu"
  homepage "https://github.com/hunzhiwange/shiju"
  version "0.5.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-acp-aarch64-apple-darwin.tar.gz"
      sha256 "9fdb4decf77bb457e0eb635323993f435e5ce7a251d445f1bbef22e26a12e507"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-acp-x86_64-apple-darwin.tar.gz"
      sha256 "50e11862ff4d0545ed834fb66f1e97799fd8e3856aefa41d72b3e15ea79234ce"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-acp-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "21cef24bd72a93cabfadbae0a83649012144e9c90109d0bd552045fc551829ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/shiju/releases/download/v0.5.7/shiju-acp-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1d3ac63a853f1a910615eeca19c7c3eb229687f056320f509b762229b1ea2d3c"
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
