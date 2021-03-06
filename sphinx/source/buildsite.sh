#!/bin/bash
set -x

apt-get update
apt-get -y install git rsync python3-sphinx

pwd ls -lah
export SOURCE_DATE_EPOCH=$(git log -1 --pretty=%ct)
 
##############
# BUILD DOCS #
##############
 
# Python Sphinx, configured with source/conf.py
# See https://www.sphinx-doc.org/
make clean
make html
 
# exit cleanly
exit 0
