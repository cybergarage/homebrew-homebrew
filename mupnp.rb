class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/3.0.2.tar.gz"
  sha256 "1f24d7789636550a40de3a690e62f52ef6076d4de85da4f66de6b85b3225f86e"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "expat"
  depends_on "readline"

  def install
    system "./bootstrap"
    if OS.mac?
      system "./configure_macosx", "--enable-expat",
                                   "--disable-examples",
                                   "--prefix=#{prefix}"
    else
      system "./configure", "--enable-expat",
                            "--disable-examples",
                            "--prefix=#{prefix}"
    end
    system "make"
    system "make", "install"
  end
end
