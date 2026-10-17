#!/bin/bash
echo "=== Bash CTF Decoder==="
read -p "Enter the base64 string to decode: " b64_input
if [ -n "$b64_input" ]; then
	decoded_b64=$(echo "$b64_input" |base64 -d 2>/dev/null)
	if [ $? -eq 0 ]; then
		echo -n "[-] Decoded Base64: "
		echo "$decoded_b64"
	else
	    echo "[-] Error: Invalid Base64 string."
	fi
else
    echo "[-] No input provided for  Base64."
fi 
echo ""
read -p "Enter  the encrypted/encoded flag:" flag_input
if [ -n "$flag_input" ]; then
	decoded_flag=$(echo  "$flag_input" | base64 -d 2>/dev/null)
	if [ $? -eq 0 ]; then
	    echo -n "[-] processed flag"
	else
	   echo "[-] flag is not  Base64 encoded or is encrypted differenlty"
	fi
     else
	echo "[-] No flag provided"
fi 
