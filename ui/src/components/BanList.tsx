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
    setCurrentBanList: React.Dispatch<React.SetStateAction<ModelBanItem[]>>;
    banListHasChanged: number;
    setBanListHasChanged: () => void;
}

const BanList: React.FC<Props> = ({
    availablePlayers,
    currentBanList,
    setCurrentBanList,
    banListHasChanged,
    setBanListHasChanged,
}) => {
    // const [gamemodes, setGamemodes] = useState<ModelGamemode[]>([]);
    const [selectedPlayer, setSelectedPlayer] = useState<string|null>(null);
    // const [selectedGamemode, setSelectedGamemode] = useState<string|null>(null);
    const [reason, setReason] = useState<string>("");

    /*const handleSortEnd = ({ oldIndex, newIndex }: any) => {
        setCurrentMapList((prevData: ModelMapListItem[]) => {
            const moveData = prevData.splice(oldIndex, 1);
            const newData = [ ...prevData ];
            newData.splice(newIndex, 0, moveData[0]);
            return newData;
        });
        setMapListHasChanged();
    };*/

    /*useEffect(() => {
        if (selectedMap !== null) {
            setSelectedGamemode(null);
            const foundMap = availableMapsAndGamemodes.find((map: any) => map.value === selectedMap);
            if (foundMap) {
                let _tempGamemodes: ModelGamemode[] = [];
                foundMap.gameModes.forEach((element: any) => {
                    _tempGamemodes.push({
                        label: GamemodeNames[element] + " (" + element + ")",
                        value: element,
                    });
                });
                setGamemodes(_tempGamemodes);
            }
        } else {
            setSelectedGamemode(null);
            setGamemodes([]);
        }
    }, [selectedMap]);*/
    
    return (
        <div className="ban-list">
            <Row>
                <Col md={8}>
                    <SelectPicker
                        data={availablePlayers}
                        block
                        placeholder="Player"
                        onChange={(value: string) => setSelectedPlayer(value)}
                        value={selectedPlayer}
                    />
                </Col>
                <Col md={8}>
                    <Input
                        placeholder="Reason"
                        onChange={(value: string) => setReason(value)}
                        value={reason}
                    />
                </Col>
                {/*<Col md={4}>
                    <InputNumber
                        min={1}
                        max={100}
                        defaultValue={1}
                        value={rounds}
                        onChange={(value: any) => setRounds(parseInt(value))}
                        disabled={selectedGamemode === null}
                    />
                </Col>*/}
                <Col md={4}>
                    <Button
                        block
                        appearance="primary"
                        color="red"
                        disabled={selectedPlayer === null}
                        onClick={() => {
                            if (currentBanList.some(e => e.id === selectedPlayer)) {
                                toaster.push(playerIsAlreadyOnListMessage, { placement: "topEnd" })
                            } else {
                                /*setSelectedMap(null);
                                setSelectedGamemode(null);
                                setCurrentMapList((prevData: ModelMapListItem[]) => ([
                                    ...prevData,
                                    {
                                        map: selectedMap,
                                        gameMode: selectedGamemode,
                                        rounds: rounds.toString(),
                                    }
                                ]));
                                setMapListHasChanged();*/
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
                                                            "banList.Remove",
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
                                                    setBanListHasChanged();
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
