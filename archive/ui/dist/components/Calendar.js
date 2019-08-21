import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Calendar.style';
export const Calendar = React.forwardRef(function Calendar(_a, ref) {
    var props = tslib_1.__rest(_a, []);
    return React.createElement("div", Object.assign({}, props, { ref: ref, className: styles.calendar }));
});
