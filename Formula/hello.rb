class Hello < Formula
  desc "Program providing model for GNU coding standards and practices"
  homepage "https://www.gnu.org/software/hello/"
  url "https://ftpmirror.gnu.org/hello/hello-2.10.tar.gz"
  sha256 "31e066137a962676e89f69d1b65382de95a7ef7d914b8cb956f41ea72e0f516b"

  bottle do
    cellar :any_skip_relocation
    sha256 "9691f91e7c6897d525b76f5910144e0ed0adcb8bd8f7bb155f29fd431d8ff431" => :sierra
    sha256 "54ac46b692fcca2abe77aeeca41976172a2dc24a6762f84a47fabcaba336df89" => :el_capitan
    sha256 "f81a305402e8f8b6cf11a17dac81f604b6f48d940909886a6733cf4f6a64c05f" => :yosemite
    sha256 "c80495cb6d1ad8f2c3a64c22c9dcee9d0117ca25fa6426f20a6acca275cd6c56" => :mavericks
    sha256 "c3468e676f2c9cb511e537774424299342ffd52740e252e515bddae6d9e79df3" => :mountain_lion
    sha256 "f81d7c0a3eee9fd62ebdecf685fbc5284e40d4a61c372d554fd45719e52a43cc" => :x86_64_linux
  end

  conflicts_with "camlistore", :because => "both install `hello` binaries"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
  test do
    system "#{bin}/hello", "--greeting=brew"
  end
end
