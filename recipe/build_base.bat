@echo on

set "PKG_CONFIG_PATH=%LIBRARY_LIB%\pkgconfig;%LIBRARY_PREFIX%\share\pkgconfig;%BUILD_PREFIX%\Library\lib\pkgconfig"

%PYTHON% -m pip install . --no-deps --no-build-isolation -vv ^
    --config-settings=setup-args="-Dsystem-freetype=true" ^
    --config-settings=setup-args="-Dsystem-qhull=true"
if errorlevel 1 exit 1
