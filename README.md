
### What Was Set Up

1. **Created Helper Scripts in `D:\Safe\Mines\Own`:**
    - **[add_to_defender_exclusions.bat](file:///D:/Safe/Mines/Own/add_to_defender_exclusions.bat)**: One-click tool to add the project folder and `xmrig.exe` to Windows Defender Exclusion List (requests Admin UAC elevation automatically).
    - **[start_miner_hidden.vbs](file:///D:/Safe/Mines/Own/start_miner_hidden.vbs)**: Launches `xmrig.exe` silently in the background without opening a command prompt window.
    - **[start_miner.bat](file:///D:/Safe/Mines/Own/start_miner.bat)**: Simple batch script set to the correct working directory (`D:\Safe\Mines\Own`).

2. **Added to Windows Startup:**
    - Created a shortcut (`XMRigMiner.lnk`) in your Windows Startup folder:
      `C:\Users\<User>\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
    - Whenever you log into Windows, XMRig will start automatically in the background with your `config.json` loaded.

---  

### Optional: Enable Admin Privileges (For Maximum Hashrate / MSR Mod)

By default, Startup items run with standard user permissions. If you want XMRig to enable MSR performance tweaks (which improves CPU hash rate):

1. Press `Win + R`, type **`taskschd.msc`**, and press **Enter**.
2. Click **Create Task...** on the right panel:
    - **Name**: `XMRig Startup`
    - Check **Run with highest privileges**.
3. Under the **Triggers** tab:
    - Click **New...** $\rightarrow$ Set *Begin the task* to **At log on**.
4. Under the **Actions** tab:
    - Click **New...** $\rightarrow$ Action: **Start a program**.
    - Program/script: `D:\Safe\Mines\Own\xmrig.exe`
    - Start in (optional): `D:\Safe\Mines\Own`
5. Click **OK** to save.

---  

Here are the standard ways to set it up to run on boot in Linux depending on your setup:

---

### Method 1: `systemd` Service (Recommended for Linux)

This runs XMRig automatically on boot as a background service (with `root` permissions so CPU MSR tweaks and huge pages work for maximum performance).

1. Make the script executable:
   ```bash
   chmod +x /path/to/Own/start_miner.sh
   ```

2. Create a systemd service file:
   ```bash
   sudo nano /etc/systemd/system/xmrig.service
   ```

3. Paste the following configuration (replace `/path/to/Own` with your actual Linux path):
   ```ini
   [Unit]
   Description=XMRig Miner Service
   After=network.target

   [Service]
   Type=simple
   WorkingDirectory=/path/to/Own
   ExecStart=/path/to/Own/xmrig
   Restart=always
   RestartSec=10
   User=root

   [Install]
   WantedBy=multi-user.target
   ```

4. Enable and start the service:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now xmrig
   ```

To check status or stop it:
```bash
sudo systemctl status xmrig
sudo systemctl stop xmrig
```

---

### Method 2: Cron Job (`@reboot`)

If you want a lightweight setup without systemd:

1. Open crontab:
   ```bash
   sudo crontab -e
   ```

2. Add this line at the end (adjusting the path):
   ```bash
   @reboot /path/to/Own/start_miner.sh > /dev/null 2>&1 &
   ```

---

### Method 3: GUI Desktop Autostart

If you are using a desktop environment (GNOME, KDE, XFCE, etc.) and want it to launch when you log into your desktop:

1. Create an autostart file:
   ```bash
   mkdir -p ~/.config/autostart
   nano ~/.config/autostart/xmrig.desktop
   ```

2. Add the following content:
   ```ini
   [Desktop Entry]
   Type=Application
   Name=XMRig Miner
   Exec=/path/to/Own/start_miner.sh
   Path=/path/to/Own
   Terminal=false
   X-GNOME-Autostart-enabled=true
   ```