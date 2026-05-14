{ ... }:

{
  hardware.amdgpu = {
    initrd.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      # enable32Bit = true;
    };
  };

  /*
    boot.kernel.sysctl = {
      "amd_pstate.shared_mem" = 1;
    };
  */
}
