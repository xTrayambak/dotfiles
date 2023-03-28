import psutil, sys

def main():
    if sys.argv[1].lower() == 'percentage':
        sys.stdout.write(str(psutil.virtual_memory()[2]))

if __name__ == '__main__':
    main()
