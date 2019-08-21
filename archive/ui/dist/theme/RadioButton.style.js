import { style } from 'typestyle';
import { RadioButton } from './theme';
export const button = style(Object.assign({}, RadioButton.button.base, { alignItems: 'center', display: 'inline-flex', justifyContent: 'center', $nest: {
        '&::after': RadioButton.button.checkmark,
    } }));
export const input = style({
    left: 4,
    position: 'absolute',
    top: 0,
    visibility: 'hidden',
    $nest: {
        [`&:checked + .${button}`]: Object.assign({}, RadioButton.button.checked, { $nest: {
                '&::after': RadioButton.button.checkmark.checked,
            } }),
        [`&:disabled + .${button}`]: RadioButton.button.disabled,
        [`&:active + .${button}`]: RadioButton.button.active,
    },
});
export const label = style(Object.assign({}, RadioButton.label));
export const radioButton = style({
    alignItems: 'center',
    display: 'inline-flex',
    position: 'relative',
});
