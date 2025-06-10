#!/bin/bash

# Get list of sinks
sinks=($(pactl list short sinks | awk '{print $2}'))

# Make sure there are exactly two sinks
if [ "${#sinks[@]}" -ne 2 ]; then
    echo "This script requires exactly two sinks."
    exit 1
fi

# Get current default sink
default_sink=$(pactl info | grep "Default Sink" | awk -F': ' '{print $2}')

# Determine the new sink
if [ "$default_sink" == "${sinks[0]}" ]; then
    new_sink="${sinks[1]}"
else
    new_sink="${sinks[0]}"
fi

# Set new default sink
echo "Switching default sink from $default_sink to $new_sink"
pactl set-default-sink "$new_sink"

# Move existing audio streams to the new sink
for input in $(pactl list short sink-inputs | awk '{print $1}'); do
    pactl move-sink-input "$input" "$new_sink"
done

echo "Switched to: $new_sink"
