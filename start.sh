#!/bin/bash

ruby tools/file-converter.rb

echo Uninstalling Nerdfeud:
adb -d uninstall no.whirlwin.nerdfeud

ant debug install

echo Starting Nerdfeud:
adb -d shell am start -n no.whirlwin.nerdfeud/.Main
