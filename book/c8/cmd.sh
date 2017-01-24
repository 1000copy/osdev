nasm -f bin c08_mbr.asm -o a.bin
dd if=a.bin of=a.vhd bs=512 count=1 conv=notrunc 
nasm -f bin c08.asm -o b.bin
dd if=b.bin of=a.vhd bs=512 conv=notrunc seek=100