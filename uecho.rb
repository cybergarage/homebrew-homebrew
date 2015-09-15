class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/0.9.tar.gz"
  sha1 "b34cf4e9e1f4f9ef94af4bf3ae249a8ddd27c923"

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
