# UNRAID-r8127-driver

Realtek R8127 Linux drivers optimized for Unraid.

## Choose Your Version

This repository provides **two versions** of the plugin. Please choose the one that best fits your hardware environment:

### Option A: Standard Version (Recommended)
* **Behavior:** Installs OOT `r8127` and **blacklists/disables** the native `r8169` driver to prevent conflicts.
* **Installation URL:**

Copy and paste the following URL into the **Install Plugin** tab on the Unraid Plugins page:

```
https://raw.githubusercontent.com/ERSTT/unraid-r8127-driver/main/unraid-r8127.plg
```

### Option B: Coexistence Version (No-Disable-R8169)
* **Behavior:** Installs OOT `r8127` **WITHOUT** disabling the native `r8169` driver. Both drivers remain available.
* **Best for:** Servers with multiple Realtek NICs where some cards still rely on the native `r8169` driver to function.
* **Note:** Since `r8169` is not blacklisted, there is a minor risk that the kernel may mistakenly bind your RTL8127 card to the native `r8169` driver instead of the newly installed OOT `r8127` driver.
* **Installation URL:**

Copy and paste the following URL into the **Install Plugin** tab on the Unraid Plugins page:

```
https://raw.githubusercontent.com/ERSTT/unraid-r8127-driver/main/unraid-r8127-no-disable-r8169.plg
```

---

## Features (Features apply to both versions)
- **Multiple Queue:** Enabled for enhanced network performance.
- **ASPM:** Disabled to ensure connection stability.

## Credits
- **Official driver source:** [Realtek R8127](https://www.realtek.com/Download/List?cate_id=584)
- **Primary code source:** [unraid-r8125-r8152-driver](https://github.com/jinlife/unraid-r8125-r8152-driver)
