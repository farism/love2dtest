import "normalize.css";
import "reset-css";
import { style } from "typestyle";

export const page = style({
  display: "flex",

  $nest: {
    "&--vertical": {
      display: "block"
    }
  }
});

export const pageSidebar = style({
  flexShrink: 0,
  height: "100%",
  width: 250
});

export const pageContent = style({
  flexGrow: 1,
  height: "100%"
});

export const select = style({
  $debugName: "select",
  background: "black"
});
