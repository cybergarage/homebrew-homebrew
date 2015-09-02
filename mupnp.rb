class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/3.0.0.tar.gz"
  sha1 "e5bf8874dbb2f0f5d75a89050a8f52e3d6a71961"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"
  depends_on "uhttp++"

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
