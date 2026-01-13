Installing Xerox Phaser 3117 on macOS Catalina using Splix 2.0.0 (USB)

This guide explains how to connect and print with a Xerox Phaser 3117 on macOS 10.15 Catalina using the Splix 2.0.0 driver, bypassing automatic driver installation issues.
It includes all files required and step-by-step instructions.
Required Files
1. Splix 2.0.0 package (contains the PPD and filters)
   * `Splix-2.0.0.mpkg`
   * Path used in tutorial: `~/Desktop/Splix-2.0.0.mpkg`
2. PPD file for Xerox Phaser 3117
   * Found inside the Splix package:

```
/Users/<your_user>/Desktop/Splix-2.0.0.mpkg/Contents/Packages/target.pkg/Contents/usr/share/cups/model/xerox/ph3117.ppd

```

   * Destination after setup:

```
/Library/Printers/PPDs/Contents/Resources/Xerox Phaser 3117.gz

```

3. CUPS filters from Splix
   * Files:

```
pstoqpdl
rastertoqpdl

```

   * Source in Splix:

```
/Users/<your_user>/Desktop/Splix-2.0.0.mpkg/Contents/Packages/target.pkg/Contents/usr/libexec/cups/filter/

```

   * Destination:

```
/Library/Printers/Samsung/UPD/Filters/

```

Step 1: Copy Filters
Open Terminal and copy the filters to the system location:

```
sudo cp ~/Desktop/Splix-2.0.0.mpkg/Contents/Packages/target.pkg/Contents/usr/libexec/cups/filter/pstoqpdl /Library/Printers/Samsung/UPD/Filters/
sudo cp ~/Desktop/Splix-2.0.0.mpkg/Contents/Packages/target.pkg/Contents/usr/libexec/cups/filter/rastertoqpdl /Library/Printers/Samsung/UPD/Filters/

```

Make sure the filters are executable and readable:

```
sudo chmod o+rx /Library/Printers/Samsung/UPD/Filters/pstoqpdl
sudo chmod o+rx /Library/Printers/Samsung/UPD/Filters/rastertoqpdl

```

Check:

```
ls -l /Library/Printers/Samsung/UPD/Filters/

```

Step 2: Install the PPD
1. Copy the PPD to the system folder:

```
sudo cp ~/Desktop/Splix-2.0.0.mpkg/Contents/Packages/target.pkg/Contents/usr/share/cups/model/xerox/ph3117.ppd /Library/Printers/PPDs/Contents/Resources/Xerox\ Phaser\ 3117

```

1. Make it executable:

```
sudo chmod +x /Library/Printers/PPDs/Contents/Resources/Xerox\ Phaser\ 3117

```

1. Edit the PPD to point to the absolute filter path:

```
sudo nano /Library/Printers/PPDs/Contents/Resources/Xerox\ Phaser\ 3117

```

Find the line:

```
*cupsFilter: "application/vnd.cups-raster 0 rastertoqpdl"

```

Change it to:

```
*cupsFilter: "application/vnd.cups-raster 0 /Library/Printers/Samsung/UPD/Filters/rastertoqpdl"

```

Save (`CTRL+X`, `Y`, `Enter`).
1. Compress and set permissions:

```
sudo gzip -f /Library/Printers/PPDs/Contents/Resources/Xerox\ Phaser\ 3117
sudo chmod o+r /Library/Printers/PPDs/Contents/Resources/Xerox\ Phaser\ 3117.gz

```

Step 3: Add the Printer in CUPS (USB Direct)
Since macOS Catalina hides the “Advanced / USB” tab in System Preferences, we must add the printer manually via Terminal:
1. Detect the USB URI:

```
lpinfo -v | grep Phaser

```

You will get something like:

```
usb://Xerox/Phaser%203117?serial=L93540594

```

1. Add the printer:

```
sudo lpadmin -p "Xerox_Phaser_3117" -E -v "usb://Xerox/Phaser%203117?serial=L93540594" -P "/Library/Printers/PPDs/Contents/Resources/Xerox Phaser 3117.gz"

```

1. Set as default (optional):

```
sudo lpadmin -d "Xerox_Phaser_3117"

```

1. Restart CUPS:

```
sudo killall cupsd
sleep 2
sudo launchctl start org.cups.cupsd

```

Step 4: Test Printing

```
echo "TEST PHASER 3117" | lp
lpstat -p

```

You should see:

```
printer Xerox_Phaser_3117 is idle.  enabled since ...

```

Job should start printing immediately.