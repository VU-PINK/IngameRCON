import React, { useState } from "react";

import {
    Button,
    Col,
    FlexboxGrid,
    IconButton,
    List,
    Panel,
    Row,
    SelectPicker,
    Notification,
    toaster,
    Input
} from "rsuite";
import CloseIcon from '@rsuite/icons/Close';

import {
    sendToLua
} from "../helpers";
import {
    ModelBanItem,
    ModelPlayerItem
} from "../models/Models";

import "./BanList.scss";

const styleMiddle = {
    display: 'flex',
    justifyContent: 'flex-start',
    alignItems: 'flex-start',
    flexFlow: 'column',
};

const styleEnd = {
    display: 'flex',
    justifyContent: 'flex-end',
    alignItems: 'flex-end',
};

const playerIsAlreadyOnListMessage = (
    <Notification type="error" header="Error" closable>
       Player is already on the list!
    </Notification>
);

interface Props {
    availablePlayers: ModelPlayerItem[];
    currentBanList: ModelBanItem[];
    setBanListHasChanged: () => void;
    selectedPlayerToBan: string|null;
    setSelectedPlayerToBan: React.Dispatch<React.SetStateAction<string>>;
}

const BanList: React.FC<Props> = ({
    availablePlayers,
    currentBanList,
    setBanListHasChanged,
    selectedPlayerToBan,
    setSelectedPlayerToBan
}) => {
    const [reason, setReason] = useState<string>("");
    const [type, setType] = useState<string>("perm");

    return (
        <div className="ban-list">
            <Row>
                <Col md={6}>
                    <SelectPicker
                        data={availablePlayers}
                        block
                        placeholder="Player"
                        onChange={(value: string) => setSelectedPlayerToBan(value)}
                        value={selectedPlayerToBan}
                        valueKey="guid"
                        labelKey="name"
                    />
                </Col>
                <Col md={4}>
                    <SelectPicker 
                        data={[
                            {
                                label: "Permanent",
                                value: "perm",
                            },
                            {
                                label: "5 minutes",
                                value: "300",
                            },
                            {
                                label: "15 minutes",
                                value: "900",
                            },
                            {
                                label: "30 minutes",
                                value: "1800",
                            },
                            {
                                label: "1 hour",
                                value: "3600",
                            },
                            {
                                label: "12 hours",
                                value: "43200",
                            },
                            {
                                label: "1 day",
                                value: "86400",
                            },
                            {
                                label: "1 week",
                                value: "604800",
                            },
                            {
                                label: "1 month",
                                value: "2629740",
                            },
                            {
                                label: "1 year",
                                value: "31556880",
                            },
                        ]}
                        searchable={false}
                        cleanable={false}
                        value={type}
                        onChange={(val: string) => {
                            setType(val);
                        }}
                        block
                    />
                </Col>
                <Col md={10}>
                    <Input
                        placeholder="Reason"
                        onChange={(value: string) => setReason(value)}
                        value={reason}
                    />
                </Col>
                <Col md={4}>
                    <Button
                        block
                        appearance="primary"
                        color="red"
                        disabled={selectedPlayerToBan === null}
                        onClick={() => {
                            if (currentBanList.some(e => e.id === selectedPlayerToBan)) {
                                toaster.push(playerIsAlreadyOnListMessage, { placement: "topEnd" })
                            } else {
                                if (type === "perm") {
                                    sendToLua("WebUI:UpdateValues", JSON.stringify([
                                        [
                                            "banList.add",
                                            [
                                                "guid",
                                                selectedPlayerToBan,
                                                "perm",
                                                reason
                                            ]
                                        ],
                                        [
                                            "banList.save",
                                            ""
                                        ],
                                    ]));
                                } else {
                                    sendToLua("WebUI:UpdateValues", JSON.stringify([
                                        [
                                            "banList.add",
                                            [
                                                "guid",
                                                selectedPlayerToBan,
                                                "seconds",
                                                type,
                                                reason
                                            ]
                                        ],
                                        [
                                            "banList.save",
                                            ""
                                        ],
                                    ]));
                                }
                                setSelectedPlayerToBan(null);
                                setReason("");
                                setType("perm");
                                sendToLua("WebUI:PullRequest");
                            }
                        }}
                    >
                        BAN
                    </Button>
                </Col>
            </Row>
            <Row style={{ marginTop: 10, marginBottom: 25 }}>
                <Col md={24}>
                    <Panel bordered bodyFill>
                        <List bordered>
                            {currentBanList.map(({ id, type, timeout, reason }: ModelBanItem, index: number) => (
                                <List.Item key={index} index={index}>
                                    <FlexboxGrid>
                                        <FlexboxGrid.Item colspan={16} style={styleMiddle}>
                                            <h4>{id}</h4>
                                            <p>{reason??""}</p>
                                        </FlexboxGrid.Item>
                                        <FlexboxGrid.Item colspan={8} style={styleEnd}>
                                            <IconButton
                                                icon={<CloseIcon/>}
                                                size="xs"
                                                color="red"
                                                appearance="ghost"
                                                onClick={() => {
                                                    sendToLua("WebUI:UpdateValues", JSON.stringify([
                                                        [
                                                            "banList.remove",
                                                            [
                                                                "guid",
                                                                id
                                                            ]
                                                        ],
                                                        [
                                                            "banList.save",
                                                            ""
                                                        ],
                                                    ]));
                                                    sendToLua("WebUI:PullRequest");
                                                }}
                                            />
                                        </FlexboxGrid.Item>
                                    </FlexboxGrid>
                                </List.Item>
                            ))}
                        </List>
                    </Panel>
                </Col>
            </Row>
        </div>
    );
}

export default BanList;
