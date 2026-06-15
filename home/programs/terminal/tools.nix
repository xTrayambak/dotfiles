{
  pkgs,
  ...
}:

{
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
    exiftool
    binwalk
    steghide
    zsteg
  ];
}
