
{ config, pkgs, ... }:

{
    imports =
        [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
        ];

# Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;


    networking.hostName = "nixos"; # Define your hostname.


        networking.networkmanager.enable = true;
    programs.nm-applet.enable = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];


    time.timeZone = "Europe/Warsaw";

    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "pl_PL.UTF-8";
        LC_IDENTIFICATION = "pl_PL.UTF-8";
        LC_MEASUREMENT = "pl_PL.UTF-8";
        LC_MONETARY = "pl_PL.UTF-8";
        LC_NAME = "pl_PL.UTF-8";
        LC_NUMERIC = "pl_PL.UTF-8";
        LC_PAPER = "pl_PL.UTF-8";
        LC_TELEPHONE = "pl_PL.UTF-8";
        LC_TIME = "pl_PL.UTF-8";
    };

    services.xserver = {
        enable = true;
        layout = "us,ru";
        xkbVariant = "";
        xkbOptions = "grp:alt_shift_toggle";

        desktopManager = {
            xfce.enable = true;
        };

        displayManager = {
            autoLogin = {
                enable = true;
                user = "yasakar";
            };
        };

    };

# bspwm
    services.xserver.windowManager.bspwm.enable = true;
    services.xserver.windowManager.bspwm.configFile = "/home/yasakar/.config/bspwm/bspwmrc";
    services.xserver.windowManager.bspwm.sxhkd.configFile= "/home/yasakar/.config/bspwm/sxhkdrc";
    services.xserver.displayManager.defaultSession = "none+bspwm";
    services.picom.enable = true;

    hardware = {
        bluetooth = {
            enable = true;
        };
    };
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };


#nvidia

    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia.modesetting.enable = true;


    hardware.nvidia.prime = {
        offload = {
            enable = true;
            enableOffloadCmd = true;
        };

# integrated
        intelBusId = "PCI:0:2:0";

# dedicated
        nvidiaBusId = "PCI:1:0:0";
    };


# Enable CUPS to print documents.
    services.printing.enable = true;


# Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;

    };


    users.users.yasakar = {
        isNormalUser = true;
        description = "yasakar";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            firefox

        ];
    };



    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        neovim
            openssh 
            steam
            discord
            neofetch
            obsidian
            telegram-desktop


#custom desktop
            rofi
            polybar
            kitty
            bluez
            sxhkd
            brightnessctl
            feh
            xscreensaver

            wget
            wineWowPackages.stable
            winetricks
            git
            home-manager
            mpv
            mangohud
            protonup
            curl
            qbittorrent
            unzip
            vscode
            glow
            pavucontrol
            spotify
            bottles
            jetbrains.idea-community
            zsh
            jq


            python3
            gcc
            clang
            rebar3
            libreoffice-qt
            uair
            ];

    programs.steam = {
        enable = true;
        dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    };
    programs.steam.gamescopeSession.enable = true;
    programs.gamemode.enable = true;


#for telegram
    nixpkgs.config.permittedInsecurePackages = [
        "electron-25.9.0"
    ];

# подключение nvme
    fileSystems."/desired/mount/point" = {
        device = "/dev/nvme0n1p1"; 
        fsType = "ntfs";      
    };


#power management
#services.tlp.enable = true;


    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];


    system.stateVersion = "23.11";

}
