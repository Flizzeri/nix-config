{
  config,
  pkgs,
  lib,
  ...
}:

{
  # boot.nix blacklists nouveau; this module supplies the actual proprietary
  # driver stack in its place, targeting the RTX 4070 (Ada Lovelace).

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Vulkan/OpenGL 32-bit, needed for Steam/Proton and some GUI apps
  };

  hardware.nvidia = {
    # "stable" tracks the current production branch; switch to "beta" only if
    # you need a feature/fix not yet backported, or "production" for the
    # long-lived branch if you'd rather trade newest features for stability.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Required for Wayland sessions (Plasma 6 defaults to Wayland).
    modesetting.enable = true;

    # Ada Lovelace (RTX 40-series) is well supported by the open kernel
    # module as of recent driver releases. It's still developed by NVIDIA
    # (not community reverse-engineered like nouveau) but open-source and
    # generally recommended for 40-series cards going forward.
    open = true;

    # Desktop with a single NVIDIA GPU: no PRIME/offload config needed,
    # that's a laptop hybrid-graphics concern.

    # Adds nvidia-settings and the NVIDIA X indicator/control panel.
    nvidiaSettings = true;

    # Keeps the driver active during suspend/resume rather than unloading —
    # more reliable on desktops than the power-management aimed at laptops.
    powerManagement.enable = true;
  };
}
