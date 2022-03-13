import React from "react";

import { Button, Dropdown, IconButton, Popover, Table, Tag, Whisper } from 'rsuite';
import MoreIcon from '@rsuite/icons/More';

import {
    sendToLua
} from "../helpers";

import "./PlayerList.scss";

const insulter = require('insult');

interface Props {
    availablePlayers: any[];
    setBanPreferred: (guid: string) => void;
}

const PlayerList: React.FC<Props> = ({
    availablePlayers,
    setBanPreferred,
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
                        return (
                            <Whisper 
                                placement="autoVerticalStart"
                                trigger="click"
                                speaker={
                                    <Popover full>
                                        <Dropdown.Menu onSelect={(eventKey: any) => {
                                            switch (eventKey) {
                                                case 1:
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
                                                    break;
                                                case 2:
                                                    sendToLua("WebUI:UpdateValues", JSON.stringify([
                                                        [
                                                            "admin.killPlayer",
                                                            rowData.name
                                                        ]
                                                    ]));
                                                    break;
                                                case 3:
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
                                                    break;
                                                case 4:
                                                    setBanPreferred(rowData.guid);
                                                    break;
                                            }
                                        }}>
                                            <Dropdown.Item eventKey={1}>
                                                Move to {rowData.teamId === "1" ? "RU" : "US"}
                                            </Dropdown.Item>
                                            <Dropdown.Item eventKey={2}>
                                                Kill
                                            </Dropdown.Item>
                                            <Dropdown.Item divider />
                                            <Dropdown.Item eventKey={3}>
                                                Kick
                                            </Dropdown.Item>
                                            <Dropdown.Item eventKey={4}>
                                                Ban
                                            </Dropdown.Item>
                                        </Dropdown.Menu>
                                    </Popover>
                                }
                            >
                                <IconButton size="xs" appearance="subtle" icon={<MoreIcon />} />
                            </Whisper>
                        );
                    }}
                </Table.Cell>
            </Table.Column>
        </Table>
    );
}

export default PlayerList;
