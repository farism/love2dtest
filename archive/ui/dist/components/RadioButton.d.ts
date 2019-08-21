import * as React from 'react';
interface RadioButtonProps extends React.HTMLAttributes<HTMLInputElement> {
    children?: React.ReactNode;
}
export declare const RadioButton: React.ForwardRefExoticComponent<RadioButtonProps & React.RefAttributes<HTMLInputElement>>;
export {};
