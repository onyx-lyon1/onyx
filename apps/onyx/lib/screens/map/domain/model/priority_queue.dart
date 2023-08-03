import 'package:onyx/screens/map/domain/model/graph_model.dart';

class PriorityQueue {
  List<PriorityQueueItem> queue = [];

  PriorityQueue();

  void add(Node item, double priority) {
    var queueItem = PriorityQueueItem(item: item, priority: priority);
    queue.add(queueItem);
    queue.sort((a, b) {
      return (a.priority).compareTo(b.priority);
    });
  }

  PriorityQueueItem pop() {
    return queue.removeAt(0);
  }

  bool get isEmpty => queue.isEmpty;

  bool get isNotEmpty => queue.isNotEmpty;
}

class PriorityQueueItem {
  final Node item;
  final double priority;

  PriorityQueueItem({required this.item, required this.priority});
}
