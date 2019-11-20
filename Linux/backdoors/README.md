# Backdoors

Creating a backdoor is kind of an art. You can just set a while loop and have it just push out a netcat shell every minute, but you have to ensure that it's not going to clobber a previous netcat session or else you could be relatively noisy. If you don't obfuscate your IP address and processes, a backdoor can be easily detected. Since the goal here is persistence, you would need to create a backdoor that's quiet and stable. For hiding these, check out the Obfuscation section.
