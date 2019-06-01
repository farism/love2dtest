import * as React from 'react'
import { sliderStyles } from './Slider.style'

interface SliderProps extends React.HTMLAttributes<HTMLDivElement> {
  children?: React.ReactNode
}

export const Slider = React.forwardRef<HTMLDivElement, SliderProps>(
  function Slider({ children, ...props }: SliderProps, ref) {
    const className = sliderStyles({})

    return (
      <div {...props} ref={ref} className={className.slider}>
        {children}
      </div>
    )
  }
)
