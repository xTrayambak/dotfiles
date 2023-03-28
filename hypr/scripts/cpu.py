import psutil
import sys


if __name__ == '__main__':
    if sys.argv[1] == '--percent':
        sys.stdout.write(str(round(psutil.cpu_percent(), 1)))
