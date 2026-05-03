class Sigil < Formula
  desc "Automated security auditing for AI agent code"
  homepage "https://sigilsec.ai"
  license "Apache-2.0"
  version "1.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/NOMARJ/sigil/releases/download/v1.1.2/sigil-macos-arm64.tar.gz"
      sha256 "a8a755a01fb60966ea1084bde635a854dfd466f78198e27b7c2d0e187519117e"
    else
      url "https://github.com/NOMARJ/sigil/releases/download/v1.1.2/sigil-macos-x64.tar.gz"
      sha256 "488d5807f67ee346309a48721250919cc344909a70754127382c9146590afc03"
    end
  end

  on_linux do
    url "https://github.com/NOMARJ/sigil/releases/download/v1.1.2/sigil-linux-x64.tar.gz"
    sha256 "50e90cf18abeecc17d1a6d71a991e596d75194e268e16a17aee2a93c4491e608"
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
