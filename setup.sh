#!/bin/bash
set -e
FILE=./.env
if test -f "$FILE"; then
    echo "$FILE exists. If you wish to recreate your auth environment variables (which will break everything), delete the .env file."
    exit;
fi
cp .env.example .env

# Autogenerate 24 character hexadecimal strings for all passwords + secret key
sed -i.bak 's/%AA_SECRET_KEY%/'"$(openssl rand -hex 24)"'/g' .env
sed -i.bak 's/%AA_DB_PASSWORD%/'"$(openssl rand -hex 24)"'/g' .env
sed -i.bak 's/%AA_DB_ROOT_PASSWORD%/'"$(openssl rand -hex 24)"'/g' .env
sed -i.bak 's/%AA_DB_ROOT_PASSWORD%/'"$(openssl rand -hex 24)"'/g' .env
sed -i.bak 's/%MUMBLE_ICE_SECERT%/'"$(openssl rand -hex 24)"'/g' .env

#Prompts to collect user information
IFS= read -p "Enter the display name for your auth instance: " sitename
sed -i.bak 's/%AA_SITENAME%/'\""${sitename}"\"'/g' .env

read -p "Enter the base domain (do not include the subdomain): " domain
sed -i.bak 's/%DOMAIN%/'${domain}'/g' .env

read -p "Enter the subdomain for auth: " subdomain
sed -i.bak 's/%AUTH_SUBDOMAIN%/'${subdomain}'/g' .env

read -p "Enter the subdomain for mumble: " mumblesubdomain
sed -i.bak 's/%MUMBLE_SUBDOMAIN%/'${mumblesubdomain}'/g' .env

read -p "Enter an email address. This is requested by CCP if there are any issues with your ESI application, and is not used in any other way by AllianceAuth: " email
sed -i.bak 's/%ESI_USER_CONTACT_EMAIL%/'${email}'/g' .env

echo "Visit https://developers.eveonline.com/ and create an application with the callback url https://${subdomain}.${domain}/sso/callback"

read -p "Enter ESI Client ID: " clientid
sed -i.bak 's/%ESI_SSO_CLIENT_ID%/'${clientid}'/g' .env

read -p "Enter ESI Client Secret: " clientsecret
sed -i.bak 's/%ESI_SSO_CLIENT_SECRET%/'${clientsecret}'/g' .env

echo "1. Visit https://discord.com/developers/applications and a new application"
echo "2. Go to OAuth2 -> General and then add a redirect with url https://${subdomain}.${domain}/discord/callback"
echo "3. Provide the client ID & client secret found on the OAuth2 -> General page"

read -p "Enter Discord Client ID: " discordclientid
sed -i.bak 's/%AA_DISCORD_CLIENT_ID%/'${discordclientid}'/g' .env

read -p "Enter Discord Client Secret: " discordclientsecret
sed -i.bak 's/%AA_DISCORD_CLIENT_SECRET%/'${discordclientsecret}'/g' .env

echo "4. In the Discord developers website go the bot page and click `reset token` to generate a new bot token"

read -p "Enter Discord Bot Token: " discordbottoken
sed -i.bak 's/%AA_DISCORD_BOT_TOKEN%/'${discordbottoken}'/g' .env

echo "5. Get your Discord server id, to do this enable developer mode by opening your personal Discord settings, going to advanced, and checking the `developer mode` box"
echo "6. Create the server then right click the icon on the left sidebar and click `copy server ID` at the bottom"

read -p "Enter Discord Server ID: " discordserverid
sed -i.bak 's/%AA_DISCORD_SERVER_ID%/'${discordserverid}'/g' .env

source ./.env
cp setup.base.sql setup.sql

# Create init SQL file for auth database with users
sed -i.bak 's/authpass/'"$AA_DB_PASSWORD"'/g' setup.sql
rm *.bak
rm .env.bak