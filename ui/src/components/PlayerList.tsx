import React, { useState } from "react";

import { Button, Col, IconButton, InputNumber, Row } from 'rsuite';
import CheckIcon from '@rsuite/icons/Check';

import TeamTable from "./TeamTable";
import {
    sendToLua
} from "../helpers";

import "./PlayerList.scss";


interface Props {
    availablePlayers: any[];
}

const PlayerList: React.FC<Props> = ({
    availablePlayers,
}) => {
    const [ruTickets, setRuTickets] = useState<string|number>(undefined);
    const [usTickets, setUsTickets] = useState<string|number>(undefined);

    return (
        <div className="player-list">
            {availablePlayers.filter((e: any) => e.teamId === "1").length > 0 &&
                <>
                    <Row>
                        <Col md={1}>
                            <h5>US</h5>
                        </Col>
                        <Col md={2}>
                            <InputNumber
                                style={{ width: "100%" }}
                                placeholder="Tickets"
                                value={usTickets}
                                onChange={(value: string|number) => {
                                    setUsTickets(value);
                                }}
                                size="sm"
                            />
                        </Col>
                        <Col md={2}>
                            <Button
                                appearance="primary"
                                size="sm"
                                onClick={() => {
                                    sendToLua("WebUI:UpdateValues", JSON.stringify([[
                                        "vu.SetTeamTicketCount",
                                        [
                                            "1",
                                            usTickets.toString()
                                        ]
                                    ]]));
                                }}
                            >
                                Save
                            </Button>
                        </Col>
                    </Row>
                    <TeamTable
                        availablePlayers={availablePlayers.filter((e: any) => e.teamId === "1")}
                    />
                </>
            }
            {availablePlayers.filter((e: any) => e.teamId === "2").length > 0 &&
                <>
                   <Row>
                        <Col md={1}>
                            <h5>RU</h5>
                        </Col>
                        <Col md={2}>
                            <InputNumber
                                style={{ width: "100%" }}
                                placeholder="Tickets"
                                value={ruTickets}
                                onChange={(value: string|number) => {
                                    setRuTickets(value);
                                }}
                                size="sm"
                            />
                        </Col>
                        <Col md={2}>
                            <Button
                                appearance="primary"
                                size="sm"
                                onClick={() => {
                                    sendToLua("WebUI:UpdateValues", JSON.stringify([[
                                        "vu.SetTeamTicketCount",
                                        [
                                            "2",
                                            ruTickets.toString()
                                        ]
                                    ]]));
                                }}
                            >
                                Save
                            </Button>
                        </Col>
                    </Row>
                    <TeamTable
                        availablePlayers={availablePlayers.filter((e: any) => e.teamId === "2")}
                    />
                </>
            }

        </div>
    );
}

export default PlayerList;
