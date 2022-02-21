import React, { useEffect, useState } from "react";

import { Button, CustomProvider, Drawer, Form, InputNumber, Nav } from "rsuite";

import GeneralTab from "./tabs/GeneralTab";
import VuTab from "./tabs/VuTab";
import { sendToLua, ToggleExtended } from "./helpers";

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
        Object.entries(values).forEach((value: any, _: any) => {
            let _items: any = [];
            Object.entries(value[1]).forEach((item: any, _: any) => {
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
    }

    window.OnSetMenu = (open: boolean) => {
        setOpen(open);
    }

    window.OnToggleMenu = () => {
        setOpen(prevState => !prevState);
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
                                {getCurrentTab().items.sort((a: any, b: any) => String(a.inputType).localeCompare(b.inputType)).map((item: any) => (
                                    <Form.Group controlId={getCurrentTab().name + "." + item.name}>
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
        OnSetMenu: (open: boolean) => void;
        OnToggleMenu: () => void;
    }
}
