import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/RadioButton.style';
export const RadioButton = React.forwardRef(function RadioButton(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    const checkbox = (React.createElement(React.Fragment, null,
        React.createElement("input", Object.assign({}, props, { ref: ref, type: "checkbox", className: styles.input })),
        React.createElement("div", { className: styles.button })));
    return children ? (React.createElement("label", { className: styles.radioButton },
        checkbox,
        children && React.createElement("div", { className: styles.label }, children))) : (checkbox);
});
