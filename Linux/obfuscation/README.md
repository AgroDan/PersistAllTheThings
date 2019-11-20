# Obfuscation

Thinking like an administrator, when one is privy to an attack, many will attempt to determine if the foreign threat is actually there on the machine *right this second.* As a result, it's very useful to cover your tracks there once the admin has reason to believe that you are actively on this machine. Here are some obfuscation tricks you can use to prevent discovery.

## Rewrite the function

Most functions can be overwritten in such a way that you can remove lines from the output without hiding the output at all. Say for example, you wanted to re-write the "who" binary to eexclude the line referencing the IP address of you, the would-be attacker would add this to the global /etc/bashrc file (credit to Bryan J. Agee):

```bash
function who(){
    /usr/bin/who $@ | sed -r '/some|strings|to|hide/d'
```

This will allow the binary to operate normally, but will drop any lines containing "some", "strings", "to", or "hide." This is useful as "which" will still point to the binary itself, and the binary will even return the same md5sum, but bash will prefer to use a local function call over the binary.

Another method is to simply use an alias, which can also be added to /etc/bashrc:

```bash
alias who='who | grep -v your.ip.address'
```

This is a little more lightweight than the function, but works pretty well in a pinch.
