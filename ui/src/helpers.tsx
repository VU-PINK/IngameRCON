import React, { forwardRef } from "react";

import { Toggle } from "rsuite";

export function sendToLua(event: string, value?: any) {
    if (!navigator.userAgent.includes('VeniceUnleashed')) {
        if (window.location.ancestorOrigins === undefined || window.location.ancestorOrigins[0] !== 'webui://main') {
            return;
        }
    }

    if (value !== null) {
        WebUI.Call('DispatchEventLocal', event, value);
    } else {
        WebUI.Call('DispatchEventLocal', event);
    }
}

export const ToggleExtended = forwardRef((props: any, ref: any) => 
    <Toggle {...props} checked={props.value} ref={ref} />
);


export const GamemodeNames: any = {
	ConquestLarge0: 'Conquest Large',
	ConquestSmall0: 'Conquest',
	ConquestAssaultLarge0: 'Conquest Assault Large',
	ConquestAssaultSmall0: 'Conquest Assault',
	ConquestAssaultSmall1: 'Conquest Assault: Day 2',
	RushLarge0: 'Rush',
	SquadRush0: 'Squad Rush',
	SquadDeathMatch0: 'Squad Deathmatch',
	TeamDeathMatch0: 'Team Deathmatch',
	TeamDeathMatchC0: 'Team DM Close Quarters',
	Domination0: 'Conquest Domination',
	GunMaster0: 'Gun Master',
	TankSuperiority0: 'Tank Superiority',
	Scavenger0: 'Scavenger',
	CaptureTheFlag0: 'Capture the Flag',
	AirSuperiority0: 'Air Superiority'
};


export const LevelNames: any = {
	MP_001: 'Grand Bazaar',
	MP_003: 'Teheran Highway',
	MP_007: 'Caspian Border',
	MP_011: 'Seine Crossing',
	MP_012: 'Operation Firestorm',
	MP_013: 'Damavand Peak',
	MP_017: 'Noshahr Canals',
	MP_018: 'Kharg Island',
	MP_Subway: 'Operation Metro',
	XP1_001: 'Strike at Karkand',
	XP1_002: 'Gulf of Oman',
	XP1_003: 'Sharqi Peninsula',
	XP1_004: 'Wake Island',
	XP2_Palace: 'Donya Fortress',
	XP2_Office: 'Operation 925',
	XP2_Factory: 'Scrapmetal',
	XP2_Skybar: 'Ziba Tower',
	XP3_Alborz: 'Alborz Mountains',
	XP3_Shield: 'Armored Shield',
	XP3_Desert: 'Bandar Desert',
	XP3_Valley: 'Death Valley',
	XP4_Parl: 'Azadi Palace',
	XP4_Quake: 'Epicenter',
	XP4_FD: 'Markaz Monolith',
	XP4_Rubble: 'Talah Market',
	XP5_001: 'Operation Riverside',
	XP5_002: 'Nebandan Flats',
	XP5_003: 'Kiasar Railroad',
	XP5_004: 'Sabalan Pipeline'
};
