class Mrboom < Formula
  desc "Eight player Bomberman clone"
  homepage "http://mrboom.mumblecore.org/"
  url "https://github.com/Javanaise/mrboom-libretro/releases/download/5.0/MrBoom-src-5.0.tar.gz"
  sha256 "88bd9fee69a9d3a5f3edafde9cfb5f9a8ca415041281fc19c1e7bc2a75407829"
  license "MIT"

  bottle do
    cellar :any
    sha256 "6531998d0edc841a0070135bad1f06910c2b7bc039db508562dedc0bcc054502" => :catalina
    sha256 "ccbe19edffde88813ff3ab4657f449ccbb366d536b3b52cc81fde1a1959bd0da" => :mojave
    sha256 "d50267a32f6fd8e9d181c0d857f2b04343702cca3d540bb14f033ee66fcf589f" => :high_sierra
    sha256 "a8795708892c9e1185bc9ddfec3a3ee0c7d05a7c4afdb3f76f50a8b700be7d9a" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "libmodplug"
  depends_on "minizip"
  depends_on "sdl2"
  depends_on "sdl2_mixer"

  def install
    system "make", "mrboom", "LIBSDL2=1"
    system "make", "install", "PREFIX=#{prefix}", "MANDIR=share/man/man6"
  end

  test do
    require "pty"
    require "expect"
    require "timeout"
    PTY.spawn(bin/"mrboom", "-m", "-f 0", "-z") do |r, _w, pid|
      sleep 1
      Process.kill "SIGINT", pid
      assert_match "monster", r.expect(/monster/, 10)[0]
    ensure
      begin
        Timeout.timeout(10) do
          Process.wait pid
        end
      rescue Timeout::Error
        Process.kill "KILL", pid
      end
    end
  end
end
