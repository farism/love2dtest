import * as React from 'react';
declare type Spacing = 'none' | 'xxs' | 'xs' | 'sm' | 'md' | 'lg' | 'xl' | 'xxl';
declare type Padding = [Spacing] | [Spacing, Spacing] | [Spacing, Spacing, Spacing, Spacing] | number;
interface BoxProps {
    children?: React.ReactNode;
    className?: string;
    style?: object;
    shrink?: boolean;
    fill?: boolean;
    fillPortion?: number;
    padding: Padding;
    centerX?: boolean;
    centerY?: boolean;
    alignLeft?: boolean;
    alignRight?: boolean;
    alignTop?: boolean;
    alignBottom?: boolean;
    transparent?: boolean;
    alpha?: number;
    pointer?: string;
    moveUp?: number;
    moveDown?: number;
    moveRight?: number;
    moveLeft?: number;
    rotate?: number;
    scale?: number;
    clip?: boolean;
    clipX?: boolean;
    clipY?: boolean;
    scrollbars?: boolean;
    scrollbarX?: boolean;
    scrollbarY?: boolean;
}
interface ListProps {
    spaceEvenly?: boolean;
    spacing: Spacing;
}
interface RowProps extends BoxProps, ListProps {
    children: typeof Box[];
    wrap?: boolean;
}
interface ColumnProps extends BoxProps, ListProps {
    children: typeof Box[];
}
export declare const Box: React.ForwardRefExoticComponent<BoxProps & React.RefAttributes<HTMLDivElement>>;
export declare const Row: React.ForwardRefExoticComponent<RowProps & React.RefAttributes<HTMLDivElement>>;
export declare const Column: React.ForwardRefExoticComponent<ColumnProps & React.RefAttributes<HTMLDivElement>>;
export {};
