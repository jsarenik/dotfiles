#!/bin/bash -vx

# From qpid-cpp-mrg.spec
# python_sitelib=`python -c "from distutils.sysconfig import get_python_lib; print get_python_lib()"`
# ruby_sitelib=`ruby -rrbconfig  -e 'puts Config::CONFIG["sitelibdir"]'`
# ruby_sitearch=`ruby -rrbconfig -e 'puts Config::CONFIG["sitearchdir"]'`

LOGFILE=$PWD/qpidcompile.log
exec </dev/null
exec 3>&1
> $LOGFILE
tailf $LOGFILE >&3 &
trap "kill $!" EXIT
exec >$LOGFILE 2>&1
# All the following will be logged to $LOGFILE

PREFIX=/usr/local
MAKE="make -j5 TMPDIR=/var/tmp"
LOCALES="LANG=sk_SK.utf8 LC_ALL=sk_SK.utf8"

NODEBUG="--without-valgrind"
DISTCHECK="$NODEBUG --disable-static --with-cpg"

#export CXXFLAGS="$CXXFLAGS -DNDEBUG -O3"

export LC_ALL=C
export LANG=C
unset PYTHONPATH

QPID_DIR=${1:-"$HOME/pub/git/qpid"}
QPID_DIR=`cd $QPID_DIR; pwd`
STORE_DIR=${2:-"$HOME/pub/git/store"}
STORE_DIR=`cd $STORE_DIR; pwd`

set -o pipefail

SUDO=sudo
test $UID -eq 0 && unset SUDO

_mybootstrap () {
    test -x configure || ./bootstrap
}

_myconfigure () {
    test -r Makefile || ./configure --prefix=$PREFIX $NODEBUG "$@"
}

__myclean () {
    $SUDO pkill qpidd
    sleep 2
    $SUDO pkill -9 qpidd
    $SUDO rm -rf $HOME/.qpidd /tmp/qpid*
}

_myautocheck () {
    __myclean && eval $LOCALES $MAKE check "$@" # || exit 1
    __myclean && eval $LOCALES $MAKE \
      DISTCHECK_CONFIGURE_FLAGS=\"$DISTCHECK\" \
      distcheck "$@" # || exit 1
}

_myinstall () {
    $SUDO $MAKE install "$@"
    $SUDO $MAKE installcheck "$@"
}

mymkdir () {
    test -d $1 || $SUDO mkdir -p $1
}

mybuild_auto () {
    cd $1; shift
    # the rest are flags for configure

    _mybootstrap &&
    _myconfigure "$@" &&
    $MAKE &&
    _myautocheck
    _myinstall
}

mybuild_python () {
    cd $1 &&
    python setup.py build &&
    $SUDO python setup.py install --prefix=$PREFIX
}

#
# Non-helper functions
#

qpid_build () {
    mybuild_auto $QPID_DIR/cpp --disable-static --with-cpg
}

store_build () {
    mybuild_auto $STORE_DIR/cpp --disable-static --disable-rpath \
        --disable-dependency-tracking \
        --with-qpid-checkout=$QPID_DIR
}

build_perftests () {
    perftests="
        perftest
        topic_listener
        topic_publisher
        latencytest
        client_test
        txtest
    "
    cd $QPID_DIR/cpp/src/tests &&
    $MAKE $perftests &&
    for ptest in $perftests; do
        $SUDO libtool --mode=install install -m755 $ptest $PREFIX/bin
    done &&
    $SUDO $MAKE install-qpidtestSCRIPTS
}

build_python_qpid () {
    mybuild_python $QPID_DIR/python &&
    mybuild_python $QPID_DIR/tools &&
    mybuild_python $QPID_DIR/extras/qmf &&
    mybuild_auto $QPID_DIR/extras/sasl &&
    cd $QPID_DIR/specs &&
    mymkdir $PREFIX/share/amqp &&
    $SUDO install -m644 amqp.0-10-qpid-errata.xml amqp.0-10.dtd \
        $PREFIX/share/amqp/
}

mymkdir $PREFIX
qpid_build &&
store_build &&
build_perftests &&
build_python_qpid
