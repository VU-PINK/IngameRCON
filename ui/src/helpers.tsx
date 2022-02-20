import React, { forwardRef } from "react";

import { Toggle } from "rsuite";

export function sendToLua(event: string, value?: any) {
    if (!navigator.userAgent.includes('VeniceUnleashed')) {
        if (window.location.ancestorOrigins === undefined || window.location.ancestorOrigins[0] !== 'webui://main') {
            return;
        }
    }

    if (value !== null) {
        WebUI.Call('DispatchEventLocal', event, value);
    } else {
        WebUI.Call('DispatchEventLocal', event);
    }
}

export const ToggleExtended = forwardRef((props: any, ref: any) => 
    <Toggle {...props} checked={props.value} ref={ref} />
);
