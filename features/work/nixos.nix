{ config, lib, ... }:
let
  cfg = config.myFeatures.work;
in
{
  config = lib.mkIf cfg.network.enable {
    networking.proxy.httpProxy = "http://sia-lb.telekom.de:8080";
    networking.proxy.httpsProxy = "http://sia-lb.telekom.de:8080";
    networking.proxy.noProxy = "localhost,127.0.0.1,.telekom.de";
    networking.nameservers = [
      "10.34.255.23"
      "10.33.255.23"
      "10.34.255.29"
      "10.33.255.29"
    ];

    programs.ssh = {
      extraConfig = ''
        	Host github.com
        	  Hostname ssh.github.com
        	  Port 443
        	  ProxyCommand nc -X connect -x sia-lb.telekom.de:8080 %h %p
      '';
    };
  };
}
