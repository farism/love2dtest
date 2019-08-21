import * as React from 'react';
interface AccordionProps extends React.HTMLAttributes<HTMLDivElement> {
    children?: React.ReactNode;
    overlay: React.ReactNode;
}
export declare const Accordion: React.ForwardRefExoticComponent<AccordionProps & React.RefAttributes<HTMLDivElement>>;
export {};
