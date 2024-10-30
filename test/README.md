cd ..

make

python tas.py examples/test.asm examples/test.tvm && ./tinyvm examples/test.tvm

python tas.py test/fib01.asm test/fib01.tvm && ./tinyvm test/fib01.tvm
