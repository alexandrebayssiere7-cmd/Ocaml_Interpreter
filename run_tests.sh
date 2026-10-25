#!/bin/sh
# Compile l'interpréteur puis vérifie :
#  - tests/*.kwa et web/examples/*.kwa : la sortie doit être identique au .expected voisin
#  - tests/errors/*.kwa                : le programme doit être rejeté (code de sortie 1)
set -u
cd "$(dirname "$0")"
dune build ./kawai.exe 2>&1 || exit 1

fail=0
for t in tests/*.kwa web/examples/*.kwa; do
  if ./kawai.exe "$t" 2>&1 | diff -u "${t%.kwa}.expected" - >/dev/null; then
    echo "ok    $t"
  else
    echo "FAIL  $t"; fail=1
  fi
done
for t in tests/errors/*.kwa; do
  ./kawai.exe "$t" >/dev/null 2>&1
  if [ $? -eq 1 ]; then echo "ok    $t"; else echo "FAIL  $t"; fail=1; fi
done
exit $fail
