import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Input.style';
export const Input = React.forwardRef(function Input(_a, ref) {
    var props = tslib_1.__rest(_a, []);
    return React.createElement("input", Object.assign({}, props, { ref: ref, className: styles.input }));
});
