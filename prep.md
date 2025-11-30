# Prep-install


### connect to wifi

```nix
sudo systemctl start wpa_supplicant
wpa_cli
add_network
set_network 0 ssid "myhomenetwork"
set_network 0 psk "mypassword"
enable_network 0
quit
```


### Run shell  as sudo

```nix
sudo -i
```


### Keyboard language

```nix
loadkeys uk
```


### Partitioning

```nix
printf "label: gpt\n,2048M,U\n,,L\n" | sfdisk /dev/nvme0n1
```


### Formating

```nix
nix-shell -p btrfs-progs
mkfs.fat -F 32 -n boot /dev/nvme0n1p1
mkfs.btrfs /dev/nvme0n1p2
```


### Create subvolumes

```nix
mkdir -p /mnt
mount /dev/nvme0n1p2 /mnt
btrf subvolume create /mnt/@
btrf subvolume create /mnt/@nix
btrf subvolume create /mnt/@home
btrf subvolume create /mnt/@swap
umount /mnt
```


### Mount

```nix
mount -o defaults,noatime,space_cache=v2,ssd,discard=async,compress=zstd:3,subvol=@ /dev/nvme0n1p2 /mnt
mkdir /mnt/{boot,nix,home,swap}
mount -o defaults,noatime,space_cache=v2,ssd,discard=async,compress=zstd:1,subvol=@nix /dev/nvme0n1p2 /mnt/nix
mount -o defaults,noatime,space_cache=v2,ssd,discard=async,compress=zstd:3,subvol=@home /dev/nvme0n1p2 /mnt/home
mount -o defaults,compress=no,nodatacow,ssd,discard=async,subvol=@swap /dev/nvme0n1p2 /mnt/swap
mount /dev/nvme0n1p1 /mnt/boot
```


###  Create & activate Swapfile

```nix
btrfs filesystem mkswapfile --size 70g --uuid clear /mnt/swap/swapfile
swapon /dev/nvme0n1p2 /mnt/swap/swapfile
```


### Generate config --flake

```nix
nixos-generate-config --root /mnt --flake
```
