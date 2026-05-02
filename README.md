# nixconf

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
