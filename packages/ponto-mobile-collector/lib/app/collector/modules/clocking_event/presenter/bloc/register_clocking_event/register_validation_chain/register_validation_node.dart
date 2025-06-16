abstract class RegisterValidationNode {
  RegisterValidationNode? _nextNode;
  RegisterValidationNode? get nextNode => _nextNode;

  RegisterValidationNode setNextNode(
    RegisterValidationNode registerValidationNode,
  ) {
    _nextNode = registerValidationNode;
    return registerValidationNode;
  }

  Future<dynamic> handler() async {
    return nextNode?.handler();
  }
}
