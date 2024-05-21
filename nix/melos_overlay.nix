# overlays/melos-overlay.nix
final: prev: {
  melos = prev.melos {
    # Add your custom configuration or override existing attributes here
    version = "6.0.0"; # Replace with the desired version
  };
}
