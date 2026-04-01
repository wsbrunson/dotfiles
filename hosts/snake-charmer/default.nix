# snake-charmer: macOS (nix-darwin) system configuration

{ pkgs, username, ... }:

{
  imports = [
    ../../modules/darwin
  ];

  # =============================================================================
  # Services
  # =============================================================================

  services.openssh = {
    enable = true;
    extraConfig = ''
      AllowUsers ${username}
    '';
  };

  # =============================================================================
  # System State
  # =============================================================================

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
