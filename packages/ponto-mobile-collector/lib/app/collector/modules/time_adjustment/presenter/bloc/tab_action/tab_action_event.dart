abstract class TabActionEvent {}

class ChangeTabActionEvent extends TabActionEvent {
  final int tabIndexToChange;

  ChangeTabActionEvent({
    required this.tabIndexToChange,
  });
}
