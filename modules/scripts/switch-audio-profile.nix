{
  jq,
  libnotify,
  writeShellApplication,
}:

writeShellApplication {
  name = "switch-audio-profile";
  runtimeInputs = [
    jq
    libnotify
  ];
  text = ''
    DEVICE=$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep "device.id" | awk -F'"' '{gsub(/"/, "", $NF); print $2}')
    PROFILE=$(pw-dump "$DEVICE" | jq '.[].info.params.Route.[].profile')

    if [ "$PROFILE" = 2 ]; then
        NEW_PROFILE=4
    else
        NEW_PROFILE=2
    fi

    pw-cli s "$DEVICE" Profile "{ index: $NEW_PROFILE, save: true }" > /dev/null

    PROFILE=$(pw-dump "$DEVICE" | jq '.[].info.params.Route.[].profile')

    if [ "$PROFILE" != $NEW_PROFILE ]; then
        echo "Failed to change audio profile!"
        notify-send -u critical "Audio Profile Toggle" "Failed to change audio profile! Please run:\nsystemctl --user restart wireplumber"
        exit 1
    fi
  '';
}
