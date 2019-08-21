import { style } from 'typestyle';
import { Avatar } from './theme';
export const image = style({
    backgroundSize: 'cover',
    height: '100%',
    width: '100%',
});
export const label = style({
    alignItems: 'center',
    display: 'flex',
    height: '100%',
    justifyContent: 'center',
    width: '100%',
});
export const avatar = style(Object.assign({}, Avatar.base, { display: 'inline-block', overflow: 'hidden', $nest: {
        '&--sm': Avatar.sm,
        '&--md': Avatar.md,
        '&--lg': Avatar.lg,
        '&:active': Avatar.active,
        '&:disabled': Avatar.disabled,
        '&:focus': Avatar.focus,
        '&:hover': Avatar.hover,
    } }));
