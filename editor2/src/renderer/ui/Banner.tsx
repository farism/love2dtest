import * as React from 'react'
import { bannerStyles } from './Banner.style'

interface IBannerProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Banner = React.forwardRef<HTMLDivElement, IBannerProps>(
  function Banner({ children, ...props }: IBannerProps, ref) {
    const className = bannerStyles({})

    return (
      <div {...props} ref={ref} className={className.banner}>
        <span>{children}</span>
      </div>
    )
  }
)
