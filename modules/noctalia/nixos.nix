{ pkgs, ... }:

let
  toml = pkgs.formats.toml { };
  greeter-config = toml.generate "greeter.toml" {
    auth.allow_empty_password = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    noctalia
    noctalia-greeter
  ];

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.noctalia-greeter}/bin/noctalia-greeter-session";
        user = "greeter";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/noctalia-greeter 0755 greeter greeter - -"
    "L+ /var/lib/noctalia-greeter/greeter.toml 0644 greeter greeter - ${greeter-config}"
  ];
}
