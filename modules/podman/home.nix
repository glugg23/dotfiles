{ pkgs, ... }:

{
  services.podman = {
    enable = true;
    settings.containers.engine = {
      compose_providers = [ "${pkgs.podman-compose}/bin/podman-compose" ];
      compose_warning_logs = false;
    };
  };
}
