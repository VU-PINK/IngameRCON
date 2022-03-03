import React, { useEffect, useState } from "react";

import { Button, Col, CustomProvider, Drawer, Form, InputNumber, List, Nav, Panel, Row, SelectPicker } from "rsuite";

import GeneralTab from "./tabs/GeneralTab";
import VuTab from "./tabs/VuTab";
import { GamemodeNames, LevelNames, sendToLua, ToggleExtended } from "./helpers";
import MapList from "./components/MapList";

import "./App.css";
import "./App.scss";

const initFormValue = {
    "vu.ColorCorrectionEnabled": true,
    "vu.ServerBanner": "https://i.imgur.com/jdUmPVA.jpg",
};

const App: React.FC = () => {
    const [open, setOpen] = useState(false);
    const [activeTab, setActiveTab] = useState<string|undefined>(undefined);
    const [formValue, setFormValue] = useState<any>(initFormValue);
    const [tabs, setTabs] = useState<any>([]);
    const [maps, setMaps] = useState<any[]>([]);

    const [vuMapList, setVuMapList] = useState([]);
    const [vuMapListHasChanged, setVuMapListHasChanged] = useState<number>(0);

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

    const getCurrentTab = () => {
        return tabs.filter((tab: any) => tab.name === activeTab)[0];
    }

    const handleSave = () => {
        let temp: any = [];
        for (const [key, value] of Object.entries(formValue)) {
            temp.push([
                key,
                value??""
            ]);
        }
        sendToLua("WebUI:UpdateValues", JSON.stringify(temp));
        // setOpen(false);
    }

    window.OnSyncValues = (values: string) => {
        let _tabs: any = [];
        let _allItems: any = {};
        let _tempCurrentMaps: any = [];
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
                } else {
                    _items.push({
                        name: item[0],
                        description: item[1].description??"",
                        canGet: item[1].canGet,
                        inputType: item[1].inputType??"none",
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
        setVuMapList(_tempCurrentMaps);
    }

    window.OnSetMenu = (open: boolean) => {
        setOpen(open);
    }

    window.OnToggleMenu = () => {
        setOpen(prevState => !prevState);
    }

    window.OnSyncMaps = (values: any) => {
        let tempMaps: any = [];
        Object.entries(values).forEach((element: any) => {
            tempMaps.push({
                label: LevelNames[element[0]] + " (" + element[0] + ")",
                value: element[0],
                gameModes: element[1][1],
                type: element[1][0],
            });
        });
        setMaps(tempMaps);
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
        if (vuMapList.length > 0) {
            let _sendData: any = [];
            vuMapList.forEach((element: any) => {
                _sendData.push([
                    element.map,
                    element.gameMode,
                    element.rounds,
                ]);
            });
            sendToLua("WebUI:UpdateMaplist", JSON.stringify(_sendData));
        }
    }, [vuMapListHasChanged]);

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
                <Button onClick={() => setFormValue(initFormValue)}>Reset</Button>
                {/*JSON.stringify(formValue)*/}
            </div>
            
            <Drawer 
                backdrop={false}
                open={open}
                onClose={() => setOpen(false)}
            >
                <Drawer.Header>
                    <Drawer.Title>InGame RCON</Drawer.Title>
                    <Drawer.Actions>
                        <Button 
                            onClick={handleSave}
                            appearance="primary"
                            size="sm"
                        >
                            Apply changes
                        </Button>
                    </Drawer.Actions>
                </Drawer.Header>
                <div className="drawer-nav">
                    <Nav 
                        appearance="subtle"
                        activeKey={activeTab}
                        onSelect={setActiveTab}
                        justified
                    >
                        {tabs.map((tab: any, index: number) => (
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
                        onChange={formValue => setFormValue(formValue)}
                    >
                        {getCurrentTab() !== undefined &&
                            <>
                                {activeTab === "mapList" &&
                                    <MapList
                                        maps={maps}
                                        currentMapList={vuMapList}
                                        setCurrentMapList={setVuMapList}
                                        vuMapListHasChanged={vuMapListHasChanged}
                                        setVuMapListHasChanged={() => {
                                            setVuMapListHasChanged((prevState: number) => {
                                                return ++prevState;
                                            });
                                        }}
                                    />
                                }

                                {getCurrentTab()
                                .items
                                .filter((item: any) => item.inputType !== "none")
                                .sort((a: any, b: any) => String(a.inputType)
                                .localeCompare(b.inputType))
                                .map((item: any, index: number) => 
                                (
                                    <Form.Group controlId={getCurrentTab().name + "." + item.name} key={index}>
                                        <Form.ControlLabel>{getCurrentTab().name + "." + item.name}</Form.ControlLabel>
                                        {getInputType(
                                            getCurrentTab(),
                                            item
                                        )}
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
        OnSyncValues: (values: string) => void;
        OnSyncMaps: (values: string) => void;
        OnSetMenu: (open: boolean) => void;
        OnToggleMenu: () => void;
    }
}
