import * as React from 'react';
interface ToastProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
}
export declare const Toast: React.ForwardRefExoticComponent<ToastProps & React.RefAttributes<HTMLDivElement>>;
export {};
