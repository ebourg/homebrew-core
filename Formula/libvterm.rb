class Libvterm < Formula
  desc "C99 library which implements a VT220 or xterm terminal emulator"
  homepage "http://www.leonerd.org.uk/code/libvterm/"
  url "http://www.leonerd.org.uk/code/libvterm/libvterm-0.1.3.tar.gz"
  sha256 "e41724466a4658e0f095e8fc5aeae26026c0726dce98ee71d6920d06f7d78e2b"
  version_scheme 1

  bottle do
    cellar :any
    sha256 "4459fb969f4c3ca5423133629037888e496ada9da2ed3f530dbb7bc8895f77c1" => :catalina
    sha256 "f6f63684294fd62fe17c4846d394ab9f040030a9ace22259921a1d775d9c10f1" => :mojave
    sha256 "449e14a3f5b1036d9083e3add31fa67c40b25b6f47c944dabb56ef4d411652c6" => :high_sierra
    sha256 "5a16b3eef1885e3dccb3b311e51db596f411086cc3d1f02a790ba12f490957d5" => :sierra
  end

  depends_on "libtool" => :build

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <vterm.h>

      int main() {
        vterm_free(vterm_new(1, 1));
      }
    EOS

    system ENV.cc, "test.c", "-L#{lib}", "-lvterm", "-o", "test"
    system "./test"
  end
end
