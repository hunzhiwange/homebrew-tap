class Rustcodegraph < Formula
  desc "Local-first code intelligence graph and CLI for AI agents"
  homepage "https://github.com/hunzhiwange/rustcodegraph"
  version "2.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.3/rustcodegraph-aarch64-apple-darwin.tar.xz"
      sha256 "ae02c3550f5eef4b12c344f2ab924dab240dd5c090096c89a19a6dc7d2808755"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.3/rustcodegraph-x86_64-apple-darwin.tar.xz"
      sha256 "b5d1e5e0229bf36b3b4cfd897f4d6b32e75eb0edab9902cdc01412ab1d335cb9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.3/rustcodegraph-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "506126aaa9488cf8286a54628fced94ddaa2cf5ce6dee44bfeb09d0829a0181e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/hunzhiwange/rustcodegraph/releases/download/v2.0.3/rustcodegraph-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bb64888f0d3fccf2b38313f8aad536ce5668cdebce5cc16db6e0ea95650e54a8"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "rustcodegraph"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "rustcodegraph"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "rustcodegraph"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "rustcodegraph"
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
