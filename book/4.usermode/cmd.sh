nasm -f bin c13_mbr.asm -o a.bin
dd if=a.bin of=a.vhd bs=512 count=1 conv=notrunc 
nasm -f bin c13_core.asm -o b.bin
dd if=b.bin of=a.vhd bs=512 count=1 conv=notrunc seek=1
nasm -f bin c13.asm -o c.bin
dd if=c.bin of=a.vhd bs=512 count=1 conv=notrunc seek=50
dd if=diskdata.txt of=a.vhd bs=512 count=1 conv=notrunc seek=100