# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    # Don't use the LTS kernel
    kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [
      "amd_iommu=pt"
      "iommu=soft"
    ];
    initrd.kernelModules = [
      "xhci_pci" 
      "ahci" 
      "nvme" 
      "usb_storage" 
      "usbhid" 
      "sd_mod" 
      "amdgpu"
    ];
  };

  hardware = {
    enableRedistributableFirmware = true;
    cpu = {
      amd.updateMicrocode = true;
    };
    opengl = {
      enable = true;
      driSupport = true; # This is already enabled by default
      driSupport32Bit = true; # For 32 bit applications
      
      # Taken from @fufexan's dotfiles
      # seem to fix random stuttering when playing videos
      extraPackages = with pkgs; [
        libva
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
  
  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Waydroid
  virtualisation.waydroid.enable = true;

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Disable LightDM (tty supremacy :D)
  # also, remove xterm (bloat :D)
  services.xserver.displayManager.lightdm.enable = false;
  services.xserver.excludePackages = with pkgs; [ xterm ];

  # dconf
  programs.dconf.enable = true;

  # Enable bweutooth
  # da bweutooth devais iz redy 2 pea
  services.blueman.enable = true;
  environment.systemPackages = with pkgs; [bluez bluez-tools];
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    package = pkgs.bluez;
  };
  
  # Hostname
  networking.hostName = "box";

  # Set your time zone
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  
  # ecks dee gee portals
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
  };

  environment = {
    # Automatically log in to Hyprland
    loginShellInit = ''
      [ "$TTY" = /dev/tty1 ] && Hyprland
    '';
    # Environment variables
    sessionVariables = {
      # Enable Wayland support
      # for most applications
      NIXOS_OZONE_WL = "1";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
    };
    variables = {
      EDITOR = "nvim";
      PATH = "~/.nimble/bin:$PATH";
    };
  };

  # Firewall stuff
  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 8080 ];
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };

  services.flatpak.enable = true;
  # services.xserver.enable = true;

  nix.gc = {
    automatic = true;  # Enable the automatic garbage collector
    dates = "48hr";   # When to run the garbage collector
    options = "-d";    # Arguments to pass to nix-collect-garbage
  };
  
  # User config
  programs.zsh.enable = true;
  users.users.tray = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      wpa_supplicant
      wl-clipboard
      gamescope
      killall
      libdrm
    ];
  };
  
  # Nerd Fonts
  fonts.packages = with pkgs; [
    fira-code
    noto-fonts-cjk-sans
    noto-fonts
    (nerdfonts.override {
      fonts = [
        "IBMPlexMono"
	"JetBrainsMono"
	"ProFont"
	"Ubuntu"
	"AnonymousPro"
	"RobotoMono"
      ];
    })
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # TLP and ThermalD
  # Battery life go brrrr
  services.thermald.enable = true;
  services.tlp = {
    enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MIN_PERF_ON_BAT = 0;
        CPU_MAX_PERF_ON_BAT = 20;

        # Optional helps save long term battery health
        START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
        STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      };
  };

  nix.settings.experimental-features = [
	"nix-command"
	"flakes"
  ];

  security = {
    tpm2.enable = true;
    pam.services.hyprlock = { # Hyprlock fix for wrong password -- thanks, Justin!
      text = '' 
        auth include login 
      ''; 
    };
  };

  system.stateVersion = "24.05";
}

