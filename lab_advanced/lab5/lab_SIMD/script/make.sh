#!/bin/bash


INCLUDEDIR=./include
SRCDIR=./src
OBJDIR=./obj
BINDIR=./bin

mkdir $OBJDIR
mkdir $BINDIR

gcc -I $INCLUDEDIR -c $SRCDIR/cmn.c -o $OBJDIR/cmn.o
gcc -I $INCLUDEDIR -c $SRCDIR/sse.c -o $OBJDIR/sse.o -msse
gcc -I $INCLUDEDIR -c $SRCDIR/avx.c -o $OBJDIR/avx.o -mavx
gcc -I $INCLUDEDIR -c $SRCDIR/main.c -o $OBJDIR/main.o

gcc $(ls $OBJDIR/*) -o ./bin/test