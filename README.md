# Running a local DNS with Subdomains and TLS/SSL

Primary goal is to develop web apps locally with a local
domain or even with a subdomain and TLS (SSL). Setting this up by modifying the
`/etc/hosts` file and creating wildcard certificates is very painful. And that
doesn't solve the problem of proxying so that we don't have to run the domain
with a port, e.g., `https://developer.test:3000`. An alternative option would be to
use ngrok; however, this doesn't work for a team because the subdomain gets
randomly generated each time it starts up, or only 1 developer can connect at a time
to a static ngrok subdomain.

## Features & Benefits

- Generate wildcard certs to run TLS
- Proxy domain to localhost with port, e.g., `https://developer.test` => `http://localhost:3000`
- Or even subdomains, e.g., `https://api.developer.test` => `http://localhost:8080`
- Can use fake TLD's, e.g., `.test` or `.fake` => `https://developer.fake`
- Can use real TLD's, e.g., `.com`, `.xyz`, etc.
- Each team member can run this same setup
- Common CORS domains for development and testing

### Homebrew Packages

- dnsmasq
- caddy
- mkcert
- nss

## Setup
Run the setup script. This will install the homebrew dependencies
- `bash setup.sh`

This will generate the wildcard certificates at the root of the project. They
are already added to `.gitignore` so you can safely generate as certificates
and domains as you like.

## Teardown
Run the teardown script. This will uninstall the homebrew dependencies and other generated files and directories
- `bash teardown.sh`


## Projects

### Setting Up and Running Apps

You can bundle apps together with their own configuration.
Follow the steps below to create a custom setup for each of your apps.
We'll use the sample `default-app` to demonstrate how this can be done.

**Step 1** - change the DNS and Reverse Proxy as specified in the Caddyfile

- Go into the `default-app` directory and edit the `Caddyfile` to point 
  to the subdomains you want, and the corresponding reverse proxies to 
  localhost ports.

**Step 2** - run local dns

- Go into the `default-app` directory and run the following scripts to start:

  `bash start.sh`

**Step 3** - stop the local dns

- Go into the `default-app` directory and run the following scripts to stop:

  `bash stop.sh`

### Add another project

- Copy the `default-app` directory and make the necessary modifications to the `Caddyfile`

### Customize the TLD's (domain suffixes)

In order to create TLS certificates and for dnsmasq to recognize a domain other than
`.test` or `.xyz`, you'll need to modify the `setup.sh` file to add your specific
TLD and modify your `Caddyfile` to use the correct certs and TLD.

Change the following line by adding or replacing your custom TLD, separated by a `/`:

- `address=/.test/.xyz/127.0.0.1` => `address=/.test/.xyz/.local/.fake/127.0.0.1`

Add new wildcard certificates for your TLD by appending to the end of the file:

```
mkcert '*.my-custom-domain.fake'
mkcert '*.my-custom-domain.local'
```

Modify the `Caddyfile` to use the correct wildcard certs and domain

```
api.my-custom-domain.fake:443 {
  tls ../_wildcard.my-custom-domain.fake.pem ../_wildcard.my-custom-domain.fake-key.pem
  reverse_proxy localhost:8080
}

my-app.my-custom-domain.fake:443 {
  tls ../_wildcard.my-custom-domain.fake.pem ../_wildcard.my-custom-domain.fake-key.pem
  reverse_proxy localhost:3000
}
```

## Notes

- Sometimes you'll be consuming a service that requires a real TLD and `.test`
  will not qualify as a real one. The `setup.sh` includes an `.xyz` TLD
  for such purposes, and will generate certs for it. However, most local 
  development can be done with `.test` to make it clear that it's not a 
  real domain you're developing against.
