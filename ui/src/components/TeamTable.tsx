import React from "react";

import { Button, ButtonToolbar, Table, Tag } from 'rsuite';

import {
    sendToLua
} from "../helpers";

import "./PlayerList.scss";

const insulter = require('insult');

interface Props {
    availablePlayers: any[];
}

const PlayerList: React.FC<Props> = ({
    availablePlayers,
}) => {
    return (
        <Table
            data={availablePlayers}
            autoHeight
            className="team-table"
        >
            <Table.Column minWidth={150} flexGrow={1}>
                <Table.HeaderCell>Name</Table.HeaderCell>
                <Table.Cell dataKey="name" />
            </Table.Column>
            <Table.Column minWidth={150} flexGrow={1}>
                <Table.HeaderCell>Team</Table.HeaderCell>
                <Table.Cell>
                    {(rowData: any) => {
                        return (
                            <>
                                {rowData.teamId === "1" ?
                                    <Tag color="blue" size="sm">US</Tag>
                                :
                                    <Tag color="red" size="sm">RU</Tag>
                                }
                            </>
                        );
                    }}
                </Table.Cell>
            </Table.Column>
            <Table.Column minWidth={150} flexGrow={1}>
                <Table.HeaderCell>Squad</Table.HeaderCell>
                <Table.Cell dataKey="squadId" />
            </Table.Column>
            <Table.Column minWidth={150} flexGrow={1}>
                <Table.HeaderCell>Score</Table.HeaderCell>
                <Table.Cell dataKey="score" />
            </Table.Column>
            <Table.Column minWidth={150} flexGrow={1}>
                <Table.HeaderCell>Kills</Table.HeaderCell>
                <Table.Cell dataKey="kills" />
            </Table.Column>
            <Table.Column minWidth={150} flexGrow={1}>
                <Table.HeaderCell>Deaths</Table.HeaderCell>
                <Table.Cell dataKey="deaths" />
            </Table.Column>
            <Table.Column flexGrow={1}>
                <Table.HeaderCell>Actions</Table.HeaderCell>
                <Table.Cell>
                    {(rowData: any) => {
                        function handleKill() {
                            sendToLua("WebUI:UpdateValues", JSON.stringify([
                                [
                                    "admin.killPlayer",
                                    rowData.name
                                ]
                            ]));
                        }
                        function handleKick() {
                            sendToLua("WebUI:UpdateValues", JSON.stringify([
                                [
                                    "admin.kickPlayer",
                                    [
                                        rowData.name,
                                        insulter.Insult()
                                    ]
                                ]
                            ]));
                            sendToLua("WebUI:PullRequest");
                        }
                        function handleBan() {
                            sendToLua("WebUI:UpdateValues", JSON.stringify([
                                [
                                    "banList.add",
                                    [
                                        "guid",
                                        rowData.guid,
                                        "perm"
                                    ]
                                ],
                                [
                                    "banList.save",
                                    ""
                                ],
                            ]));
                            sendToLua("WebUI:PullRequest");
                        }
                        function handleSwitch() {
                            sendToLua("WebUI:UpdateValues", JSON.stringify([
                                [
                                    "admin.movePlayer",
                                    [
                                        rowData.name,
                                        rowData.teamId === "1" ? "2" : "1",
                                        "0",
                                        "true"
                                    ]
                                ],
                            ]));
                            sendToLua("WebUI:PullRequest");
                        }
                        return (
                            <ButtonToolbar>
                                <Button onClick={handleSwitch} appearance="primary" size="xs">Switch</Button>
                                <Button onClick={handleKill} appearance="primary" size="xs">Kill</Button>
                                <Button onClick={handleKick} appearance="primary" color="yellow" size="xs">Kick</Button>
                                <Button onClick={handleBan} appearance="primary" color="red" size="xs">Ban</Button>
                            </ButtonToolbar>
                        );
                    }}
                </Table.Cell>
            </Table.Column>
        </Table>
    );
}

export default PlayerList;
