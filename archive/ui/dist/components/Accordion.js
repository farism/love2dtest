import * as tslib_1 from "tslib";
import * as React from 'react';
export const Accordion = React.forwardRef(function Accordion(_a, ref) {
    var { children, overlay } = _a, props = tslib_1.__rest(_a, ["children", "overlay"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref }), children));
});
