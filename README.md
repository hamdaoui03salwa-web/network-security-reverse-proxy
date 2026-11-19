# 🔐 Sécurisation d'une architecture réseau de 6 serveurs

Stage de 2 mois (juillet - août 2026) à l'Académie Régionale de l'Éducation et de la Formation Souss-Massa, Agadir.

## 🎯 Contexte et problème

Six serveurs internes (Linux et Windows) étaient accessibles depuis Internet à travers **une seule adresse IP publique**, via des redirections de ports (NAT). Plusieurs services d'administration se retrouvaient exposés directement.

**Analogie :** c'était un immeuble où chaque appartement avait sa propre porte donnant sur la rue. L'objectif était de n'avoir qu'**une seule entrée**, avec un gardien qui contrôle qui passe et où.

## 🏗️ Solution : une seule porte d'entrée contrôlée

```
Internet → <IP_PUBLIQUE> → Serveur reverse proxy (NGINX) → 6 serveurs internes
                                      │
                                      └→ VPN WireGuard pour l'administration à distance
```

| Besoin | Outil | Rôle |
|---|---|---|
| Point d'entrée unique | NGINX (HTTP/HTTPS + TCP stream) | Reçoit tout et redirige vers le bon serveur |
| Chiffrement | Let's Encrypt / Certbot | Certificats HTTPS avec renouvellement automatique |
| Résolution interne | dnsmasq | DNS local avec filtrage |
| Accès distant sécurisé | WireGuard | Tunnel VPN, une configuration par utilisateur |
| Durcissement | UFW, Fail2ban | Pare-feu, bannissement des tentatives répétées |
| Accès admin | SSH/RDP limités au LAN et au VPN | Plus aucune administration exposée sur Internet |
| Supervision | ntopng | Visualisation du trafic en temps réel |

## 🔎 Audits de sécurité non intrusifs

Audits réalisés avec **Nmap**, **Nikto** et **OpenSSL** sur des serveurs Linux et Windows : identification des vulnérabilités et recommandations de remédiation.

## 📁 Contenu du dépôt

- `docs/` : architecture avant / après (schémas anonymisés)
- `configs/` : exemples de configuration NGINX, UFW, Fail2ban (valeurs fictives)

## ⚠️ Note

Toutes les adresses, domaines et identifiants ont été volontairement anonymisés (`<IP_PUBLIQUE>`, `192.168.x.x`, `exemple.com`).

## 🛠️ Technologies

`NGINX` `WireGuard` `Let's Encrypt` `dnsmasq` `UFW` `Fail2ban` `ntopng` `Nmap` `Nikto` `OpenSSL` `Ubuntu Server` `Cisco Packet Tracer`
