#!/bin/bash

PORTAINER_HASH=$(htpasswd -nbB admin $PORTAINER_PASSWORD | cut -d ":" -f 2)
exec /usr/local/bin/portainer/portainer --admin-password "$PORTAINER_HASH"