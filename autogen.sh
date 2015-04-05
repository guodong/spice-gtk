#!/bin/sh

set -e # exit on errors

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

(
    cd "$srcdir"
    git submodule update --init --recursive
    gtkdocize
    autoreconf -v --force --install
    intltoolize -f
)

CONFIGURE_ARGS="--enable-maintainer-mode --disable-gtk-doc --with-gtk=3.0 --disable-werror --enable-vala"

if [ -z "$NOCONFIGURE" ]; then
    echo "Running configure with $CONFIGURE_ARGS $@"
    "$srcdir/configure" $CONFIGURE_ARGS "$@"
fi
