import * as tslib_1 from "tslib";
import * as React from 'react';
import { classes } from 'typestyle';
import * as styles from '../theme/Button.style';
export const Button = React.forwardRef(function Button(_a, ref) {
    var { children, className = '', size = 'md' } = _a, props = tslib_1.__rest(_a, ["children", "className", "size"]);
    const classNames = classes(styles.button, {
        [`${styles.button}--${size}`]: size,
    }, className);
    return (React.createElement("button", Object.assign({}, props, { ref: ref, className: classNames }), children));
});
