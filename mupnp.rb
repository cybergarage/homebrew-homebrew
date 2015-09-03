class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/3.0.1.tar.gz"
  sha1 "e39b88efefda06884610e32af4914c6687c29030"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

  def install
    system "./bootstrap"
    system "./configure_macosx", "--enable-libxml2",
                                 "--disable-debug",
                                 "--disable-dependency-tracking",
                                 "--disable-silent-rules",
                                 "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
