# ============================================================
# modules/apps.nix
# ============================================================

{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # ── Terminal emulator ──────────────────────────────────────
    kitty
    #wezterm

    # ── Email ─────────────────────────────────────────────────
    thunderbird

    # ── Editor ────────────────────────────────────────────────
    sublime4          # requires allowUnfree = true (set in base.nix)
    neovim
    # notion-app
    trilium-desktop

    # ── Productivity ──────────────────────────────────────────
    #libreoffice-qt    # Qt-native build fits better inside KDE
    onlyoffice-desktopeditors

    # ── Spotify ───────────────────────────────────────────────
    spotify
    spotify-tray

    # ── Utilities ─────────────────────────────────────────────
    bat               # `cat` with syntax highlighting
    fd                # fast `find` replacement
    ripgrep           # fast `grep` replacement
    fzf               # fuzzy finder (used by zsh plugins too)
    zoxide            # smarter `cd` with memory
    tldr              # quick command examples
    jq                # JSON processor
    btop              # fancy system monitor
    synology-drive-client
    cryptomator
    portfolio
    threema-desktop
    wireguard-ui
    keepassxc

  ];

  # ── AppImage support ────────────────────────────────────────
  programs.appimage = {
    enable = true;
    binfmt = true;   # run AppImages directly without a launcher
  };
}
