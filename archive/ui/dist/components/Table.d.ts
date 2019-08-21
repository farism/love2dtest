import * as React from 'react';
interface TableProps extends React.HTMLAttributes<HTMLTableElement> {
    children?: React.ReactNode;
}
export declare const Table: React.ForwardRefExoticComponent<TableProps & React.RefAttributes<HTMLTableElement>>;
export {};
