class Husky < Formula
  desc "Open-source agent runtime platform"
  homepage "https://github.com/HandleCoding/OpenHuskyAgent"
  version "0.1.6"
  url "https://github.com/HandleCoding/OpenHuskyAgent/releases/download/v0.1.6/husky-macos-universal.tar.gz"
  sha256 "ed3c25bfae3876b52bb565d084ed301b84c5d074eedc71597b12e7823ee5e1cc"
  license "MIT"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    chmod 0755, libexec/"bin/husky"

    java_home = Formula["openjdk@17"].opt_prefix/"libexec/openjdk.jdk/Contents/Home"

    (bin/"husky").write <<~SH
      #!/bin/bash
      export JAVA_HOME="#{java_home}"
      export PATH="$JAVA_HOME/bin:$PATH"
      exec "#{opt_libexec}/bin/husky" "$@"
    SH
  end

  def caveats
    <<~EOS
      First run:
        husky init
        husky serve

      Homebrew installs openjdk@17 automatically and keeps the runtime bundle under:
        #{opt_libexec}
    EOS
  end

  test do
    assert_match "husky 0.1.6", shell_output("#{bin}/husky --version")
  end
end
