#!/usr/bin/env sh

set -o errexit
set -o nounset

main() {
  cd "$(dirname "$0")/.."

  set -- lvjp/mkdocs:v1.2.3-3 mkdocs "$@"

  if [ "${3:-}" = "serve" ]; then
    os=$(docker version --format '{{.Client.Os}}')
    case "${os}" in
      darwin) set -- --publish 8000:8000 "$@" --dev-addr 0.0.0.0:8000;;
      linux) set -- --network host "$@";;
      *)
        echo "Unsupported os: ${os}"
        exit 1
        ;;
    esac
  fi

  docker run \
    --mount "type=bind,src=${PWD}/site,dst=/work,ro" \
    --workdir /work \
    --rm \
    "$@"
}

main "$@"
