import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Link.style';
export const Link = React.forwardRef(function Link(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    return (React.createElement("a", Object.assign({}, props, { ref: ref, className: styles.link }),
        children,
        "foo"));
});
