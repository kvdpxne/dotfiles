#!/bin/bash

query=$(wofi --dmenu --prompt "🔍 Search or URL: " --lines 1)
if [ -n "$query" ]; then
    # Check if the input contains a dot and has no spaces -> treat as URL
    if [[ "$query" == *"."* && "$query" != *" "* ]]; then
        # If no protocol prefix, add https://
        if [[ ! "$query" =~ ^https?:// ]]; then
            query="https://$query"
        fi
        xdg-open "$query"
    else
        # URL‑encode the query and search on DuckDuckGo
        encoded=$(echo "$query" | sed 's/ /%20/g')
        xdg-open "https://duckduckgo.com/?q=$encoded"
    fi
fi
