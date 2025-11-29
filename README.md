NIDS are the most popular tools for monitoring network traffic. There is 
clearly a fine line between raising alerts for every single packet or flow and 
raising alerts for highly specific traffic. This assignment wants to make you 
become acquainted with Suricata IDS. Develop the following signatures:

 - Many viruses have specific signatures that can be seen either when they are 
being downloaded (e.g., http download exe file) or once they are installed 
they have specific communication patterns (specific payloads). While 
executables can be detected based on their hex or hash values, network 
patterns need specific hex signatures. Since most viruses already have 
signatures which can be found online (not ideal for an assignment), your first 
task is to instead develop a policy signature that detects HTTP png downloads. 
Your signature's msg (very important) should be: 
`POLICY HTTP Portable network graphics downloaded`

 - Encoded binary files in HTTP downloads use Base64 encoding. A good example 
of this is where a binary (encoded in Base64) is meant to be executed through 
PowerShell. Build a policy that alerts us whenever we see Base64 in HTTP 
inbound traffic. The signature msg should be: 
`POLICY HTTP Base64 encoding detected.` You will need perl compatible regular 
expressions for this one.  Use an online regex test service while building 
your pattern. 

 - Create a Suricata alert that can detect an inbound port scan on port 
addresses below 1024. Use a suricata alert to detect a potential slow port 
scan (hint: you will need to use threshold: type threshold, track by_src...). 
Use the nmap.pcap to help you test (or the actual command from the terminal. 
The signature msg should be: `SCAN nmap -sS.`

 - Finally, Lua scripting. There are weird domain name requests that are the 
likely result of Domain Generation Algorithms. One way to detect such traffic 
(which would be wise) is through the use of Shannon's Entropy on the domain's 
alphanumeric and - (minus) characters. You need to omit . (periods). Look for 
what a string's max entropy could be and it will make sense why. Lua scripts 
attach to Suricata rules and their output either returns 0 or 1 (the latter 
means raise an alert). Look for the Lua Scripting reference on Suricata's 
online manual. For simplicity, let us forget that multiple DNS queries could 
be stacked in one DNS payload. Raise an alert if a domain name's entropy is at 
least 3 and is at least 85% of the max possible entropy for that string 
length. For capturing domain names you will need to use patterns in lua to 
find domain names in the payload (there is an option for accessing this 
through Lua). The signature msg should be: POLICY DNS Domain name request with 
entropy > 3 and at least 85% of max entropy. TIP: use print in lua to output 
different results as you are testing your patterns.
