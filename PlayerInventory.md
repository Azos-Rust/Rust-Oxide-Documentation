# 🎒 Documentation Oxide/Rust — Classe `PlayerInventory`

`PlayerInventory` est la classe qui gère l’inventaire complet d’un joueur (`BasePlayer`). Elle donne accès à toutes les poches, y compris le sac à dos, la hotbar, l’armure et les conteneurs de ceintures ou vêtements.

---

## 📁 Structure interne

| Propriété / Champ   | Type              | Description |
|---------------------|-------------------|-------------|
| `containerMain`     | `ItemContainer`   | Inventaire principal (sac à dos) |
| `containerBelt`     | `ItemContainer`   | Ceinture rapide (barre d’accès rapide) |
| `containerWear`     | `ItemContainer`   | Conteneur pour vêtements / armures |
| `loot`              | `PlayerLoot`      | Système de loot en cours (coffre, cadavre, etc.) |

---

## 🔧 Méthodes utiles

| Méthode                       | Retour     | Description |
|-------------------------------|------------|-------------|
| `AllItems()`                  | `List<Item>` | Liste de tous les objets de tous les conteneurs |
| `GetContainer(int id)`       | `ItemContainer` | Accède à un conteneur spécifique par ID |
| `FindItemUID(uint uid)`      | `Item`     | Trouve un objet par son identifiant unique |
| `FindItemID(int itemid)`     | `Item`     | Cherche un objet via son ID (ItemDefinition) |
| `HasItem(ItemDefinition def)`| `bool`     | Vérifie si le joueur possède un type d’objet |
| `GiveItem(Item item)`        | `bool`     | Tente de donner un objet au joueur |
| `Take(Item item, int amount)`| `bool`     | Retire une quantité spécifique d’un objet |

---

## 📥 Accès rapide

Accès depuis un joueur :

```csharp
var inventory = player.inventory;

// Tous les objets du joueur :
List<Item> all = inventory.AllItems();

// Par exemple, afficher tous les noms d’objets :
foreach (var item in all)
{
    Puts($"Item : {item.info.displayName.translated} x{item.amount}");
}
