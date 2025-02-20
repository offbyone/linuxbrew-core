class Py3cairo < Formula
  desc "Python 3 bindings for the Cairo graphics library"
  homepage "https://cairographics.org/pycairo/"
  url "https://github.com/pygobject/pycairo/releases/download/v1.20.0/pycairo-1.20.0.tar.gz"
  sha256 "5695a10cb7f9ae0d01f665b56602a845b0a8cb17e2123bfece10c2e58552468c"
  license any_of: ["LGPL-2.1-only", "MPL-1.1"]
  revision 1

  bottle do
    cellar :any
    sha256 "00bfdfca9a8665250cfc9d4f8c8eb96c0b4fd89676be20ed93b7846878c1b129" => :catalina
    sha256 "f36dfa15e2516165595fb12892f8ed3490cb1be28c5e51212746c54de7ac0223" => :mojave
    sha256 "0b82f9de10293fd7eb028ccb5d61dff9dd6b934376c9badde21a516b8fabcc24" => :high_sierra
    sha256 "af39d37b955707782985bf71261229caed6cc440d0942f1797a2cc95c51a6428" => :x86_64_linux
  end

  depends_on "pkg-config" => :build
  depends_on "cairo"
  depends_on "python@3.9"

  def install
    system Formula["python@3.9"].bin/"python3", *Language::Python.setup_install_args(prefix)
  end

  test do
    system Formula["python@3.9"].bin/"python3", "-c", "import cairo; print(cairo.version)"
  end
end
