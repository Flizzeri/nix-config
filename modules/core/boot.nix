{ config, pkgs, lib, ... }:

{
  # Bootloader (UEFI + systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # initrd: make sure USB keyboards work at LUKS prompt
  # These modules cover most USB controllers + HID keyboards in early boot.
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "xhci_hcd"
    "ehci_pci"
    "ehci_hcd"
    "uhci_hcd"
    "usbhid"
    "hid_generic"
    "hid"
  ];

  boot.initrd.kernelModules = [
    "usbcore"
    "usb_storage"
  ];

  # Stop nouveau from loading (fixes the boot spam on RTX 4070)
  boot.blacklistedKernelModules = [ "nouveau" ];

  # Make it extra-sure by also adding kernel params:
  boot.kernelParams = [
    "modprobe.blacklist=nouveau"
    "nouveau.modeset=0"
    # optional: quiet boot later if you want; leave off for now while debugging
    # "quiet"
    # "loglevel=3"
  ];

  # Add a modprobe.d blacklist too (covers cases outside kernelParams tooling)
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
  '';

  boot.initrd.systemd.enable = true;
}

