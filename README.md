# BurnedHTTP Server

(c) 0xFireball, 2015-2016

## Summary

BurnedHTTP Server was created as a more lightweight and performance-leaning alternative to [FireHTTP Server](https://github.com/AluminumDev/FireHTTP), also written by [FireHTTP Server](https://github.com/0xFireball). Since Haxe can compile to Neko bytecode and run at nearly native speeds in the Neko VM with JIT, BurnedHTTP Server is faster than FireHTTP Server on platforms other than Windows. However, it does not support the powerful scripting that FireHTTP Server supports. BurnedHTTP Server is written and optimized for use in Neko, but the source can also be built, unmodified, to the CPP and C# targets of Haxe.

Another cross-platform HTTP Server loosely based on [FireHTTP Server](https://github.com/AluminumDev/FireHTTP). Written in Haxe and
designed to be as cross-platform as possible, running in the Neko VM, BurnedHTTPServer
also can be scripted in Haxe through `hscript`.
