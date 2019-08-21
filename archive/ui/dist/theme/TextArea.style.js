import { style } from 'typestyle';
import { TextArea } from './theme';
export const textarea = style(Object.assign({}, TextArea.base, { $nest: {
        '&:active': TextArea.active,
        '&:disabled': TextArea.disabled,
        '&:focus': TextArea.focus,
        '&:hover': TextArea.hover,
    } }));
