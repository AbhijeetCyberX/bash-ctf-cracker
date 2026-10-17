#!/bin/bash

echo "=== MD5 & SHA-256 Hash Checker (Bash) ==="
echo "1) MD5 Hash"
echo "2) SHA-256 Hash"
read -p "Select hash type (1 or 2): " type_choice

read -p "Enter the target hash: " target_hash
read -p "Enter path to your wordlist file (e.g., words.txt): " wordlist

# Check if wordlist exists
if [ ! -f "$wordlist" ]; then
    echo "[-] Error: Wordlist file not found!"
    exit 1
fi

echo "[*] Searching for matching plain text..."
found=0

# Read wordlist line by line
while IFS= read -r word; do
    # Remove any trailing carriage return if from Windows wordlists
    word=$(echo "$word" | tr -d '\r')

    if [ "$type_choice" -eq 1 ]; then
        # Compute MD5
        computed_hash=$(echo -n "$word" | md5sum | awk '{print $1}')
    elif [ "$type_choice" -eq 2 ]; then
        # Compute SHA-256
        computed_hash=$(echo -n "$word" | sha256sum | awk '{print $1}')
    else
        echo "[-] Invalid choice."
        exit 1
    fi

    # Compare computed hash with target hash
    if [ "$computed_hash" == "$target_hash" ]; then
        echo -e "\n[+] MATCH FOUND!"
        echo "----------------------------------------"
        echo "Plain Text : $word"
        echo "Hash       : $target_hash"
        echo "----------------------------------------"
        found=1
        break
    fi
done < "$wordlist"

if [ $found -eq 0 ]; then
    echo "[-] Match not found in the provided wordlist."
fi
