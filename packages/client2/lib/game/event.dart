abstract class Event {}

class DeathEvent extends Event {
  int entityId;

  DeathEvent(this.entityId);
}
