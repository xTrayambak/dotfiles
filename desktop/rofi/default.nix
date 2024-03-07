{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    terminal = "foot";
    theme = ''
* {
    background:                 #1A1B26;
    background-alt:             #16161E;
    background-alt2:            #414868;
    foreground:                 #A9B1D6;
    foreground-alt:             #061115;
    accent:                     #7DCFFF;
    transparent: #00000000;
    text-color:                 @fg;
}
    '';
    extraConfig = ''
configuration {
    show-icons:                     true;
    display-drun: 					"Applications";
    drun-display-format:            "{name}";
    disable-history:                false;
	hide-scrollbar: 				true;
	sidebar-mode: 					false;
}

window {    
    transparency:                   "real";
	width:						    36%;
}

entry {
    background-color:               @background-alt;
    text-color:                     @foreground;
    placeholder-color:              @foreground;
    expand:                         true;
    horizontal-align:               0;
    placeholder:                    "Type here to search...";
    padding:                        10px;
    margin:                         0 1%;
    blink:                          true;
    border:                         0px 0px 3px 0px;
    border-radius:                  6px;
    border-color:                   @border;
}

inputbar {
	children: 						[ entry ];
    background-color:               @background;
    text-color:                     @background;
    expand:                         false;
    margin:                         0px 0px 0px 0px;
    padding:                        1%;
}

listview {
    background-color:               @background;
    padding:                        10px;
    columns:                        4;
    lines:                          3;
    spacing:                        0%;
    cycle:                          false;
    dynamic:                        true;
    layout:                         vertical;
}

mainbox {
    background-color:               @background;
    children:                       [ inputbar, listview ];
    spacing:                       	0%;
    padding:                        10px;
}

element {
    orientation:                    vertical;
    background-color:               @background;
    text-color:                     @foreground;
    border-radius:                  0%;
    padding:                        6px;
}

element-icon, element-text {
    background-color:               inherit;
    text-color:                     inherit;
}

element-icon {
    horizontal-align:               0.5;
    vertical-align:                 0.5;
    size:                           42px;
    border:                         16px;
    border-color:                   transparent;
}

element-text {
    expand:                         true;
    horizontal-align:               0.5;
    vertical-align:                 0.5;
    margin:                         -12px 0px 12px 0px;
}

element selected {
    background-color:               @background-alt;
    text-color:                     @foreground;
    border:                         0px 0px 2px 0px;
    border-color:                   @border;
    border-radius:                  10px;
}
    '';
  };
}
