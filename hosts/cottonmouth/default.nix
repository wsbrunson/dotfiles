# cottonmouth: NixOS system configuration (Lenovo mini PC)

{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/shared/packages.nix
  ];

  # =============================================================================
  # Boot
  # =============================================================================

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # =============================================================================
  # Networking
  # =============================================================================

  networking.hostName = "cottonmouth";
  networking.networkmanager.enable = true;

  # =============================================================================
  # Nix Settings
  # =============================================================================

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # =============================================================================
  # Locale & Time
  # =============================================================================

  time.timeZone = "America/Los_Angeles"; # Adjust as needed
  i18n.defaultLocale = "en_US.UTF-8";

  # =============================================================================
  # Desktop Environment
  # =============================================================================

  # Enable X11/Wayland - uncomment your preference
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  # Or for a minimal setup with just a window manager:
  # services.xserver.windowManager.i3.enable = true;

  # =============================================================================
  # Sound
  # =============================================================================

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # =============================================================================
  # System Programs
  # =============================================================================

  programs.fish.enable = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # =============================================================================
  # Users
  # =============================================================================

  users.users.${username} = {
    isNormalUser = true;
    description = "Shane Brunson";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # =============================================================================
  # Services
  # =============================================================================

  services.openssh.enable = true;

  # =============================================================================
  # System State
  # =============================================================================

  system.stateVersion = "24.11"; # Check NixOS version when installing
}
