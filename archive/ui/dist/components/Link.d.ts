import * as React from 'react';
interface LinkProps extends React.HTMLAttributes<HTMLAnchorElement> {
    children?: React.ReactNode;
}
export declare const Link: React.ForwardRefExoticComponent<LinkProps & React.RefAttributes<HTMLAnchorElement>>;
export {};
