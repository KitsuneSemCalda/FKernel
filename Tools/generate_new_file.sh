#!/usr/bin/env bash
set -euo pipefail

AUTHOR="$(git config user.name)"
EMAIL="$(git config user.email)"
DATE="$(date +%F)"
LICENSE="SPDX-License-Identifier: $(head -n 1 LICENSE 2>/dev/null | sed -E 's/[[:space:]]*License//I' | xargs || echo "UNKNOWN")"

if [ $# -lt 1 ]; then
  echo "Uso: $0 caminho/ArquivoBase (ex: Boot/Efi)"
  exit 1
fi

MODULE_PATH="$1" # Ex: Boot/Efi

HEADER_DIR="Include/$(dirname "$MODULE_PATH")"
SRC_DIR="Src/$(dirname "$MODULE_PATH")"
TEST_DIR="Test/$(dirname "$MODULE_PATH")"

HEADER_BASENAME="$(basename "$MODULE_PATH").h"
SRC_BASENAME="$(basename "$MODULE_PATH").c"
TEST_BASENAME="$(basename "$MODULE_PATH").test.c"

HEADER_FILE="${HEADER_DIR}/${HEADER_BASENAME}"
SRC_FILE="${SRC_DIR}/${SRC_BASENAME}"
TEST_FILE="${TEST_DIR}/${TEST_BASENAME}"

mkdir -p "$HEADER_DIR" "$SRC_DIR" "$TEST_DIR"

generate_test() {
  cat <<EOF
/*
 * Filename: $(basename "$1")
 * Project: KitsuneBSD / FKernel - Test Suite
 * Author: ${AUTHOR} <${EMAIL}>
 * Created On: ${DATE}
 * License: ${LICENSE}
 */

#include <assert.h>
#include "${HEADER_FILE}"

int main(void) {
    // TODO: Implementar testes para $(basename "$MODULE_PATH")

    // Exemplo:
    // assert(func_x(1) == 2);

    return 0;
}
EOF
}

generate_header() {
  cat <<EOF
/*
 * Filename: $(basename "$1")
 * Project: KitsuneBSD / FKernel
 * Author: ${AUTHOR} <${EMAIL}>
 * Created On: ${DATE}
 * License: ${LICENSE}
 */
EOF
}

{
  generate_header "$HEADER_FILE"
  echo "#pragma once"
} >"$HEADER_FILE"

generate_header "$SRC_FILE" >"$SRC_FILE"
generate_test "$TEST_FILE" >"$TEST_FILE"

echo "✔️ Arquivos gerados com sucesso:"
echo " - $HEADER_FILE"
echo " - $SRC_FILE"
echo " - $TEST_FILE"
