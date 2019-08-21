import * as React from 'react';
interface ToggleProps extends React.HTMLAttributes<HTMLInputElement> {
    children?: React.ReactNode;
}
export declare const Toggle: React.ForwardRefExoticComponent<ToggleProps & React.RefAttributes<HTMLInputElement>>;
export {};
