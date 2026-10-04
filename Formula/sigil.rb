class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.3.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.7/sigil-macos-arm64.tar.gz"
      sha256 "6277c9218d661b917ffd296ac4239887505ef55bc4f09c67701adc0fee77e375"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.7/sigil-macos-x64.tar.gz"
      sha256 "266bc34f8df9103bb29af7a2c45c5f38c188bcac1e5799ebb1f69a2d194814e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.7/sigil-linux-arm64.tar.gz"
      sha256 "8de1bde83d61e4eb5384dbda8a38c0e51f12b66eb034ea36f656826138409835"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.3.7/sigil-linux-x64.tar.gz"
      sha256 "758d5079cd19cf8eb99f29987c78d388514e04dc9087f50baf429c870b272747"
    end
  end

  def install
    bin.install "sigil"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sigil --version")
    (testpath/"test.py").write("print('hello')")
    system "#{bin}/sigil", "scan", testpath/"test.py"
  end
end
