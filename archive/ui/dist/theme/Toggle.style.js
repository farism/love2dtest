import { style } from 'typestyle';
import { Checkbox } from './theme';
export const button = style(Object.assign({}, Checkbox.button.base, { alignItems: 'center', display: 'inline-flex', justifyContent: 'center', $nest: {
        '&::after': Checkbox.button.checkmark.base,
    } }));
export const input = style({
    left: 4,
    position: 'absolute',
    top: 0,
    visibility: 'hidden',
    $nest: {
        [`&:checked + .${button}`]: Object.assign({}, Checkbox.button.checked, { $nest: {
                '&::after': Checkbox.button.checkmark.checked,
            } }),
        [`&:disabled + .${button}`]: Checkbox.button.disabled,
        [`&:active + .${button}`]: Checkbox.button.active,
    },
});
export const label = style(Object.assign({}, Checkbox.label));
export const checkbox = style({
    alignItems: 'center',
    display: 'inline-flex',
    position: 'relative',
});
