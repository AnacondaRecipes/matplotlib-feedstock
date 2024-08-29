#!/bin/bash

set -ex

mkdir builddir
$PYTHON -m build --wheel --no-isolation --skip-dependency-check \
    -Cbuilddir=builddir \
    -Csetup-args=-Dsystem-freetype=true \
    -Csetup-args=-Dsystem-qhull=false \
    || (cat builddir/meson-logs/meson-log.txt && exit 1)
$PYTHON -m pip install dist/matplotlib*.whl
