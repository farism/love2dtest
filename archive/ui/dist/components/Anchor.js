import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Anchor.style';
import isReactElement from '../utils/isReactElement';
export const Anchor = React.forwardRef(function Anchor(_a, ref) {
    var { children, overlay } = _a, props = tslib_1.__rest(_a, ["children", "overlay"]);
    if (isReactElement(children)) {
        return (React.createElement("div", Object.assign({}, props, { ref: ref }),
            React.cloneElement(children, { ref }),
            React.createElement("div", { className: styles.anchor }, overlay)));
    }
    return null;
});
