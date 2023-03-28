import psutil
import sys


if __name__ == '__main__':
    binfo = psutil.sensors_battery()

    if sys.argv[1].lower() == '--percentage':
        sys.stdout.write(str(round(binfo.percent, 1)))
    elif sys.argv[1].lower() == '--plugged':
        match binfo.power_plugged:
            case True:
                sys.stdout.write('Charging')
            case False:
                sys.stdout.write('Discharging')
