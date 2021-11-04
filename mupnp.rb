class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/3.0.1.tar.gz"
  sha256 "3f8b302f62a5c77ac4294501fde0812816e5943ff4c683fb0c450ff3a200bb61"

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
