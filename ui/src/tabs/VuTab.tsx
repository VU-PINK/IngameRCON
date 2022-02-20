import React from "react";
import { Form } from "rsuite";
import { ToggleExtended } from "../helpers";

interface Props {
    formValue: any;
    setFormValue: any;
}

const VuTab: React.FC<Props> = ({
    formValue,
    setFormValue,
}) => {
    return (
        <Form
            fluid
            formValue={formValue}
            onChange={formValue => setFormValue(formValue)}
        >
            <Form.Group controlId="vu.ColorCorrectionEnabled">
                <Form.ControlLabel>Color correction</Form.ControlLabel>
                <Form.Control 
                    name="vu.ColorCorrectionEnabled"
                    accepter={ToggleExtended}
                />
            </Form.Group>
            <Form.Group controlId="vu.ServerBanner">
                <Form.ControlLabel>Server banner URL</Form.ControlLabel>
                <div className="server-banner">
                    <img src={formValue["vu.ServerBanner"]} alt="" />
                </div>
                <Form.Control 
                    name="vu.ServerBanner"
                />
                <Form.HelpText>
                    Use 1378x162 and .jpg only!
                </Form.HelpText>
            </Form.Group>
            
            
        </Form>
    );
}

export default VuTab;
