const getFlag = (index: number) => {
  return bit.lshift(1, index)
}

export enum Flag {
  GameObjectRenderer = getFlag(0),
}
