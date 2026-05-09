class Husky < Formula
  desc "Open-source agent runtime platform"
  homepage "https://github.com/HandleCoding/OpenHuskyAgent"
  version "0.1.2"
  url "https://github.com/HandleCoding/OpenHuskyAgent/releases/download/v0.1.2/husky-macos-universal.tar.gz"
  sha256 "e4d91df85229d25c7f6ec6b3300d999c11057499ca7aae5e26d3111d012a6e10"
  license "MIT"

  depends_on "openjdk@17"

  def install
    libexec.install Dir["*"]
    chmod 0755, libexec/"husky-macos-universal/bin/husky"

    java_home = Formula["openjdk@17"].opt_prefix/"libexec/openjdk.jdk/Contents/Home"

    (bin/"husky").write <<~SH
      #!/bin/bash
      export JAVA_HOME="#{java_home}"
      export PATH="$JAVA_HOME/bin:$PATH"
      exec "#{opt_libexec}/husky-macos-universal/bin/husky" "$@"
    SH
  end

  def caveats
    <<~EOS
      First run:
        husky init
        husky serve

      Homebrew installs openjdk@17 automatically and keeps the runtime bundle under:
        #{opt_libexec}/husky-macos-universal
    EOS
  end

  test do
    assert_match "husky 0.1.2", shell_output("#{bin}/husky --version")
  end
end
