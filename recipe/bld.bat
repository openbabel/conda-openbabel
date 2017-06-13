cmake ^
      -G "%CMAKE_GENERATOR%" ^
      -DCMAKE_INSTALL_PREFIX=%PREFIX% ^
      -DWITH_INCHI=ON ^
      -DOPENBABEL_USE_SYSTEM_INCHI=FALSE^
      -DPYTHON_EXECUTABLE=%PYTHON% ^
      -DPYTHON_BINDINGS=ON ^
      -DRUN_SWIG=ON ^
      -DCMAKE_BUILD_TYPE=Release ^
      .


cmake --build . --target install --config Release -- -j2

:: Where should BABEL_DATADIR go?
xcopy %PREFIX%\bin\data %PREFIX%\share\openbabel /e /c
rmdir /s /q %PREFIX%\bin\data

xcopy %PREFIX%\bin %PREFIX%\Library\bin /e /c
rmdir /s /q %PREFIX%\bin

set "BABEL_DATADIR=%PREFIX%/bin/data/"

ctest -j2 --output-on-failure

echo "Done!"
