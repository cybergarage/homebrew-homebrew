class Uhttpxx < Formula
  homepage "http://www.cybergarage.org/oss/cloud/µhttp-for-cc/"
  url "https://github.com/cybergarage/uhttp/archive/0.8.tar.gz"
  sha256 "49c50c6f199a848a255c4546e4679a58c8a5d7fe8abadc219073ab647f116036"

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
