class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho/archive/refs/tags/1.2.0.tar.gz"
  sha256 "53259aadc79ce2c9e9316571685d10580dd20cbafb6c6d58f259d8f121a6785f"

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
