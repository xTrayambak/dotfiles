{ ... }:
{
	services.tlp = {
		enable = true;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        		CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        		CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        		CPU_ENERGY_PERF_POLICY_ON_AC = "schedutil";

        		CPU_MIN_PERF_ON_AC = 0;
        		CPU_MAX_PERF_ON_AC = 100;
        		CPU_MIN_PERF_ON_BAT = 0;
        		CPU_MAX_PERF_ON_BAT = 20;

        		# Optional helps save long term battery health
        		START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        		STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
			
			RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
			RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";
		};
	};

	/* services.auto-cpufreq = {
		enable = true;
		settings = {
			battery = {
				governor = "powersave";
				turbo = "auto";
			};
			charger = {
				governor = "performance";
				turbo = "auto";
			};
		};
	}; */
}
