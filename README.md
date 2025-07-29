# 📚 Rust-Oxide Documentation

Documentation technique pour les classes essentielles du modding Oxide/uMod sur **Rust**. Ce dépôt vise à centraliser les principales propriétés et méthodes des classes utilisées pour interagir avec les joueurs, les conteneurs d’objets, et l’inventaire.

---

## 🔍 Contenu

- [`BasePlayer`](./BasePlayer.md) — Accès aux informations du joueur (vie, position, réseau, etc.)
- [`ItemContainer`](./ItemContainer.md) — Gestion des conteneurs d’objets (sacs, coffres, etc.)
- [`PlayerInventory`](./PlayerInventory.md) — Contrôle de l’inventaire du joueur (sac, ceinture, vêtements)

---

## 🧰 Objectif

Ce dépôt est conçu pour :

- Aider les développeurs de plugins Rust utilisant Oxide/uMod
- Fournir une documentation claire et francisée sur les classes courantes
- Donner des exemples pratiques et structurés (code C#)

---

## 📦 Exigences

- Rust (serveur)
- Oxide/uMod installé
- Connaissances de base en C# et structures Rust

---

## 📘 Exemple d’utilisation rapide

```csharp
void OnPlayerInit(BasePlayer player)
{
    player.ChatMessage("Bienvenue sur le serveur !");
    Puts($"Nouveau joueur : {player.displayName} (SteamID : {player.UserIDString})");
}
