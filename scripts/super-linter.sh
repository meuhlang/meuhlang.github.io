#!/usr/bin/env sh

set -o errexit
set -o nounset

main() {
  cd "$(dirname "$0")/.."

  docker run \
    --env FILTER_REGEX_EXCLUDE=site/docs/about/license.md \
    --env RUN_LOCAL=true \
    --env VALIDATE_CSS=false \
    --env VALIDATE_JAVASCRIPT_ES=false \
    --env VALIDATE_JAVASCRIPT_STANDARD=false \
    --mount "type=bind,src=${PWD},dst=/tmp/lint" \
    github/super-linter:v4.8.1
}

main "$@"
