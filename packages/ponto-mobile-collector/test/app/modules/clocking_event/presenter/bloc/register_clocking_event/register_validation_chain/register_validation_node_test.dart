import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/register_validation_node.dart';

class RegisterValidationNodeBase extends RegisterValidationNode {}

class RegisterValidationNodeTest extends RegisterValidationNode {
  @override
  Future<dynamic> handler() async {
    return true;
  }
}

void main() {
  late RegisterValidationNode registerValidationNode;

  setUpAll(() {
    registerValidationNode = RegisterValidationNodeBase();
  });

  group('RegisterValidationNode |', () {
    test('should set next node', () {
      final result =
          registerValidationNode.setNextNode(RegisterValidationNodeTest());
      expect(result, isA<RegisterValidationNodeTest>());
    });

    test('should return any type from handler', () async {
      final node =
          registerValidationNode.setNextNode(RegisterValidationNodeTest());
      final result = await node.handler();
      expect(result, equals(true));
    });
  });
}
