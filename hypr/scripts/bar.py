import subprocess


if __name__ == '__main__':
    subprocess.call(['killall', 'waybar'])
    subprocess.call(['waybar'])
