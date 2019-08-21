import * as React from 'react';
interface Div extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
    className?: string;
}
interface ContainerProps extends Div {
}
interface BodyProps extends Div {
}
interface ButtonProps extends Div {
}
interface IconProps extends Div {
}
interface TitleProps extends Div {
}
export declare const Body: React.ForwardRefExoticComponent<BodyProps & React.RefAttributes<HTMLDivElement>>;
export declare const Buttons: React.ForwardRefExoticComponent<ButtonProps & React.RefAttributes<HTMLDivElement>>;
export declare const Icon: React.ForwardRefExoticComponent<IconProps & React.RefAttributes<HTMLDivElement>>;
export declare const Title: React.ForwardRefExoticComponent<TitleProps & React.RefAttributes<HTMLDivElement>>;
export declare const Container: React.ForwardRefExoticComponent<ContainerProps & React.RefAttributes<HTMLDivElement>>;
export {};
