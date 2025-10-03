{ ... }:

{
  hardware.amdgpu = {
    initrd.enable = true;
    amdvlk = {
      enable = true;
      support32Bit.enable = true;
      settings = {
        AllowVkPipelineCachingToDisk = 1;
        ShaderCacheMode = 1;
      };
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  boot.kernel.sysctl = {
    "amd_pstate.shared_mem" = 1;
  };
}
