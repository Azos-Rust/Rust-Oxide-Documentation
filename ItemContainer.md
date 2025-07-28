# 📂 Documentation Oxide/Rust — Classe `ItemContainer`

La classe `ItemContainer` représente un conteneur d’objets dans Rust. Elle est utilisée dans l’inventaire du joueur (`PlayerInventory`), mais aussi dans les coffres, les entités lootables, les boîtes, etc.

---

## 📁 Propriétés principales

| Propriété            | Type          | Description |
|----------------------|---------------|-------------|
| `itemList`           | `List<Item>`  | Liste des objets contenus dans le conteneur |
| `capacity`           | `int`         | Nombre de slots maximum dans le conteneur |
| `uid`                | `uint`        | ID unique du conteneur |
| `playerOwner`        | `BasePlayer`  | Joueur propriétaire (s’il y en a un) |
| `entityOwner`        | `BaseEntity`  | Entité propriétaire (coffre, corpse, etc.) |
| `isServer`           | `bool`        | Si le conteneur existe côté serveur |
| `allowedContents`    | `ItemContainer.ContentsType` | Types de contenus autorisés (ex : vêtements, armes, etc.) |
| `flags`              | `ItemContainer.Flag` | Paramètres spécifiques (ex : verrouillé) |

---

## 🔧 Méthodes utiles

| Méthode                        | Retour         | Description |
|--------------------------------|----------------|-------------|
| `CanAccept(Item item)`         | `bool`         | Vérifie si l’objet peut être placé dans ce conteneur |
| `FindItemByUID(uint uid)`      | `Item`         | Recherche un objet par UID |
| `HasItem(Item item)`           | `bool`         | Vérifie si le conteneur contient un objet donné |
| `GetSlot(int i)`               | `Item`         | Récupère l’objet à l’index `i` (slot) |
| `RemoveItem(Item item)`        | `void`         | Supprime l’objet du conteneur |
| `Clear()`                      | `void`         | Vide entièrement le conteneur |
| `Insert(Item item)`            | `bool`         | Tente d’ajouter un objet (si possible) |

---

## 🧰 Création de conteneur personnalisé

Tu peux créer manuellement un conteneur (utile pour du loot virtuel, des UI customs, etc.).

```csharp
ItemContainer container = new ItemContainer
{
    capacity = 6,
    allowedContents = ItemContainer.ContentsType.Generic,
    flags = ItemContainer.Flag.IsLoot,
    isServer = true
};

// Exemple : créer un item et l’ajouter
Item item = ItemManager.CreateByName("wood", 250);
bool inserted = item.MoveToContainer(container);

if (inserted)
{
    Puts($"L’objet a été inséré avec succès !");
}
else
{
    Puts($"Échec d’insertion dans le conteneur.");
}

## 🧪 Exemple d’accès

```csharp
var belt = player.inventory.containerBelt;

foreach (var item in belt.itemList)
{
    Puts($"Slot ceinture : {item.info.shortname} x{item.amount}");
}
