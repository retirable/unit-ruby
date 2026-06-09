# Changelog

## 1.1.1

- Publish releases automatically to RubyGems.org via OIDC trusted publishing when `version.rb` changes on `main`.

## 1.1.0

- Support Rails 8 / Active Support 8 (widen the `activesupport` dependency to `>= 7.0, < 9`).
- Stop committing `Gemfile.lock` so applications resolve dependencies against the gemspec

## 1.0.1

- Resolve dependency vulnerabilities by bumping vulnerable transitive dependencies.

## 1.0.0

- First stable release, promoting the 0.12.x API to 1.0 with no breaking changes.
- Expanded README documentation and cleaned up the gemspec and CI configuration.

## 0.1.0

Initial release
