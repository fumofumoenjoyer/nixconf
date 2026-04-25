{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.limine.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  boot.kernelModules = [ "ntsync" ];
  
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642; # SteamOS default
  };   
  
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-"; # "-" sets both soft and hard limits
      item = "nofile";
      value = "1048576";
    }
  ];   
  
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;
  
  systemd.package = pkgs.systemd.override { withUserDb = false; };
  services.userdbd.enable = lib.mkForce false;

  security.rtkit.enable = true; # Realtime priority for audio

  services.pulseaudio.enable = false; # Disable PulseAudio in favor of PipeWire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for Steam/Wine
    extraPackages = [
      pkgs.lsfg-vk
      ];
  };

  #Power Profiles Daemon
  services.power-profiles-daemon.enable = true;

  # GPU Daemon (Overclocking/Fan control)
  services.lact.enable = true;

  time.timeZone = "America/Asuncion";
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocales = [ "ja_JP.UTF-8/UTF-8" ];
  };

  services.displayManager.cosmic-greeter.enable = true;
  services.desktopManager.cosmic.enable = true;

  users.users.fumo = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "libvirt" ];
    packages = with pkgs; [
      
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    nixd
    nixpkgs-fmt
    vim
    wget
    git
    sbctl
    brave
    antigravity-fhs
    _7zz
    unrar
    fastfetch
    file-roller
    thunderbird
    lollypop
    gthumb
    mpv
    appimage-run
    mangohud
    goverlay
    lact
    (heroic.override {
      extraPkgs = pkgs': with pkgs'; [
        gamescope
        gamemode
      ];
    })
    lsfg-vk-ui
    
  ];
  
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zsh = {
    enable = true;
  };
  
  programs.gamescope.enable = true;
  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "com.usebottles.bottles"
    "com.github.tchx84.Flatseal"
    "com.discordapp.Discord"
    "com.protonvpn.www"
    "com.stremio.Stremio"
    "com.vysp3r.ProtonPlus"
    "net.retrodeck.retrodeck"
    "org.vinegarhq.Sober"
    "com.obsproject.Studio"
  ];
  # Dynamically linked executables
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [

  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      ipafont
      kochi-substitute
      liberation_ttf
      nerd-fonts.symbols-only
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu
      nerd-fonts.hack
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
      
    ];
  };
  
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true; # TPM support for Windows 11 VMs
      };
    };
    podman = {
      enable = true;
      dockerCompat = true; # Aliases docker -> podman
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  programs.virt-manager.enable = true;
  services.spice-vdagentd.enable = true; # Clipboard sharing with VMs


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

}
