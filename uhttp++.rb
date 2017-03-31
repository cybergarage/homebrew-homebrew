class Uhttpxx < Formula
  homepage "http://www.cybergarage.org/oss/cloud/µhttp-for-cc/"
  url "https://github.com/cybergarage/uhttp/archive/0.8.1.tar.gz"
  sha256 "3c828cdd59eb4d555998ba4d5e7347b21b5451ca13e26aacb898d7f53ad2a3b0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

  def install
    system "./bootstrap"
    system "./configure_macosx", "--disable-debug",
                                 "--disable-dependency-tracking",
                                 "--disable-silent-rules",
                                 "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
