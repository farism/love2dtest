import * as React from 'react'
import { avatarStyles } from './Avatar.style'

interface AvatarProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Avatar = React.forwardRef<HTMLDivElement, AvatarProps>(
  function Avatar({ children, ...props }: AvatarProps, ref) {
    const className = avatarStyles({})

    return (
      <div {...props} ref={ref} className={className.avatar}>
        {children}
      </div>
    )
  }
)
