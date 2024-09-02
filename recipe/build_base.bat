@echo on

set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig;%BUILD_PREFIX%\Library\lib\pkgconfig"
"%PYTHON%" -m build --wheel --no-isolation --skip-dependency-check ^
    -Cbuilddir=builddir ^
    -Csetup-args=-Dsystem-freetype=true ^
    -Csetup-args=-Dsystem-qhull=false
if errorlevel 1 (
  type builddir\meson-logs\meson-log.txt
  exit /b 1
)

%PYTHON% -m pip install --no-deps --no-build-isolation --no-index --find-links dist matplotlib
if errorlevel 1 exit 1
