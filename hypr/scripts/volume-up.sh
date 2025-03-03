#!/usr/bin/env bash

for sink in $(wpctl status | grep -oP '^\s*\d+(?=\. Audio Sink)'); do
    wpctl set-volume $sink 5%+
done

