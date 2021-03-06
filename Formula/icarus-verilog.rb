class IcarusVerilog < Formula
  desc "Verilog simulation and synthesis tool"
  homepage "http://iverilog.icarus.com/"
  url "ftp://icarus.com/pub/eda/verilog/v10/verilog-10.0.tar.gz"
  sha256 "179f09afbafb951bea28c9001b06ed8b9b2e54181092d48e343cb20f436b1185"

  bottle do
    sha256 "32b49d99490f6076377ec3e41dab98ec23848e61b180bce9e74026fd8d16457a" => :sierra
    sha256 "74ba9d85c0c64df9c4d68f978ef56ccfe623eaade7e8c16080c418f3ccc6d864" => :el_capitan
    sha256 "b6b8920ebb2837a6bdf292f935d6ec09f4a4df2a3b79050fb3906a38f787893a" => :yosemite
    sha256 "8a1f573ce80b2a7f8e7789030a27d9ea8dfd68cbd690c3c556ac96e3a013e410" => :mavericks
    sha256 "5f9fe152d5af29ef33719342f5127d3b36f00952afd67cc3dfe8da455eac77bc" => :x86_64_linux
  end

  head do
    url "https://github.com/steveicarus/iverilog.git"
    depends_on "autoconf" => :build
  end

  unless OS.mac?
    depends_on "bison" => :build
    depends_on "flex" => :build
    depends_on "gperf" => :build
    depends_on "bzip2"
    depends_on "readline"
    depends_on "zlib"
  end

  def install
    system "autoconf" if build.head?
    system "./configure", "--prefix=#{prefix}"
    # https://github.com/steveicarus/iverilog/issues/85
    ENV.deparallelize
    system "make", "install"
  end

  test do
    (testpath/"test.v").write <<-EOS.undent
      module main;
        initial
          begin
            $display("Boop");
            $finish;
          end
      endmodule
    EOS
    system bin/"iverilog", "-otest", "test.v"
    assert_equal "Boop", shell_output("./test").chomp
  end
end
