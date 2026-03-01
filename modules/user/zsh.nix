# ============================================================
# modules/user/zsh.nix
# ============================================================
{ config, pkgs, ... }:

{
      programs.zsh = {
        enable = true;

        # History
        history = {
          size       = 50000;
          save       = 50000;
          ignoreDups = true;
          share      = true;    # share history between terminals
        };

        # Handy options
        autocd              = true;
        enableCompletion    = true;
        syntaxHighlighting.enable = true;
        autosuggestion.enable     = true;

        # Plugins (managed by home-manager, no Oh-My-Zsh needed)
        plugins = [
          {
            name = "zsh-fzf-history-search";
            src  = pkgs.fetchFromGitHub {
              owner  = "joshskidmore";
              repo   = "zsh-fzf-history-search";
              rev    = "d1aae98";
              sha256 = "sha256-4Dp2ehZLO83NhdBOKV0BhYFIvieaZPqiZZZtxsXWRaQ=";
            };
          }
          {
            name = "zsh-history-substring-search";
            src  = pkgs.fetchFromGitHub {
              owner  = "zsh-users";
              repo   = "zsh-history-substring-search";
              rev    = "14c8d2e";
              sha256 = "sha256-KHujL1/TM5R3m4uQh2nGVC98D6MOyCgQpyFf+8gjKR0=";
            };
          }

        ];

        # Aliases
        shellAliases = {
          # Better defaults
          ll    = "ls -lsa";
          lt    = "eza --tree --icons --level=2";
          cat   = "bat";
          grep  = "rg";
          find  = "fd";
          cd    = "z";          # zoxide smarter cd

          # Kitty
          icat  = "kitty +kitten icat";   # display images in terminal

          # Nvim
          nvimm = "nvim .";
        };

        # Commands run for every interactive shell
        initContent = ''
          # Substring Search
          bindkey '^[OA' history-substring-search-up
          bindkey '^[OB' history-substring-search-down

          # Word jumping
          bindkey '^[[1;5C' forward-word
          bindkey '^[[1;5D' backward-word

          # zoxide init (smart cd)
          eval "$(zoxide init zsh)"

          # fzf keybindings & completion
          source ${pkgs.fzf}/share/fzf/key-bindings.zsh
          source ${pkgs.fzf}/share/fzf/completion.zsh

          # Better fzf defaults
          export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
          export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        '';
      };
}
