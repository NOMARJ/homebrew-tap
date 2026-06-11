class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.2.0/sigil-macos-arm64.tar.gz"
      sha256 "c61bffeaeba1f793b6a784dc9de8b33fc8d61b77ce17182c4c198612b342fb3f"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.2.0/sigil-macos-x64.tar.gz"
      sha256 "2c3327286f43a7f8bd1b36002869135087b5ca0e96374b00d2d2d77e47e55af6"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.2.0/sigil-linux-x64.tar.gz"
    sha256 "95593b4ca9f7f409d36072ac07502ce1a0449a0ae025c7c8924334c8c07e3f66"
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
