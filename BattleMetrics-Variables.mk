# Variables de modèle BattleMetrics — Aide-mémoire rapide

> **Remarque :** L’ensemble exact des variables dépend de votre **jeu** et du **type de déclencheur**. Pour la liste définitive dans votre configuration, ouvrez le déclencheur/planificateur dans l’éditeur et cliquez sur **Condition Table** (en haut à droite). Utilisez les variables entre doubles accolades comme `{{player.name}}`.

---

## Variables serveur (`server.*`)

| Variable | Type | Description |
|---|---|---|
| `server.id` | string | Identifiant BattleMetrics du serveur. |
| `server.name` | string | Nom du serveur. |
| `server.ip` | string | IP du serveur (si disponible). |
| `server.port` | number | Port du serveur (si disponible). |
| `server.players` | number | Nombre actuel de joueurs. |
| `server.maxPlayers` | number | Nombre maximal de places. |

---

## Variables joueur (`player.*`)

| Variable | Type | Description |
|---|---|---|
| `player.id` | string | Identifiant BattleMetrics du joueur. |
| `player.name` | string | Nom affiché / pseudo. |
| `player.steamID` | string | Steam64 ID (si applicable). |
| `player.timePlayed` | number | Total des secondes jouées. |
| `player.ip` | string | IP du joueur (si fournie via RCON). |
| `player.ip.country` | string | Pays dérivé de l’IP. |
| `player.steam.country` | string | Pays depuis le profil Steam (si disponible). |

> Certains jeux exposent d’autres champs (p. ex. des identifiants spécifiques à la plateforme). Utilisez la **Condition Table** pour confirmer ce qui est disponible pour votre déclencheur.

---

## Variables de message & de commande (`msg.*`)

| Variable | Type | Description | Déclencheur(s) typique(s) |
|---|---|---|---|
| `msg.body` | string | Texte du chat/message. | Message joueur, Commande admin |
| `msg.command` | string | Chaîne de la commande admin. | Commande admin |
| `msg.commandSource` | string | Source de la commande (p. ex., en jeu, RCON). | Commande admin |

---

## Commande personnalisée (action déclenchée par l’utilisateur) (`user.*`, `input.*`)

| Variable | Type | Description |
|---|---|---|
| `user.id` | string | Utilisateur BattleMetrics qui a invoqué la commande. |
| `user.nickname` | string | Surnom de cet utilisateur. |
| `input.<name>` | string | Valeur d’un champ personnalisé ; remplacez `<name>` par la clé du champ. |

> `user.*` et `input.*` ne sont présents **que** pour les **actions déclenchées par l’utilisateur (commandes personnalisées)**.

---

## Horodatage

| Variable | Type | Description |
|---|---|---|
| `timestamp.iso8601` | string | Heure d’exécution au format ISO‑8601 (utile pour journaux/embeds). |

---

## Helpers (fonctions) courants pour les templates

Ces fonctions s’exécutent **à l’intérieur** de `{{ ... }}` et peuvent être combinées/imbriquées.

- **Chaînes :** `concatenate`, `coalesce`, `join`
- **Maths :** `add`, `subtract`, `multiply`, `divide`, `round`, `toPrecision`
- **Logique :** `if`, `equal`, `not`, `and`, `or`, `gt`, `lt`, `gte`, `lte`
- **JSON :** `jsonObject`, `jsonArray`

> Exemple : `{{toPrecision (divide player.timePlayed 3600) 1}}` → heures jouées avec 1 décimale.

---

## Exemples pratiques

**1) Ligne de chat compacte**
```text
{{concatenate "[" server.name "] " player.name ": " msg.body}}
```

**2) Badge de population du serveur**
```text
{{concatenate server.name " (" server.players "/" server.maxPlayers ")"}}
```

**3) Audit des commandes admin**
```text
{{jsonObject
  embeds=(jsonArray (jsonObject
    title=(concatenate "Commande admin sur " server.name)
    description=(concatenate "**Commande :** " msg.command "\n**Source :** " msg.commandSource "\n**À :** " timestamp.iso8601)
  ))
}}
```

**4) Attribution de commande personnalisée**
```text
{{jsonObject
  embeds=(jsonArray (jsonObject
    title=(concatenate "Commande exécutée par " user.nickname " (" user.id ")")
    description=msg.body
  ))
}}
```

---

### Conseils
- Vous pouvez combiner librement variables et helpers ; entourez chaque élément avec `{{ ... }}`.
- Si une variable est parfois absente, utilisez `coalesce`, p. ex. `{{coalesce player.steam.country player.ip.country "Inconnu"}}`.
- Pour votre jeu + déclencheur exacts, ouvrez la **Condition Table** et copiez les variables directement depuis cette liste.
