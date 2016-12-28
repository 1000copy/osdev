#工具nasm

使用汇编语言就必须有一个可以把汇编代码编译为机器语言的工具。nasm是一个开源的、被广泛使用的汇编工具，它可以把汇编语言编写的文件编译为二进制的，机器可运行的代码。

可以从此处下载：http://www.nasm.us/。

为了验证此工具的有效性和使用方法，我们会使用如下的汇编代码，文件内容为(a.asm)：

	mov ax,3fh 
	add bx,ax  
	add cx,ax  

首先，创建文件：

	echo mov ax,3fh > a.asm
	echo add bx,ax  >>a.asm
	echo add cx,ax  >>a.asm


使用nasm编译此文件：

 	nasm -f bin a.asm -o a.bin

使用可以阅读16进制的编辑器，打开a.bin，应该可以看到：

	b83f 0001 c301 c1
	
汇编器nasm可以通过-f指定很多输出格式，列表可以使用

	nasm -hf

输出为：

		valid output formats for -f are (`*' denotes default):

	  * bin       flat-form binary files (e.g. DOS .COM, .SYS)
	    aout      Linux a.out object files
	    aoutb     NetBSD/FreeBSD a.out object files
	    coff      COFF (i386) object files (e.g. DJGPP for DOS)
	    elf       ELF32 (i386) object files (e.g. Linux)
	    as86      Linux as86 (bin86 version 0.3) object files
	    obj       MS-DOS 16-bit/32-bit OMF object files
	    win32     Microsoft Win32 (i386) object files
	    rdf       Relocatable Dynamic Object File Format v2.0
	    ieee      IEEE-695 (LADsoft variant) object file format
	    macho     NeXTstep/OpenStep/Rhapsody/Darwin/MacOS X object files

我们这里使用的是flat-form binary文件。

