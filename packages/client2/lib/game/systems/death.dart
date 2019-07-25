// import 'package:client2/game/systems/base/render_system.dart';
// import 'package:client2/game/systems/base/system.dart';
// import 'package:flutter/material.dart';

// import '../../ecs/ecs.dart';
// import '../components/health.dart';
// import '../event.dart';
// import '../flags.dart';

// class ProcessDeath extends System with BaseSystem, RenderingSystem {
//   static const int Flag = ProcessingSystemFlags.Death;
//   int flag = ProcessDeath.Flag;

//   static const String Id = 'ProcessDeath';
//   String id = ProcessDeath.Id;

//   Aspect aspect = Aspect(all: [
//     Health.Flag,
//   ]);

//   void update(double dt) {
//     entities.values.forEach((entity) {
//       final health = entity.as<Health>(Health.Id);

//       if (health == null) {
//         return;
//       }

//       if (health.hitpoints == 0) {
//         manager.emit(DeathEvent(entity.id));
//       }
//     });
//   }

//   void render(Canvas canvas) {

//   }
// }

// final foo = ProcessDeath();

// final bar = foo.isRenderSystem()
