import React, { useEffect, useState } from "react";

import {
    Button,
    Col,
    FlexboxGrid,
    IconButton,
    InputNumber,
    List,
    Panel,
    Row,
    SelectPicker,
    Notification,
    toaster
} from "rsuite";
import CloseIcon from '@rsuite/icons/Close';
import PlayOutlineIcon from '@rsuite/icons/PlayOutline';

import {
    GamemodeNames,
    LevelNames,
    sendToLua
} from "../helpers";
import {
    ModelGamemode,
    ModelMapListItem,
    ModelMapWithGamemodesItem
} from "../models/Models";

import "./MapList.scss";

const styleStart = {
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

const mapIsAlreadyOnListMessage = (
    <Notification type="error" header="Error" closable>
        Map and gamemode is already on the list!
    </Notification>
);

interface Props {
    availableMapsAndGamemodes: ModelMapWithGamemodesItem[];
    currentMapList: ModelMapListItem[];
    setCurrentMapList: React.Dispatch<React.SetStateAction<ModelMapListItem[]>>;
    mapListHasChanged: number;
    setMapListHasChanged: () => void;
    closeDrawer: () => void;
}

const MapList: React.FC<Props> = ({
    availableMapsAndGamemodes,
    currentMapList,
    setCurrentMapList,
    mapListHasChanged,
    setMapListHasChanged,
    closeDrawer,
}) => {
    const [gamemodes, setGamemodes] = useState<ModelGamemode[]>([]);
    const [selectedMap, setSelectedMap] = useState<string|null>(null);
    const [selectedGamemode, setSelectedGamemode] = useState<string|null>(null);
    const [rounds, setRounds] = useState<number>(1);

    const handleSortEnd = ({ oldIndex, newIndex }: any) => {
        setCurrentMapList((prevData: ModelMapListItem[]) => {
            const moveData = prevData.splice(oldIndex, 1);
            const newData = [ ...prevData ];
            newData.splice(newIndex, 0, moveData[0]);
            return newData;
        });
        setMapListHasChanged();
    };

    useEffect(() => {
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
    }, [selectedMap]);
    
    return (
        <>
            <Row>
                <Col md={8}>
                    <SelectPicker
                        data={availableMapsAndGamemodes}
                        block
                        placeholder="Map"
                        onChange={(value: string) => setSelectedMap(value)}
                        value={selectedMap}
                        groupBy="type"
                    />
                </Col>
                <Col md={8}>
                    <SelectPicker
                        data={gamemodes}
                        block
                        placeholder="Gamemode"
                        disabled={selectedMap === null}
                        onChange={(value: string) => setSelectedGamemode(value)}
                        value={selectedGamemode}
                    />
                </Col>
                <Col md={4}>
                    <InputNumber
                        min={1}
                        max={100}
                        defaultValue={1}
                        value={rounds}
                        onChange={(value: any) => setRounds(parseInt(value))}
                        disabled={selectedGamemode === null}
                    />
                </Col>
                <Col md={4}>
                    <Button
                        block
                        appearance="primary"
                        disabled={selectedMap === null || selectedGamemode === null}
                        onClick={() => {
                            if (currentMapList.some(e => e.map === selectedMap && e.gameMode === selectedGamemode)) {
                                toaster.push(mapIsAlreadyOnListMessage, { placement: "topEnd" })
                            } else {
                                setSelectedMap(null);
                                setSelectedGamemode(null);
                                setCurrentMapList((prevData: ModelMapListItem[]) => ([
                                    ...prevData,
                                    {
                                        map: selectedMap,
                                        gameMode: selectedGamemode,
                                        rounds: rounds.toString(),
                                    }
                                ]));
                                setMapListHasChanged();
                            }
                        }}
                    >
                        Add
                    </Button>
                </Col>
            </Row>
            <Row style={{ marginTop: 10, marginBottom: 25 }}>
                <Col md={24}>
                    <Panel bordered bodyFill>
                        <List bordered sortable onSort={handleSortEnd}>
                            {currentMapList.map(({ map, gameMode, rounds }: ModelMapListItem, index: number) => (
                                <List.Item key={index} index={index}>
                                    <FlexboxGrid>
                                        <FlexboxGrid.Item colspan={2} style={styleStart}>
                                            <h5>{rounds}</h5>
                                        </FlexboxGrid.Item>
                                        <FlexboxGrid.Item colspan={14} style={styleStart}>
                                            <h4>{LevelNames[map]}</h4>
                                            <p>{GamemodeNames[gameMode]}</p>
                                        </FlexboxGrid.Item>
                                        <FlexboxGrid.Item colspan={8} style={styleEnd}>
                                            <IconButton
                                                icon={<PlayOutlineIcon/>}
                                                size="xs"
                                                color="blue"
                                                appearance="ghost"
                                                style={{ marginRight: 8 }}
                                                onClick={() => {
                                                    sendToLua("WebUI:UpdateValues", JSON.stringify([
                                                        [
                                                            "mapList.setNextMapIndex",
                                                            index.toString()
                                                        ],
                                                        [
                                                            "mapList.runNextRound",
                                                            ""
                                                        ],
                                                    ]));
                                                    closeDrawer();
                                                }}
                                            />
                                            <IconButton
                                                icon={<CloseIcon/>}
                                                size="xs"
                                                color="red"
                                                appearance="ghost"
                                                onClick={() => {
                                                    setCurrentMapList((prevState: ModelMapListItem[]) => (
                                                        [
                                                            ...prevState.slice(0, index),
                                                            ...prevState.slice(index + 1)
                                                        ]
                                                    ));
                                                    setMapListHasChanged();
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
        </>
    );
}

export default MapList;
