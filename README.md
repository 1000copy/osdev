# osdev simplize start up code

源代码：

	mov ax,0xb800
	mov ds,ax
	mov byte[0x00],'a'
	mov byte[0x02],'s'
	mov byte[0x04],'m'
	jmp $
	times 510-($-$$) db 0
	db 0x55,0xaa

创建虚拟盘：

    使用vitual box创建一个固定尺寸的虚拟盘VHD。在a.vhd

执行cmd.sh,即可编译代码并把bin文件拷贝到a.vhd上。

随后启动vitual box的虚拟机，看到显示asm三个字母。