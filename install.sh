#!/bin/bash

mount /dev/sda1 /mnt &&
cp ./locale.gen /etc/locale.gen &&
./packages.sh &&
genfstab -U /mnt >> /mnt/etc/fstab &&

arch-chroot /mnt /bin/bash <<"EOT"
ln -sf /usr/share/zoneinfo/America/New_York &&
hwclock --systohc &&
locale-gen &&
touch /etc/locale.conf &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "arch-test" >> /etc/hostname &&
useradd -m joey &&
cd /home/joey &&
git clone https://github.com/EmptyGroceryBag/dotfiles.git &&
cd dotfiles &&
cp -r .config ~/.config &&
cp -r .vim ~/.vim &&
cp .vimrc ~/.vimrc &&
cp .zshrc ~/.zshrc &&
grub-install --target=i386-pc /dev/sda
EOT
