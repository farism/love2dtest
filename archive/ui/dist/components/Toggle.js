import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Toggle.style';
export const Toggle = React.forwardRef(function Toggle(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    const checkbox = (React.createElement(React.Fragment, null,
        React.createElement("input", Object.assign({}, props, { ref: ref, type: "checkbox", className: styles.input })),
        React.createElement("div", { className: styles.button })));
    return children ? (React.createElement("label", { className: styles.toggle },
        checkbox,
        children && React.createElement("div", { className: styles.label }, children))) : (checkbox);
});
