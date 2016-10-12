PC OS的第一块被执行的代码被称为Boot Loader，它由PC BIOS加载到内存，并把代码控制权交给它。
# 工具准备

- nasm，汇编器，把asm文件汇编为机器语言。OS X的话已经内置。其他系统可能需要在 http://www.nasm.us/ 安装
- qemu，仿真器，可以仿真PC的运行。我们使用它来测试加载bootloader，而不是使用VMWare虚拟机护着是硬件启动。使用qemu会更方便
OS X没有内置，需要安装：
    brew install qemu

# 启动代码：
    ;boot.asm
    BITS 16
    start:
        ;设置堆栈sp,ss
        mov ax, 07C0h       ; Set up 4K stack space after this bootloader
        add ax, 288     ; (4096 + 512) / 16 bytes per paragraph
        mov ss, ax
        mov sp, 4096
        ;设置数据段ds
        mov ax, 07C0h       ; Set data segment to where we're loaded
        mov ds, ax
        ;打印字符
        mov si, text_string ; Put string position into SI
        call print_string   ; Call our string-printing routine
        ;无限循环
        jmp $           ; Jump here - infinite loop!
        text_string db 'This is my cool new OS!', 0
    print_string:           ; Routine: output string in SI to screen
        ;0Eh标识使用10号中断的打印字符功能
        mov ah, 0Eh     ; int 10h 'print char' function 
    .repeat:
        lodsb           ; Get character from string
        cmp al, 0
        je .done        ; If char is zero, end of string
        int 10h         ; Otherwise, print it
        jmp .repeat
    .done:
        ret
        times 510-($-$$) db 0   ; Pad remainder of boot sector with 0s
        dw 0xAA55       ; The standard PC boot signature
#使用nasm编译asm源代码到二进制文件
    
    nasm -f bin -o boot.bin boot.asm 
    
#创建镜像文件

##做一个可以承载img文件的空文件

    dd if=/dev/zero of=boot.img bs=512 count=2880

##拷贝bin文件到此新建映像文件内
对于OS X，使用命令：
    dd conv=notrunc if=boot.bin of=boot.img
对于Linux，使用命令：
    dd status=noxfer conv=notrunc if=boot.bin of=boot.img

## 使用仿真软件载入bootloader

仿真软件qemu可以模拟硬件和PC BIOS，从而使用它替代硬件的BIOS，来测试验证载入启动代码过程是否成功。

    qemu-system-i386 boot.bin

或者64-bit的
    qemu-system-x86_64 boot.bin

看到qemu内显示了消息就表示成功：
    Hello World. This is from the bootloader
