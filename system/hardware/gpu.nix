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

	boot.kernel.sysctl = {
		"amd_pstate.shared_mem" = 1;
	};
}
