# homebrew-husky

Official Homebrew tap for Husky.

## Install

```bash
brew tap HandleCoding/husky
brew install HandleCoding/husky/husky
mkdir -p ~/.husky
cp "$(brew --prefix husky)/libexec/husky-macos-universal/.env.example" ~/.husky/.env
husky serve
```

## Release maintenance

When a new Husky release is published from `HandleCoding/OpenHuskyAgent`:

1. Publish the GitHub release tag from the main repository.
2. Wait for the release workflow to upload `husky-macos-universal.tar.gz` and `husky-macos-universal.tar.gz.sha256`.
3. Copy the SHA256 from `husky-macos-universal.tar.gz.sha256`.
4. Update `Formula/husky.rb` with the new `version`, `url`, and `sha256`.
5. Commit and push this tap repository.
