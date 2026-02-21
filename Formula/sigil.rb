class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.0.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.0.4/sigil-macos-arm64.tar.gz"
      sha256 "533a6331740c760b2d5dd4ce86dc96b98dd49c1119937ec24d520841fc6e0a1b"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.0.4/sigil-macos-x64.tar.gz"
      sha256 "24a87f438e5f0db8317fbdc56991d55653d4dfe8aaeed31d644713158bfba301"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.0.4/sigil-linux-x64.tar.gz"
    sha256 "d43a0cf9240bea7175b29cc3e4cd01511afdba5ebe24f0ac6d5af53e0f43d184"
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
