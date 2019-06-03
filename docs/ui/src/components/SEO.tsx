import { graphql, useStaticQuery } from "gatsby";
import * as React from "react";
import Helmet from "react-helmet";

interface SEOProps {
  description?: string;
  keywords?: string[];
  lang?: string;
  meta?: any[];
  title?: string;
}

export function SEO({
  description = "",
  keywords = [],
  lang = "en",
  meta = [],
  title = ""
}: SEOProps) {
  const { site } = useStaticQuery(graphql`
    query DefaultSEOQuery {
      site {
        siteMetadata {
          title
          description
          author
        }
      }
    }
  `);

  const metaDescription = description || site.siteMetadata.description;

  return (
    <Helmet
      htmlAttributes={{
        lang
      }}
      title={title}
      titleTemplate={`%s | ${site.siteMetadata.title}`}
      meta={[
        {
          name: "description",
          content: metaDescription
        },
        {
          property: "og:title",
          content: title
        },
        {
          property: "og:description",
          content: metaDescription
        },
        {
          property: "og:type",
          content: "website"
        }
      ]
        .concat(
          keywords.length > 0
            ? {
                name: "keywords",
                content: keywords.join(", ")
              }
            : []
        )
        .concat(meta)}
    />
  );
}
