import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Icon.style';
export const Icon = React.forwardRef(function Icon(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    return (React.createElement("span", Object.assign({}, props, { ref: ref, className: styles.icon }), children));
});
