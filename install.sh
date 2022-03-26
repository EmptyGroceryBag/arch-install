timedatectl set-ntp true &&
mkfs.ext4 /dev/sda1 &&
mkswap /dev/sda2 &&
swapon /dev/sda2 &&
mount /dev/sda1 /mnt &&
genfstab -U /mnt >> /mnt/etc/fstab &&
./packages.sh &&
arch-chroot /mnt &&
ln -sf /usr/share/zoneinfo/America/New_York &&
hwclock --systohc &&
cp ./locale.gen /etc/locale.gen &&
locale-gen &&
touch /etc/locale.conf &&
echo "LANG=en_US.UTF-8" >> /etc/locale.conf &&
echo "arch-test" >> /etc/hostname &&
useradd -m joey &&
cd /home/joey &&
git clone https://github.com/EmptyGroceryBag/dotfiles &&
cp -r .config ~/.config &&
cp -r .vim ~/.vim &&
cp .vimrc ~/.vimrc &&
cp .zshrc ~/.zshrc &&
grub-install --target=1386-pc /dev/sda &&
exit
