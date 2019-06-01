import * as React from 'react'
import { avatarStyles } from './Avatar.style'

interface IAvatarProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Avatar = React.forwardRef<HTMLDivElement, IAvatarProps>(
  function Avatar({ children, ...props }: IAvatarProps, ref) {
    const className = avatarStyles({})

    return (
      <div {...props} ref={ref} className={className.avatar}>
        <span>{children}</span>
      </div>
    )
  }
)
