import * as React from 'react';
interface DialogProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
}
export declare const Dialog: React.ForwardRefExoticComponent<DialogProps & React.RefAttributes<HTMLDivElement>>;
export {};
