#!/bin/sh

set -e

module="BigNumber"
github="mkrd/Swift-Big-Integer"
project="Swift-BigNumber.xcodeproj"
scheme="BigNumber"

# get version number from podspec
version="$(egrep "^\s*s.version\s*" BigNumber.podspec | awk '{ gsub("\"", "", $3);  print $3 }')"
today="$(date '+%Y-%m-%d')"

if git rev-parse "v$version" >/dev/null 2>&1; then
    # Use the tagged commit when we have one
    ref="v$version"
else
    # Otherwise, use the current commit.
    ref="$(git rev-parse HEAD)"
fi

jazzy \
    --clean \
    --github_url "https://github.com/$github" \
    --github-file-prefix "https://github.com/$github/tree/$ref" \
    --module-version "$version" \
    --xcodebuild-arguments "-project,$project,-scheme,$scheme" \
    --module "$module" \
    --root-url "https://mkrd.github.io/$module/reference/" \
    --theme fullwidth \
    --output docs \
    --min-acl public\
    --hide-documentation-coverage\
    --copyright "[© 2018 BigNumber](https://github.com/mkrd/Swift-Big-Integer/blob/master/LICENSE). (Last updated: $today)" \
    --author "mkrd" \
    --author_url "https://github.com/mkrd" \
