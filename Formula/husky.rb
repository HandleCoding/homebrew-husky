class Husky < Formula
  desc "Open-source agent runtime platform"
  homepage "https://github.com/HandleCoding/OpenHuskyAgent"
  version "0.1.1"
  url "https://github.com/HandleCoding/OpenHuskyAgent/releases/download/v0.1.1/husky-macos-universal.tar.gz"
  sha256 "fe13ceb8890be7f6e652f85cf80f0b938444da7277240da3befcaf30e965cb5a"
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
        mkdir -p ~/.husky
        cp #{opt_libexec}/husky-macos-universal/.env.example ~/.husky/.env
        husky serve

      Homebrew installs openjdk@17 automatically and keeps the runtime bundle under:
        #{opt_libexec}/husky-macos-universal
    EOS
  end

  test do
    output = shell_output("#{bin}/husky invalid-command 2>&1", 1)
    assert_match "Usage: husky", output
  end
end
