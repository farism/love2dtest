import * as React from 'react';
interface AvatarProps extends React.HTMLAttributes<HTMLDivElement> {
    className: string;
    image?: string;
    label?: string;
    size?: 'sm' | 'md' | 'lg';
}
export declare const Avatar: React.ForwardRefExoticComponent<AvatarProps & React.RefAttributes<HTMLDivElement>>;
export declare const CustomAvatar: () => JSX.Element;
export {};
