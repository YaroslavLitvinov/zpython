#!/bin/bash

NACL_TOOLCHAIN=${NACL_SDK_ROOT}/toolchain/linux_x86_glibc

export PATH=${PATH}:${NACL_TOOLCHAIN}/bin

LINK="-s -static -T \
${NACL_TOOLCHAIN}/x86_64-nacl/lib64/ldscripts/elf64_nacl.x.static \
-melf64_nacl -m64 \
-L${ZRT_ROOT}/lib -lzrt -lfs -lstdc++ -lzglibc"

#configure cpython to be built statically, also overrided LINKFORSHARED variable,
#although rest variables has been set to link it statically by nacl-gcc
PYTHONPATH="${ZPYTHON_ROOT}/Modules:$${ZPYTHON_ROOT}/Lib:${ZPYTHON_ROOT}" \
LINKFORSHARED="${LINK}" \
CC="x86_64-nacl-gcc" \
CXX="x86_64-naclg++" \
AR="x86_64-nacl-ar" \
RANLIB="x86_64-nacl-ranlib" \
LD_LIBRARY_PATH=${NACL_TOOLCHAIN}"/x86_64-nacl/lib" \
CFLAGS="-I${ZRT_ROOT}/lib" \
LDFLAGS=" -s -static -static-libgcc" \
LIBC="-lzglibc" \
./configure \
--host=x86_64-nacl \
--build=x86_64-linux-gnu \
--prefix=/python \
--without-threads \
--enable-shared=no 
