# IngameRCON

**Dependency**: https://github.com/FlashHit/VU-Mods/tree/master/gameAdmin

Tries to replace Procon for VU by allowing the usage of Procon commands ingame.

## Installation
1. Download and Install [gameAdmin](https://github.com/FlashHit/VU-Mods/tree/master/gameAdmin) by FlashHit
2. Download and Install IngameRCON
3. Join your Server right after Startup, the first person joining will automatically be saved as the Server Owner, granting them full rights / priviliges.
4. Add any further Admins using gameAdmin 
5. You are now able to open & use IngameRCON with **F10**
6. Enjoy

## Installation with VUMM (VU Mod Manager)
Can also be installed via VUMM with ```vumm install ingamercon``` (this will install ingamercon and it´s dependency gameAdmin automatically)

### FOR DEVS - Adding Custom Maps & Modes (Dispatch on Client)
Events:Dispatch('InGameRCON:RegisterCustomMap', table)
``` table = {'NameOfMap', {'CustomGroup', {'Mode1', 'Mode2', 'Mode3'}}```

Events:Dispatch('InGameRCON:AddCustomMode', table)
``` table = {'NameOfMap', {'Mode1', Mode2', 'Mode3'}}```
