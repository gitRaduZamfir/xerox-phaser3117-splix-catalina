#!/bin/bash
PPD_PATH="/Library/Printers/PPDs/Contents/Resources/Xerox Phaser 3117.gz"
FILTER_DIR="/Library/Printers/Samsung/UPD/Filters"
PRINTER_NAME="Xerox_Phaser_3117"
USB_URI=$(lpinfo -v | grep Phaser | awk '{print $2}')

sudo chmod o+rx "$FILTER_DIR/pstoqpdl"
sudo chmod o+rx "$FILTER_DIR/rastertoqpdl"

sudo gunzip -f "$PPD_PATH"
PPD_UNZIPPED="${PPD_PATH%.gz}"
sudo sed -i '' 's|application/vnd.cups-raster 0 rastertoqpdl|application/vnd.cups-raster 0 /Library/Printers/Samsung/UPD/Filters/rastertoqpdl|' "$PPD_UNZIPPED"
sudo gzip -f "$PPD_UNZIPPED"
sudo chmod o+r "$PPD_PATH"

sudo lpadmin -x "$PRINTER_NAME" 2>/dev/null
sudo lpadmin -p "$PRINTER_NAME" -E -v "$USB_URI" -P "$PPD_PATH"
sudo lpadmin -d "$PRINTER_NAME"

sudo killall cupsd
sleep 2
sudo launchctl start org.cups.cupsd

