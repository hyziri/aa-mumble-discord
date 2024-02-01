# Alliance Auth w/ Discord & Mumble Example

## Setup

1. Get a domain if you don't have one already, you need to create 2 A records for this setup, `auth` & `mumble` for example, which point to the IP address of your server.
2. Clone this repo to your server
3. Run the setup script by running `sh start.sh` in your install directory.
4. Run `docker-compose up -d`
5. Run `docker-compose exec allianceauth bash` and then the following commands

- `auth migrate`
- `auth collectstatic`
- `auth createsuperuser`

You're done, login to your site with the admin account.

## Mumble Certificates

Certificates have to be created for mumble manually as an automatic solution has not been added here yet (feel free to create a pull request if you wish).
To get mumble certificates install certbot <https://certbot.eff.org/> & run it for your mumble domain, if mumble has trouble accessing the certificates then you may need to change the permissions on the letsencrypt folder containing the certs.
