class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/refs/tags/1.4.2.tar.gz"
  sha256 "9de6e6c879c43f7e00fdafae8d8f1029fb6689b57230a4fecc0588b8eada79ad"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    system "./bootstrap"
    if OS.mac?
      system "./configure_macosx", "--disable-examples",
                                   "--prefix=#{prefix}"
    else
      system "./configure", "--disable-examples",
                            "--prefix=#{prefix}"
    end
    system "make"
    system "make", "install"
  end
end
