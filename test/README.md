cd ..

make

python tas.py examples/test.asm examples/test.tvm && ./tinyvm examples/test.tvm

make && python tas.py test/fib01.asm test/fib01.tvm && time ./tinyvm test/fib01.tvm

> 1.4s (for fib(30))
> 67.1s (for fib(38))

make && python tas.py test/fib02.asm test/fib02.tvm && time ./tinyvm test/fib02.tvm

> 0.8s (for fib(30))
> 38.3s (for fib(38))

TODO:
- Use direct threading dispatch or tail call dispatch
- Use actual registers (i.e. asm syntax)