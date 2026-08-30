class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.3.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.5/sigil-macos-arm64.tar.gz"
      sha256 "f7d522672bf580b1895e53a490b7b477d8f56769ba85f6bd1e5bb45ae478cc90"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.5/sigil-macos-x64.tar.gz"
      sha256 "3d1b4c4412ca6ac3351ef9adc3edcc53a1a82a2f2756d4bf7997cc22fca0c9b6"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.3.5/sigil-linux-x64.tar.gz"
    sha256 "266ec978afdbf835992e97355dc6c4440284f5aae8c1917a66b8d7c51a9695c1"
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
