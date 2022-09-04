class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/refs/tags/1.2.3.tar.gz"
  sha256 "e3137863b509f4127c291a9f69984724c63251f1fb582a798f1bcfe3fa718913"

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
