#!/bin/bash

printf "%x\n" `stat -c "%s" ${1}`
