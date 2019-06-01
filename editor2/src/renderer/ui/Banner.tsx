import * as React from 'react'
import { bannerStyles } from './Banner.style'

interface BannerProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Banner = React.forwardRef<HTMLDivElement, BannerProps>(
  function Banner({ children, ...props }: BannerProps, ref) {
    const className = bannerStyles({})

    return (
      <div {...props} ref={ref} className={className.banner}>
        {children}
      </div>
    )
  }
)
