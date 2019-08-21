import * as React from 'react';
interface AnchorProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
    overlay: React.ReactNode;
}
export declare const Anchor: React.ForwardRefExoticComponent<AnchorProps & React.RefAttributes<HTMLDivElement>>;
export {};
