# Architecture : avant / après

## Avant : une adresse publique, des portes partout

```
                 Internet
                    │
             <IP_PUBLIQUE>
                    │
        Routeur (redirections de ports)
        ┌───────┬───────┬───────┬───────┬───────┐
        │       │       │       │       │       │
     Serveur Serveur Serveur Serveur Serveur Serveur
        1       2       3       4       5       6
```

**Problèmes identifiés :**

- Le routeur redirige directement des ports vers chaque serveur : **autant de points d'entrée que de services**.
- Des services d'administration (accès à distance, bases de données) étaient joignables depuis Internet.
- Aucun point central pour chiffrer, filtrer ou observer le trafic.

## Après : une seule porte d'entrée contrôlée

```
                 Internet
                    │
             <IP_PUBLIQUE>
                    │
        Routeur (UNE redirection : 80 / 443 / VPN)
                    │
         ┌──────────────────────┐
         │ Serveur reverse proxy│  NGINX + HTTPS + UFW + Fail2ban + ntopng
         └──────────┬───────────┘
                    │  réseau local uniquement
        ┌───────┬───┴───┬───────┬───────┬───────┐
     Serveur Serveur Serveur Serveur Serveur Serveur
        1       2       3       4       5       6

   Administration à distance : uniquement via le VPN WireGuard
```

**Ce qui a changé :**

| Avant | Après |
|---|---|
| Un point d'entrée par service | Un seul point d'entrée |
| Administration exposée sur Internet | Administration réservée au réseau local et au VPN |
| Trafic non chiffré selon les services | HTTPS partout, certificats renouvelés automatiquement |
| Aucune visibilité | Supervision en temps réel avec ntopng |
| Pas de protection contre les tentatives répétées | Bannissement automatique (Fail2ban) |

## Limites et pistes d'amélioration

- Le reverse proxy devient un **point unique de défaillance** : une redondance serait à prévoir.
- Le réseau interne est encore « à plat » : une segmentation par VLAN / DMZ limiterait les dégâts en cas de compromission d'un serveur.
- Un IPS (par exemple Suricata) et une journalisation centralisée compléteraient la détection.
