
{ config, pkgs, ... }:



{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Bootloader.
	boot.loader.systemd-boot.enable = false;

	boot.loader.grub.enable = true;
	boot.loader.grub.useOSProber = true;
	boot.loader.grub.efiSupport = true;
	boot.loader.efi.efiSysMountPoint = "/boot";
	boot.loader.grub.device = "nodev";	

	boot.loader.efi.canTouchEfiVariables = true;


	networking.hostName = "nixos"; # Define your hostname.


    networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 7d";
	};


	time.timeZone = "Europe/Warsaw";
#time.timeZone = "Europe/Moscow";

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

  systemd.services.NetworkManager-wait-online.enable = false;


	services.xserver = {
		enable = true;
		layout = "us,ru";
		xkbVariant = "";
		xkbOptions = "grp:alt_shift_toggle";

    displayManager.gdm.enable = true;
    displayManager.autoLogin = {
      enable = true;
      user = "yasakar";
    };
	};

    systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
# bspwm
	services.xserver.windowManager.bspwm.enable = true;
	services.xserver.windowManager.bspwm.configFile = "/home/yasakar/.config/bspwm/bspwmrc";
	services.xserver.windowManager.bspwm.sxhkd.configFile= "/home/yasakar/.config/bspwm/sxhkdrc";
	services.picom.enable = true;



# Hyprland
	hardware = {
		bluetooth = {
			enable = true;
		};
	};
	hardware.opengl = {
		enable = true;
			extraPackages = with pkgs; [
      libglvnd
      vulkan-loader
      vulkan-tools
      mesa
      vaapiIntel
		];
	};

  services.seatd.enable = true;


  hardware.nvidia = {
    open = true;
  };


#nvidia

	services.xserver.videoDrivers = ["nvidia"];

	hardware.nvidia.modesetting.enable = true;

  
	#hardware.nvidia.prime = {
	#	offload = {
	#		enable = true;
	#		enableOffloadCmd = true;
	#	};

# integrated
	#	intelBusId = "PCI:0:2:0";

# dedicated
	#	nvidiaBusId = "PCI:1:0:0";
	#};


# Enable CUPS to print documents.
	services.printing.enable = true;


# Enable sound with pipewire.
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;

	};

  security.polkit.enable = true;


	users.users.yasakar = {
		isNormalUser = true;
		description = "yasakar";
		extraGroups = [ "networkmanager" "wheel" ];
		packages = with pkgs; [
			firefox

		];
	};


  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };



	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [

      redis

      obs-studio
  
      ghostty

      nvtopPackages.nvidia
      unigine-heaven
  
      # qt
      qt5.full
      cmake
      gcc
      gdb
      gnumake
      qtcreator

      btop
      pulseaudio 
      playerctl
      hyprlock
      wl-clipboard
      hyprshot
      swww
      wayland
      waybar
      hyprland
      nodejs
      lazydocker
      mongosh
      libvirt
      simple-mtpfs
      libmtp
      openjdk11
      nginx
      postman
      polkit
			dconf
			xdg-desktop-portal-hyprland
			direnv
			nix-direnv
			go
			python312
			prismlauncher
			xfce.thunar
			neovim
			openssh 
			steam
			discord
			neofetch
			obsidian
			telegram-desktop
			lunarvim
			libsForQt5.filelight		
			gimp
#custom desktop
			rofi
			polybar
			kitty
      alacritty
			bluez
			blueman
			networkmanager
			networkmanagerapplet
			sxhkd
			brightnessctl
			feh
			xscreensaver
			dunst

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
			zip
			vscode
			glow
			pavucontrol
			spotify
			bottles
			jetbrains.idea-community
			zsh
			jq
			bfg-repo-cleaner
			google-chrome
			flex
			bison
			openvpn
			tmux
			docker
			xournalpp
			slack
			python312Full
			ghc
			jetbrains.pycharm-community
			lutris-unwrapped

			light


			python3
			gcc
			clang
			rebar3
			libreoffice-qt
			uair
			bat
			zoom-us
			betterlockscreen
			openjdk
			fzf
			eza

			xorg.xorgserver
			xorg.xinput
			xf86_input_wacom
			libwacom

			fortune
			figlet
			neo-cowsay
			cmatrix

			postgresql
			pgcli


			flameshot
			xclip
			ffmpeg
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


	programs.java = {
		enable = true;
		package = (pkgs.jdk21.override { enableJavaFX = true; });
	};


  services.xserver.config = ''
    Section "InputClass"
    Identifier "Wacom Tablet"
    MatchProduct "[G30]T509 Graphic Tablet"
    Driver "wacom"
    EndSection
    '';

  environment.etc."libinput/99-tablet.quirks".text = ''
    [Tablet Stylus Quirks]
    MatchName=SZ PING-IT INC.  [G30]T509 Graphic Tablet Stylus
    ModelTabletNoTilt=1
    # Атрибут разрешения – число точек на дюйм (lpi).
    # Можно попробовать 5080, 4000, 2048 — в зависимости от планшета.
    AttrResolutionHint=5080
  '';

	services.tlp.enable = true;
  services.xserver.libinput.enable = true;

	services.postgresql = {
		enable = true;
		package = pkgs.postgresql_13; # Или другую версию, если вам нужна конкретная версия
	};

	virtualisation.virtualbox.host.enable = true;

#docker
	virtualisation.docker.enable = true;

	virtualisation.docker.rootless = {
		enable = true;
		setSocketVariable = true;
	};

#nginx
  services.nginx.enable = true;
  services.nginx.virtualHosts."localhost" = {
    root = "/var/www/html";
    serverName = "localhost";
  };



	users.extraGroups.vboxusers.members = [ "yasakar" ];
	virtualisation.virtualbox.host.enableExtensionPack = true;

	fonts.packages = with pkgs; [
		(nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
	];


	system.stateVersion = "23.11";

}
