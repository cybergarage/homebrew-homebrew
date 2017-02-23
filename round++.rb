class Roundxx < Formula
  homepage "https://github.com/cybergarage/round-cc"
  url "https://github.com/cybergarage/round-cc/archive/0.1.tar.gz"
  sha256 "1e31c162aab5b87d570464fe2f47130f82a5e590be09c21dfc41b73af7f67910"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline" 
  depends_on "boost"   
  depends_on "jansson"
  depends_on "spidermonkey"
  depends_on "v8"
  depends_on "mupnp++"

  def install
    system "./bootstrap"
    system "./configure_macosx", "--disable-debug",
                                 "--disable-dependency-tracking",
                                 "--disable-silent-rules",
                                 "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end
end
