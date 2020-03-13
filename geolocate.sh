#! /bin/bash
# Generate a report about locations of the logins
# First time generate the report with all logins in the log
# In other executions append logins from yesterday, because is designed for a daily execution with cron

OUTPUT_FILE=/tmp/server_ip_location.txt

# Grab all public IP addresses that login in this server since yesterday


if [[ -f "${OUTPUT_FILE}" ]]; then
    LOGINS_IP="$(last --since yesterday| head -n -2 | awk '$3 ~ /pts/ { next;} {print $3}')"
else
    LOGINS_IP="$(last | head -n -2 | awk '$3 ~ /pts/ { next;} {print $3}')"
fi


# Call the geolocation API and capture the output
# Example of output
# curl -s https://ipinfo.io/95.121.170.128
# {
#   "ip": "95.121.170.128",
#   "hostname": "128.red-95-121-170.dynamicip.rima-tde.net",
#   "city": "Madrid",
#   "region": "Madrid",
#   "country": "ES",
#   "loc": "40.4165,-3.7026",
#   "org": "AS3352 TELEFONICA DE ESPANA",
#   "postal": "28001",
#   "timezone": "Europe/Madrid",
#   "readme": "https://ipinfo.io/missingauth"
# }

# Split string with newlines characters in lines
# https://unix.stackexchange.com/a/275797
while IFS= read -r IP ; do
    curl -s "https://ipinfo.io/${IP}" | jq '[.ip, .city] | @csv ' | \
	tr -d \" | \
	awk  -F '\' '{print "Login from ip " $2 " sited in " $4 }' >> "${OUTPUT_FILE}"
done <<< "${LOGINS_IP}"
