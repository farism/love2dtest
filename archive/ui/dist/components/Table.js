import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Table.style';
export const Table = React.forwardRef(function Table(_a, ref) {
    var { children } = _a, props = tslib_1.__rest(_a, ["children"]);
    return (React.createElement("table", Object.assign({}, props, { ref: ref, className: styles.table }), children));
});
