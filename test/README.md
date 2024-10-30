cd ..

make

python tas.py examples/test.asm examples/test.tvm && ./tinyvm examples/test.tvm

make && python tas.py test/fib01.asm test/fib01.tvm && time ./tinyvm test/fib01.tvm

> 1.4s (for fib(30))