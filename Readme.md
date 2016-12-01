# hstatic-example

## Intro

Example of how to statically compile a haskell stack project.

This project depends on the docker build flow in stack.

## Running the example
There are two make targets for running the example.

To run the example in the resulting docker image:
```sh
make run_image
```

To run the example using stack:
```sh
make run
```

## Cleaning up the example
Run `make clean`, this will remove all of the stack build target, intermediate files, and docker images.

## Try it Out
Try running it with a centos container:
```sh
docker run -it -v `pwd`/dist:/dist --rm centos:6.6 /dist/hstatic-example
docker run -it -v `pwd`/dist:/dist --rm centos:latest /dist/hstatic-example
```

How about ubuntu:
```sh
docker run -it -v `pwd`/dist:/dist --rm ubuntu:latest /dist/hstatic-example
```

## Details

When trying to compile a static binary one may run into the following bug when tyring to link the c-runtime statically with gcc.

 /usr/bin/ld: error: /usr/lib/gcc/x86_64-linux-gnu/5/crtbeginT.o: requires dynamic R_X86_64_32 reloc against '__TMC_END__' which may overflow at runtime; recompile with -fPIC 

To build a static binary we apply the workaround in [640734](https://bugs.launchpad.net/ubuntu/+source/gcc-4.4/+bug/640734) to the fpco/stack-build docker image.


See:

https://www.fpcomplete.com/blog/2016/10/static-compilation-with-stack

http://askubuntu.com/questions/530617/how-to-make-a-static-binary-of-coreutils

https://bugs.launchpad.net/ubuntu/+source/gcc-4.4/+bug/640734


