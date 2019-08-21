const { hot } = require("react-hot-loader/root")

// prefer default export if available
const preferDefault = m => m && m.default || m


exports.components = {
  "component---src-components-page-tsx": hot(preferDefault(require("/Users/farismustafa/Documents/Projects/games/icepicker/packages/ui-docs/src/components/Page.tsx"))),
  "component---cache-dev-404-page-js": hot(preferDefault(require("/Users/farismustafa/Documents/Projects/games/icepicker/packages/ui-docs/.cache/dev-404-page.js"))),
  "component---src-pages-index-tsx": hot(preferDefault(require("/Users/farismustafa/Documents/Projects/games/icepicker/packages/ui-docs/src/pages/index.tsx")))
}

