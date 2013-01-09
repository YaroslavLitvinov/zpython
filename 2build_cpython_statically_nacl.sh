#!/bin/bash

SCRIPT=$(readlink -f "$0")
SCRIPT_PATH=`dirname "$SCRIPT"`

PLAT=${NACL_SDK_ROOT}/toolchain/linux_x86_glibc
ZRT_LIB=${ZRT_ROOT}/lib
LINK="-T ${PLAT}/x86_64-nacl/lib64/ldscripts/elf64_nacl.x.static -melf64_nacl -m64 -L${ZRT_LIB} -lzrt -lfs -lstdc++ -lzglibc"

export PATH=${PATH}:${PLAT}/bin
echo $PATH

#configure cpython to be built statically, override LINKFORSHARED variable bu flags related to statically linked NaCl code
PYTHONPATH="${SCRIPT_PATH}/Modules:${SCRIPT_PATH}/Lib:${SCRIPT_PATH}" \
LINKFORSHARED="${LINK}" \
CC="x86_64-nacl-gcc" \
CXX="x86_64-naclg++" \
AR="x86_64-nacl-ar" \
RANLIB="x86_64-nacl-ranlib" \
LD_LIBRARY_PATH=${PLAT}"/x86_64-nacl/lib" \
CFLAGS="-D__NACL__ -I${ZRT_LIB}" \
LDFLAGS=" -s -static -static-libgcc" \
LIBC="-lzglibc" \
./configure --host=x86_64-nacl --build=x86_64-linux-gnu --prefix=/python --without-threads --enable-shared=no 

echo MAKE PYTHON

make PYTHONHOME=${SCRIPT_PATH}:${SCRIPT_PATH}/Lib HOSTPYTHON=./hostpython HOSTPGEN=./Parser/hostpgen PATH=${PATH}:${PLAT}"/bin" CROSS_COMPILE="x86_64-nacl-" CROSS_COMPILE_TARGET=yes HOSTARCH=amd64-linux BUILDARCH=x86_64-linux-gnu

#echo INSTALL PYTHON
#make install HOSTPYTHON=./hostpython CROSS_COMPILE=ppc_6xx- CROSS_COMPILE_TARGET=yes prefix=~/Python-3.2.2/_install

