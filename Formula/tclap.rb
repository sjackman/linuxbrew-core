class Tclap < Formula
  desc "Templatized C++ command-line parser library"
  homepage "https://tclap.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/tclap/tclap-1.2.2.tar.gz"
  sha256 "f5013be7fcaafc69ba0ce2d1710f693f61e9c336b6292ae4f57554f59fde5837"
  license "MIT"

  livecheck do
    url :stable
    regex(%r{url=.*?/tclap[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "b47ec931191894dada537833a53058fbf33fd134b32c4bd2a4d23e71cfdfd5d8" => :big_sur
    sha256 "9aa20fbd7d5f371e993181a9dbdbfc4b56b83cbcf55cd6efc84d68546c159aaf" => :arm64_big_sur
    sha256 "025227d952333920194194626d4e80eb02439a7de957a6722bd672a0cb2c7631" => :catalina
    sha256 "31d001dc926c1faf748a2dd0ad34fe9f3c3908400eac998802ce36ba78fab794" => :mojave
    sha256 "8e85cfa71594680dc52d5ff18d93cf585fc5990c28316f0b60f42584ff3a2697" => :high_sierra
    sha256 "8e85cfa71594680dc52d5ff18d93cf585fc5990c28316f0b60f42584ff3a2697" => :sierra
    sha256 "8e85cfa71594680dc52d5ff18d93cf585fc5990c28316f0b60f42584ff3a2697" => :el_capitan
    sha256 "07dcfd5a5be305cdf6b1d773dadd6b0ba1bf59b784964518fd03989262f6eb1e" => :x86_64_linux
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    # Installer scripts have problems with parallel make
    ENV.deparallelize
    system "make", "install"
  end
end
