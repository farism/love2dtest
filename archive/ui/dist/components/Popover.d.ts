import * as React from 'react';
interface PopoverProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
}
export declare const Popover: React.ForwardRefExoticComponent<PopoverProps & React.RefAttributes<HTMLDivElement>>;
export {};
