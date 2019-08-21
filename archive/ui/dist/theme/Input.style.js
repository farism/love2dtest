import { style } from 'typestyle';
import { Input } from './theme';
export const input = style(Object.assign({}, Input.base, { $nest: {
        '&:active': Input.active,
        '&:disabled': Input.disabled,
        '&:focus': Input.focus,
        '&:hover': Input.hover,
    } }));
