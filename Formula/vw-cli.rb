class VwCli < Formula
  desc "Rust-first autonomous agent runtime CLI"
  homepage "https://github.com/hunzhiwange/vibewindow"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-cli-aarch64-apple-darwin.tar.xz"
      sha256 "35b8e123fddd8824b4cfa9c9258e876e7514b95fc2c0fb3f6be4e8bc8f06287d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-cli-x86_64-apple-darwin.tar.xz"
      sha256 "765a706e069e604efcd1aab1d949a435d4832f51acff620a3b5619e16fa6621c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "aa801b6e5c356e85b593497509dfdcd43fe084e5e96d73e3a3ea2a9025a6bf29"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/vibewindow/releases/download/v0.3.0/vw-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "95b91c75c3244e0cdb3d254a195d14318424a22f604c4bd9484acf77ab87d77d"
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
    bin.install "vibe-agent", "vibewindow" if OS.mac? && Hardware::CPU.arm?
    bin.install "vibe-agent", "vibewindow" if OS.mac? && Hardware::CPU.intel?
    bin.install "vibe-agent", "vibewindow" if OS.linux? && Hardware::CPU.arm?
    bin.install "vibe-agent", "vibewindow" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
