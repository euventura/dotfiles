#!/bin/bash

# Get graphics mode
graphics_mode=$(supergfxctl -g 2>/dev/null)
case "$graphics_mode" in
    "Hybrid")
        graphics=" 󰈐 Hybrid "
        ;;
    "Integrated")
        graphics=" 󰢮 iGPU "
        ;;
    "Dedicated")
        graphics=" 󰢹 dGPU "
        ;;
    *)
        graphics=" 󰢤 Unknown "
        ;;
esac

# Get performance profile
profile=$(asusctl profile get | grep "Active profile: " | awk '{print $3}' 2>/dev/null)
 perf="  󰓅 Performance "
case "$profile" in
    "Performance")
        perf= " 󰓅 Performance "
        ;;
    "Balanced")
        perf=" 󰾅 Balanced "
        ;;
    "Quiet")
        perf=" 󰾆 Quiet "
        ;;
esac

# Output in JSON format for waybar
echo "{\"text\": \"$graphics  $perf\", \"tooltip\": \"Graphics: $graphics\nProfile: $perf\"}"
