#!/bin/bash

PLAT=${NACL_SDK_ROOT}/toolchain/linux_x86_glibc
export PATH=${PATH}:${PLAT}/bin

make \
PYTHONHOME=${ZPYTHON_ROOT}:${ZPYTHON_ROOT}/Lib \
HOSTPYTHON=./hostpython \
HOSTPGEN=./Parser/hostpgen \
PATH=${PATH}:${PLAT}"/bin" \
CROSS_COMPILE="x86_64-nacl-" \
CROSS_COMPILE_TARGET=yes \
HOSTARCH=amd64-linux \
BUILDARCH=x86_64-linux-gnu


#copy python files into _install directory, all installed files should be accessible
#in filesystem in order to run python on zerovm+zrt

#make install HOSTPYTHON=./hostpython CROSS_COMPILE=ppc_6xx- CROSS_COMPILE_TARGET=yes prefix=~/Python-3.2.2/_install

