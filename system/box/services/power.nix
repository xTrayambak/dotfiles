{
  services = {
    logind.settings.Login = {
      HandlePowerKey = "lock";
      HandleLidSwitch = "suspend";
    };

    upower.enable = true;
  };
}
