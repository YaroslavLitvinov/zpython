#!/bin/bash

./configure

make HOSTPGEN=./Parser/pgen python Parser/pgen

mv python hostpython

mv Parser/pgen Parser/hostpgen

make distclean
