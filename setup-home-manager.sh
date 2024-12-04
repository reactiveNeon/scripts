nix shell nixpkgs#home-manager nixpkgs#gh --command sh -c '
  USER_NAME=$(whoami)
  HOST_NAME=$(hostname)

  if ! gh auth status > /dev/null 2>&1; then
    echo "Logging into GitHub CLI..."
    gh auth login
  else
    echo "Already authenticated with GitHub CLI."
  fi

  REPO_DIR=~/nix
  if [ ! -d "$REPO_DIR" ]; then
    echo "Cloning the repository..."
    gh repo clone reactiveNeon/unrav-nix "$REPO_DIR"
  else
    echo "Repository already cloned at $REPO_DIR."
  fi

  echo "Running home-manager..."
  home-manager -b bak switch --flake "$REPO_DIR#$USER_NAME@$HOST_NAME"
'
