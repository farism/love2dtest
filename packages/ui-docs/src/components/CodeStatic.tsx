import { Language } from "prism-react-renderer";
import * as React from "react";
import { LiveEditor, LiveProvider } from "react-live";
import styled from "styled-components";

interface Scope {
  [k: string]: any;
}

interface CodeStaticProps {
  children: string;
  className?: string;
  language: Language;
  scope?: Scope;
}

export const Container = styled.div`
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
  margin: 32px 0;
`;

export function CodeStatic({ children, language }: CodeStaticProps) {
  return (
    <Container>
      <LiveProvider disabled code={children.trim()} language={language}>
        <LiveEditor />
      </LiveProvider>
    </Container>
  );
}
