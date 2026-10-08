class Uhttpxx < Formula
  homepage "https://github.com/cybergarage/uhttp-cc"
  url "https://github.com/cybergarage/uhttp-cc/archive/refs/tags/0.8.2.tar.gz"
  sha256 "6d47ee576a0985e28ad40c5ac07da048f60a21a2b22f8f07716ffadeff8dcae5"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

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
