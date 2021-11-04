class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/refs/tags/1.0.0.tar.gz"
  sha256 "01e49838a8490e5b4f101ed2973ccf9bc163ed3714d2833664f5bf80c3e66c0e"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./bootstrap"
    if OS.mac?
      system "./configure_macosx", "--disable-examples",
                                   "--prefix=#{prefix}"
    elsif
      system "./configure", "--disable-examples",
                                   "--prefix=#{prefix}"
    end
    system "make"
    system "make", "install"
  end
end
