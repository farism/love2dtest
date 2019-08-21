import { style } from 'typestyle';
import { Spacing } from './theme';
const paddingVariants = (spacings) => {
    return Object.keys(spacings).reduce((acc, key) => {
        const val = spacings[key];
        acc[`&--pad-t-${key}`] = { paddingTop: val };
        acc[`&--pad-r-${key}`] = { paddingRight: val };
        acc[`&--pad-b-${key}`] = { paddingTop: val };
        acc[`&--pad-l-${key}`] = { paddingLeft: val };
        return acc;
    }, {});
};
const base = Object.assign({}, paddingVariants(Spacing), { 
    // sizing
    '&--shrink': {
        flexShrink: 1,
    }, '&--fill': {
        flexGrow: 1,
    }, 
    // children alignment
    '&--centerX': {
        justifyContent: 'center',
    }, '&--centerY': {
        alignItems: 'center',
    }, 
    // self alignment
    '&--alignTop, &--alignLeft': {
        alignSelf: 'flex-start',
    }, '&--alignBottom, &--alignRight': {
        alignSelf: 'flex-end',
    }, 
    // transparency
    '&--transparent': {
        opacity: 0,
        pointerEvents: 'none',
    }, '&--pointer': {
        cursor: 'pointer',
    }, 
    // clipping
    '&--clip': {
        overflow: 'hidden',
    }, '&--clipX': {
        overflowX: 'hidden',
    }, '&--clipY': {
        overflowY: 'hidden',
    }, 
    // scrollbars
    '&--scrollbars': {
        overflow: 'auto',
    }, '&--scrollbarX': {
        overflowX: 'auto',
    }, '&--scrollbarY': {
        overflowY: 'auto',
    } });
export const box = style({
    display: 'flex',
    $nest: base,
});
export const row = style({
    display: 'flex',
    flexDirection: 'row',
    $nest: {
        '& > *:first-child': {
            paddingLeft: 0,
        },
        '&--wrap': {
            flexWrap: 'wrap',
        },
        '&--space-evenly': {
            justifyContent: 'space-between',
        },
    },
});
export const column = style({
    display: 'flex',
    flexDirection: 'column',
    $nest: {
        '& > *:first-child': {
            paddingTop: 0,
        },
        '&--centerX': {
            alignItems: 'center',
        },
        '&--centerY': {
            justifyContent: 'center',
        },
    },
});
