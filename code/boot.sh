nasm -f bin -o boot.bin boot.asm 
dd if=/dev/zero of=boot.img bs=512 count=2880
dd conv=notrunc if=boot.bin of=boot.img
qemu-system-i386 boot.bin