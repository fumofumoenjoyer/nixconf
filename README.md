# nixconf
### Prerequisites
* NixOS
* Replace the ```hardware-configuration.nix``` for the one generated when you installed NixOS (usually on ```/etc/nixos```)


### Switch to config
```
cd nixconf
sudo nixos-rebuild boot --flake .#nixos-btw
```

### Update
```
cd nixconf
sudo nix flake update
sudo nixos-rebuild switch --flake .#nixos-btw
```
