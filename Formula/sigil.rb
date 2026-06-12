class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.2.1/sigil-macos-arm64.tar.gz"
      sha256 "c2f1639371d93ee6e98b10ec92a9514c414593638a1a0a65a8eb1cf8165a346b"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.2.1/sigil-macos-x64.tar.gz"
      sha256 "e3637652901accdb25c0ca2abd4ce6f377afa8fde17952ef7c22e8d9b9f6d412"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.2.1/sigil-linux-x64.tar.gz"
    sha256 "8138dae629291579b16a3f406c69b3fbfc8aec64eb039f5ccae7414732acf74e"
  end

  def install
    bin.install "sigil"
  end

  def post_install
    system "#{bin}/sigil", "install" rescue nil
  end

  test do
    assert_match "SIGIL", shell_output("#{bin}/sigil --version")
    (testpath/"test.py").write("print('hello')")
    system "#{bin}/sigil", "scan", testpath/"test.py"
  end
end
