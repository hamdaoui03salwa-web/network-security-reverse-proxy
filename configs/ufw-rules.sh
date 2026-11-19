#!/bin/bash
# Exemple de règles UFW pour le serveur reverse proxy
# Valeurs fictives : à adapter avant tout usage.
# ATTENTION : sur un serveur géré en SSH, autoriser SSH AVANT d'activer UFW,
# sinon tu te fermes toi-même la porte.

# 1) Politique par défaut : tout est fermé, sauf ce qu'on autorise
ufw default deny incoming
ufw default allow outgoing

# 2) Le web est public : c'est le rôle du reverse proxy
ufw allow 80/tcp
ufw allow 443/tcp

# 3) Le VPN WireGuard doit être joignable depuis Internet
ufw allow 51820/udp

# 4) L'administration SSH : uniquement depuis le réseau local et le VPN
ufw allow from <RESEAU_LAN> to any port 22 proto tcp
ufw allow from <RESEAU_VPN> to any port 22 proto tcp

# 5) La supervision ntopng : uniquement depuis le réseau local
ufw allow from <RESEAU_LAN> to any port 3000 proto tcp

# 6) Activation
ufw enable
