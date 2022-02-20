import React from "react";

import {
    Col,
    Form,
    Input,
    InputNumber,
    Row,
    Toggle
} from "rsuite";

const Textarea = React.forwardRef((props: any, ref: any) => <Input {...props} as="textarea" ref={ref} />);

const GeneralTab: React.FC = () => {
    return (
        <Form fluid>
            <Form.Group controlId="vars.serverName">
                <Form.ControlLabel>Server name</Form.ControlLabel>
                <Form.Control name="vars.serverName" />
            </Form.Group>
            <Form.Group controlId="vars.gamePassword">
                <Form.ControlLabel>Server password</Form.ControlLabel>
                <Form.Control name="vars.gamePassword" />
            </Form.Group>
            <Row style={{ marginBottom: 24 }}>
                <Col md={12}>
                    <Form.Group controlId="vars.roundStartPlayerCount">
                        <Form.ControlLabel>Round start player count</Form.ControlLabel>
                        <Form.Control 
                            name="vars.roundStartPlayerCount"
                            accepter={InputNumber}
                            style={{ width: "100%" }}
                        />
                    </Form.Group>
                </Col>
                <Col md={12}>
                    <Form.Group controlId="vars.roundRestartPlayerCount">
                        <Form.ControlLabel>Round restart player count</Form.ControlLabel>
                        <Form.Control 
                            name="vars.roundRestartPlayerCount"
                            accepter={InputNumber}
                            style={{ width: "100%" }}
                        />
                    </Form.Group>
                </Col>
            </Row>
            <Row style={{ marginBottom: 24 }}>
                <Col md={12}>
                    <Form.Group controlId="vars.roundLockdownCountdown">
                        <Form.ControlLabel>Duration of pre-round</Form.ControlLabel>
                        <Form.Control 
                            name="vars.roundLockdownCountdown"
                            accepter={InputNumber}
                            style={{ width: "100%" }}
                        />
                    </Form.Group>
                </Col>
                <Col md={12}>
                    <Form.Group controlId="vars.maxPlayers">
                        <Form.ControlLabel>Max players</Form.ControlLabel>
                        <Form.Control 
                            name="vars.maxPlayers"
                            accepter={InputNumber}
                            style={{ width: "100%" }}
                        />
                    </Form.Group>
                </Col>
            </Row>
            <Form.Group controlId="vars.serverMessage">
                <Form.ControlLabel>Server message</Form.ControlLabel>
                <Form.Control 
                    name="vars.serverMessage"
                    accepter={Textarea}
                    rows={4}
                    style={{ width: "100%", resize: "none" }}
                />
            </Form.Group>
            <Form.Group controlId="vars.serverDescription">
                <Form.ControlLabel>Server description</Form.ControlLabel>
                <Form.Control 
                    name="vars.serverDescription"
                    accepter={Textarea}
                    rows={4}
                    style={{ width: "100%", resize: "none" }}
                />
            </Form.Group>
            <Row style={{ marginBottom: 24 }}>
                <Col md={6}>
                    <Form.Group controlId="vars.friendlyFire">
                        <Form.ControlLabel>Friendly fire</Form.ControlLabel>
                        <Form.Control 
                            name="vars.friendlyFire"
                            accepter={Toggle}
                        />
                    </Form.Group>
                </Col>
                <Col md={6}>
                    <Form.Group controlId="vars.killCam">
                        <Form.ControlLabel>Kill cam</Form.ControlLabel>
                        <Form.Control 
                            name="vars.killCam"
                            accepter={Toggle}
                        />
                    </Form.Group>
                </Col>
                <Col md={6}>
                    <Form.Group controlId="vars.miniMap">
                        <Form.ControlLabel>Minimap</Form.ControlLabel>
                        <Form.Control 
                            name="vars.miniMap"
                            accepter={Toggle}
                        />
                    </Form.Group>
                </Col>
                <Col md={6}>
                    <Form.Group controlId="vars.hud">
                        <Form.ControlLabel>HUD</Form.ControlLabel>
                        <Form.Control 
                            name="vars.hud"
                            accepter={Toggle}
                        />
                    </Form.Group>
                </Col>
            </Row>
            <Row style={{ marginBottom: 24 }}>
                <Col md={6}>
                    <Form.Group controlId="vars.crossHair">
                        <Form.ControlLabel>CrossHair</Form.ControlLabel>
                        <Form.Control 
                            name="vars.crossHair"
                            accepter={Toggle}
                        />
                    </Form.Group>
                </Col>
                <Col md={6}>
                    <Form.Group controlId="vars.3dSpotting">
                        <Form.ControlLabel>3D spotting</Form.ControlLabel>
                        <Form.Control 
                            name="vars.3dSpotting"
                            accepter={Toggle}
                        />
                    </Form.Group>
                </Col>
            </Row>
        </Form>
    );
}

export default GeneralTab;
