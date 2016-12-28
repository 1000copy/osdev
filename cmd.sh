nasm -f bin a.asm -o a.bin
dd if=a.bin of=a.vhd bs=512 count=1 conv=notrunc 