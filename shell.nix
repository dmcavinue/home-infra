let
  nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-24.05";
  pkgs = import nixpkgs { config.allowUnfree = true; overlays = []; };
in

let vscode = (pkgs.vscode-with-extensions.override {
  vscodeExtensions = with pkgs.vscode-extensions; [
    bbenoist.nix
    eamodio.gitlens
    ms-kubernetes-tools.vscode-kubernetes-tools
    ms-vscode-remote.remote-containers
    signageos.signageos-vscode-sops
  ];
  });
in
pkgs.mkShellNoCC {
  packages = with pkgs; [
    ansible
    cilium-cli
    cloudflared
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
    minio-client
    python3
    python3Packages.pip
    restic
    sops
    talosctl
    vault
    vscode
    yq
  ];

  DONT_PROMPT_WSL_INSTALL="true";
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
    ansible-galaxy install -r ./ansible/requirements.yaml
    # load up python packages
    if [ -f ./pip-requirements.txt ]; then
      python -m venv .venv
      source .venv/bin/activate
      pip install -r ./pip-requirements.txt
    fi
    # load up kube contexts if they exist
    if [ ! -d ~/.kube/kubeconfigs ]; then
      export KUBECONFIG="$(find ~/.kube/kubeconfigs -type f | tr '\n' ':')"
    fi
    # load up our ssh key if it exists
    if [ -f ~/.ssh/id_ed25519 ]; then
      eval $(ssh-agent -s)
      ssh-add ~/.ssh/id_ed25519
    fi
  '';
}
