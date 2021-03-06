class Modules < Formula
  desc "Dynamic modification of a user's environment via modulefiles"
  homepage "https://modules.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/modules/Modules/modules-4.6.1/modules-4.6.1.tar.bz2"
  sha256 "9aa8789046cff374857dde62406623bccf14644286ac97765d89806138f73f12"

  livecheck do
    url :stable
    regex(%r{url=.*?/modules[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 "b3327bf218e44bfd3b26c02ffcdd87accc74975e8133bdc8902ce8cb1f24b06b" => :big_sur
    sha256 "673d73d75d4d693610580f9037ae2522701b5cb418d8a79289988dbaa3229e79" => :catalina
    sha256 "219a6de0edbd5a629af151f5cb67889088cba2610a0b93c6eab74c3c9e70afa7" => :mojave
    sha256 "726872de440c74e8eebc8169731d291c35b12910929e75cc1ce08926223cf696" => :x86_64_linux
  end

  on_linux do
    depends_on "tcl-tk"
    depends_on "less"
  end

  def install
    tcl = OS.mac? ? "#{MacOS.sdk_path}/System/Library/Frameworks/Tcl.framework" : Formula["tcl-tk"].opt_lib
    with_tclsh = OS.mac? ? "" : "--with-tclsh=#{Formula["tcl-tk"].opt_bin}/tclsh"
    with_pager = OS.mac? ? "" : "--with-pager=#{Formula["less"].opt_bin}/less"

    args = %W[
      --prefix=#{prefix}
      --datarootdir=#{share}
      --with-tcl=#{tcl}
      #{with_tclsh}
      #{with_pager}
      --without-x
    ]
    system "./configure", *args
    system "make", "install"
  end

  def caveats
    <<~EOS
      To activate modules, add the following at the end of your .zshrc:
        source #{opt_prefix}/init/zsh
      You will also need to reload your .zshrc:
        source ~/.zshrc
    EOS
  end

  test do
    assert_match "restore", shell_output("#{bin}/envml --help")
    output = if OS.mac?
      shell_output("zsh -c 'source #{prefix}/init/zsh; module' 2>&1")
    else
      shell_output("sh -c '. #{prefix}/init/sh; module' 2>&1")
    end
    assert_match version.to_s, output
  end
end
