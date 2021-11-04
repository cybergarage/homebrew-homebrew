class Mupnpxx < Formula
  homepage "https://github.com/cybergarage/mupnp-cc"
  url "https://github.com/cybergarage/mupnp-cc/archive/3.0.1.tar.gz"
  sha256 "0980a9868fe78c24f7859fea712f236c25da45f2f9c90e6f89102120af752090"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"
  depends_on "uhttp++"

  def install
    system "./bootstrap"
    if OS.mac?
      system "./configure_macosx", "--disable-debug",
                                   "--disable-dependency-tracking",
                                   "--disable-silent-rules",
                                   "--prefix=#{prefix}"
    else
      system "./configure", "--disable-debug",
                                   "--disable-dependency-tracking",
                                   "--disable-silent-rules",
                                   "--prefix=#{prefix}"
    end
    system "make"
    system "make", "install"
  end
end
