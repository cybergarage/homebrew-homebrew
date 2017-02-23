class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/0.9.tar.gz"
  sha256 "49c50c6f199a848a255c4546e4679a58c8a5d7fe8abadc219073ab647f116036"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./bootstrap"
    system "./configure_macosx", "--disable-examples",
                                 "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
