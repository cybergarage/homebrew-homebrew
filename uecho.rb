class Uecho < Formula
  homepage "https://github.com/cybergarage/uecho"
  url "https://github.com/cybergarage/uecho-c/archive/0.9.2.tar.gz"
  sha256 "e2eee4028cfe390a5f76f1c4335b2bc3b8652740467e8cff264f32130491e39a"

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
