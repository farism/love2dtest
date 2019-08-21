import * as tslib_1 from "tslib";
import * as React from 'react';
import { classes } from 'typestyle';
import * as styles from '../theme/Layout.style';
const getPaddingVariants = (padding) => {
    let t = '';
    let r = '';
    let b = '';
    let l = '';
    if (padding.length === 2) {
        t = padding[0];
        r = padding[1];
        b = padding[0];
        l = padding[1];
    }
    else if (padding.length === 3) {
        t = padding[0];
        r = padding[2];
        b = padding[1];
        l = padding[2];
    }
    else if (padding.length === 4) {
        t = padding[0];
        r = padding[1];
        b = padding[2];
        l = padding[3];
    }
    return {
        [`${styles.box}--pad-t-${t}`]: t !== 'none',
        [`${styles.box}--pad-r-${r}`]: r !== 'none',
        [`${styles.box}--pad-b-${b}`]: b !== 'none',
        [`${styles.box}--pad-l-${l}`]: l !== 'none',
    };
};
export const Box = React.forwardRef(function El(_a, ref) {
    var { children, className } = _a, props = tslib_1.__rest(_a, ["children", "className"]);
    let style = typeof props.padding === 'number'
        ? Object.assign({}, (props.style || {}), { padding: props.padding }) : props.style;
    let paddingVariants = Array.isArray(props.padding)
        ? getPaddingVariants(props.padding)
        : {};
    const classNames = classes(styles.box, Object.assign({}, paddingVariants, { 
        // container behavior
        [`${styles.box}--shrink`]: props.shrink, [`${styles.box}--fill`]: props.fill, 
        // alignment
        [`${styles.box}--centerX`]: props.centerX, [`${styles.box}--centerY`]: props.centerY, [`${styles.box}--alignLeft`]: props.alignLeft, [`${styles.box}--alignRight`]: props.alignRight, [`${styles.box}--alignTop`]: props.alignTop, [`${styles.box}--alignBottom`]: props.alignBottom, 
        // transparency
        [`${styles.box}--transparent`]: props.transparent, [`${styles.box}--pointer`]: props.pointer, 
        // clipping
        [`${styles.box}--clip`]: props.clip, [`${styles.box}--clipX`]: props.clipX, [`${styles.box}--clipY`]: props.clipY, 
        // scrollbars
        [`${styles.box}--scrollbars`]: props.scrollbars, [`${styles.box}--scrollbarX`]: props.scrollbarX, [`${styles.box}--scrollbarY`]: props.scrollbarY }), className);
    return (React.createElement("div", { ref: ref, className: classNames, style: style }, children));
});
export const Row = React.forwardRef(function Row(_a, ref) {
    var { children, spacing = 'none', spaceEvenly, style, wrap } = _a, props = tslib_1.__rest(_a, ["children", "spacing", "spaceEvenly", "style", "wrap"]);
    const classNames = classes(styles.row, {
        [`${styles.row}--space-evenly`]: spaceEvenly,
        [`${styles.row}--wrap`]: wrap,
    });
    return (React.createElement(Box, Object.assign({}, props, { ref: ref, className: classNames, style: style }), React.Children.map(children, child => {
        return (React.createElement(Box, Object.assign({}, props, { padding: ['none', 'none', 'none', spacing] }), child));
    })));
});
export const Column = React.forwardRef(function Column(_a, ref) {
    var { children, spacing = 'none', spaceEvenly, style } = _a, props = tslib_1.__rest(_a, ["children", "spacing", "spaceEvenly", "style"]);
    const classNames = classes(styles.column, {
        [`${styles.row}--spaceEvenly`]: spaceEvenly,
    });
    return (React.createElement(Box, Object.assign({}, props, { ref: ref, className: classNames, style: style }), React.Children.map(children, child => {
        return (React.createElement(Box, Object.assign({}, props, { padding: [spacing, 'none', 'none', 'none'] }), child));
    })));
});
