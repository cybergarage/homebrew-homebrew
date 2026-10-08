class Mupnp < Formula
  homepage "https://github.com/cybergarage/mupnpc"
  url "https://github.com/cybergarage/mupnpc/archive/refs/tags/3.1.1.tar.gz"
  sha256 "acf32fd0a16f4bfd3fd851a1fe8b06c548a409abd63cde6ee515c08e77218ce2"

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
