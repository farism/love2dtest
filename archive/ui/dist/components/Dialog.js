import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Dialog.style';
export const Dialog = React.forwardRef(function Dialog(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: styles.dialog }), children));
});
