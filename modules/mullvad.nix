{ config, lib, ... }:

{
  services.mullvad-vpn = {
    enable = true;
    gui.enable = lib.mkDefault true;
  };

  networking.nftables = {
    enable = config.services.tailscale.enable;
    tables.mullvad_tailscale = {
      family = "inet";
      content = ''
        chain output {
          type route hook output priority -100; policy accept;
          ip daddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }

        chain input {
          type filter hook input priority -100; policy accept;
          ip saddr 100.64.0.0/10 ct mark set 0x00000f41 meta mark set 0x6d6f6c65;
        }
      '';
    };
  };

  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;
}
