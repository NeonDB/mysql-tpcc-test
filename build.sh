#!/bin/bash

which mysql_config
if [ $? != 0 ] ; then
    echo "Error: must have mysql_config in $PATH"
    exit 1
fi

cd tpcc-mysql/src ; make
