class BerkeleyDb4 < Formula
  desc "High performance key/value database"
  homepage "https://www.oracle.com/technology/products/berkeley-db/index.html"
  url "http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz"
  sha256 "e0491a07cdb21fb9aa82773bbbedaeb7639cbd0e7f96147ab46141e0045db72a"

  bottle do
    cellar :any
    sha256 "0f53d408c3646bb2776d0be456e14fc1a66eca706e272ce6840ae03d2e7d9559" => :sierra
    sha256 "598c8cc77263920589169c413c1b40cad1f02774bc889aeb0c1406d6b46ccfa3" => :el_capitan
    sha256 "9e4fd0da37c849e00a5bead14e64c8a71168287d957f71a96be96e4bd3000985" => :yosemite
    sha256 "45c3212a6755c7a6bda099b8fcd7c5f92014a350849f310ca3ca8cde63cc705b" => :mavericks
    sha256 "f9c3b08e17e19ad61058066c8988341e88369bfe0bf99a04a8edc3bf2a0959d6" => :x86_64_linux
    sha256 "04fc8d3b03381d87b3852ac1756dd144a10e7ac47444fa3e81dec0fc8ea33d25" => :mountain_lion
  end

  keg_only "BDB 4.8.30 is provided for software that doesn't compile against newer versions."

  # Fix build under Xcode 4.6
  patch :DATA

  def install
    # BerkeleyDB dislikes parallel builds
    ENV.deparallelize

    args = ["--disable-debug",
            "--prefix=#{prefix}",
            "--mandir=#{man}",
            "--enable-cxx"]

    # BerkeleyDB requires you to build everything from the build_unix subdirectory
    cd "build_unix" do
      system "../dist/configure", *args
      system "make", "install"

      # use the standard docs location
      doc.parent.mkpath
      mv prefix+"docs", doc
    end
  end
end

__END__
diff --git a/dbinc/atomic.h b/dbinc/atomic.h
index 0034dcc..50b8b74 100644
--- a/dbinc/atomic.h
+++ b/dbinc/atomic.h
@@ -144,7 +144,7 @@ typedef LONG volatile *interlocked_val;
 #define	atomic_inc(env, p)	__atomic_inc(p)
 #define	atomic_dec(env, p)	__atomic_dec(p)
 #define	atomic_compare_exchange(env, p, o, n)	\
-	__atomic_compare_exchange((p), (o), (n))
+	__atomic_compare_exchange_db((p), (o), (n))
 static inline int __atomic_inc(db_atomic_t *p)
 {
 	int	temp;
@@ -176,7 +176,7 @@ static inline int __atomic_dec(db_atomic_t *p)
  * http://gcc.gnu.org/onlinedocs/gcc-4.1.0/gcc/Atomic-Builtins.html
  * which configure could be changed to use.
  */
-static inline int __atomic_compare_exchange(
+static inline int __atomic_compare_exchange_db(
 	db_atomic_t *p, atomic_value_t oldval, atomic_value_t newval)
 {
 	atomic_value_t was;
