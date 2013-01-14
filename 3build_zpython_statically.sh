#!/bin/bash

NACL_TOOLCHAIN=${NACL_SDK_ROOT}/toolchain/linux_x86_glibc

export PATH=${PATH}:${NACL_TOOLCHAIN}/bin:

export PYTHONHOME=${ZPYTHON_ROOT}:${ZPYTHON_ROOT}/Lib
export HOSTPYTHON=./hostpython
export HOSTPGEN=./Parser/hostpgen
export PATH=${PATH}:${PLAT}"/bin"
export CROSS_COMPILE="x86_64-nacl-"
export CROSS_COMPILE_TARGET=yes
export HOSTARCH=amd64-linux
export BUILDARCH=x86_64-linux-gnu

make 

#copy python files into _install directory, all installed files should be accessible
#in filesystem in order to run python on zerovm+zrt

#CROSS_COMPILE=ppc_6xx-

make install HOSTPYTHON prefix=~/Python-3.2.2/_install

