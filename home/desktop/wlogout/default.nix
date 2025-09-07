{ config, pkgs, ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "Lock";
        action = "/home/${config.home.username}/.scripts/locker";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "Logout";
        action = "hyprctl dispatch exit 0";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "Suspend";
        action = "/home/${config.home.username}/.scripts/locker && ${pkgs.systemd}/bin/systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }
      {
        label = "Shutdown";
        action = "${pkgs.systemd}/bin/systemctl poweroff";
        text = "Shutdown";
        keybind = "o";
      }
      {
        label = "Hibernate";
        action = "${pkgs.systemd}/bin/systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
      {
        label = "Reboot";
        action = "${pkgs.systemd}/bin/systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
    ];
    style = ''
      * {
        font-family: AdwaitaSans, NerdFontMono;
        font-size: 24px;
        transition-duration: 0.7s;
      }

      window {
        background-color: rgba(0, 0, 0, 0);
        border-radius: 10px;
      }

      button {
        color: rgba(255, 255, 255, 1.0);
        background-color: rgba(11, 11, 13, 0.3998);
        border-style: solid;
        border-width: 3px;
        border-radius: 50px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 15%;
        margin: 15px;
      }

      button:active,
      button:hover {
        background-size: 25%;
        background-color: rgba(11, 11, 13, 0.8998);
      }

      button:focus {
        background-color: rgba(11, 11, 13, 0.8998);
      }

      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }

      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }

      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"))
      }

      #hibernate {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }

      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
      		'';
  };
}
