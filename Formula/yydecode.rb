class Yydecode < Formula
  desc "Decode yEnc archives"
  homepage "https://yydecode.sourceforge.io"
  url "https://downloads.sourceforge.net/project/yydecode/yydecode/0.2.10/yydecode-0.2.10.tar.gz"
  sha256 "bd4879643f6539770fd23d1a51dc6a91ba3de2823cf14d047a40c630b3c7ba66"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "4700a77bb5b4bbce8b34f92662661cf13f9560c1637256fd8dc9581ec7caf077" => :big_sur
    sha256 "83fcf98a8fbf68bf2ce8c5847b53730856f65f8139bda8506a912e4650020e8d" => :arm64_big_sur
    sha256 "206152a71458e053c332c7ca52f6db716b146e993c08384afb98e56a43c043b6" => :catalina
    sha256 "18d815befe31bcdeaac8edff43cb878f53c34a608fa946c13a14143139bf887a" => :mojave
    sha256 "e2e7285f1f2b18b4b99800602d15932dba435f6480c5776e5b57b734727f652f" => :high_sierra
    sha256 "91dc4fe34931d45fcebaead39ce505116322c7866e786cf86a7065f9e57b42ac" => :sierra
    sha256 "07aa31cabc4f2533df3b5670beed1ba99e3e7dcc3ffb3cf55fff56866e7bf11e" => :el_capitan
    sha256 "29e030d103507190633e2070ff380510b53719d0dbc22038b3ce5d56ae993cae" => :x86_64_linux
  end

  def install
    # Redefinition of type found in 10.13 system headers
    # https://sourceforge.net/p/yydecode/bugs/5/
    inreplace "src/crc32.h", "typedef unsigned long int u_int32_t;", "" if DevelopmentTools.clang_build_version >= 900

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end
end
