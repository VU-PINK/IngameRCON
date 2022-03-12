import React from "react";

import { Button, ButtonToolbar, Table, Tag } from 'rsuite';

import {
    sendToLua
} from "../helpers";

import "./PlayerList.scss";
import TeamTable from "./TeamTable";

const insulter = require('insult');


interface Props {
    availablePlayers: any[];
}

const PlayerList: React.FC<Props> = ({
    availablePlayers,
}) => {
    return (
        <div className="player-list">
            {availablePlayers.filter((e: any) => e.teamId === "1").length > 0 &&
                <>
                    <h4>US</h4>
                    <TeamTable
                        availablePlayers={availablePlayers.filter((e: any) => e.teamId === "1")}
                    />
                </>
            }
            {availablePlayers.filter((e: any) => e.teamId === "2").length > 0 &&
                <>
                    <h4>RU</h4>
                    <TeamTable
                        availablePlayers={availablePlayers.filter((e: any) => e.teamId === "2")}
                    />
                </>
            }

        </div>
    );
}

export default PlayerList;
