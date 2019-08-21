import * as tslib_1 from "tslib";
import * as React from 'react';
import * as styles from '../theme/Search.style';
export const Search = React.forwardRef(function Search(_a, ref) {
    var props = tslib_1.__rest(_a, []);
    return (React.createElement("div", { className: styles.search },
        React.createElement("input", Object.assign({}, props, { ref: ref }))));
});
