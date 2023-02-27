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

if [[ $(uname) == "Darwin" ]]; then
  export CFLAGS="${CFLAGS} -Wno-unused-command-line-argument"
  export CXXFLAGS="${CXXFLAGS} -Wno-unused-command-line-argument"
fi

# System's gcc compiler is randomly picked on linux-s390x,
# rather than the conda's one, so we need to force it to use the correct one.
# Probably worth doing on all linux based archs.
# Also, it builds some parts of numpy when creating the wheel. Compilation 
# crashes on s390x arch, unless the following optimisation flags are present.
if [[ $target_platform == linux-* ]]; then
  ln -f -s ${CC} gcc
  export PATH=${PWD}:$PATH
  if [[ $target_platform == "linux-s390x" ]]; then
    export CFLAGS="${CFLAGS} -mno-vx"
    export CXXFLAGS="${CXXFLAGS} -mno-vx"
  fi
fi

$PYTHON -m pip install . --no-deps -vvv
