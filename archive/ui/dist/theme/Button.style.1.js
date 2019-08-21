import { style } from 'typestyle';
import { ComponentVar } from './variables';
export const button = style({
    paddingTop: `var(${ComponentVar.buttonPaddingVertical})`,
    paddingRight: `var(${ComponentVar.buttonPaddingHorizontal})`,
    paddingBottom: `var(${ComponentVar.buttonPaddingVertical})`,
    paddingLeft: `var(${ComponentVar.buttonPaddingHorizontal})`,
    color: `var(${ComponentVar.buttonLabelColor})`,
    backgroundColor: `var(${ComponentVar.buttonBackgroundColor})`,
});
