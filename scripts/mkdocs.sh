#!/usr/bin/env sh

set -o errexit
set -o nounset

main() {
  cd "$(dirname "$0")/.."

  docker run \
    --mount "type=bind,src=${PWD}/site,dst=/work,ro" \
    --workdir /work \
    --network host \
    lvjp/mkdocs:v1.2.3-2 \
    mkdocs "$@"
}

main "$@"
