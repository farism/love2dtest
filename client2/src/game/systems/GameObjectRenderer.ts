import { System } from '../../ecs/System'
import { GameObject } from '../components/gameobject'
import { Flag } from './flags'

const isPolygonShape = (shape: Shape): shape is PolygonShape =>
  shape.getType() === 'polygon'

const isCircleShape = (shape: Shape): shape is CircleShape =>
  shape.getType() === 'circle'

const isChainShape = (shape: Shape): shape is ChainShape =>
  shape.getType() === 'edge'

const isEdgeShape = (shape: Shape): shape is EdgeShape =>
  shape.getType() === 'chain'

export class GameObjectRenderer extends System {
  static _id = 'GameObjectRenderer'
  _id = GameObjectRenderer._id

  static _flag = Flag.GameObjectRenderer
  _flag = GameObjectRenderer._flag

  draw = () => {
    this.entities.forEach(entity => {
      const gameObject = entity.as<GameObject>(GameObject)

      if (!gameObject) {
        return
      }

      const body = gameObject.fixture.getBody()
      const shape = gameObject.fixture.getShape()

      if (isPolygonShape(shape)) {
        // const pts = body.getWorldPoints(...shape.getPoints())
        // print(shape.getPoints()[1])
        // print(...shape.computeAABB(0, 0, 0, 0))
        // print(pts[2])
        // print(...body.getWorldPoints(...shape.getPoints()))
        love.graphics.polygon(
          'fill',
          ...body.getWorldPoints(...shape.getPoints())
        )
        // love.graphics.polygon('fill', 0, 0, 16, 16, 0, 16)
      }
    })
  }
}

// local Aspect = require 'src.ecs.aspect'
// local System = require 'src.ecs.system'
// local Fixture = require 'src.game.components.fixture'

// local aspect = Aspect.new({Fixture})
// local FixtureRender = System:new('fixturerender', aspect)

// function FixtureRender:draw()
//   for _, entity in pairs(self.entities) do
//     local fixture = entity:as(Fixture)
//     local body = fixture.fixture:getBody()
//     local shape = fixture.fixture:getShape()
//     local shapeType = shape:getType()

//     if (entity.meta.type == 'icicle') then
//       love.graphics.setColor(255, 0, 0, 1)
//     elseif (entity.meta.type == 'checkpoint') then
//       love.graphics.setColor(0, 255, 0, 1)
//     elseif (entity.meta.type == 'container') then
//       love.graphics.setColor(0, 0, 255, 1)
//     end

//     if shapeType == 'polygon' then
//     elseif shapeType == 'circle' then
//       love.graphics.circle('fill', body:getX(), body:getY(), shape:getRadius())
//     elseif shapeType == 'edge' then
//       -- return love.physics.newEdgeShape(...)
//     elseif shapeType == 'chain' then
//     -- return love.physics.newChainShape(...)
//     end

//     love.graphics.setColor(255, 255, 255, 1)
//   end
// end

// return FixtureRender
