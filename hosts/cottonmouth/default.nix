# cottonmouth: NixOS system configuration (Lenovo mini PC)

{ config, pkgs, username, ... }:

{
  imports = [
    ./hardware-configuration.nix
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
    extraGroups = [ "networkmanager" "wheel" "dialout" ];  # dialout for USB serial devices
    shell = pkgs.fish;
  };

  security.sudo.wheelNeedsPassword = false;

  # =============================================================================
  # Containers (Podman)
  # =============================================================================

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;  # Alias docker to podman
    defaultNetwork.settings.dns_enabled = true;
  };

  # Quadlet container definitions (systemd-managed containers)
  environment.etc."containers/systemd/homeassistant.container".text = ''
    [Unit]
    Description=Home Assistant
    After=local-fs.target network-online.target
    Wants=network-online.target

    [Container]
    Image=docker.io/homeassistant/home-assistant:stable
    ContainerName=homeassistant
    AutoUpdate=registry
    Volume=/var/lib/hass:/config:Z
    Network=host
    # USB serial device access (Zigbee/Z-Wave dongles) - cgroup rules allow access when plugged in
    # To pass a specific device, add: AddDevice=/dev/ttyUSB0
    PodmanArgs=--device-cgroup-rule="c 188:* rwm" --device-cgroup-rule="c 166:* rwm"
    Environment=TZ=America/Los_Angeles

    [Service]
    Restart=always
    TimeoutStartSec=900

    [Install]
    WantedBy=multi-user.target default.target
  '';

  # =============================================================================
  # Services
  # =============================================================================

  services.openssh.enable = true;

  # Tailscale VPN
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];
  # Open Home Assistant port for local network access
  networking.firewall.allowedTCPPorts = [ 8123 ];
  # Open ports for device discovery (SSDP, mDNS)
  networking.firewall.allowedUDPPorts = [ 1900 5353 ];

  # Create persistent storage directories for containers
  systemd.tmpfiles.rules = [
    "d /var/lib/hass 0755 root root -"
  ];

  # =============================================================================
  # System State
  # =============================================================================

  system.stateVersion = "24.11"; # Check NixOS version when installing
}
