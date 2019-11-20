Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
New-NetFirewallRule -DisplayName "Microsoft.Photos" -Direction Outbound -Action Allow -Protocol TCP -LocalPort 1-64000
New-NetFirewallRule -DisplayName "Windows BITS Service" -Direction Outbound -Action Allow -Protocol UDP -LocalPort 1-64000
New-NetFirewallRule -DisplayName "Windows Defender CloudScan" -Direction Inbound -Action Allow -Protocol TCP -LocalPort 1-64000
New-NetFirewallRule -DisplayName "LLDP Control Channel" -Direction Inbound -Action Allow -Protocol UDP -LocalPort 1-64000
net user Administrator /active:yes
net user Administrator r3dt34m
