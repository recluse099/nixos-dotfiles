{pkgs, ...}:{
  home.packages = with pkgs; [ 
    yt-dlg
    yt-dlp
    ffmpeg
  ];
  home.file.".config/yt-dlp/config".text = ''
  -P ~/youtube-vidoes
  -o "%(title)s.%(ext)s"
'';
}
