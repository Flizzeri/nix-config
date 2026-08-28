{ config, pkgs, lib, ... }:

{
  # PipeWire replaces PulseAudio + JACK + ALSA-dmix as the single audio/video
  # routing daemon. Plasma 6 assumes PipeWire by default.

  security.rtkit.enable = true; # required by pipewire for realtime scheduling

  services.pulseaudio.enable = false; # mutually exclusive with pipewire's pulse shim

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true; # 32-bit ALSA apps (some games/Steam), pairs with graphics.enable32Bit
    pulse.enable = true; # drop-in PulseAudio-compatible socket, most apps use this
    jack.enable = true; # JACK compatibility, only matters if you use pro-audio software
  };
}
