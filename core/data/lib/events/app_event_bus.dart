import 'package:data/contracts/events/event_base.dart';
import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';

@singleton
class AppEventBus {
  final EventBus _eventBus = EventBus();

  @disposeMethod
  void dispose() {
    _eventBus.destroy();
  }

  void fireEvent(EventBase event) {
    _eventBus.fire(event);
  }

  Stream<T> on<T>() {
    return _eventBus.on<T>();
  }
}
