export const isShapeType = <T extends Shape>(
  type: string,
  shape: Shape
): shape is T => shape.getType() === type

export const isPolygonShape = (shape: Shape): shape is PolygonShape => {
  return isShapeType<PolygonShape>('polygon', shape)
}

export const isCircleShape = (shape: Shape): shape is CircleShape => {
  return isShapeType<CircleShape>('circle', shape)
}

export const isChainShape = (shape: Shape): shape is ChainShape => {
  return isShapeType<ChainShape>('chain', shape)
}

export const isEdgeShape = (shape: Shape): shape is EdgeShape => {
  return isShapeType<EdgeShape>('edge', shape)
}

export const isDynamic = (fixture: Fixture) => {
  return fixture.getBody().getType() === 'dynamic'
}

export const isKinematic = (fixture: Fixture) => {
  return fixture.getBody().getType() === 'kinematic'
}

export const isStatic = (fixture: Fixture) => {
  return fixture.getBody().getType() === 'static'
}
