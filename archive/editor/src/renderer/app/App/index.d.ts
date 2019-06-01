// WARNING: Do not manually modify this file. It was generated using:
// https://github.com/dillonkearns/elm-typescript-interop
// Type definitions for Elm ports

export namespace Elm {
  namespace App {
    export interface App {
      ports: {
        selectProjectPathIn: {
          send(data: string): void
        }
        selectProjectPathOut: {
          subscribe(callback: (data: null) => void): void
        }
        loadFileIn: {
          send(data: [string, string]): void
        }
        loadFileOut: {
          subscribe(callback: (data: string) => void): void
        }
        saveFileOut: {
          subscribe(callback: (data: [string, any]) => void): void
        }
      };
    }
    export function init(options: {
      node?: HTMLElement | null;
      flags: {  };
    }): Elm.App.App;
  }
}