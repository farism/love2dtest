import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Popover.style';
export const Popover = React.forwardRef(function Popover(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: styles.popover }), children));
});
