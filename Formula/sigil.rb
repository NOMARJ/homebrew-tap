class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.3.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.6/sigil-macos-arm64.tar.gz"
      sha256 "85ac2159599e6bb364ff0af19c887b197bbc47ceb2d72eadfd5691de9d12b77b"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.6/sigil-macos-x64.tar.gz"
      sha256 "0b9d97e3e64b57abff49899b91a58b6567112c15741a2053fd4ef4136a64308e"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.3.6/sigil-linux-x64.tar.gz"
    sha256 "fab0db2343b5cc5794f74d41d766cef1754c27e8d016f18aa925d9c81a9d6c85"
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
