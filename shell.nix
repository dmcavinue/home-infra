let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config.allowUnfree = true; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    ansible
    dyff
    fluxcd
    git
    go-task
    helm
    jq
    k9s
    kubectl
    python3
    vault
    yq
  ];

  EDITOR = "nano";
  LANGUAGE = "C.UTF-8";
  LANG="C.UTF-8";
  LC_COLLATE="C.UTF-8";
  LC_CTYPE="C.UTF-8";
  LC_MONETARY="C.UTF-8";
  LC_NUMERIC="C.UTF-8";
  LC_TIME="C.UTF-8";
  LC_MESSAGES="C.UTF-8";
  LC_ALL="C.UTF-8";
  KUBECTL_EXTERNAL_DIFF = "dyff between --omit-header --set-exit-code";
}