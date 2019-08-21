import * as tslib_1 from "tslib";
import * as React from 'react';
import { classes, cssRaw } from 'typestyle';
import * as styles from '../theme/Avatar.style';
import * as Theme from '../theme/theme';
export const Avatar = React.forwardRef(function Avatar(_a, ref) {
    var { className = '', image = '', label = '', size = 'md' } = _a, props = tslib_1.__rest(_a, ["className", "image", "label", "size"]);
    const classNames = classes(styles.avatar, {
        [`${styles.avatar}--${size}`]: size,
    }, className);
    return (React.createElement("div", Object.assign({}, props, { ref: ref, className: classNames }),
        image && (React.createElement("div", { className: styles.image, style: { backgroundImage: `url('${image}')` } })),
        label && React.createElement("div", { className: styles.label }, label)));
});
cssRaw(`
  .custom-avatar {
    ${Theme.Avatar.md.width.replace('var(', '').replace(')', '')}: 100px;
  }
`);
export const CustomAvatar = () => {
    return React.createElement(Avatar, { className: 'custom-avatar' });
};
