import { cssRaw } from 'typestyle';
class Theme {
    constructor() {
        this.variables = [];
        this.define = (scope, theme) => {
            Object.keys(theme).map(key => {
                const value = theme[key];
                if (typeof value === 'string') {
                    const name = `--${scope}-${key}`;
                    this.variables.push({ name, value });
                    const t = theme;
                    t[key] = `var(${name})`;
                }
                else {
                    this.define(scope ? `${scope}-${key}` : key, value);
                }
            });
            return theme;
        };
        this.generateCss = () => {
            const variables = this.variables
                .map(v => `${v.name}: ${v.value};`)
                .join('\n');
            cssRaw(`
      :root {
        ${variables}
      }
    `);
        };
        this.variables = [];
    }
}
const theme = new Theme();
export const Color = theme.define('color', {
    primary: 'red',
    secondary: 'black',
    tertiary: 'white',
});
export const Spacing = theme.define('spacing', {
    xxs: '2px',
    xs: '4px',
    sm: '8px',
    md: '12px',
    lg: '16px',
    xl: '24px',
    xxl: '32px',
});
export const Typography = theme.define('typography', {});
export const FontSize = theme.define('fontsize', {
    sm: '11px',
    md: '14px',
    lg: '16px',
});
export const Anchor = theme.define('anchor', {});
export const Avatar = theme.define('avatar', {
    // base styles
    base: {
        backgroundColor: 'white',
        borderColor: 'black',
        borderRadius: '100%',
        borderStyle: 'solid',
        borderWidth: '1px',
    },
    // sizes
    sm: {
        fontSize: FontSize.sm,
        height: '20px',
        width: '20px',
    },
    md: {
        fontSize: FontSize.md,
        height: '32px',
        width: '32px',
    },
    lg: {
        fontSize: '48px',
        height: '48px',
        width: '48px',
    },
    // states
    active: {
        backgroundColor: 'green',
    },
    disabled: {
        backgroundColor: 'grey',
    },
    focus: {
        backgroundColor: 'black',
    },
    hover: {
        backgroundColor: 'red',
    },
});
export const Badge = theme.define('badge', {});
export const Button = theme.define('button', {
    // base styles
    base: {
        backgroundColor: 'white',
        borderColor: 'black',
        borderRadius: '2px',
        borderWidth: '1px',
    },
    // sizes
    sm: {
        fontSize: FontSize.sm,
        padding: `${Spacing.sm} ${Spacing.md}`,
    },
    md: {
        fontSize: FontSize.md,
        padding: `${Spacing.sm} ${Spacing.md}`,
    },
    lg: {
        fontSize: FontSize.lg,
        padding: `${Spacing.sm} ${Spacing.md}`,
    },
    // states
    active: {
        backgroundColor: 'green',
    },
    focus: {
        backgroundColor: 'black',
    },
    hover: {
        backgroundColor: 'red',
    },
    disabled: {
        backgroundColor: 'grey',
    },
    // color variants
    variant: {
        regular: {},
        primary: {},
    },
});
export const ButtonGroup = theme.define('buttonGroup', {});
export const Calendar = theme.define('calendar', {});
export const Checkbox = theme.define('checkbox', {
    button: {
        base: {
            backgroundColor: 'white',
            borderColor: 'black',
            borderStyle: 'solid',
            borderWidth: '1px',
            width: '20px',
            height: '20px',
        },
        checkmark: {
            base: {
                color: 'transparent',
                content: '"✓"',
            },
            // states
            checked: {
                color: 'black',
            },
        },
        // states
        active: {
            backgroundColor: 'green',
        },
        checked: {
            backgroundColor: 'yellow',
        },
        disabled: {
            backgroundColor: 'grey',
        },
        focus: {
            backgroundColor: 'black',
        },
    },
    label: {
        paddingLeft: Spacing.md,
    },
});
export const Dialog = theme.define('dialog', {});
export const Input = theme.define('input', {
    // base styles
    base: {
        backgroundColor: 'white',
        borderColor: 'black',
        borderRadius: '2px',
        borderWidth: '1px',
    },
    // states
    active: {
        backgroundColor: 'green',
    },
    disabled: {
        backgroundColor: 'grey',
    },
    focus: {
        backgroundColor: 'black',
    },
    hover: {
        backgroundColor: 'red',
    },
});
export const Link = theme.define('link', {});
export const Modal = theme.define('modal', {});
export const Panel = theme.define('panel', {});
export const Popover = theme.define('popover', {});
export const Progress = theme.define('progress', {});
export const RadioButton = theme.define('radioButton', {
    button: {
        base: {
            backgroundColor: 'white',
            borderColor: 'black',
            borderRadius: '100%',
            borderStyle: 'solid',
            borderWidth: '1px',
            width: '20px',
            height: '20px',
        },
        checkmark: {
            backgroundColor: 'transparent',
            borderRadius: '100%',
            height: `14px`,
            width: '14px',
            // states
            checked: {
                backgroundColor: 'black',
            },
        },
        // states
        active: {
            backgroundColor: 'green',
        },
        checked: {
            backgroundColor: 'yellow',
        },
        disabled: {
            backgroundColor: 'grey',
        },
        focus: {
            backgroundColor: 'black',
        },
    },
    label: {
        paddingLeft: Spacing.md,
    },
});
export const RichText = theme.define('richText', {});
export const Search = theme.define('search', {});
export const Slider = theme.define('slider', {});
export const Spinner = theme.define('spinner', {});
export const Table = theme.define('table', {});
export const Tabs = theme.define('tabs', {});
export const TextArea = theme.define('textArea', {
    // base styles
    base: {
        backgroundColor: 'white',
        borderColor: 'black',
        borderRadius: '2px',
        borderWidth: '1px',
    },
    // states
    active: {
        backgroundColor: 'green',
    },
    disabled: {
        backgroundColor: 'grey',
    },
    focus: {
        backgroundColor: 'black',
    },
    hover: {
        backgroundColor: 'red',
    },
});
export const Toast = theme.define('toast', {});
export const Toggle = theme.define('toggle', {
    button: {
        base: {
            backgroundColor: 'white',
            borderColor: 'black',
            borderRadius: '100%',
            borderStyle: 'solid',
            borderWidth: '1px',
            width: '20px',
            height: '20px',
        },
        checkmark: {
            backgroundColor: 'transparent',
            borderRadius: '100%',
            height: `14px`,
            width: '14px',
            // states
            checked: {
                backgroundColor: 'black',
            },
        },
        // states
        active: {
            backgroundColor: 'green',
        },
        checked: {
            backgroundColor: 'yellow',
        },
        disabled: {
            backgroundColor: 'grey',
        },
        focus: {
            backgroundColor: 'black',
        },
    },
    label: {
        paddingLeft: Spacing.md,
    },
});
export const Token = theme.define('token', {});
export const Tooltip = theme.define('tooltip', {});
theme.generateCss();
