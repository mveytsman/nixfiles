# nixfiles

# Install

System

- clone this repo into `/etc/nixos`

```
echo \"$(mkpasswd -m sha-512)\" > /etc/nixos/secrets/hashedPassword.nix
export NIXOS_CONFIG=/etc/nixos/hosts/$HOST/default.nix
nixos-rebuild switch
chown -R maxim /etc/nixos
chown -R root secrets/
chmod -R 400 secrets/
```

User

```
ln -s /etc/nixos/home/ $HOME/.config/nixpkgs # I wish I knew a better way here
home-manager switch
```

# Inspiration

Thanks so much to
- https://github.com/shazow/nixfiles
- https://github.com/ghedamat/nixfiles
- https://github.com/sondr3/dotfiles
