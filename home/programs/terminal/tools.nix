{
  pkgs,
  ...
}:

{
  imports = [
    ./hyfetch.nix
    ./agenix.nix
  ];

  home.packages = with pkgs; [
    cloc
    htop
    ripgrep
    fzf
    jq
    wl-clipboard
    playerctl
    moreutils
    arp-scan
    gocryptfs
    yt-dlp
    python314
    gh
    git
    hyperfine
    arp-scan
    pciutils
    ninja
    cmatrix
    fd
    file
    ngrok
    mpv
    cloudflared
    ani-cli
    amdgpu_top

    zip
    unzip
    htop
    imagemagick_light
    senpai

    # Stuff I use for cryptic hunts
    stegseek
    subfinder
    nmap
    exiftool
    binwalk
    steghide
    zsteg
  ];
}
