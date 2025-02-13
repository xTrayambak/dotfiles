{ ... }:
{
	powerManagement = {
		enable = true;
		powertop.enable = false;
		cpuFreqGovernor = "ondemand";
	};
	services.tlp = {
		enable = true;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "powersave";
        		CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        		CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        		CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";

        		#CPU_MIN_PERF_ON_AC = 0;
        		#CPU_MAX_PERF_ON_AC = 100;
        		#CPU_MIN_PERF_ON_BAT = 0;
        		#CPU_MAX_PERF_ON_BAT = 10;
			CPU_SCALING_MIN_FREQ_ON_AC = 0;
			CPU_SCALING_MAX_FREQ_ON_AC = 3200000;
			CPU_SCALING_MIN_FREQ_ON_BAT = 0;
			CPU_SCALING_MAX_FREQ_ON_BAT = 1000000;

			CPU_BOOST_ON_AC = 1;
			CPU_BOOST_ON_BAT = 0;

        		# Optional helps save long term battery health
        		START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
        		STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
			
			RADEON_DPM_PERF_LEVEL_ON_AC = "auto";
			RADEON_DPM_PERF_LEVEL_ON_BAT = "auto";

			PCIE_ASPM_ON_AC = "performance";
			PCIE_ASPM_ON_BAT = "powersupersave";

			WIFI_PWR_ON_AC = "off";
			WIFI_PWR_ON_BAT = "on";

			USB_AUTOSUSPEND = 0;

			DISK_APM_LEVEL_ON_AC = "254 254";
			DISK_APM_LEVEL_ON_BAT = "80 80";
		};
	};

	/*services.power-profiles-daemon = {
		enable = true;
	};*/

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
