#!/usr/bin/env bash

for sink in $(wpctl status | grep -oP '^\s*\d+(?=\. .*Audio Controller.*Sink)'); do
    wpctl set-volume $sink 5%+
done

