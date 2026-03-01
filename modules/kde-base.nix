{ config, pkgs, ... }:

{
  # === KDE PLASMA 6 CONFIGURATION ===

  # Enable KDE Plasma 6
  services.desktopManager.plasma6.enable = true;

  # Enable SDDM (KDE's display manager)
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;  # Use Wayland for SDDM
  };

  # Set Plasma Wayland as default session
  services.displayManager.defaultSession = "plasma";

  # Enable X server (still needed for some compatibility)
  services.xserver = {
    enable = true;

    # Configure keyboard layout
    xkb = {
      layout = "ch";
      variant = "";
      # For German keyboard: layout = "de";
      # options = "eurosign:e,caps:escape";  # Optional: make Caps Lock = Escape
    };
  };

  # === OPTIONAL: EXCLUDE UNWANTED KDE PACKAGES ===

  # Remove KDE apps you don't want
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa              # Music player
    # konsole          # Terminal (uncomment if you prefer another terminal)
    kate             # Text editor (uncomment if you use another editor)
    plasma-browser-integration
    oxygen             # Oxygen theme
  ];

  # === KDE-RELATED PACKAGES ===

  environment.systemPackages = with pkgs; [
    # KDE Apps
    kdePackages.discover       # Software center
    kdePackages.kate           # Text editor
    kdePackages.kcalc          # Calculator
    kdePackages.konsole        # Terminal
    kdePackages.spectacle      # Screenshots
    kdePackages.gwenview       # Image viewer
    kdePackages.okular         # Document viewer
    kdePackages.ark            # Archive manager

    # Wayland utilities
    wl-clipboard               # Wayland clipboard utilities

    # Optional: KDE Connect (sync with phone)
    # kdePackages.kdeconnect-kde
  ];

  # === ADDITIONAL SERVICES ===

  # Enable CUPS for printing
  services.printing.enable = true;

  # Enable sound with pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Enable Flatpak (useful for apps not in nixpkgs)
  # services.flatpak.enable = true;

  # XDG portal for Wayland
  #xdg.portal = {
  #  enable = true;
  #  extraPortals = [ pkgs.xdg-desktop-portal-kde ];
  #};
}

