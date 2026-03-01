# ============================================================
# modules/base-config.nix
# ============================================================

{ config, pkgs, ... }:

{
    # ── Nix settings ────────────────────────────────────────────
    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];   # flakes enabled
        auto-optimise-store = true;                            # deduplicate store files
    };

    # Allow unfree packages (Sublime Text, some GPU drivers, etc.)
    nixpkgs.config.allowUnfree = true;

    # ── Locale & timezone ───────────────────────────────────────
    time.timeZone = "Europe/Zurich";

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = "ch";
        variant = "";
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "en_GB.UTF-8";

    # ── Networking ──────────────────────────────────────────────
    networking.networkmanager.enable = true;

    # ── Fonts ───────────────────────────────────────────────────
    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            liberation_ttf
            nerd-fonts.jetbrains-mono
            nerd-fonts.fira-code
        ];
        fontconfig.defaultFonts = {
            serif      = [ "Noto Serif" ];
            sansSerif  = [ "Noto Sans" ];
            monospace  = [ "FiraCode Nerd Font Mono" ];
        };
    };

    # ── Core system packages ─────────────────────────────────────
    environment.systemPackages = with pkgs; [
        curl
        wget
        unzip
        zip
        htop
        pciutils     # lspci
        usbutils     # lsusb
        man-pages
        gnupg
    ];

    programs.gnupg.agent.enable = true;

    # Auto Garbage Collection
    nix.gc = {
        automatic = true;
        dates = "weekly";       # or "daily", "monthly", or a systemd calendar string
        options = "--delete-older-than 30d";  # delete generations older than 30 days
    };

    # ── Misc services ───────────────────────────────────────────
    services.openssh.enable = false;  # flip to true if you need SSH in
    services.printing.enable = true;  # CUPS for printers
}
