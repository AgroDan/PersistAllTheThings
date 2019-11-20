# SystemD service

Install the following file in /etc/systemd/system/rtfm.service

Then change the provided code to work with any reverse shell or
whatever persistence method you'd like. It kicks off and tries
a connection out every second.

Start the service with:

```bash
$ systemctl start rtfm
$ systemctl enable rtfm
```

This technique from James Golovich, learned from Cyberforce gitlab
account.
