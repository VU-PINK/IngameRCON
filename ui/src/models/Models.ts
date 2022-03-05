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

export interface ModelTab {
    name: string,
    items: ModelItem[],
};
