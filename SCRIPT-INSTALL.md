# Script-Based Installation (Recommended)

This document explains how to install and configure the **Xerox Phaser 3117** on **macOS Catalina** using the **provided script**.

This is the **fastest and safest method** and is recommended for most users.

If you want to understand or perform the setup manually, see **INSTALL.md**.

---

## What the Script Does

The script automates all required steps:

* Sets correct permissions for Splix filters
* Fixes the PPD to use an **absolute CUPS filter path**
* Removes broken or auto-installed printer entries
* Adds the printer directly via **CUPS (USB)**
* Restarts the CUPS service safely

No System Settings interaction is required.

---

## Requirements

### Supported system
* macOS **10.15.x Catalina**
* Intel Mac
* USB connection
* Xerox Phaser 3117

### Required software (from this repo)

1.  **Samsung / HP Mac Printer Driver v3.92**
2.  **Splix 2.0.0**

Place the file `Splix-2.0.0.mpkg` on your **Desktop**:
`~/Desktop/Splix-2.0.0.mpkg`

---

## Files Used by the Script

The script relies on the following files from Splix:
* `pstoqpdl`
* `rastertoqpdl`
* `ph3117.ppd`

After installation, the system will use:
* `/Library/Printers/Samsung/UPD/Filters/pstoqpdl`
* `/Library/Printers/Samsung/UPD/Filters/rastertoqpdl`
* `/Library/Printers/PPDs/Contents/Resources/Xerox Phaser 3117.gz`

A diagram of these paths is included in the repository.

---

## How to Use the Script

### 1️⃣ Open Terminal
Applications → Utilities → Terminal

---

### 2️⃣ Navigate to the repository folder
Example:
```bash
cd ~/xerox-phaser3117-splix-catalina

3️⃣ Make sure the script is executable
chmod +x install_phaser.sh

4️⃣ Run the script
./install_phaser.sh

5️⃣ Test printing
After the script finishes:
echo "TEST PHASER 3117" | lp
lpstat -p

Expected result:

Printer is enabled

Job prints immediately

-----------------------------------------------------------------------------------------------------------------------------------------------

Important Notes
Do NOT add the printer via System Settings: macOS may auto-add the printer using a broken driver. If that happens, simply run the script again.

The script is:

Idempotent (safe to re-run)

Non-destructive

Limited to printer-related paths only

When to Re-run the Script
Re-run the script if:

You reconnect the printer and printing stops.

macOS auto-installs a Generic/Gutenprint driver.

A macOS update resets printer settings.

Troubleshooting
Printer prints but nothing comes out
Ensure paper is loaded.

Check lpstat -p.

Error mentioning: /usr/libexec/cups/filter/rastertoqpdl not found
This means a broken driver is in use.

Re-run the script.

Manual Installation
If you want to understand or manually perform each step, see INSTALL.md.

License
This script and documentation are licensed under MIT. Third-party software is not included and remains under its original license.

Author: Script and documentation by Radu Zamfir

Tested on: macOS Catalina, 2026
