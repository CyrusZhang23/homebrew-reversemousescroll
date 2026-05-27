class Reversemousescroll < Formula
  desc "Reverse mouse scroll direction independently from trackpad on macOS"
  homepage "https://github.com/CyrusZhang23/ReverseMouseScroll"
  url "https://github.com/CyrusZhang23/ReverseMouseScroll/archive/refs/tags/v1.1.2.tar.gz"
  sha256 "1cc73ad5261a5315b5b404ecbfb42cf375103c0d0862e609cce4df76ac8454d0"
  license "MIT"

  depends_on :macos
  depends_on xcode: ["14.0", :build]

  def install
    system "swift", "build", "-c", "release", "--disable-sandbox"
    bin.install ".build/release/ReverseMouseScroll"
  end

  def caveats
    <<~EOS
      To install and start the background service, run:
        ReverseMouseScroll --install

      You will be prompted to grant Accessibility permission in:
        System Settings > Privacy & Security > Accessibility

      To check status or configure scroll direction:
        ReverseMouseScroll --status
        ReverseMouseScroll --show
        ReverseMouseScroll --setreverse y reverse
        ReverseMouseScroll --setreverse x normal

      To uninstall the service:
        ReverseMouseScroll --uninstall
    EOS
  end

  test do
    output = shell_output("#{bin}/ReverseMouseScroll 2>&1")
    assert_match "Usage", output
  end
end
