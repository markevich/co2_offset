#!/bin/sh
export SECRET_KEY_BASE=mix_phx.gen.secret
export DATABASE_USER=postgres
export DATABASE_PASS=
export DATABASE_NAME=co2_offset_dev
export PORT=4001
export ERLANG_COOKIE=KLJFDKSHF*@HFSUGDF#$JDSSD*SDF#HD*DF%$ASGJBMXMCBNN{}
export LIVE_VIEW_SALT=mix_phx.gen.secret_32
export CO2_OFFSET_SSL_KEY_PATH=/etc/letsencrypt/live/domain_name/privkey.pem
export CO2_OFFSET_SSL_CERT_PATH=/etc/letsencrypt/live/domain_name/chain.pem
export CO2_OFFSET_SSL_CACERT_PATH=/etc/letsencrypt/live/domain_name/cert.pem
