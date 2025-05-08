#!/bin/bash

FILE=$(find out/target/product/lime/ -name '*.zip' -type f -printf '%T@ %p\n' | sort -nr | head -n1 | cut -d' ' -f2-)

# Cek kalau file ditemukan
if [ -z "$FILE" ]; then
    echo "Tidak ditemukan file .zip dalam out/target/product/*/"
    exit 1
fi

FILENAME=$(basename "$FILE")

# === Upload ke GoFile ===
RESP=$(curl -s -F "file=@$FILE" https://upload.gofile.io/uploadFile)
LINK=$(echo "$RESP" | grep -o '"downloadPage":"[^"]*' | cut -d'"' -f4)

# Cek jika upload berhasil
if [ -z "$LINK" ]; then
    echo "Upload gagal atau respons tidak valid:"
    echo "$RESP"
    exit 1
fi

# === Kirim ke Telegram ===
TEXT="ROM berhasil diupload!<b>Nama file:</b> $FILENAME<b>Link:</b>$LINK"
curl -s -X POST "https://api.telegram.org/bot$botToken/sendMessage" \
     -d chat_id="$chatId" \
     -d text="$TEXT" \
     -d parse_mode="HTML"
     
