source .env
HOME=/mnt/Base/acmeScript/run /mnt/Base/acmeScript/acme.sh/acme.sh --issue -d "tyderion.ch" -d "*.tyderion.ch" -d "*.homeassistant.tyderion.ch" --keylength ec-256 --dns dns_freedns

