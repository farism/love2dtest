import { style } from 'typestyle';
import { Button } from './theme';
export const button = style(Object.assign({}, Button.base, { $nest: {
        '&--sm': Button.sm,
        '&--md': Button.md,
        '&--lg': Button.lg,
        '&:active': Button.active,
        '&:disabled': Button.disabled,
        '&:focus': Button.focus,
        '&:hover': Button.hover,
    } }));
