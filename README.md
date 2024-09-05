# Ragged Alliance 2
An ARMA 3 mission inspired by a very similar sounding game.

## Description
Liberate cities, villages and other locations on the islands of Tanoa. Player starting inventory, loot inventory and enemy inventory is random and improves with game progress. At the start, you'll be facing looters with no body armor armed with pistols, SMGs and shotguns, until you encounter the Tanoan National Army, who'll come equipped with assault rifles and machine guns.

## What makes it special?
- Developer-written code to quantify a weapon's "value" on the battlefield, that is generic, meaning it could in theory be applicable to any mod OOTB
- This quantification of a weapon's quality is thus used to randomize every unit's inventory and loadout, granting the end-user a complete loot-based environment with regards to weapons the missions offers to the users
- This random genericness is further used on locations themselves; enemy bases and roadblocks are created in editor; a script is used to extract the relative positions of every item and create a `#define BUILDING_HQ_TYPE` blueprint; during mission start, the map is scanned for buildings with known "base-configurations" and a random one is chosen
- All of the above ensures tons of randomness and thereby a same, but unique experience everytime it's played

## Limitations
- Presently, it is only written for and usable on **Tanoa** (the building configs above require it; there are generics, but also only for Tanoa (tropical flavor; generifying this is also possible, in theory, or maybe just LUT translation))
- It requires **all official DLCs (e.g. Marksmen DLC, etc.), including Contact** and **no mods** to have the **same experience as the developer and clients** that have so far tested it
- You can replace the place-holding sound files with the real deal for the more authentic experience; only intro (Menu music), win (sector won), lose (sector lost) are implemented; they add a lot of atmosphere, but I don't want to tread licensing issues by including them here, so this is on you
- **For the actual current source code, please refer to the attachments of the releases**
- If you want to **play it single-player**, place the PBO file in your `MPMissions` folder in your Arma directory and **host a local LAN multiplayer** game; this is effectively de facto single-player ("lone multiplayer")
- There is no saving, so your progress is lost; the current **workaround is a dedicated server with persistency**; if you hack around and enable saving and it happens to work, tell me!

## Instructions
Download the latest release [here](https://github.com/ariebesehl/RaggedAlliance2/releases). Does **not** work on single-player, functional on self-hosted multiplayer ~~with slightly limited gaming experience (e.g. locations supposed to be discovered are already marked on map)~~ (May have been fixed), designed for and works best on dedicated servers.  
This is the command I use to spawn a dedicated server on a Linux shell I've SSH'ed into with the Arma 3 directory as the working directory `nohup ./RA2_Tanoa.sh >stdout.log 2>stderr.log &`  
These are the contents of `RA2_Tanoa.sh`  
    
    #!/bin/sh    
    ./arma3server_x64 -cfg="./serverconfig/basic.cfg" -config="./serverconfig/CONFIG_RA2_Tanoa.cfg" -world=empty -port=2902 -noSound -hugePages -loadMissionToMemory -autoInit

These are the (brevity- and privacy-redacted) contents of `CONFIG_RA2_Tanoa.cfg`  
    
    hostname       = "[DE] cr4qsh0t's dedicated | Ragged Alliance 2 | PUBLIC TESTING"; // *if* my dedicated public server is running, you can find my dedicated server on port 2902 on morgen.ist or zaidatek.net
    //password     = "YOUR_SERVER_PASSWORD";
    passwordAdmin  = "YOUR_ADMIN_PASSWORD"; 
    maxPlayers     = 8;
    persistent     = 1; 
    disableVoN       = 0;     // If set to 1, voice chat will be disabled
    vonCodecQuality  = 10;    // Supports range 1-30
    voteMissionPlayers  = 1;
    voteThreshold       = 9999;
    allowedVoteCmds[] =            // Voting commands allowed to players
    {
    	{"admin", false, false}, // vote admin
    	{"kick", false, true, 0.51}, // vote kick
    	{"missions", false, false}, // mission change
    	{"mission", false, false}, // mission selection
    	{"restart", false, false}, // mission restart
    	{"reassign", false, false} // mission restart with roles unassigned
    };
    motd[] = {""};
    motdInterval = 0;
    autoSelectMission = true; // fix for battleyequerytimeout // idk if still required; used to be an issue around 2021/2022
    class Missions
    {
    	class Mission1
    	{
    		template = "cr4qsh0t_RA2.Tanoa"; // Filename of pbo in MPMissions folder
    		difficulty = "Regular"; // "Recruit", "Regular", "Veteran", "Custom"
    		class Params { // find the names of variables and their default/possible values in CRQ__Param.hpp and CQM__Param.hpp files inside the PBO file
    			CRA_SystemClutterDetect = 1;
    			CRA_ProgressFactor = 4000;
    			CRA_ProgressInit = 0;
    		};
    	};
    };
    timeStampFormat  = "short";
    logFile          = "server_console.log";
    BattlEye             = 0;
    verifySignatures     = 2;
    kickDuplicate        = 1;
    allowedFilePatching  = 1;
    allowedLoadFileExtensions[] =       {"hpp","sqs","sqf","fsm","cpp","paa","txt","xml","inc","ext","sqm","ods","fxy","lip","csv","kb","bik","bikb","html","htm","biedi"}; // only allow files with those extensions to be loaded via loadFile command (since Arma 3 v1.19.124216) 
    allowedPreprocessFileExtensions[] = {"hpp","sqs","sqf","fsm","cpp","paa","txt","xml","inc","ext","sqm","ods","fxy","lip","csv","kb","bik","bikb","html","htm","biedi"}; // only allow files with those extensions to be loaded via preprocessFile / preprocessFileLineNumbers commands (since Arma 3 v1.19.124323)
    allowedHTMLLoadExtensions[] =       {"htm","html","php","xml","txt"}; // only allow files and URLs with those extensions to be loaded via htmlLoad command (since Arma 3 v1.27.126715)
    onUserConnected     = "";    // command to run when a player connects
    onUserDisconnected  = "";    // command to run when a player disconnects
    doubleIdDetected    = "";    // command to run if a player has the same ID as another player in the server
    onUnsignedData      = "kick (_this select 0)";    // command to run if a player has unsigned files
    onHackedData        = "kick (_this select 0)";    // command to run if a player has tampered files
    headlessClients[]  = {""};
    localClient[]      = {"127.0.0.1"};
As you can see from the above, I make the progress 4x faster, meaning you need only acquire 25% of the island's locations for 100% equipment progress, otherwise, the full mission would likely take 240+ hours (no victory condition has been programmed yet; obviously I'm inspired to make it about assasinating a particularly ruthless dictator). System-clutter detect makes the engine run a simulation with known objects to determine their EXACT maximum dimensions via ray-collision, allowing those generic bases to be placed even more immersive into location ba having to delete fewer surrounding cluttering objects.

Once it's started, there are two modes it works: One will hot-load locations, the other cold-loads them before the server starts. Faster systems (>= e.g. Ryzen 2700X) should use the latter, slower the former (e.g. <=i5-3470), this is a user-defined setting, the default I think is to hot-load, so you may need to wait five minutes until the server is warm and ready (you can join beforehand, but only a progress indicator will be there, no enemies or anything).

You parajump in; left-click the location, right-click and hold to drag the map around AND set the direction you want to be faced inserting, mouse-wheel to zoom, and then click OK to spawn in. Liberated locations in your control will show up on the left side of the map as an alternative spawn location, without parajumping.
The default intention is Imuri Island -> Koumac -> Bala Airport, much like Omerta -> Drassen, but the parajump allows you to pick any location you'd want, since it's all code designed to run as generic as possible.

## Known Issues
- ~~Spawning in the first time is a bit buggy.~~ ~~May have been fixed.~~ Probably has.
- Duplicate user-defined actions on inventory/maps at locations are unintentional, but harmless and cosmetic
- Enemy names are not synced if the user is not present when they spawn in, these are harmless as well, and also only cosmetic
- Road-Blocks and Outposts can be cleared without having been discovered; in either case, there is no music to signify an acquisition of the player's party by it (usual victory music too much; silence too litte; but cosmetic)
- and a few more I'm currently likely not thinking about
