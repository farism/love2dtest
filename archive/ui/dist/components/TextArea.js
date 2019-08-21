import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/TextArea.style';
export const TextArea = React.forwardRef(function TextArea(_a, ref) {
    var props = tslib_1.__rest(_a, []);
    return React.createElement("textarea", Object.assign({}, props, { ref: ref, className: styles.textarea }));
});
