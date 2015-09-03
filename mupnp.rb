class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/3.0.1.tar.gz"
  sha1 "7968619b22b55e23b986210905b4970f50a33ef0"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "expat"
  depends_on "readline"

  def install
    system "./bootstrap"
    system "./configure_macosx", "--enable-expat",
                                 "--disable-examples",
                                 "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
