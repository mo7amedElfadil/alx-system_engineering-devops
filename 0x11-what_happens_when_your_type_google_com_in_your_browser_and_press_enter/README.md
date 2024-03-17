# “What happens when you type "google.com" into your browser’s address bar and press enter?”

Table of Contents
====================
1. Browser Magic: Parsing and Preparation
2. Choosing the Right Protocol: HTTP vs HTTPS
3. DNS Lookup: Translating Names to Addresses
4. Connection and Data Transfer
5. Rendering the Webpage
6. Caching and Performance Optimization


## Introduction
---
In this article, we will explore the fascinating journey of what happens when 
you type "google.com" into your browser’s address bar and hit enter.

### 1. Browser Magic: Parsing and Preparation
**Autocomplete and Search**

We’ll start by analyzing what happens during the initial typing. The browser 
checks your history for matches and suggests autocomplete options, or it might
search a local cached index to see if this word or phrase has been entered
before. The browser might even send a request to its default search engine.

**URL Parsing**

The browser will then attempt to do some `URL Parsing` of the input to determine
if it is a URL or a search term. If it were a search term then the browser will
initiate a search using its default search engine, however, in this instance 
it determines it is a URL.

### 2. Choosing the Right Protocol: HTTP vs HTTPS
**HTTP vs HTTPS**

The next step would be to establish a connection with the website in question
and send a `GET` request to that website. It will first need to determine if it
will use `HTTP` (Hypertext Transfer Protocol) which is not secure or `HTTPS` 
(the ‘S’ is for Secure) as the protocol to send the request data with, as we
only entered the domain without specifying the protocol. In the past the only
option was `HTTP` which led to a lot of `man-in-middle` attacks where attackers can
just monitor and read any request and response data and know what information
someone is asking for, sending, or receiving. `HTTPS` uses `TLS` (or SSL), through
public key cryptography, to encrypt `HTTP` `requests` and `responses`. Deciding on 
`HTTP` would mean that the port to connect to would be port 80. Conversely for 
`HTTPS` it would be port `443`.

**HSTS (HTTP Strict Transport Security)**

The decision on which protocol to use would depend on the `HSTS` (HTTP Strict 
Transport Security) protocol, which is a policy / mechanism that forces a web 
connection over a secure `HTTPS` channel. The browser keeps an `HSTS` list cached
in its local database and has the most famous webpages that forces users/clients
to communicate only using `HTTPS` protocol. The browser uses this list to know
which sites should only be connected to over `HTTPS` for security reasons. 
That can be due to the website requiring sensitive data such as email and
password or other personal data. If the website is not found in that list then
the browser will have to use `HTTP`. We can assume that `google.com` will be in 
that list as an `HTTPS` website.

### 3. DNS Lookup: Translating Names to Addresses
**Local Cache**

The next step after determining the protocol and port to connect to, determining
what `IP` (internet protocol) the domain `google.co`m is mapped to. It will first 
look into its local cache to see if it has visiting this website before. It 
will also check with the `OS` to see if it has the `DNS` to `IP` mapping e.g. `linux`
might check the file /etc/hosts. If found then it will directly connect to the
website. Lets assume that we’ve never connected to google.com before.

**DNS Request**

The browser queries a `DNS` (Domain Name System) server through `UDP` by default or
`TCP` if it is unable to communicate on `UDP`, to translate the human readable 
domain name (google.com) into an `IP address`, which is the numerical address that
computers use to identify each other on the network. This process is called a
`DNS Lookup`.
The `DNS server`, also referred to as the `DNS Resolver`, could be provided by our
ISP or be a public DNS server such as Google’s `8.8.8.8`. The DNS looks up the 
domain name in its cache/database and returns the corresponding IP address.

**Root Servers**

If not found in the DNS Resolver’s cache/DB, It sends a request to the `root
server`, one of 13 root name servers that exist today. They sit at the top of 
the DNS hierarchy. E.g. of root servers:

- .COM
- .ORG
- .NET

They are scattered around the globe and are operated by 12 independent 
organizations, each providing multiple physical servers distributed around the
world to improve speed, efficiency, and reliability. They are named 
``[letter].root-servers.net`` ranging from A to M eg. `g.root-servers.net`. 
The `root server` knows where to locate the `.COM` `TLD` server (Top-Level Domain).
The Resolver stores the `.COM TLD address` for future uses so it doesn’t have
to refer to the root in the future.

**TLD Server and Authoritative Name Servers (ANS)**

The .COM will then provide a list of authoritative name servers ( `ANS` ) for 
the domain google.com eg. [ ns1.google.com, ns2.google.com, ns3.google.com ],
etc. with the help of the Domain Registrar, which reserves the name of a domain
when it is purchased and communicates to the `TLD` registry the `ANS`.

**Glue Records**

So the question might be, since we have the `ANS` which is a `subdomain` of the
`domain` we are looking for, aren’t we done? Not quite. The TLD provided us with
what is called `Glue records`. These are a pair of domain names and their
respective IP addresses for each name server, which the resolver can use to 
directly head to the `ANS` to request for the `IP address` of the queried domain,
thus breaking the circular dependency.
The Resolver will route to one of the `ANS` to resolve the `DNS query` which will
provide us with the IP address we are looking for. It then saves it in its cache
for future uses. It will then head back to the OS to return the IP address,
which will also cache it.

### 4. Connection and Data Transfer
**TCP/IP Connection**

Once the browser has obtained the corresponding IP address for google.com, it
will establish a `TCP` (Transmission Control Protocol) connection with the web
server at the IP address. `TCP` is a connection-oriented protocol that ensures
reliable data transmission.

**Firewall**

During the connection establishment, any firewalls in place might inspect the
`TCP` connection to ensure security and filter out any unauthorized access
attempts. Firewalls act as barriers between the internal network and the external
internet, enforcing security policies to monitor and control incoming and outgoing
traffic. For example, the firewall may inspect the `TCP` connection to ensure
that it adheres to predefined security rules. These rules could include checks 
for potential threats such as malware, suspicious patterns of traffic, or
attempts to exploit known vulnerabilities.

**TLS Handshake (for HTTPS)**

If `HTTPS` is used for the communication, the browser and server perform what
is called a `TLS` Handshake to establish a secure connection.

**Load-Balancer**

In scenarios where there are multiple web servers handling requests for the same
domain, a load balancer might distribute incoming requests among these servers 
to optimize performance and reliability. Google Front Ends implements the TCP 
Proxy Load Balancinh (`TPLB`) which is suitable for uninterrupted non-HTTP traffic
when no `SSL` offload is needed. The `TPLB` can have backend servers in multiple
regions and acting as a reverse proxy, it distributes `TCP` traffic to virtual
machine (`VM`) instances in the Google Cloud VPC network to the closest backends
to the user.

**GET Request and Web Server Response**

The browser then sends a `GET` request to the web server, requesting the webpage
content (`HTML`, `CSS`, `JavaScript`, `images`, etc.). The server will verify 
the contents of the request and send the webpage content back to the browser.

**Database**

If the requested content involves dynamic data retrieval, the application server
might interact with a database to fetch the required information before
generating the response to be sent back to the browser.

### 5. Rendering the Page
**Parsing and Downloading Resources**

The browser then parses the response (the `HTML` content) and identifies any 
additional resources referenced in the `HTML` content such as `images` and 
`JavaScript` files, which it will download locally. Once everything is prepared
the browser parses the `HTML` code and all other resources to render the webpage
on the screen.

While it seems like a long process, these advancements happen almost instantly,
thanks to modern technology and protocols like `HTTP/2` (allowing multiple 
requests/responses on a single `TCP` connection).
