import React, { useEffect, useState } from "react";

import { Button, CustomProvider, Drawer, Nav } from "rsuite";

import GeneralTab from "./tabs/GeneralTab";
import VuTab from "./tabs/VuTab";
import { sendToLua } from "./helpers";

import "./App.css";
import "./App.scss";

const initFormValue = {
    "vu.ColorCorrectionEnabled": true,
    "vu.ServerBanner": "https://i.imgur.com/jdUmPVA.jpg",
};

const App: React.FC = () => {
    const [open, setOpen] = useState(false);
    const [activeTab, setActiveTab] = useState<string>("general");
    const [formValue, setFormValue] = useState<any>(initFormValue);

    /*
    * Debug
    */
    let debugMode: boolean = false;
    if (!navigator.userAgent.includes("VeniceUnleashed")) {
        if (window.location.ancestorOrigins === undefined || window.location.ancestorOrigins[0] !== "webui://main") {
            debugMode = true;
        }
    }

    const renderTab = () => {
        switch (activeTab) {
            case "vu":
                return <VuTab formValue={formValue} setFormValue={setFormValue} />;
            case "general":
            default:
                return <GeneralTab />;
        }
    }

    const handleSave = () => {
        let temp: any = [];
        for (const [key, value] of Object.entries(formValue)) {
            temp.push([
                key,
                value
            ]);
        }
        sendToLua("WebUI:UpdateValues", JSON.stringify(temp));
        setOpen(false);
    }

    window.OnSyncValues = (values: string) => {
        var _values = undefined;
        try {
            _values = JSON.parse(values)
        } catch (error) {
            return;
        }
        console.log(_values);
        setFormValue(_values);
    }

    window.OnSetMenu = (open: boolean) => {
        setOpen(open);
    }

    window.OnToggleMenu = () => {
        setOpen(prevState => !prevState);
    }

    useEffect(() => {
        if (open) {
            sendToLua("WebUI:PullRequest");
        }
    }, [open])
    

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
                {JSON.stringify(formValue)}
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
                <div>
                    <Nav 
                        appearance="subtle"
                        activeKey={activeTab}
                        onSelect={setActiveTab}
                        justified
                    >
                        <Nav.Item eventKey="general">
                            General
                        </Nav.Item>
                        <Nav.Item eventKey="vu">
                            Venice Unleashed
                        </Nav.Item>
                        <Nav.Item eventKey="admin">
                            Admin
                        </Nav.Item>
                        <Nav.Item eventKey="maps">
                            Maps
                        </Nav.Item>
                    </Nav>
                </div>
                <Drawer.Body>
                    {renderTab()}
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
