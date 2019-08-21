import * as React from 'react';
interface CheckboxProps extends React.HTMLAttributes<HTMLInputElement> {
    children?: React.ReactNode;
}
export declare const Checkbox: React.ForwardRefExoticComponent<CheckboxProps & React.RefAttributes<HTMLInputElement>>;
export {};
