class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/0.9.tar.gz"
  sha1 "3d5fc48017efb7970aeb19a201c575c9058361bf"

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
