{
  programs.waybar = {
    enable = true;
    style = '' 
        * {

          border: none;
          font-family: JetBrainsMono Nerd Font, sans-serif;
          font-size: 14px;
        }

        window#waybar {
          background-color: transparent;
          border-radius: 6px; 
          color: #cdd6f4;
          opacity: 1;
          transition-property: background-color;
          transition-duration: .5s;
          margin-bottom: -7px;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        window#hyprland-window {
          background-color: #181825;
        } 

        window#niri-window {
          background-color: #181825;
        }

        #tray {
          background-color: #fab387;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
        }

        #window {
          background-color: #fab387;
          color: #181825;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
        }

        #workspaces {
          background-color: #68686a;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
        }

        #workspaces button {
          background-color: #68686a;
          padding: 0 5px;
          min-width: 20px;
          color: #cdd6f4;
        }

        #workspaces button:hover {
          background-color: rgba(0, 0, 0, 0)
        }

        #workspaces button.active {
          color: #89b4fa;
        }

        #workspaces button.urgent {
          color: #f38ba8;
        }

        #clock {
          background-color: #e692fe;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
          color: #181825;
        }

        #pulseaudio {
          background-color: #92fefe;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
          color: #181825;
        }

        #pulseaudio.muted {
          padding: 0 10px;
          background-color: #f38ba8;
          color: #181825;
        }

        #backlight {
          background-color: #fefd92;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
          color: #181825;
        }

        #battery {
          padding: 0 10px;
          background-color: #a6e3a1;
          color: #181825;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
        }

        #battery.charging, #battery.plugged {
          padding: 0 10px;
          background-color: #a6e3a1;
          color: #181825;
        }

        @keyframes blink {
            to {
                background-color: #181825;
                color: #f38ba8;
            }
        }

        #battery.critical:not(.charging) {
            padding: 0 10px;
            background-color: #f38ba8;
            color: #181825;
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }

        #bluetooth {
          background-color: #9492fe;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
          color: #181825;   
        }

        #network {
          background-color: #1e1e2e;
          padding: 0 10px;
          margin: 1px 1px 1px 1px;
          border: 1px solid rgba(0, 0, 0, 0);
          border-radius: 6px;
          background-clip: padding-box;
          color: #a6e3a1; /* default color when connected */
        }

        #network.disconnected {
          color: #f38ba8;
        }

        #network.ethernet {
          color: #89b4fa;
        }


        #custom-distro {
            color: #89b4fa;
            background-color: transparent;
            font-size: 20px;
            margin: 1px;
            padding: 0px 0px 0px 6px;
            border: 1px solid rgba(0, 0, 0, 0);
            border-radius: 6px;
            background-clip: padding-box;
        }
    '';
    settings = {
      mainBar = {
      margin-top = 0;
      margin-bottom = 0;
      margin-left = 5; 
      margin-right = 5;
        layer = "top";
        position = "bottom";

        modules-left = ["niri/workspaces" "niri/window"];
        modules-center = [ "custom/distro" ];
        modules-right = ["network" "tray" "battery" "backlight" "pulseaudio" "bluetooth" "clock" ];

      /* Modules configuration */

      "niri/workspaces" = {
        on-click = "activate";
        all-outputs = false;
        active-only = false;
        format = "{icon}";
        format-icons = {
          "1" = " ";
          "2" = " ";
          "3" = "󰊴 ";
          "4" = " ";
          "5" = " ";
          "6" = " ";
          # "7" = " ";
          # "8" = " ";
          # "9" = " ";
          # "10" = " ";
        };
      };

      "niri/window" = {
          icon = true;
      };      
      
        "tray" = {
          icon-size = 13;
          spacing = 8;
        };

        "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	        format = "{:%I:%M%p}";
	        format-alt = " {:%A, %B %d, %Y}";
        };

        "backlight" = {
          format = "{icon}{percent}%";
          format-icons = ["󰃞 " "󰃟 " "󰃠 "];
          on-scroll-up = "brightnessctl set 1%+";
          on-scroll-down = "brightnessctl set 1%-";
        };

        "battery" = {
          states = {
           warning = "30";
           critical = "15";
          };
          format = "{icon}{capacity}%";
          tooltip-format = "{timeTo} {capacity}%";
          format-charging = "󱐋{capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{time} {icon}";
          format-icons = ["  " "  " "  " "  " "  "];
        };
        
        "pulseaudio" = {
          format = "{icon}{volume}% {format_source}";
          format-bluetooth = "{icon} {volume}%";
          format-bluetooth-muted = "   {volume}%";
          format-source = "";
          format-source-muted = "";
          format-muted = "  {format_source}";
          format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = [" " " " "  "];
          };
          tooltip-format = "{desc} {volume}%";
          on-click-middle = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          on-click-right = "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          on-click = "pavucontrol";
          on-click-release = "sleep 0";
          on-click-middle-release = "sleep 0";
        };

        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          interval = 30;
          on-click = "blueberry";
          format-no-controller = "";
        };
        "network" = {
          format-wifi = " {essid} {signalStrength}%";
          format-ethernet = " {ifname}";
          format-disconnected = " Disconnected";
          tooltip-format = "{ifname} via {gwaddr}\n{ipaddr}/{cidr}";
          interval = 5;
          on-click = "nm-connection-editor";
        };

        "custom/distro" = {
          format = " ";
          on-click = "wlogout";
          on-click-release = "sleep 0";
        };

      };
    };
  };
}

