#!/usr/bin/env sh

set -o errexit
set -o nounset

main() {
  cd "$(dirname "$0")/.."

  if command -v mkdocs > /dev/null 2>&1; then
    cd site
    exec mkdocs "$@"
  fi

  docker build \
    --tag local/meuhlang.github.io/mkdocs:latest \
    - < ./scripts/mkdocs.Dockerfile

  docker run \
    --mount "type=bind,src=${PWD}/site,dst=/work,ro" \
    --workdir /work \
    --network host \
    local/meuhlang.github.io/mkdocs:latest \
    mkdocs "$@"
}

main "$@"