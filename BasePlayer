# 👤 Documentation Oxide/Rust — Classe `BasePlayer`

Cette documentation regroupe les principales propriétés et méthodes disponibles sur la classe `BasePlayer` utilisée dans Rust via Oxide/uMod.

---

## 🧱 Propriétés générales

| Propriété           | Type           | Description |
|---------------------|----------------|-------------|
| `userID`            | `ulong`        | SteamID 64 du joueur |
| `UserIDString`      | `string`       | SteamID sous forme de chaîne |
| `displayName`       | `string`       | Nom visible du joueur |
| `net`               | `Network.Net`  | Informations réseau du joueur |
| `Connection`        | `Connection`   | Connexion réseau (authentification, IP, etc.) |
| `playerID`          | `ulong`        | Identifiant unique |
| `IsSleeping()`      | `bool`         | Indique si le joueur dort |
| `IsConnected`       | `bool`         | Indique si le joueur est connecté |
| `IsAdmin`           | `bool`         | Le joueur est administrateur (serveur) |
| `IsDeveloper`       | `bool`         | Indique si c’est un dev (Rust) |
| `IsNpc`             | `bool`         | Indique s’il s’agit d’un NPC |
| `userGroup`         | `string`       | Groupe d’utilisateur |
| `currentTeam`       | `ulong`        | ID de l’équipe actuelle |
| `client`            | `BasePlayer.ClientInfo` | Infos client (locale, IP, etc.) |

---

## 🌍 Localisation et position

| Propriété / Méthode | Type        | Description |
|---------------------|-------------|-------------|
| `transform.position`| `Vector3`   | Position du joueur dans le monde |
| `eyes.position`     | `Vector3`   | Position des yeux du joueur (utile pour raycasts) |
| `ServerPosition`    | `Vector3`   | Position serveur actuelle |
| `IsVisible(BaseEntity)` | `bool` | Vérifie si une entité est visible depuis la position du joueur |
| `LookRotation()`    | `Quaternion`| Orientation du regard du joueur |

---

## 💬 Communication

| Méthode             | Paramètres       | Description |
|---------------------|------------------|-------------|
| `SendConsoleCommand(string cmd)` | `cmd` = commande console | Envoie une commande à la console du joueur |
| `SendNetworkUpdate()` | — | Force la mise à jour réseau du joueur |
| `ChatMessage(string msg)` | `msg` = texte | Envoie un message dans le chat local |
| `ConsoleMessage(string msg)` | `msg` = texte | Envoie un message à la console client |

---

## 🎒 Inventaire et items

| Propriété / Méthode | Type           | Description |
|---------------------|----------------|-------------|
| `inventory`         | `PlayerInventory` | Accès complet à l’inventaire |
| `GetHeldEntity()`   | `HeldEntity`   | Récupère l’objet tenu dans la main |
| `GiveItem(Item item)` | `void`       | Ajoute un item à l’inventaire |
| `GiveItem(Item item, ItemContainer container)` | `void` | Place l’item dans un conteneur précis |
| `TakeDamage(...)`   | `void`         | Inflige des dégâts personnalisés |

---

## ❤️ Vie et état du joueur

| Propriété / Méthode | Type   | Description |
|---------------------|--------|-------------|
| `health`            | `float`| Vie actuelle |
| `MaxHealth()`       | `float`| Vie maximale |
| `IsDead()`          | `bool` | Le joueur est-il mort ? |
| `Kill()`            | `void` | Tue immédiatement le joueur |
| `Hurt(float amount)`| `void` | Inflige des dégâts |
| `Heal(float amount)`| `void` | Soigne le joueur |

---

## 📦 Divers utiles

| Méthode / Propriété | Type      | Description |
|---------------------|-----------|-------------|
| `Ban(string reason)`| `void`    | Bannit le joueur |
| `Kick(string reason)`| `void`   | Expulse le joueur |
| `CanBuild()`        | `bool`    | Peut-il construire ? |
| `CanInteract()`     | `bool`    | Peut-il interagir avec l’environnement ? |
| `MountEntity(BaseMountable entity)` | `void` | Monte sur un objet (ex : véhicule) |
| `DismountObject()`  | `void`    | Descend de l’objet monté |
| `EnsureDismounted()`| `void`    | Force le démontage |

---

## 📘 Exemple d'utilisation

```csharp
void OnPlayerInit(BasePlayer player)
{
    Puts($"Connexion de : {player.displayName} (SteamID : {player.UserIDString})");
    player.ChatMessage("Bienvenue sur le serveur !");
}
