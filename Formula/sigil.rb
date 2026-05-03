class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.0.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.0.5/sigil-macos-arm64.tar.gz"
      sha256 "9c5f378f68181a7d67d7280ba0e1367d7929903bacfa98a900fe1956012138bc"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.0.5/sigil-macos-x64.tar.gz"
      sha256 "2fa1eb2cf37c6e262694caf0f8eb1b11ea3a2f98f3093f224a99b89d7980f538"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.0.5/sigil-linux-x64.tar.gz"
    sha256 "29c1d719ac96bedfe63cb6efaab1e7f79d89e8a38c355413dcf34c62112f4cc6"
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
