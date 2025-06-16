enum UserResourceEnum {

  mobileLog(
    resource: 'res://senior.com.br/hcm/pontomobile/entities/mobileLog',
  ),
  entityPerimeter(
    resource: 'res://senior.com.br/hcm/pontomobile/entities/perimeter',
  ),
  entityOvernight(
    resource: 'res://senior.com.br/hcm/pontomobile/entities/overnight',
  ),
  pushNotification(
    resource: 'res://senior.com.br/hcm/pontomobile/pushNotification',
  ),
  clockEventList(
    resource: 'res://senior.com.br/hcm/clientmobile/clockEventList',
  ),
  clockingEvent(
    resource: 'res://senior.com.br/hcm/pontomobile/clockingEvent',
  ),
  qrcodeconfig(
    resource: 'res://senior.com.br/hcm/pontomobile/qrcodeconfig',
  ),
  applicationKeyConfig(
    resource:
        'res://senior.com.br/hcm/pontomobile/application_key_configuration',
  ),
  facialAuth(
    resource: 'res://senior.com.br/hcm/pontomobile/facial_auth',
  ),
  employeesQrCode(
    resource: 'res://senior.com.br/hcm/pontomobile/employeesqrcode',
  ),
  employee(
    resource: 'res://senior.com.br/hcm/pontomobile/employee',
  ),
  manager(
    resource: 'res://senior.com.br/hcm/pontomobile/manager',
  ),
  admin(
    resource: 'res://senior.com.br/hcm/pontomobile/administrator',
  );

  final String resource;

  const UserResourceEnum({required this.resource});

  static UserResourceEnum build({required String resource}) {
    if (resource == UserResourceEnum.mobileLog.resource) {
      return UserResourceEnum.mobileLog;
    }

    if (resource == UserResourceEnum.entityPerimeter.resource) {
      return UserResourceEnum.entityPerimeter;
    }

    if (resource == UserResourceEnum.entityOvernight.resource) {
      return UserResourceEnum.entityOvernight;
    }

    if (resource == UserResourceEnum.pushNotification.resource) {
      return UserResourceEnum.pushNotification;
    }

    if (resource == UserResourceEnum.clockEventList.resource) {
      return UserResourceEnum.clockEventList;
    }

    if (resource == UserResourceEnum.clockingEvent.resource) {
      return UserResourceEnum.clockingEvent;
    }

    if (resource == UserResourceEnum.qrcodeconfig.resource) {
      return UserResourceEnum.qrcodeconfig;
    }

    if (resource == UserResourceEnum.facialAuth.resource) {
      return UserResourceEnum.facialAuth;
    }

    if (resource == UserResourceEnum.employeesQrCode.resource) {
      return UserResourceEnum.employeesQrCode;
    }

    if (resource == UserResourceEnum.employee.resource) {
      return UserResourceEnum.employee;
    }

    if (resource == UserResourceEnum.manager.resource) {
      return UserResourceEnum.manager;
    }

    if (resource == UserResourceEnum.admin.resource) {
      return UserResourceEnum.admin;
    }

    throw Exception('UserResourceEnum resource not found.');
  }
}
