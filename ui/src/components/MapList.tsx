import React, { useEffect, useState } from "react";

import {
    Button,
    Col,
    FlexboxGrid,
    Form,
    IconButton,
    Input,
    InputNumber,
    List,
    Panel,
    Row,
    SelectPicker,
    Toggle
} from "rsuite";
import { GamemodeNames, LevelNames, sendToLua } from "../helpers";
import CloseIcon from '@rsuite/icons/Close';

import "./MapList.scss";

const styleEnd = {
    display: 'flex',
    justifyContent: 'flex-end',
    alignItems: 'flex-end',
};

const styleStart = {
    display: 'flex',
    justifyContent: 'flex-start',
    alignItems: 'flex-start',
    flexFlow: 'column',
};

interface Props {
    maps: any;
    currentMapList: any;
    setCurrentMapList: any;
    vuMapListHasChanged: any;
    setVuMapListHasChanged: any;
}

const MapList: React.FC<Props> = ({
    maps,
    currentMapList,
    setCurrentMapList,
    vuMapListHasChanged,
    setVuMapListHasChanged,
}) => {
    const [gamemodes, setGamemodes] = useState<any[]>([]);
    const [selectedMap, setSelectedMap] = useState<any>(null);
    const [selectedGamemode, setSelectedGamemode] = useState<any>(null);
    const [rounds, setRounds] = useState<number>(1);

    const handleSortEnd = ({ oldIndex, newIndex }: any) => {
        console.log("handleSortEnd");
        setCurrentMapList((prevData: any) => {
            const moveData = prevData.splice(oldIndex, 1);
            const newData = [ ...prevData ];
            newData.splice(newIndex, 0, moveData[0]);
            return newData;
        });
        setVuMapListHasChanged();
    };

    useEffect(() => {
        if (selectedMap !== null) {
            setSelectedGamemode(null);
            const foundMap = maps.find((map: any) => map.value === selectedMap);
            if (foundMap) {
                let tempGamemodes: any = [];
                foundMap.gameModes.forEach((element: any) => {
                    tempGamemodes.push({
                        label: GamemodeNames[element] + " (" + element + ")",
                        value: element,
                    });
                });
                setGamemodes(tempGamemodes);
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
                        data={maps}
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
                            setSelectedMap(null);
                            setSelectedGamemode(null);
                            // TODO: Check if the map and the gamemode is there on the list already
                            setCurrentMapList((prevData: any) => ([
                                ...prevData,
                                {
                                    map: selectedMap,
                                    gameMode: selectedGamemode,
                                    rounds: rounds,
                                }
                            ]));
                            setVuMapListHasChanged();
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
                            {currentMapList.map(({ map, gameMode, rounds }: any, index: number) => (
                                <List.Item key={index} index={index}>
                                    <FlexboxGrid>
                                        <FlexboxGrid.Item colspan={12} style={styleStart}>
                                            <h4>{LevelNames[map]}</h4>
                                            <p>{GamemodeNames[gameMode]}</p>
                                            {rounds}
                                        </FlexboxGrid.Item>
                                        <FlexboxGrid.Item colspan={12} style={styleEnd}>
                                            <IconButton icon={<CloseIcon/>} size="xs" color="blue" appearance="ghost" />
                                            <IconButton icon={<CloseIcon/>} size="xs" color="red" appearance="ghost" />
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
