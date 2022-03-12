import React, { useEffect, useState } from "react";

import {
    Button,
    CustomProvider,
    Drawer,
    Form,
    IconButton,
    InputNumber,
    Nav,
} from "rsuite";
import CheckIcon from '@rsuite/icons/Check';

import {
    LevelNames,
    sendToLua,
    ToggleExtended
} from "./helpers";
import MapList from "./components/MapList";
import {
    ModelMapListItem,
    ModelTab,
    ModelMapWithGamemodesItem,
    ModelBanItem,
    ModelPlayerItem
} from "./models/Models";
import BanList from "./components/BanList";
import PlayerList from "./components/PlayerList";

import "./App.css";
import "./App.scss";

const App: React.FC = () => {
    const [open, setOpen] = useState<boolean>(false);
    const [activeTab, setActiveTab] = useState<string|undefined>(undefined);
    const [formValue, setFormValue] = useState<any>({});
    const [tabs, setTabs] = useState<ModelTab[]>([]);

    const [availableMapsAndGamemodes, setAvailableMapsAndGamemodes] = useState<ModelMapWithGamemodesItem[]>([]);
    const [currentMapList, setCurrentMapList] = useState<ModelMapListItem[]>([]);
    const [mapListHasChanged, setMapListHasChanged] = useState<number>(0);

    const [availablePlayers, setAvailablePlayers] = useState<ModelPlayerItem[]>([]);
    const [currentBanList, setCurrentBanList] = useState<ModelBanItem[]>([]);
    const [banListHasChanged, setBanListHasChanged] = useState<number>(0);

    /*
    * Debug
    */
    let debugMode: boolean = false;
    if (!navigator.userAgent.includes("VeniceUnleashed")) {
        if (window.location.ancestorOrigins === undefined || window.location.ancestorOrigins[0] !== "webui://main") {
            debugMode = true;
        }
    }

    const getInputType = (tab: any, item: any) => {
        switch (item.inputType) {
            case "button":
                return (
                    <Button 
                        block
                        appearance="primary"
                        size="sm"
                        onClick={() => {
                            sendToLua("WebUI:UpdateValues", JSON.stringify([[
                                tab.name + "." + item.name,
                                ""
                            ]]));
                        }}
                    >
                        {tab.name}.{item.name??""}
                    </Button>
                );
            case "switch":
                return (
                    <Form.Control 
                        name={tab.name + "." + item.name}
                        accepter={ToggleExtended}
                        onChange={(value: any) => {
                            sendToLua("WebUI:UpdateValues", JSON.stringify([[
                                tab.name + "." + item.name,
                                value.toString()
                            ]]));
                        }}
                    />
                );
            case "float":
            case "integer":
                return (
                    <Form.Control 
                        name={tab.name + "." + item.name}
                        accepter={InputNumber}
                        style={{ width: "100%" }}
                    />
                );
            case "alphanumeric":
                return (
                    <Form.Control 
                        name={tab.name + "." + item.name}
                    />
                );
            case "percentageModifier":
                return (
                    <Form.Control 
                        name={tab.name + "." + item.name}
                        accepter={InputNumber}
                        style={{ width: "100%" }}
                        postfix="%"
                    />
                );
            case "none":
            default:
                return <></>;
        }
    }

    const hasSaveButton = (tab: any, item: any) => {
        switch (item.inputType) {
            case "float":
            case "integer":
                return true;
            case "alphanumeric":
                return true;
            case "percentageModifier":
                return true;
            case "switch":
            case "button":
            case "none":
            case "hidden":
            default:
                return false;
        }
    }

    const getCurrentTab = () => {
        return tabs.filter((tab: any) => tab.name === activeTab)[0];
    }

    const handleSave = () => {
        //let temp: Array<Array<string>> = [];
        let temp: any = [];
        for (const [key, value] of Object.entries(formValue)) {
            temp.push([
                key,
                value??""
            ]);
        }
        sendToLua("WebUI:UpdateValues", JSON.stringify(temp));

        // If we want to close the RCON menu when you save then uncomment this line.
        // setOpen(false);
    }

    window.OnSyncValues = (values: any) => {
        values = JSON.parse(values);
        let _tabs: ModelTab[] = [];
        let _allItems: any = {};
        let _tempCurrentMaps: ModelMapListItem[] = [];
        let _tempCurrentBans: ModelBanItem[] = [];
        let _tempAvailablePlayers: ModelPlayerItem[] = [];

        Object.entries(values).forEach((value: any, _: any) => {
            let _items: any = [];
            Object.entries(value[1]).forEach((item: any, _: any) => {
                if (value[0] === "mapList" && item[0] === "list") {
                    let _mapTemp = item[1].currentData.splice(3);
                    for (let index = 0; index < _mapTemp.length; index++) {
                        _tempCurrentMaps.push({
                            map: _mapTemp[index],
                            gameMode: _mapTemp[index + 1],
                            rounds: _mapTemp[index + 2],
                        });
                        index = index + 2;
                    }
                } else if (value[0] === "banList" && item[0] === "list") {
                    let _banTemp = item[1].currentData.splice(1);
                    for (let index = 0; index < _banTemp.length; index++) {
                        _tempCurrentBans.push({
                            type: _banTemp[index],
                            id: _banTemp[index + 1],
                            timeout: _banTemp[index + 2],
                            reason: _banTemp[index + 5] ?? "",
                        });
                        index = index + 5;
                    }
                } else if (value[0] === "admin" && item[0] === "listPlayers") {
                    let _tempPlayers = item[1].currentData.splice(1);
                    let index = 14;
                    for (index; index < _tempPlayers.length; index++) {
                        _tempAvailablePlayers.push({
                            name: _tempPlayers[index],
                            guid: _tempPlayers[index + 1],
                            teamId: _tempPlayers[index + 2],
                            squadId: _tempPlayers[index + 3],
                            kills: _tempPlayers[index + 4],
                            deaths: _tempPlayers[index + 5],
                            score: _tempPlayers[index + 6],
                            rank: _tempPlayers[index + 7],
                            ping: _tempPlayers[index + 8],
                            spectator: _tempPlayers[index + 9],
                            playerGuid: _tempPlayers[index + 10],
                            ip: _tempPlayers[index + 11],
                        });
                        index = index + 11;
                    }
                } else {
                    _items.push({
                        name: item[0],
                        description: item[1].description??"",
                        canGet: item[1].canGet,
                        inputType: item[1].inputType??"none",
                        title: item[1].title??"",
                    });
    
                    if (item[1].canGet === true) {
                        let val:any = item[1].currentData[1];
                        if (item[1].inputType === "switch") {
                            val = item[1].currentData[1] === "true" ? true : false;
                        }
                        _allItems[value[0] + "." + item[0]] = val;
                    }
                }
            });
            _tabs.push({
                name: value[0],
                items: _items,
            });
        });

        setTabs(_tabs);
        if (activeTab === undefined) {
            setActiveTab(Object.entries(values)[0][0]);
        }

        setFormValue(_allItems);
        setCurrentMapList(_tempCurrentMaps);
        setCurrentBanList(_tempCurrentBans);
        setAvailablePlayers(_tempAvailablePlayers);
    }

    window.OnSetMenu = (open: boolean) => {
        setOpen(open);
    }

    window.OnToggleMenu = () => {
        setOpen(prevState => !prevState);
    }

    window.OnSyncMaps = (values: any) => {
        let _tempMaps: ModelMapWithGamemodesItem[] = [];
        Object.entries(values).forEach((element: any) => {
            _tempMaps.push({
                label: LevelNames[element[0]] + " (" + element[0] + ")",
                value: element[0],
                gameModes: element[1][1],
                type: element[1][0],
            });
        });
        setAvailableMapsAndGamemodes(_tempMaps);
    }

    useEffect(() => {
        if (open) {
            if (navigator.userAgent.includes("VeniceUnleashed")) {
                WebUI.Call("EnableKeyboard");
                WebUI.Call("EnableMouse");
            }
            sendToLua("WebUI:PullRequest");
        } else {
            if (navigator.userAgent.includes("VeniceUnleashed")) {
                WebUI.Call("ResetKeyboard");
                WebUI.Call("ResetMouse");
            }
        }
    }, [open]);
    
    useEffect(() => {
        if (currentMapList.length > 0) {
            let _sendData: any = [];
            currentMapList.forEach((element: any) => {
                _sendData.push([
                    element.map,
                    element.gameMode,
                    element.rounds,
                ]);
            });
            sendToLua("WebUI:UpdateMaplist", JSON.stringify(_sendData));
        }
    }, [mapListHasChanged]);

    return (
        <CustomProvider theme="dark">
            {debugMode &&
                <style dangerouslySetInnerHTML={{
                    __html: `
                    body {
                        // background: #333;
                    }

                    #debugChat,
                    #debug {
                        display: flex !important;
                        opacity: 0.5;
                    }
                `}} />
            }
            <div id="debug">
                <Button onClick={() => setOpen(true)}>Open</Button>
                <Button onClick={() => setFormValue({})}>Reset</Button>
                {/*JSON.stringify(formValue)*/}
            </div>
            
            <Drawer 
                backdrop={false}
                open={open}
                onClose={() => setOpen(false)}
                placement="bottom"
                full
            >
                <Drawer.Header>
                    <Drawer.Title>InGame RCON</Drawer.Title>
                    {/*<Drawer.Actions>
                        <Button 
                            onClick={handleSave}
                            appearance="primary"
                            size="sm"
                        >
                            Apply changes
                        </Button>
                    </Drawer.Actions>*/}
                </Drawer.Header>
                <div className="drawer-nav">
                    <Nav 
                        appearance="subtle"
                        activeKey={activeTab}
                        onSelect={setActiveTab}
                        justified
                    >
                        {tabs
                        .sort((a: any, b: any) => String(a.name)
                        .localeCompare(b.name))
                        .map((tab: any, index: number) => (
                            <Nav.Item eventKey={tab.name} key={index}>
                                {tab.name}
                            </Nav.Item>
                        ))}
                    </Nav>
                </div>
                <Drawer.Body>
                    <Form
                        fluid
                        formValue={formValue}
                        onChange={(formValue: any, event: any) => {
                            setFormValue(formValue);
                        }}
                    >
                        {getCurrentTab() !== undefined &&
                            <>
                                {activeTab === "mapList" &&
                                    <MapList
                                        availableMapsAndGamemodes={availableMapsAndGamemodes}
                                        currentMapList={currentMapList}
                                        setCurrentMapList={setCurrentMapList}
                                        mapListHasChanged={mapListHasChanged}
                                        setMapListHasChanged={() => {
                                            setMapListHasChanged((prevState: number) => {
                                                return ++prevState;
                                            });
                                        }}
                                        closeDrawer={() => {
                                            setOpen(false);
                                        }}
                                    />
                                }

                                {activeTab === "banList" &&
                                    <BanList
                                        availablePlayers={availablePlayers}
                                        currentBanList={currentBanList}
                                        setCurrentBanList={setCurrentBanList}
                                        banListHasChanged={banListHasChanged}
                                        setBanListHasChanged={() => {
                                            setBanListHasChanged((prevState: number) => {
                                                return ++prevState;
                                            });
                                        }}
                                    />
                                }

                                {activeTab === "admin" &&
                                    <PlayerList
                                        availablePlayers={availablePlayers}
                                    />
                                }

                                {getCurrentTab()
                                .items
                                .filter((item: any) => item.inputType !== "hidden")
                                .sort((a: any, b: any) => String(a.inputType)
                                .localeCompare(b.inputType))
                                .map((item: any, index: number) => 
                                (
                                    <Form.Group controlId={getCurrentTab().name + "." + item.name} key={index}>
                                        <Form.ControlLabel>{item.title}</Form.ControlLabel>
                                        <div className="inline-save">
                                            {getInputType(
                                                getCurrentTab(),
                                                item
                                            )}
                                            {hasSaveButton(getCurrentTab(), item) &&
                                                <IconButton
                                                    icon={<CheckIcon />}
                                                    appearance="primary"
                                                    size="md"
                                                    onClick={() => {
                                                        sendToLua("WebUI:UpdateValues", JSON.stringify([[
                                                            getCurrentTab().name + "." + item.name,
                                                            formValue[getCurrentTab().name + "." + item.name]
                                                        ]]));
                                                    }}
                                                />
                                            }
                                        </div>
                                        <Form.HelpText>
                                            {item.description}
                                        </Form.HelpText>
                                    </Form.Group>
                                ))}
                            </>
                        }
                    </Form>
                </Drawer.Body>
            </Drawer>
        </CustomProvider>
    );
};

export default App;

declare global {
    interface Window {
        OnSyncValues: (values: any) => void;
        OnSyncMaps: (values: any) => void;
        OnSetMenu: (open: boolean) => void;
        OnToggleMenu: () => void;
    }
}
