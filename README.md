# Ragged Alliance 2
*An ARMA 3 mission inspired by a very similar sounding game's name... but in 3D and in the first-person-view!*

Liberate cities, villages, installations and the entire map from enemies using random and progressively improving weapons available to the game.

At the start, you'll be facing looters, bandits and outlaws with little-to-no body armor, armed with pistols, SMGs and shotguns.

And after you finally defeat those, you'll start encountering the armed forces, who are equipped with assault rifles, machine guns, rocket launchers and much, much worse!

## Features
- On average, a village may have 10 **different buildings the enemy may randomly set up their base** in
- Thus, two villages would already mean 100 different and unique base combinations
- This philosophy towards **randomness is also implemented** in the mission's handling of **equipment, enemy sizes, skills, squad constellations** and many more
- A **progress system** is implemented, which automatically determines what equipment and assets are available to the players and enemies, and when
- All of these features ensure a **unique experience** on every playthrough
- Great care and delicate consideration to ensure sane and balanced defaults
- Extreme customizability (optional)
- A great tool to effectively learn to use and operate all of the game's assets
- Drop-in/-out gaming and join-in-progress (JIP) supported (for example, dynamically adjusted enemy forces based on number of players)

## Limitations
- The mission has been a steady on/off work-in-progress since late 2021, but is definitely enjoyably **playable for hours-on-end**, due to the inherent randomness and the progress system
- Originally **developed on Tanoa**, the mission has been expanded to accomodate other maps and terrains (**currently experimentally testing Malden**)
- It is currently being **tested with assets from all official expansion packs and DLCs**
- Compatibility with popular community-mods is intended, in the current design paradigm, but unimplemented (*"Using RHS/CUP/etc. assets is on the (distant) road-map, but vanilla should be done for that first..."*)
- Otherwise, *specific* mod-compatibilities are unknown, but generally not improbable
- There is no saving yet, the current workaround is a (dedicated) **server with persistency** (saving for this mission in itself has just only recently been made feasibly possible by the updates to the game's engine)
- (As with many other Arma 3 missions) Single-player is only 'quasi-supported' via self-hosting a LAN multiplayer game (but it is *actually* supported in that the mission becomes harder with two players than one player)


## Instructions (non-dedicated)
- Download the latest release [here](https://github.com/ariebesehl/RaggedAlliance2/releases)
- To **play single-player,** place the PBO file in your `MPMissions` folder in your Arma directory and **host a local LAN multiplayer** game; this is effectively single-player ("lone multiplayer")

## Instructions (dedicated servers)
- The official BI instructions on how to set up dedicated servers apply the same
- On a dedicated server running *Linux*, the command-line I use is: `./arma3server_x64 -cfg="./serverconfig/basic.cfg" -config="./serverconfig/CONFIG_RA2_Tanoa.cfg" -world=empty -port=2902 -noSound -hugePages -loadMissionToMemory -autoInit`
- The variable names and default/possible values for `class Params {NAME=VALUE;}` in the server config can be found in `CRQ/CRQ__INC__Param.hpp` and `CRA/CRA__INC__Param.hpp`
    
## Known Issues
- ~~Spawning in the first time is a bit buggy.~~ ~~May have been fixed.~~ ~~Probably has.~~ Not sure, but it seems so.
- The **Teleport** system is an early-stage QOL feature, and it's far from perfect, especially if the location you're spawning into is also unspawned
- ~~Duplicate user-defined actions on inventory/maps at locations are unintentional, but harmless and cosmetic~~ Possibly fixed.
- Enemy names are not synced if the user is not present when they spawn in, these are harmless as well, and also only cosmetic
- Road-Blocks and Outposts can be cleared without having been "discovered" first (they are only ever cleared, never captured)
- "and many more" ;)

## Screenshots

**Note (2025-06-20):** These are somewhat outdated now

![20240906164941_1](https://github.com/user-attachments/assets/14547ebc-3986-4dab-9f77-a07774f60e97)
>*The map after liberating Imuri Island, Koumac and Bala Airstrip, and using the "Gather Intel" action on Bala Airstrip's map, revealing the surrounding area's locations (in the case of an airport, a lot of intel is secured). Half-transparent markers are inactive locations, for which simulation runs suspended. The distance of this defaults to a flat 700m, but it can be adjusted to a higher/lower value and grow or shrink with progress. Locations are kept in an unknown state to decide at the very last moment (to mirror the current progress as closely as possible) what equipment, units, faction, etc. the location is spawned with/as.*
---
![20240906165832_1](https://github.com/user-attachments/assets/fcc91430-f89a-4a96-b195-67150a891539)
>*The randomly picked enemy base in Yanukka from the preceding screenshot. As a lone player and with default settings, only one larger guard squad and two smaller patrol squads garrison a base at this stage. In the background, a civilian vehicle is moving away into the distance and was spawned in such a way that its origin and destination are beyond the player's activation range and a central waypoint is a random road segment within a certain radius of the player (a civilian road vehicle becomes spawnable when a valid path fulfilling the above criteria has been found, after which it becomes a probability if it gets spawned at all). Compensations due for moving players are also in effect.*
---
![20240906165842_1](https://github.com/user-attachments/assets/7a2146e7-dbb0-419c-96d8-65a55c64d005)
>*Same as above, a little later, but without HUD.*
---
![20240906165950_1](https://github.com/user-attachments/assets/3e9bca9e-48c1-4dda-9644-3bcc97a2c302)
>*The inside of that base. The map can be gathered for intel, revealing locations, and used to teleport and parajump (arbitrarily as of current development state). The inventory box also gathers loot from corpses and on the ground, and can unload/repack items/mags. A map is part of every location worth points and one that a player can secure, and intentionally missing from Road Blocks/Outposts (which currently cannot be captured by the player, only neutralized)*
---
![20240906170001_1](https://github.com/user-attachments/assets/aab9ec83-58c8-47bb-bdc3-87f0541149d9)
>*The plants are not part of the base configuration are part of the scenery; they did not intersect with the base's blueprint, hence they are not deleted from the global scenery when the base spawns. Every component in a non-player/non-character unit's identity (voice, face, pitch, uniform/clothing) is a randomly picked as well.*
---
![20240906170016_1](https://github.com/user-attachments/assets/3a0f4861-d9ef-40b3-b698-b7f2d66d4f45)
>*Patrol paths and bases (what to delete, what to insert) are all precalculated at the beginning to optimize run-time efficiency. A ground-evenness compensation for base decorations is not being performed, as the tipped over bench demonstrates.*

