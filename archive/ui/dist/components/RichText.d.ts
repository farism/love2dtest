import * as React from 'react';
interface RichTextProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
}
export declare const RichText: React.ForwardRefExoticComponent<RichTextProps & React.RefAttributes<HTMLDivElement>>;
export {};
