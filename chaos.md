Documentation d’utilisation – Oxide.Ext.Chaos (pour développeurs de plugins)

Ce document explique comment utiliser l’extension Oxide.Ext.Chaos en s’appuyant sur les usages réels observés dans deux plugins fournis (AdminMenu et Loadouts). Il couvre la base plugin (ChaosPlugin), la construction d’UI (UIFramework / ChaosUI / ChaosPrefab), la configuration typée, la gestion de données (Datafile<T>), les callbacks d’UI, la pagination, et une intégration Discord.

Sommaire

Fondations : ChaosPlugin

Données typées : Datafile<T>

UI Chaos : UIFramework, ChaosUI, ChaosPrefab

Conteneurs & styles

Layouts & pagination

Callbacks d’UI

Composants prêts-à-l’emploi (prefabs)

Gestion de l’UI à l’exécution

Recherche, filtres et champs de saisie

Permissions & groupes (patterns d’UI)

Configuration typée & migration

Intégration Discord (journalisation)

Recettes de développement

Référence rapide des classes Chaos observées

Exemples “copier-coller”

Checklist de démarrage

1) Fondations : ChaosPlugin

Héritez de ChaosPlugin pour bénéficier des services Chaos : config typée, helpers d’UI, localisation, etc. Les plugins fournis héritent directement de ChaosPlugin et importent les namespaces Oxide.Ext.Chaos, Oxide.Ext.Chaos.UIFramework, etc.

Cycle de configuration (typée)

Chargement : surchargez OnLoadConfig et retournez new ConfigurationFile<YourConfig>(Config).

Migration : implémentez OnConfigurationUpdated(VersionNumber oldVersion) pour injecter/initialiser les nouveaux champs selon oldVersion.

Valeurs par défaut : fournissez GenerateDefaultConfiguration<T>() pour renvoyer un objet de configuration complet (sections, listes, exemples).

Localisation / helpers d’affichage

Utilisez des helpers (ex. GetString, FormatString) pour composer du texte localisé dans l’UI Chaos (étiquettes, titres, boutons…).

Permissions (annotations)

Déclarez des constantes annotées [Chaos.Permission] pour centraliser les permissions et faciliter leur gestion/énumération.

2) Données typées : Datafile<T>

Datafile<T> encapsule un fichier persistant (JSON) fortement typé : ouverture simple, accès via .Data, et Save() quand nécessaire.

Plusieurs datafiles : vous pouvez ouvrir/maintenir plusieurs stores (ex. loadouts joueurs, coûts, limitations, états temporaires).

Remplissage/MAJ automatique : itérez la liste d’items du jeu et complétez les clés manquantes dans vos dictionnaires, puis Save().

Purge/initialisation : sur vos modèles, exposez des méthodes utilitaires (purge d’entrées “anciennes”, caches d’infos joueurs…) et appelez-les au démarrage.

3) UI Chaos : UIFramework, ChaosUI, ChaosPrefab

La stack UI de Chaos est déclarative et chaînée : vous créez un BaseContainer racine (souvent ImageContainer), y ajoutez des enfants via .WithChildren(...), puis affichez l’ensemble via ChaosUI.Show(player, root).

3.1 Conteneurs & styles

Création & affichage :

var root = ImageContainer.Create("MY_UI", Layer.Overlay, Anchor.Center, new Offset(-300f,-200f,300f,200f))
    .WithStyle(m_BackgroundStyle)
    .WithChildren(parent => { /* … */ })
    .DestroyExisting();
ChaosUI.Show(player, root);


Pattern courant : overlay (Layer.Overlay / Layer.Overall), style (fond, matériau, couleurs), injection d’enfants, et DestroyExisting() pour remplacer proprement une UI portant le même ID.

Styles/Thèmes : centralisez Style, OutlineComponent, couleurs, polices et sprites (souvent dérivés d’une config). Exemples typiques : couleurs de fond/panneau/bouton, outline de sélection, matériau de flou, sprites arrondis.

Fermer/Nettoyer : ChaosUI.Destroy(player, UI_ID) pour fermer un écran (penser aux popups/overlays secondaires).

3.2 Layouts & pagination

Déclarez des groupes de layout (grid/horizontal/vertical) avec dimension fixe (FixedSize, FixedCount) et surface (Area, Padding, Spacing, Corner).

Peignez des collections via .WithLayoutGroup(layout, items, page, (i, item, parent, anchor, offset) => { /* dessiner item */ }).

Activez les flèches “<<< / >>>” selon layout.HasNextPage(page, totalCount).

3.3 Callbacks d’UI

Instanciez CommandCallbackHandler et branchez les actions via .WithCallback(handler, arg => { … }, "unique.key").

Dans les callbacks, mettez à jour l’état (page, filtre, sélection, valeur saisie) puis reconstruisez l’UI (la source de vérité).

3.4 Composants prêts-à-l’emploi (prefabs)

ChaosPrefab.* fournit des briques rapides : Panel, Title, TextButton, Input, Toggle, PreviousPage, NextPage, etc., pour accélérer la mise en page d’entêtes, de listes et de panneaux d’actions.

4) Gestion de l’UI à l’exécution

Overlays & popups : utilisez des IDs d’UI distincts (ex. …_UI, …_UI_POPUP, …_UI_OVERLAY) afin de pouvoir les afficher/détruire indépendamment.

Toasts temporisés : affichez un petit container sur Layer.Overall, stockez un Timer par joueur, et détruisez l’UI au bout de X secondes.

Navigation / rafraîchissement : après une action (clic, commande exécutée, convar modifiée), redessinez l’écran d’origine pour refléter l’état courant.

5) Recherche, filtres et champs de saisie

Barre de recherche : placez un InputFieldContainer dans votre en-tête. Dans le callback .WithCallback(...), récupérez le texte via arg.Args, mettez à jour le filtre, remettez page = 0, puis redessinez la vue.

Astuce UX : ajoutez une icône (PNG ou item icon) à gauche du champ, et un bouton “X” à droite pour réinitialiser rapidement le filtre.

6) Permissions & groupes (patterns d’UI)

Onglets restreints par permissions : conditionnez l’accès aux onglets/actions (ex. “Convars”, “Plugins”, “Give”, “Players…”) à des permissions dédiées, et grisez/masquez les boutons pour lesquels l’utilisateur ne les possède pas.

Permissions dynamiques : si vos permissions dépendent d’entrées de config (ex. commandes custom), enregistrez-les au Init() pour éviter les oublis côté serveur.

7) Configuration typée & migration

Modèle : créez ConfigData : BaseConfigData avec [JsonProperty] sur chaque champ pour contrôler le JSON. Les sous-classes (ex. “CommandEntry”, “Colors”, “Costs”, “Limits”) permettent d’organiser clairement la config.

Défauts riches : via GenerateDefaultConfiguration<T>(), fournissez des exemples utiles (commandes chat/console préremplies, couleurs d’UI, tailles de grilles…).

Migration : dans OnConfigurationUpdated(oldVersion), alimentez les nouveaux champs si oldVersion est inférieur à la version d’introduction (ex. ajouter LogWebhook, PurgeDays, AlternateUI, etc.).

8) Intégration Discord (journalisation)

API : DiscordWebhook, DiscordMessage, DiscordEmbed, DiscordColor.

Pattern typique : une instance _webhook initialisée avec l’URL depuis la config ; construction d’un embed (auteur = joueur + lien Steam, description = message + timestamp) ; SendAsync(...).

Conseil : court-circuiter si l’URL webhook est vide pour éviter des envois inutiles.

9) Recettes de développement
9.1 Ouvrir un menu avec entête, corps, pied + bouton “Fermer”

Racine ImageContainer en Layer.Overlay, style de fond, un header (ChaosPrefab.Title) avec bouton ✘ (callback → ChaosUI.Destroy), un corps qui accueille vos listes/panels, et un pied (pagination / actions globales).

9.2 Liste paginée + marqueur de sélection

WithLayoutGroup pour dessiner la collection ; outline ou style accentué si l’item est sélectionné ; flèches “<<< / >>>” selon HasNextPage.

9.3 Popup/Toast auto-dismiss 5s

Mini conteneur sur Layer.Overall; mémorisez le Timer précédent pour éviter les doublons ; détruisez l’UI à expiration.

9.4 Convars éditables en ligne

Chaque convar → une ligne avec label + champ InputFieldContainer ; au callback : ConsoleSystem.Run(Option.Server, convarFullName, newValue) puis redessin.

10) Référence rapide des classes Chaos observées

Base/Config : ChaosPlugin, BaseConfigData, ConfigurationFile<T>, OnConfigurationUpdated(VersionNumber), GenerateDefaultConfiguration<T>().

Data : Datafile<T> avec .Data, Save().

UI Core : BaseContainer, ImageContainer, TextContainer, ButtonContainer, InputFieldContainer, RawImageContainer ; Anchor, Offset, Layer, Style, Color, Font.

Layouts : GridLayoutGroup, HorizontalLayoutGroup, VerticalLayoutGroup, Area, Padding, Spacing, Corner, Axis, HasNextPage(page, total).

Prefabs : ChaosPrefab.Panel/Title/TextButton/Input/Toggle/PreviousPage/NextPage.

Discord : DiscordWebhook, DiscordMessage, DiscordEmbed, DiscordColor.

11) Exemples “copier-coller”
11.1 Panneau centré avec titre + Quitter
var root = ImageContainer.Create("MY_UI", Layer.Overlay, Anchor.Center, new Offset(-300f,-200f,300f,200f))
  .WithStyle(m_BackgroundStyle)
  .WithChildren(parent => {
    // Entête
    ImageContainer.Create(parent, Anchor.TopStretch, new Offset(5f,-35f,-5f,-5f))
      .WithStyle(m_PanelStyle)
      .WithChildren(titleBar => {
        TextContainer.Create(titleBar, Anchor.FullStretch, new Offset(5f,0f,-35f,0f))
          .WithStyle(m_TitleStyle)
          .WithText("Mon menu");
        ImageContainer.Create(titleBar, Anchor.CenterRight, new Offset(-25f,-10f,-5f,10f))
          .WithStyle(m_ButtonStyle)
          .WithChildren(exit => {
            TextContainer.Create(exit, Anchor.FullStretch, Offset.zero).WithText("✘");
            ButtonContainer.Create(exit, Anchor.FullStretch, Offset.zero)
              .WithColor(Color.Clear)
              .WithCallback(m_CallbackHandler, _ => ChaosUI.Destroy(player, "MY_UI"), $"{player.UserIDString}.close");
          });
      });
  })
  .DestroyExisting();
ChaosUI.Show(player, root);

11.2 Pagination simple d’une liste
bool hasNext = m_ProfileLayoutGroup.HasNextPage(page, items.Count);

ImageContainer.Create(parent, Anchor.BottomLeft, new Offset(5f,5f,72.5f,25f))
  .WithChildren(back => {
    TextContainer.Create(back, Anchor.FullStretch, Offset.zero).WithText("<<<");
    if (page > 0) {
      ButtonContainer.Create(back, Anchor.FullStretch, Offset.zero)
        .WithColor(Color.Clear)
        .WithCallback(m_CallbackHandler, _ => Redraw(page - 1), $"{player.UserIDString}.back");
    }
  });

ImageContainer.Create(parent, Anchor.BottomRight, new Offset(-72.5f,5f,-5f,25f))
  .WithChildren(next => {
    TextContainer.Create(next, Anchor.FullStretch, Offset.zero).WithText(">>>");
    if (hasNext) {
      ButtonContainer.Create(next, Anchor.FullStretch, Offset.zero)
        .WithColor(Color.Clear)
        .WithCallback(m_CallbackHandler, _ => Redraw(page + 1), $"{player.UserIDString}.next");
    }
  });

11.3 Convar éditable en ligne + log
InputFieldContainer.Create(parent, Anchor.FullStretch, Offset.zero)
  .WithText(currentValue)
  .WithAlignment(TextAnchor.MiddleCenter)
  .WithCallback(m_CallbackHandler, arg => {
      ConsoleSystem.Run(ConsoleSystem.Option.Server, convarFullName, arg.GetString(1));
      Redraw();
  }, $"{player.UserIDString}.convar.edit");

12) Checklist de démarrage

Hériter de ChaosPlugin et créer ConfigData : BaseConfigData. Brancher OnLoadConfig, OnConfigurationUpdated, GenerateDefaultConfiguration.

Centraliser les styles (thème UI : couleurs, outlines, sprites) au chargement.

Instancier CommandCallbackHandler et tous les callbacks UI.

Construire l’UI (containers + prefabs), nommer les zones, ChaosUI.Show.

Layouts & pagination avec HasNextPage.

Fermer/nettoyer correctement (ChaosUI.Destroy) y compris popups temporisés.

(Optionnel) Journaliser via DiscordWebhook si pertinent.
