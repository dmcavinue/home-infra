let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config.allowUnfree = true; overlays = []; };
in

pkgs.mkShellNoCC {
  packages = with pkgs; [
    ansible
    dyff
    fluxcd
    google-cloud-sdk
    git
    go-task
    helm
    jq
    k9s
    kopia
    kubectl
    python3
    restic
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
  shellHook =
  ''
    # load up kube contexts if they exist
    if [ ! -d ~/.kube/kubeconfigs ]; then
      export KUBECONFIG="$(find ~/.kube/kubeconfigs -type f | tr '\n' ':')"
    fi
  '';
}