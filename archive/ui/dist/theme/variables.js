import { cssRaw } from 'typestyle';
const newVar = (str, defaultValue) => {
    const ret = new String(str);
    ret.def = defaultValue;
    return ret;
};
export var Theme;
(function (Theme) {
    Theme.color = {
        primary: {
            name: '--color-primary',
            default: 'red',
        },
        secondary: {
            name: '--color-secondary',
            default: 'black',
        },
        tertiary: {
            name: '--color-tertiary',
            default: 'white',
        },
    };
    Theme.spacing = {
        xxs: {
            name: '--spacing-xxs',
            default: '2px',
        },
        xs: {
            name: '--spacing-xs',
            default: '4px',
        },
        sm: {
            name: '--spacing-sm',
            default: '8px',
        },
        md: {
            name: '--spacing-md',
            default: '12px',
        },
        lg: {
            name: '--spacing-lg',
            default: '16px',
        },
        xl: {
            name: '--spacing-xl',
            default: '24px',
        },
        xxl: {
            name: '--spacing-xxl',
            default: '32px',
        },
    };
    Theme.typography = {
        primary: {
            name: '--typography-primary',
            default: '',
        },
        secondary: {
            name: '--typography-secondary',
            default: '',
        },
        tertiary: {
            name: '--typography-tertiary',
            default: '',
        },
    };
    Theme.button = {
        backgroundColor: {
            name: '--button-background-color',
            default: '',
        },
        color: {
            name: '--button-color-color',
            default: '',
        },
        paddingHorizontal: {
            name: '--button-padding-horizontal',
            default: `var(${Theme.spacing.xxs.var})`,
        },
        paddingVertical: {
            name: '--button-padding-vertical',
            default: '',
        },
    };
})(Theme || (Theme = {}));
const renderVariables = (variables) => {
    return Object.keys(variables)
        .map(key => {
        return `${key}: ${variables[key]};`;
    })
        .join('\n  ');
};
cssRaw(`
:root {
}
`);
