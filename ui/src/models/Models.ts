export interface ModelItem {
    canGet: boolean;
    description: string;
    inputType: string;
    name: string;
};

export interface ModelMapWithGamemodesItem {
    label: string;
    value: string;
    gameModes: string[];
    type: string;
};

export interface ModelGamemode {
    label: string;
    value: string;
};

export interface ModelMapListItem {
    gameMode: string;
    map: string;
    rounds: string;
};

export interface ModelBanItem {
    type: string;
    id: string;
    timeout: string;
    reason: string;
};

export interface ModelPlayerItem {
    /*label: string;
    value: string;*/
    name: string;
    guid: string;
    teamId: string;
    squadId: string;
    kills: string;
    deaths: string;
    score: string;
    rank: string;
    ping: string;
    spectator: string;
    playerGuid: string;
    ip: string;
};

export interface ModelTab {
    name: string,
    items: ModelItem[],
};
