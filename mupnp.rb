class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/3.0.1.tar.gz"
  sha1 "424a00981524ffeeb9d2c29c86ac2cce0d4c64ee"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

  def install
    system "./bootstrap"
    system "./configure_macosx", "--enable-libxml2",
                                 "--disable-examples",
                                 "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
