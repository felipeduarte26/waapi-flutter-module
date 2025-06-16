enum UserActionEnum {
  edit(action: 'Editar'),
  delete(action: 'Deletar'),
  include(action: 'Incluir'),
  allow(action: 'Permitir'),
  view(action: 'Visualizar');

  final String action;

  const UserActionEnum({required this.action});

  static UserActionEnum build({required String action}) {
    if (action == UserActionEnum.edit.action) {
      return edit;
    }

    if (action == UserActionEnum.delete.action) {
      return delete;
    }

    if (action == UserActionEnum.include.action) {
      return include;
    }

    if (action == UserActionEnum.allow.action) {
      return allow;
    }

    if (action == UserActionEnum.view.action) {
      return view;
    }

    throw Exception('UserPermissionEnum value not found.');
  }
}
