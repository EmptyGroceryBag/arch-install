#!/bin/bash

mount /dev/sda3 /mnt &&
mkdir /mnt/boot &&
mount /dev/sda1 /mnt/boot &&
mkdir -p /mnt/boot/EFI &&

cp ./locale.gen /etc/locale.gen &&
./packages.sh &&
genfstab -U /mnt >> /mnt/etc/fstab &&

arch-chroot /mnt /bin/bash <<"EOT"
ln -sf /usr/share/zoneinfo/America/New_York &&
hwclock --systohc &&
locale-gen &&
touch /etc/locale.conf &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "HOSTNAME_GOES_HERE" >> /etc/hostname &&
useradd -m joey &&
cd /home/joey &&
git clone https://github.com/EmptyGroceryBag/dotfiles.git &&
cd dotfiles &&
cp -r .config ~/.config &&
cp -r .vim ~/.vim &&
cp .vimrc ~/.vimrc &&
cp .zshrc ~/.zshrc &&
grub-install --target=x86_64-efi --efi-directory=/mnt/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
EOT
