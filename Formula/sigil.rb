class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.0.1/sigil-macos-arm64.tar.gz"
      sha256 "cb102cc1117bc0a4d5ebd85c6b95b7cefea2123d8e6e21a97848f13888250c3d"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.0.1/sigil-macos-x64.tar.gz"
      sha256 "689a110fc29c98dcf924481804b6f063dd4f128e99fb81b37b7326961fc4e5cd"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.0.1/sigil-linux-x64.tar.gz"
    sha256 "beebca81de4e6aefd6a72ab4a19535e526da3d959dd0714c23b62c5796d26e09"
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
