import * as tslib_1 from "tslib";
import * as React from 'react';
import { classes } from 'typestyle';
import * as styles from '../theme/Banner.style';
export const Body = React.forwardRef(function Body(_a, ref) {
    var { children, className } = _a, props = tslib_1.__rest(_a, ["children", "className"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: classes(styles.body, className) }), children));
});
export const Buttons = React.forwardRef(function Buttons(_a, ref) {
    var { children, className } = _a, props = tslib_1.__rest(_a, ["children", "className"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: classes(styles.body, className) }), children));
});
export const Icon = React.forwardRef(function Icon(_a, ref) {
    var { children, className } = _a, props = tslib_1.__rest(_a, ["children", "className"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: classes(styles.icon, className) }), children));
});
export const Title = React.forwardRef(function Title(_a, ref) {
    var { children, className } = _a, props = tslib_1.__rest(_a, ["children", "className"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: classes(styles.title, className) }), children));
});
export const Container = React.forwardRef(function Container(_a, ref) {
    var { children, className } = _a, props = tslib_1.__rest(_a, ["children", "className"]);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: classes(styles.banner, className) }), children));
});
