class Pgweb < Formula
  desc "Web-based PostgreSQL database browser"
  homepage "https://sosedoff.github.io/pgweb/"
  url "https://github.com/sosedoff/pgweb/archive/v0.11.7.tar.gz"
  sha256 "d35f74a6d80093764aece7b0a0ad6869799d04316efab077e0f7603835a9f159"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "38ad603da0bc035e5a905f44e22e70335d965a4ca62a2019d08a03cde3fe7f8c" => :catalina
    sha256 "7230e2f2ef476b2768a25796c3f20d45654eb8fa33ff171e70d91188df7e6527" => :mojave
    sha256 "536cc0ae5680a2c6316c569e2989868108f4b6626e496ec99c93e1ea823a7ba5" => :high_sierra
    sha256 "9390d1f9bed7b4326230994f6e0960f5b65a4902f3dc613416445063d723d6f2" => :x86_64_linux
  end

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/sosedoff/pgweb").install buildpath.children

    cd "src/github.com/sosedoff/pgweb" do
      # Avoid running `go get`
      inreplace "Makefile", "go get", ""

      system "make", "build"
      bin.install "pgweb"
      prefix.install_metafiles
    end
  end

  test do
    port = free_port

    begin
      pid = fork do
        exec bin/"pgweb", "--listen=#{port}",
                          "--skip-open",
                          "--sessions"
      end
      sleep 2
      assert_match "\"version\":\"#{version}\"", shell_output("curl http://localhost:#{port}/api/info")
    ensure
      Process.kill("TERM", pid)
    end
  end
end
