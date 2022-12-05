#!/bin/bash

cat <<EOF > conda_mpl_config.cfg
[directories]
basedirlist = $PREFIX

[packages]
tests = False
toolkit_tests = False
sample_data = False

[libs]
system_freetype = True

EOF

cat conda_mpl_config.cfg
sed -i.bak "s|/usr/local|${PREFIX}|" setupext.py

export MPLSETUPCFG=conda_mpl_config.cfg
export XDG_CACHE_HOME=${BUILD_PREFIX}/matplotlib.cache/
mkdir build
curl http://www.qhull.org/download/qhull-2020-src-8.0.2.tgz --output ./build/qhull-2020-src-8.0.2.tgz
tar zxvf ./build/qhull-2020-src-8.0.2.tgz -C ./build

if [[ $(uname) == "Darwin" ]]; then
  export CFLAGS="${CFLAGS} -Wno-unused-command-line-argument"
  export CXXFLAGS="${CXXFLAGS} -Wno-unused-command-line-argument"
fi

$PYTHON -m pip install . --no-deps -vv
