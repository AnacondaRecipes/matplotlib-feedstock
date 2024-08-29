#!/bin/bash
set -ex

export AR=$GCC_AR
export PKG_CONFIG_PATH="${BUILD_PREFIX}/bin/pkg-config:${BUILD_PREFIX}/lib/pkgconfig:${PREFIX}/bin/pkg-config:${PREFIX}/lib/pkg-config"

$PYTHON -m pip install . -vv \
    --no-deps --no-build-isolation \
    --config-settings=setup-args="-Dsystem-freetype=true" \
    --config-settings=setup-args="-Dsystem-qhull=true"
