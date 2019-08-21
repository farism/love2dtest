import * as React from 'react';
interface TokenProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
}
export declare const Token: React.ForwardRefExoticComponent<TokenProps & React.RefAttributes<HTMLDivElement>>;
export {};
