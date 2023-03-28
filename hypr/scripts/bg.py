import threading, random, os, subprocess, datetime, signal, time, socket


def unbiased_choice(collection: list) -> str:
    """
    Less biased random generator, for your viewing pleasures. ;)
    """
    if len(collection) < 2: return collection[0]
    cx = None
    cy = None

    while (cx == cy):
        cx = random.choice(collection)
        cy = random.choice(collection)

    return cx


def set_bg(wallpaper: str) -> subprocess.Popen:
    """
    Kill other SwayBG instances and changing the wallpaper.
    """
    return subprocess.Popen(['swww', 'img', wallpaper, '--transition-step', '8', '--transition-fps', '60'])


def get_time_string() -> str:
    """
    Translate current hour of day to string (morning, afternoon, evening, night)
    """
    hour: int = datetime.datetime.today().hour

    if hour >= 0 and hour <= 12: return 'morning'
    elif hour > 12 and hour <= 16: return 'afternoon'
    elif hour > 16 and hour <= 18: return 'evening'
    elif hour > 18 and hour <= 24: return 'night'


def logic_threaded(process):
    """
    Threaded logic.
    """
    last_time: str = get_time_string()
    home: str = os.path.expanduser('~')

    while True:
        time.sleep(random.randint(180, 680))
        """if get_time_string() != last_time:
            do_reset_background = False
            print(f'[BG-THREAD]: Time changed: {last_time} -> {get_time_string()}')
            last_time = get_time_string()
            os.kill(process.pid, signal.SIGTERM)
    """
        new_wallpaper: str = unbiased_choice(os.listdir(f'{home}/Wallpapers/'))
        process = set_bg(f'{home}/Wallpapers/{new_wallpaper}')


if __name__ == '__main__':
    home: str = os.path.expanduser('~')
    time_of_day: str = get_time_string()
    wallpaper: str = unbiased_choice(os.listdir(f'{home}/Wallpapers/'))

    print(f'[BG]: Time of day:{time_of_day}')
    print('[BG]: ', wallpaper, 'chosen!')
    process = set_bg(f'{home}/Wallpapers/{wallpaper}')

    threading.Thread(target = logic_threaded, args = (process,)).start()
