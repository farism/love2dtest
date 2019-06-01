import * as React from 'react'
import { sliderStyles } from './Slider.style'

interface ISliderProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Slider = React.forwardRef<HTMLDivElement, ISliderProps>(
  function Slider({ children, ...props }: ISliderProps, ref) {
    const className = sliderStyles({})

    return (
      <div {...props} ref={ref} className={className.slider}>
        <span>{children}</span>
      </div>
    )
  }
)
