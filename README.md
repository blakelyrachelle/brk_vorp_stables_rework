# BRK VORP Stables Rework

A free community rework of VORP Stables

This resource is based on the original VORP stable system and has been updated with cleaner stable configuration, improved menu behavior, expanded horse/component data, vendor-specific shop behavior, and a new tack storage/loadout workflow.

---

## Release Notice

This resource is released free for the VORP/RedM community.

You may edit it for use on your own server.

You may not rename, repackage, redistribute, or resell this resource as your own work.

Please keep credits to VORP, CrimsonFreak, and BRK intact.

For bug support or reasonable behavior-tweak requests, contact **Akrania** on Discord.

---

## Features

### Stable System

- Buy, store, call, transfer, and release horses and carriages.
- Optional hard-death system for long-term horse damage.
- Default horse and carriage support.
- Horse and carriage inventories through `vorp_inventory`.
- Stable vendors can be configured per location.
- Stable menus only show horses, carts, and categories available at that location.

### Vendor Configuration

- Configure different horses and carts per stable.
- Organize horses into clean shop categories.
- Hide empty/unavailable categories automatically.
- Configure display names more cleanly.
- Set a currency type per horse/vendor entry.

### Tack and Equipment

- Tack is separated from hair components.
- Manes and tails save directly to the horse.
- Tack uses a storage/loadout system.
- Bought tack equips to the selected horse.
- Replaced tack moves into tack storage instead of being deleted.
- Removing horse equipment stores equipped tack instead of deleting it.
- Stored tack can be equipped again from the stable menu.
- Per-horse tack loadouts are tracked separately from general tack storage.
- Duplicate tack limits can be controlled through config.

### Compatibility / Migration Support

- Existing owned horses are preserved when using the included SQL migration.
- Existing `stables.gear` equipment remains usable.
- Old equipped tack can be picked up by fallback logic and moved into the new tack system when replaced or removed.

### Menu / Stability Improvements

- Improved React/NUI stable menu handling.
- Improved preview horse cleanup.
- Reduced camera/focus issues when exiting the menu.
- Fixed component preview issues caused by moving quickly through menu entries.
- Improved component apply logic for saved horses and preview horses.

---

## Requirements

- VORP Core
- VORP Inventory
- oxmysql

---

## Installation

1. Place script in your server resources folder.
2. Make sure the resource folder is named one of the following:

```txt
brk_vorp_stables_rework
vorp_stables
```

3. Add the resource to your `server.cfg`:

```cfg
ensure brk_vorp_stables_rework
```

or, if using the original VORP folder name:

```cfg
ensure vorp_stables
```

4. Run the included SQL file before starting the resource.
5. Configure `config.lua`, `data.lua`, and `languages.lua` as needed.
6. Restart the server.

---

## SQL Setup / Migration

Use the included:

```txt
stables.sql
```

### Fresh Install

1. Import `stables.sql` into your database.
2. Start the resource.

### Updating From Old VORP Stables

1. Back up your database first.
2. Import `stables.sql` into your existing database.
3. Start the resource.

The included SQL is intended to preserve existing owned horses. It does not drop the existing `stables` table.

It creates or updates the required tack tables:

```txt
horse_tack_storage
horse_tack_loadout
```

It also performs cleanup/sync steps for tack loadout ownership where possible.

### Important SQL Notes

- Back up your database before running any migration.
- Do not run old SQL files that contain `DROP TABLE stables` unless you are intentionally wiping horses for a clean install.
- Existing horses in the `stables` table should remain.
- Existing old gear stored in `stables.gear` should remain usable.
- Old equipped tack is moved into the new tack system when replaced or removed through the stable menu.

---

## Usage

Keys are not currently configurable.

### Basic Interactions

| Key | Action |
| --- | --- |
| **G** | Open stable vendor when in range |
| **U** | Open ride inventory when in range |
| **H** | Call default horse |
| **J** | Call default carriage |
| **Spacebar** | Stop horse from following |
| **Ctrl + Spacebar** | Prance while mounted |

### Focus Interactions

Focus on a horse with **right click** to use these actions.

| Key | Action |
| --- | --- |
| **B** | Brush horse and remove dirt |
| **F** | Make horse flee and despawn |
| **E** | Make horse follow you |

### UI Notes

- The UI is mouse-based.
- When left/right arrows are shown, use the keyboard arrow keys instead of clicking the arrows.

---

## Ride Transfer

Players can transfer a horse or carriage to another player, with or without a sale price.

The transfer offer is registered server-side. The receiving player can accept or decline the offer the next time they visit a stable vendor.

When a horse transfer is accepted, the horse ownership and tack loadout ownership should move to the new character.

---

## Equipment Behavior

### Hair

Hair components include manes and tails.

Hair is saved directly to the horse and is not stored as tack.

### Tack

Tack includes saddles, blankets, saddle horns, saddlebags, stirrups, bedrolls, lanterns, and masks.

Tack is handled through the tack storage/loadout system:

- The equipped tack is saved to that horse's tack loadout.
- Replaced tack is moved into storage.
- Removed tack is moved into storage.
- Stored tack can be equipped again later.

---

## Config

| Key | Type | Description |
| --- | --- | --- |
| `Lang` | reference | Language table reference, for example `Langs.En` |
| `StaticData` | reference | Core static data reference. Do not modify unless you know what you are changing. |
| `MaxHorses` | integer | Maximum number of horses a player can own |
| `MaxCarts` | integer | Maximum number of carriages a player can own |
| `StableSlots` | integer | Maximum combined horse and carriage stable slots |
| `SecondsToRespawn` | integer | Time a player must wait before recalling a dead horse |
| `DisableBuyOption` | boolean | Disables all horse and cart purchasing when set to `true` |
| `JobRequired` | boolean | Enables job checking for ride purchases |
| `JobForHorseDealer` | string | Job required to buy horses when job checks are enabled |
| `JobForCartDealer` | string | Job required to buy carriages when job checks are enabled |
| `JobForAllDealer` | string | Job required to buy both horses and carriages when job checks are enabled |
| `HardDeath` | boolean | Enables or disables the hard death system |
| `LongTermHealth` | integer | Long-term health value used by the hard death system |
| `ShowTagsOnHorse` | boolean | Enables floating names above horses |
| `HorseSkillPullUpFailPercent` | integer | Chance of falling while prancing |
| `DistanceToTeleport` | integer | Distance at which an unused horse or carriage is deleted and respawned closer |
| `MaxTackPerItem` | integer / false | Maximum owned copies of the same tack hash, or `false` for unlimited |
| `Stables` | table | Stable location configuration |

---

## Stable Config

| Key | Type | Description |
| --- | --- | --- |
| `Name` | string | Name displayed on the in-game prompt |
| `BlipIcon` | integer | Stable blip icon |
| `EnterStable` | table | Prompt location and interaction radius |
| `StableNPC` | table | Stable NPC position |
| `SpawnHorse` | table | Horse preview spawn position |
| `SpawnCart` | table | Cart preview spawn position |
| `CamHorse` | table | Horse preview camera position and rotation |
| `CamCart` | table | Cart preview camera position and rotation |
| `horses` | table | Vendor horse inventory for this stable |
| `carts` | table | Vendor cart inventory for this stable |

---

## Vendor Config

Stable vendors can be configured to sell different horses and carts per location.

The menu only displays entries that are available at that stable. Horse categories with no available horses are hidden automatically.

### Supported Vendor Entry Formats

| Format | Description |
| --- | --- |
| `{ "RIDE_NAME_HASH" }` | Uses the default price defined in `Data[rideType]` |
| `{ RIDE_NAME_HASH = price }` | Uses a custom price for that vendor |
| `{ RIDE_NAME_HASH = { name = "Display Name", price = 100, currency = 0 } }` | Uses display name, price, and currency override |

---

## Translation

To add or edit translations:

1. Open `languages.lua`.
2. Copy the existing `En` language table.
3. Rename the language key.
4. Translate the values.

French and English are already included.

---

## Developers

The UI is a Vite + React app.

The compiled UI is included for normal server use. You only need to rebuild the UI if you edit files inside `UI/src`.

To install dependencies and rebuild the UI:

```bash
cd UI
npm i
npm run build
```

For UI development testing:

```bash
npm run dev
```

Development mode requires valid test data to properly preview the interface.

---

## Public Release Notes

Before uploading this resource publicly, do not include `node_modules` in the release zip or GitHub repository.

Recommended release contents:

```txt
Client/
Server/
UI/dist/
UI/src/
config.lua
data.lua
events.lua
keys.lua
languages.lua
deathReasons.lua
fxmanifest.lua
stables_ready.sql
README.md
```

---

## Credits

**Original resource:** [VORP Stables](https://github.com/VORPCORE/VORP-Stables)  
**Original author:** [CrimsonFreak](https://github.com/CrimsonFreak)  
**BRK rework:** [BlakelyRachelle](https://github.com/blakelyrachelle)

Support/contact: **Akrania** on Discord.
