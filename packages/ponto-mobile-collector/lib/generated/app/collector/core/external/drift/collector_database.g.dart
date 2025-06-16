// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../../../../app/collector/core/external/drift/collector_database.dart';

// ignore_for_file: type=lint
class $CompanyTableTable extends CompanyTable
    with TableInfo<$CompanyTableTable, CompanyTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompanyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _identifierMeta =
      const VerificationMeta('identifier');
  @override
  late final GeneratedColumn<String> identifier = GeneratedColumn<String>(
      'identifier', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeZoneMeta =
      const VerificationMeta('timeZone');
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
      'time_zone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _arpIdMeta = const VerificationMeta('arpId');
  @override
  late final GeneratedColumn<String> arpId = GeneratedColumn<String>(
      'arp_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _caepfMeta = const VerificationMeta('caepf');
  @override
  late final GeneratedColumn<String> caepf = GeneratedColumn<String>(
      'caepf', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cnoNumberMeta =
      const VerificationMeta('cnoNumber');
  @override
  late final GeneratedColumn<String> cnoNumber = GeneratedColumn<String>(
      'cno_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, identifier, name, timeZone, arpId, caepf, cnoNumber];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'company_table';
  @override
  VerificationContext validateIntegrity(Insertable<CompanyTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('identifier')) {
      context.handle(
          _identifierMeta,
          identifier.isAcceptableOrUnknown(
              data['identifier']!, _identifierMeta));
    } else if (isInserting) {
      context.missing(_identifierMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('time_zone')) {
      context.handle(_timeZoneMeta,
          timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta));
    } else if (isInserting) {
      context.missing(_timeZoneMeta);
    }
    if (data.containsKey('arp_id')) {
      context.handle(
          _arpIdMeta, arpId.isAcceptableOrUnknown(data['arp_id']!, _arpIdMeta));
    }
    if (data.containsKey('caepf')) {
      context.handle(
          _caepfMeta, caepf.isAcceptableOrUnknown(data['caepf']!, _caepfMeta));
    }
    if (data.containsKey('cno_number')) {
      context.handle(_cnoNumberMeta,
          cnoNumber.isAcceptableOrUnknown(data['cno_number']!, _cnoNumberMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CompanyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      identifier: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}identifier'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      timeZone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_zone'])!,
      arpId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arp_id']),
      caepf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caepf']),
      cnoNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cno_number']),
    );
  }

  @override
  $CompanyTableTable createAlias(String alias) {
    return $CompanyTableTable(attachedDatabase, alias);
  }
}

class CompanyTableData extends DataClass
    implements Insertable<CompanyTableData> {
  final String id;
  final String identifier;
  final String name;
  final String timeZone;
  final String? arpId;
  final String? caepf;
  final String? cnoNumber;
  const CompanyTableData(
      {required this.id,
      required this.identifier,
      required this.name,
      required this.timeZone,
      this.arpId,
      this.caepf,
      this.cnoNumber});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['identifier'] = Variable<String>(identifier);
    map['name'] = Variable<String>(name);
    map['time_zone'] = Variable<String>(timeZone);
    if (!nullToAbsent || arpId != null) {
      map['arp_id'] = Variable<String>(arpId);
    }
    if (!nullToAbsent || caepf != null) {
      map['caepf'] = Variable<String>(caepf);
    }
    if (!nullToAbsent || cnoNumber != null) {
      map['cno_number'] = Variable<String>(cnoNumber);
    }
    return map;
  }

  CompanyTableCompanion toCompanion(bool nullToAbsent) {
    return CompanyTableCompanion(
      id: Value(id),
      identifier: Value(identifier),
      name: Value(name),
      timeZone: Value(timeZone),
      arpId:
          arpId == null && nullToAbsent ? const Value.absent() : Value(arpId),
      caepf:
          caepf == null && nullToAbsent ? const Value.absent() : Value(caepf),
      cnoNumber: cnoNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(cnoNumber),
    );
  }

  factory CompanyTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyTableData(
      id: serializer.fromJson<String>(json['id']),
      identifier: serializer.fromJson<String>(json['identifier']),
      name: serializer.fromJson<String>(json['name']),
      timeZone: serializer.fromJson<String>(json['timeZone']),
      arpId: serializer.fromJson<String?>(json['arpId']),
      caepf: serializer.fromJson<String?>(json['caepf']),
      cnoNumber: serializer.fromJson<String?>(json['cnoNumber']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'identifier': serializer.toJson<String>(identifier),
      'name': serializer.toJson<String>(name),
      'timeZone': serializer.toJson<String>(timeZone),
      'arpId': serializer.toJson<String?>(arpId),
      'caepf': serializer.toJson<String?>(caepf),
      'cnoNumber': serializer.toJson<String?>(cnoNumber),
    };
  }

  CompanyTableData copyWith(
          {String? id,
          String? identifier,
          String? name,
          String? timeZone,
          Value<String?> arpId = const Value.absent(),
          Value<String?> caepf = const Value.absent(),
          Value<String?> cnoNumber = const Value.absent()}) =>
      CompanyTableData(
        id: id ?? this.id,
        identifier: identifier ?? this.identifier,
        name: name ?? this.name,
        timeZone: timeZone ?? this.timeZone,
        arpId: arpId.present ? arpId.value : this.arpId,
        caepf: caepf.present ? caepf.value : this.caepf,
        cnoNumber: cnoNumber.present ? cnoNumber.value : this.cnoNumber,
      );
  CompanyTableData copyWithCompanion(CompanyTableCompanion data) {
    return CompanyTableData(
      id: data.id.present ? data.id.value : this.id,
      identifier:
          data.identifier.present ? data.identifier.value : this.identifier,
      name: data.name.present ? data.name.value : this.name,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      arpId: data.arpId.present ? data.arpId.value : this.arpId,
      caepf: data.caepf.present ? data.caepf.value : this.caepf,
      cnoNumber: data.cnoNumber.present ? data.cnoNumber.value : this.cnoNumber,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyTableData(')
          ..write('id: $id, ')
          ..write('identifier: $identifier, ')
          ..write('name: $name, ')
          ..write('timeZone: $timeZone, ')
          ..write('arpId: $arpId, ')
          ..write('caepf: $caepf, ')
          ..write('cnoNumber: $cnoNumber')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, identifier, name, timeZone, arpId, caepf, cnoNumber);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CompanyTableData &&
          other.id == this.id &&
          other.identifier == this.identifier &&
          other.name == this.name &&
          other.timeZone == this.timeZone &&
          other.arpId == this.arpId &&
          other.caepf == this.caepf &&
          other.cnoNumber == this.cnoNumber);
}

class CompanyTableCompanion extends UpdateCompanion<CompanyTableData> {
  final Value<String> id;
  final Value<String> identifier;
  final Value<String> name;
  final Value<String> timeZone;
  final Value<String?> arpId;
  final Value<String?> caepf;
  final Value<String?> cnoNumber;
  final Value<int> rowid;
  const CompanyTableCompanion({
    this.id = const Value.absent(),
    this.identifier = const Value.absent(),
    this.name = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.arpId = const Value.absent(),
    this.caepf = const Value.absent(),
    this.cnoNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompanyTableCompanion.insert({
    required String id,
    required String identifier,
    required String name,
    required String timeZone,
    this.arpId = const Value.absent(),
    this.caepf = const Value.absent(),
    this.cnoNumber = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        identifier = Value(identifier),
        name = Value(name),
        timeZone = Value(timeZone);
  static Insertable<CompanyTableData> custom({
    Expression<String>? id,
    Expression<String>? identifier,
    Expression<String>? name,
    Expression<String>? timeZone,
    Expression<String>? arpId,
    Expression<String>? caepf,
    Expression<String>? cnoNumber,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (identifier != null) 'identifier': identifier,
      if (name != null) 'name': name,
      if (timeZone != null) 'time_zone': timeZone,
      if (arpId != null) 'arp_id': arpId,
      if (caepf != null) 'caepf': caepf,
      if (cnoNumber != null) 'cno_number': cnoNumber,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompanyTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? identifier,
      Value<String>? name,
      Value<String>? timeZone,
      Value<String?>? arpId,
      Value<String?>? caepf,
      Value<String?>? cnoNumber,
      Value<int>? rowid}) {
    return CompanyTableCompanion(
      id: id ?? this.id,
      identifier: identifier ?? this.identifier,
      name: name ?? this.name,
      timeZone: timeZone ?? this.timeZone,
      arpId: arpId ?? this.arpId,
      caepf: caepf ?? this.caepf,
      cnoNumber: cnoNumber ?? this.cnoNumber,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (identifier.present) {
      map['identifier'] = Variable<String>(identifier.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (arpId.present) {
      map['arp_id'] = Variable<String>(arpId.value);
    }
    if (caepf.present) {
      map['caepf'] = Variable<String>(caepf.value);
    }
    if (cnoNumber.present) {
      map['cno_number'] = Variable<String>(cnoNumber.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompanyTableCompanion(')
          ..write('id: $id, ')
          ..write('identifier: $identifier, ')
          ..write('name: $name, ')
          ..write('timeZone: $timeZone, ')
          ..write('arpId: $arpId, ')
          ..write('caepf: $caepf, ')
          ..write('cnoNumber: $cnoNumber, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeeTableTable extends EmployeeTable
    with TableInfo<$EmployeeTableTable, EmployeeTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pisMeta = const VerificationMeta('pis');
  @override
  late final GeneratedColumn<String> pis = GeneratedColumn<String>(
      'pis', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cpfNumberMeta =
      const VerificationMeta('cpfNumber');
  @override
  late final GeneratedColumn<String> cpfNumber = GeneratedColumn<String>(
      'cpf_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mailMeta = const VerificationMeta('mail');
  @override
  late final GeneratedColumn<String> mail = GeneratedColumn<String>(
      'mail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyIdMeta =
      const VerificationMeta('companyId');
  @override
  late final GeneratedColumn<String> companyId = GeneratedColumn<String>(
      'company_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES company_table (id)'));
  static const VerificationMeta _nfcCodeMeta =
      const VerificationMeta('nfcCode');
  @override
  late final GeneratedColumn<String> nfcCode = GeneratedColumn<String>(
      'nfc_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeTypeMeta =
      const VerificationMeta('employeeType');
  @override
  late final GeneratedColumn<String> employeeType = GeneratedColumn<String>(
      'employee_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  @override
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>('registration_number', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _arpIdMeta = const VerificationMeta('arpId');
  @override
  late final GeneratedColumn<String> arpId = GeneratedColumn<String>(
      'arp_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _enableMeta = const VerificationMeta('enable');
  @override
  late final GeneratedColumn<bool> enable = GeneratedColumn<bool>(
      'enable', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enable" IN (0, 1))'));
  static const VerificationMeta _faceRegisteredMeta =
      const VerificationMeta('faceRegistered');
  @override
  late final GeneratedColumn<String> faceRegistered = GeneratedColumn<String>(
      'face_registered', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeCodeMeta =
      const VerificationMeta('employeeCode');
  @override
  late final GeneratedColumn<String> employeeCode = GeneratedColumn<String>(
      'employee_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        pis,
        cpfNumber,
        mail,
        companyId,
        nfcCode,
        employeeType,
        registrationNumber,
        arpId,
        enable,
        faceRegistered,
        employeeCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_table';
  @override
  VerificationContext validateIntegrity(Insertable<EmployeeTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('pis')) {
      context.handle(
          _pisMeta, pis.isAcceptableOrUnknown(data['pis']!, _pisMeta));
    }
    if (data.containsKey('cpf_number')) {
      context.handle(_cpfNumberMeta,
          cpfNumber.isAcceptableOrUnknown(data['cpf_number']!, _cpfNumberMeta));
    } else if (isInserting) {
      context.missing(_cpfNumberMeta);
    }
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail']!, _mailMeta));
    }
    if (data.containsKey('company_id')) {
      context.handle(_companyIdMeta,
          companyId.isAcceptableOrUnknown(data['company_id']!, _companyIdMeta));
    } else if (isInserting) {
      context.missing(_companyIdMeta);
    }
    if (data.containsKey('nfc_code')) {
      context.handle(_nfcCodeMeta,
          nfcCode.isAcceptableOrUnknown(data['nfc_code']!, _nfcCodeMeta));
    }
    if (data.containsKey('employee_type')) {
      context.handle(
          _employeeTypeMeta,
          employeeType.isAcceptableOrUnknown(
              data['employee_type']!, _employeeTypeMeta));
    } else if (isInserting) {
      context.missing(_employeeTypeMeta);
    }
    if (data.containsKey('registration_number')) {
      context.handle(
          _registrationNumberMeta,
          registrationNumber.isAcceptableOrUnknown(
              data['registration_number']!, _registrationNumberMeta));
    }
    if (data.containsKey('arp_id')) {
      context.handle(
          _arpIdMeta, arpId.isAcceptableOrUnknown(data['arp_id']!, _arpIdMeta));
    }
    if (data.containsKey('enable')) {
      context.handle(_enableMeta,
          enable.isAcceptableOrUnknown(data['enable']!, _enableMeta));
    }
    if (data.containsKey('face_registered')) {
      context.handle(
          _faceRegisteredMeta,
          faceRegistered.isAcceptableOrUnknown(
              data['face_registered']!, _faceRegisteredMeta));
    }
    if (data.containsKey('employee_code')) {
      context.handle(
          _employeeCodeMeta,
          employeeCode.isAcceptableOrUnknown(
              data['employee_code']!, _employeeCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmployeeTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      pis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pis']),
      cpfNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf_number'])!,
      mail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mail']),
      companyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_id'])!,
      nfcCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nfc_code']),
      employeeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_type'])!,
      registrationNumber: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}registration_number']),
      arpId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}arp_id']),
      enable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable']),
      faceRegistered: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}face_registered']),
      employeeCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_code']),
    );
  }

  @override
  $EmployeeTableTable createAlias(String alias) {
    return $EmployeeTableTable(attachedDatabase, alias);
  }
}

class EmployeeTableData extends DataClass
    implements Insertable<EmployeeTableData> {
  final String id;
  final String name;
  final String? pis;
  final String cpfNumber;
  final String? mail;
  final String companyId;
  final String? nfcCode;
  final String employeeType;
  final String? registrationNumber;
  final String? arpId;
  final bool? enable;
  final String? faceRegistered;
  final String? employeeCode;
  const EmployeeTableData(
      {required this.id,
      required this.name,
      this.pis,
      required this.cpfNumber,
      this.mail,
      required this.companyId,
      this.nfcCode,
      required this.employeeType,
      this.registrationNumber,
      this.arpId,
      this.enable,
      this.faceRegistered,
      this.employeeCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || pis != null) {
      map['pis'] = Variable<String>(pis);
    }
    map['cpf_number'] = Variable<String>(cpfNumber);
    if (!nullToAbsent || mail != null) {
      map['mail'] = Variable<String>(mail);
    }
    map['company_id'] = Variable<String>(companyId);
    if (!nullToAbsent || nfcCode != null) {
      map['nfc_code'] = Variable<String>(nfcCode);
    }
    map['employee_type'] = Variable<String>(employeeType);
    if (!nullToAbsent || registrationNumber != null) {
      map['registration_number'] = Variable<String>(registrationNumber);
    }
    if (!nullToAbsent || arpId != null) {
      map['arp_id'] = Variable<String>(arpId);
    }
    if (!nullToAbsent || enable != null) {
      map['enable'] = Variable<bool>(enable);
    }
    if (!nullToAbsent || faceRegistered != null) {
      map['face_registered'] = Variable<String>(faceRegistered);
    }
    if (!nullToAbsent || employeeCode != null) {
      map['employee_code'] = Variable<String>(employeeCode);
    }
    return map;
  }

  EmployeeTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeeTableCompanion(
      id: Value(id),
      name: Value(name),
      pis: pis == null && nullToAbsent ? const Value.absent() : Value(pis),
      cpfNumber: Value(cpfNumber),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
      companyId: Value(companyId),
      nfcCode: nfcCode == null && nullToAbsent
          ? const Value.absent()
          : Value(nfcCode),
      employeeType: Value(employeeType),
      registrationNumber: registrationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationNumber),
      arpId:
          arpId == null && nullToAbsent ? const Value.absent() : Value(arpId),
      enable:
          enable == null && nullToAbsent ? const Value.absent() : Value(enable),
      faceRegistered: faceRegistered == null && nullToAbsent
          ? const Value.absent()
          : Value(faceRegistered),
      employeeCode: employeeCode == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeCode),
    );
  }

  factory EmployeeTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      pis: serializer.fromJson<String?>(json['pis']),
      cpfNumber: serializer.fromJson<String>(json['cpfNumber']),
      mail: serializer.fromJson<String?>(json['mail']),
      companyId: serializer.fromJson<String>(json['companyId']),
      nfcCode: serializer.fromJson<String?>(json['nfcCode']),
      employeeType: serializer.fromJson<String>(json['employeeType']),
      registrationNumber:
          serializer.fromJson<String?>(json['registrationNumber']),
      arpId: serializer.fromJson<String?>(json['arpId']),
      enable: serializer.fromJson<bool?>(json['enable']),
      faceRegistered: serializer.fromJson<String?>(json['faceRegistered']),
      employeeCode: serializer.fromJson<String?>(json['employeeCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'pis': serializer.toJson<String?>(pis),
      'cpfNumber': serializer.toJson<String>(cpfNumber),
      'mail': serializer.toJson<String?>(mail),
      'companyId': serializer.toJson<String>(companyId),
      'nfcCode': serializer.toJson<String?>(nfcCode),
      'employeeType': serializer.toJson<String>(employeeType),
      'registrationNumber': serializer.toJson<String?>(registrationNumber),
      'arpId': serializer.toJson<String?>(arpId),
      'enable': serializer.toJson<bool?>(enable),
      'faceRegistered': serializer.toJson<String?>(faceRegistered),
      'employeeCode': serializer.toJson<String?>(employeeCode),
    };
  }

  EmployeeTableData copyWith(
          {String? id,
          String? name,
          Value<String?> pis = const Value.absent(),
          String? cpfNumber,
          Value<String?> mail = const Value.absent(),
          String? companyId,
          Value<String?> nfcCode = const Value.absent(),
          String? employeeType,
          Value<String?> registrationNumber = const Value.absent(),
          Value<String?> arpId = const Value.absent(),
          Value<bool?> enable = const Value.absent(),
          Value<String?> faceRegistered = const Value.absent(),
          Value<String?> employeeCode = const Value.absent()}) =>
      EmployeeTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        pis: pis.present ? pis.value : this.pis,
        cpfNumber: cpfNumber ?? this.cpfNumber,
        mail: mail.present ? mail.value : this.mail,
        companyId: companyId ?? this.companyId,
        nfcCode: nfcCode.present ? nfcCode.value : this.nfcCode,
        employeeType: employeeType ?? this.employeeType,
        registrationNumber: registrationNumber.present
            ? registrationNumber.value
            : this.registrationNumber,
        arpId: arpId.present ? arpId.value : this.arpId,
        enable: enable.present ? enable.value : this.enable,
        faceRegistered:
            faceRegistered.present ? faceRegistered.value : this.faceRegistered,
        employeeCode:
            employeeCode.present ? employeeCode.value : this.employeeCode,
      );
  EmployeeTableData copyWithCompanion(EmployeeTableCompanion data) {
    return EmployeeTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      pis: data.pis.present ? data.pis.value : this.pis,
      cpfNumber: data.cpfNumber.present ? data.cpfNumber.value : this.cpfNumber,
      mail: data.mail.present ? data.mail.value : this.mail,
      companyId: data.companyId.present ? data.companyId.value : this.companyId,
      nfcCode: data.nfcCode.present ? data.nfcCode.value : this.nfcCode,
      employeeType: data.employeeType.present
          ? data.employeeType.value
          : this.employeeType,
      registrationNumber: data.registrationNumber.present
          ? data.registrationNumber.value
          : this.registrationNumber,
      arpId: data.arpId.present ? data.arpId.value : this.arpId,
      enable: data.enable.present ? data.enable.value : this.enable,
      faceRegistered: data.faceRegistered.present
          ? data.faceRegistered.value
          : this.faceRegistered,
      employeeCode: data.employeeCode.present
          ? data.employeeCode.value
          : this.employeeCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pis: $pis, ')
          ..write('cpfNumber: $cpfNumber, ')
          ..write('mail: $mail, ')
          ..write('companyId: $companyId, ')
          ..write('nfcCode: $nfcCode, ')
          ..write('employeeType: $employeeType, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('arpId: $arpId, ')
          ..write('enable: $enable, ')
          ..write('faceRegistered: $faceRegistered, ')
          ..write('employeeCode: $employeeCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      pis,
      cpfNumber,
      mail,
      companyId,
      nfcCode,
      employeeType,
      registrationNumber,
      arpId,
      enable,
      faceRegistered,
      employeeCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.pis == this.pis &&
          other.cpfNumber == this.cpfNumber &&
          other.mail == this.mail &&
          other.companyId == this.companyId &&
          other.nfcCode == this.nfcCode &&
          other.employeeType == this.employeeType &&
          other.registrationNumber == this.registrationNumber &&
          other.arpId == this.arpId &&
          other.enable == this.enable &&
          other.faceRegistered == this.faceRegistered &&
          other.employeeCode == this.employeeCode);
}

class EmployeeTableCompanion extends UpdateCompanion<EmployeeTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> pis;
  final Value<String> cpfNumber;
  final Value<String?> mail;
  final Value<String> companyId;
  final Value<String?> nfcCode;
  final Value<String> employeeType;
  final Value<String?> registrationNumber;
  final Value<String?> arpId;
  final Value<bool?> enable;
  final Value<String?> faceRegistered;
  final Value<String?> employeeCode;
  final Value<int> rowid;
  const EmployeeTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.pis = const Value.absent(),
    this.cpfNumber = const Value.absent(),
    this.mail = const Value.absent(),
    this.companyId = const Value.absent(),
    this.nfcCode = const Value.absent(),
    this.employeeType = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.arpId = const Value.absent(),
    this.enable = const Value.absent(),
    this.faceRegistered = const Value.absent(),
    this.employeeCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeeTableCompanion.insert({
    required String id,
    required String name,
    this.pis = const Value.absent(),
    required String cpfNumber,
    this.mail = const Value.absent(),
    required String companyId,
    this.nfcCode = const Value.absent(),
    required String employeeType,
    this.registrationNumber = const Value.absent(),
    this.arpId = const Value.absent(),
    this.enable = const Value.absent(),
    this.faceRegistered = const Value.absent(),
    this.employeeCode = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        cpfNumber = Value(cpfNumber),
        companyId = Value(companyId),
        employeeType = Value(employeeType);
  static Insertable<EmployeeTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? pis,
    Expression<String>? cpfNumber,
    Expression<String>? mail,
    Expression<String>? companyId,
    Expression<String>? nfcCode,
    Expression<String>? employeeType,
    Expression<String>? registrationNumber,
    Expression<String>? arpId,
    Expression<bool>? enable,
    Expression<String>? faceRegistered,
    Expression<String>? employeeCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (pis != null) 'pis': pis,
      if (cpfNumber != null) 'cpf_number': cpfNumber,
      if (mail != null) 'mail': mail,
      if (companyId != null) 'company_id': companyId,
      if (nfcCode != null) 'nfc_code': nfcCode,
      if (employeeType != null) 'employee_type': employeeType,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (arpId != null) 'arp_id': arpId,
      if (enable != null) 'enable': enable,
      if (faceRegistered != null) 'face_registered': faceRegistered,
      if (employeeCode != null) 'employee_code': employeeCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeeTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? pis,
      Value<String>? cpfNumber,
      Value<String?>? mail,
      Value<String>? companyId,
      Value<String?>? nfcCode,
      Value<String>? employeeType,
      Value<String?>? registrationNumber,
      Value<String?>? arpId,
      Value<bool?>? enable,
      Value<String?>? faceRegistered,
      Value<String?>? employeeCode,
      Value<int>? rowid}) {
    return EmployeeTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      pis: pis ?? this.pis,
      cpfNumber: cpfNumber ?? this.cpfNumber,
      mail: mail ?? this.mail,
      companyId: companyId ?? this.companyId,
      nfcCode: nfcCode ?? this.nfcCode,
      employeeType: employeeType ?? this.employeeType,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      arpId: arpId ?? this.arpId,
      enable: enable ?? this.enable,
      faceRegistered: faceRegistered ?? this.faceRegistered,
      employeeCode: employeeCode ?? this.employeeCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (pis.present) {
      map['pis'] = Variable<String>(pis.value);
    }
    if (cpfNumber.present) {
      map['cpf_number'] = Variable<String>(cpfNumber.value);
    }
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    if (companyId.present) {
      map['company_id'] = Variable<String>(companyId.value);
    }
    if (nfcCode.present) {
      map['nfc_code'] = Variable<String>(nfcCode.value);
    }
    if (employeeType.present) {
      map['employee_type'] = Variable<String>(employeeType.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    if (arpId.present) {
      map['arp_id'] = Variable<String>(arpId.value);
    }
    if (enable.present) {
      map['enable'] = Variable<bool>(enable.value);
    }
    if (faceRegistered.present) {
      map['face_registered'] = Variable<String>(faceRegistered.value);
    }
    if (employeeCode.present) {
      map['employee_code'] = Variable<String>(employeeCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('pis: $pis, ')
          ..write('cpfNumber: $cpfNumber, ')
          ..write('mail: $mail, ')
          ..write('companyId: $companyId, ')
          ..write('nfcCode: $nfcCode, ')
          ..write('employeeType: $employeeType, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('arpId: $arpId, ')
          ..write('enable: $enable, ')
          ..write('faceRegistered: $faceRegistered, ')
          ..write('employeeCode: $employeeCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ConfigurationTableTable extends ConfigurationTable
    with TableInfo<$ConfigurationTableTable, ConfigurationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConfigurationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _onlyOnlineMeta =
      const VerificationMeta('onlyOnline');
  @override
  late final GeneratedColumn<bool> onlyOnline = GeneratedColumn<bool>(
      'only_online', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("only_online" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _operationModeMeta =
      const VerificationMeta('operationMode');
  @override
  late final GeneratedColumn<String> operationMode = GeneratedColumn<String>(
      'operation_mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _takePhotoMeta =
      const VerificationMeta('takePhoto');
  @override
  late final GeneratedColumn<bool> takePhoto = GeneratedColumn<bool>(
      'take_photo', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("take_photo" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _allowChangeTimeMeta =
      const VerificationMeta('allowChangeTime');
  @override
  late final GeneratedColumn<bool> allowChangeTime = GeneratedColumn<bool>(
      'allow_change_time', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_change_time" IN (0, 1))'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  static const VerificationMeta _faceRecognitionMeta =
      const VerificationMeta('faceRecognition');
  @override
  late final GeneratedColumn<bool> faceRecognition = GeneratedColumn<bool>(
      'face_recognition', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("face_recognition" IN (0, 1))'));
  static const VerificationMeta _overnightMeta =
      const VerificationMeta('overnight');
  @override
  late final GeneratedColumn<bool> overnight = GeneratedColumn<bool>(
      'overnight', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("overnight" IN (0, 1))'));
  static const VerificationMeta _controlOvernightMeta =
      const VerificationMeta('controlOvernight');
  @override
  late final GeneratedColumn<bool> controlOvernight = GeneratedColumn<bool>(
      'control_overnight', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("control_overnight" IN (0, 1))'));
  static const VerificationMeta _gpsMeta = const VerificationMeta('gps');
  @override
  late final GeneratedColumn<bool> gps = GeneratedColumn<bool>(
      'gps', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("gps" IN (0, 1))'));
  static const VerificationMeta _deviceAuthorizationTypeMeta =
      const VerificationMeta('deviceAuthorizationType');
  @override
  late final GeneratedColumn<bool> deviceAuthorizationType =
      GeneratedColumn<bool>('device_authorization_type', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("device_authorization_type" IN (0, 1))'));
  static const VerificationMeta _allowDrivingTimeMeta =
      const VerificationMeta('allowDrivingTime');
  @override
  late final GeneratedColumn<bool> allowDrivingTime = GeneratedColumn<bool>(
      'allow_driving_time', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_driving_time" IN (0, 1))'));
  static const VerificationMeta _allowGpoOnAppMeta =
      const VerificationMeta('allowGpoOnApp');
  @override
  late final GeneratedColumn<bool> allowGpoOnApp = GeneratedColumn<bool>(
      'allow_gpo_on_app', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_gpo_on_app" IN (0, 1))'));
  static const VerificationMeta _exportNotCheckedMeta =
      const VerificationMeta('exportNotChecked');
  @override
  late final GeneratedColumn<bool> exportNotChecked = GeneratedColumn<bool>(
      'export_not_checked', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("export_not_checked" IN (0, 1))'));
  static const VerificationMeta _insightOutOfBoundMeta =
      const VerificationMeta('insightOutOfBound');
  @override
  late final GeneratedColumn<String> insightOutOfBound =
      GeneratedColumn<String>('insight_out_of_bound', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _openExternalBrowserMeta =
      const VerificationMeta('openExternalBrowser');
  @override
  late final GeneratedColumn<bool> openExternalBrowser = GeneratedColumn<bool>(
      'open_external_browser', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("open_external_browser" IN (0, 1))'));
  static const VerificationMeta _allowUseMeta =
      const VerificationMeta('allowUse');
  @override
  late final GeneratedColumn<bool> allowUse = GeneratedColumn<bool>(
      'allow_use', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("allow_use" IN (0, 1))'));
  static const VerificationMeta _externalControlTimezoneMeta =
      const VerificationMeta('externalControlTimezone');
  @override
  late final GeneratedColumn<bool> externalControlTimezone =
      GeneratedColumn<bool>('external_control_timezone', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("external_control_timezone" IN (0, 1))'));
  static const VerificationMeta _nfcModeMeta =
      const VerificationMeta('nfcMode');
  @override
  late final GeneratedColumn<bool> nfcMode = GeneratedColumn<bool>(
      'nfc_mode', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("nfc_mode" IN (0, 1))'));
  static const VerificationMeta _takePhotoNfcMeta =
      const VerificationMeta('takePhotoNfc');
  @override
  late final GeneratedColumn<bool> takePhotoNfc = GeneratedColumn<bool>(
      'take_photo_nfc', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_nfc" IN (0, 1))'));
  static const VerificationMeta _takePhotoSingleMeta =
      const VerificationMeta('takePhotoSingle');
  @override
  late final GeneratedColumn<bool> takePhotoSingle = GeneratedColumn<bool>(
      'take_photo_single', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_single" IN (0, 1))'));
  static const VerificationMeta _takePhotoDriverMeta =
      const VerificationMeta('takePhotoDriver');
  @override
  late final GeneratedColumn<bool> takePhotoDriver = GeneratedColumn<bool>(
      'take_photo_driver', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_driver" IN (0, 1))'));
  static const VerificationMeta _takePhotoQrcodeMeta =
      const VerificationMeta('takePhotoQrcode');
  @override
  late final GeneratedColumn<bool> takePhotoQrcode = GeneratedColumn<bool>(
      'take_photo_qrcode', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_qrcode" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        onlyOnline,
        operationMode,
        timezone,
        takePhoto,
        allowChangeTime,
        username,
        employeeId,
        faceRecognition,
        overnight,
        controlOvernight,
        gps,
        deviceAuthorizationType,
        allowDrivingTime,
        allowGpoOnApp,
        exportNotChecked,
        insightOutOfBound,
        openExternalBrowser,
        allowUse,
        externalControlTimezone,
        nfcMode,
        takePhotoNfc,
        takePhotoSingle,
        takePhotoDriver,
        takePhotoQrcode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'configuration_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ConfigurationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('only_online')) {
      context.handle(
          _onlyOnlineMeta,
          onlyOnline.isAcceptableOrUnknown(
              data['only_online']!, _onlyOnlineMeta));
    }
    if (data.containsKey('operation_mode')) {
      context.handle(
          _operationModeMeta,
          operationMode.isAcceptableOrUnknown(
              data['operation_mode']!, _operationModeMeta));
    } else if (isInserting) {
      context.missing(_operationModeMeta);
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    } else if (isInserting) {
      context.missing(_timezoneMeta);
    }
    if (data.containsKey('take_photo')) {
      context.handle(_takePhotoMeta,
          takePhoto.isAcceptableOrUnknown(data['take_photo']!, _takePhotoMeta));
    }
    if (data.containsKey('allow_change_time')) {
      context.handle(
          _allowChangeTimeMeta,
          allowChangeTime.isAcceptableOrUnknown(
              data['allow_change_time']!, _allowChangeTimeMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('face_recognition')) {
      context.handle(
          _faceRecognitionMeta,
          faceRecognition.isAcceptableOrUnknown(
              data['face_recognition']!, _faceRecognitionMeta));
    }
    if (data.containsKey('overnight')) {
      context.handle(_overnightMeta,
          overnight.isAcceptableOrUnknown(data['overnight']!, _overnightMeta));
    }
    if (data.containsKey('control_overnight')) {
      context.handle(
          _controlOvernightMeta,
          controlOvernight.isAcceptableOrUnknown(
              data['control_overnight']!, _controlOvernightMeta));
    }
    if (data.containsKey('gps')) {
      context.handle(
          _gpsMeta, gps.isAcceptableOrUnknown(data['gps']!, _gpsMeta));
    }
    if (data.containsKey('device_authorization_type')) {
      context.handle(
          _deviceAuthorizationTypeMeta,
          deviceAuthorizationType.isAcceptableOrUnknown(
              data['device_authorization_type']!,
              _deviceAuthorizationTypeMeta));
    }
    if (data.containsKey('allow_driving_time')) {
      context.handle(
          _allowDrivingTimeMeta,
          allowDrivingTime.isAcceptableOrUnknown(
              data['allow_driving_time']!, _allowDrivingTimeMeta));
    }
    if (data.containsKey('allow_gpo_on_app')) {
      context.handle(
          _allowGpoOnAppMeta,
          allowGpoOnApp.isAcceptableOrUnknown(
              data['allow_gpo_on_app']!, _allowGpoOnAppMeta));
    }
    if (data.containsKey('export_not_checked')) {
      context.handle(
          _exportNotCheckedMeta,
          exportNotChecked.isAcceptableOrUnknown(
              data['export_not_checked']!, _exportNotCheckedMeta));
    }
    if (data.containsKey('insight_out_of_bound')) {
      context.handle(
          _insightOutOfBoundMeta,
          insightOutOfBound.isAcceptableOrUnknown(
              data['insight_out_of_bound']!, _insightOutOfBoundMeta));
    }
    if (data.containsKey('open_external_browser')) {
      context.handle(
          _openExternalBrowserMeta,
          openExternalBrowser.isAcceptableOrUnknown(
              data['open_external_browser']!, _openExternalBrowserMeta));
    }
    if (data.containsKey('allow_use')) {
      context.handle(_allowUseMeta,
          allowUse.isAcceptableOrUnknown(data['allow_use']!, _allowUseMeta));
    }
    if (data.containsKey('external_control_timezone')) {
      context.handle(
          _externalControlTimezoneMeta,
          externalControlTimezone.isAcceptableOrUnknown(
              data['external_control_timezone']!,
              _externalControlTimezoneMeta));
    }
    if (data.containsKey('nfc_mode')) {
      context.handle(_nfcModeMeta,
          nfcMode.isAcceptableOrUnknown(data['nfc_mode']!, _nfcModeMeta));
    }
    if (data.containsKey('take_photo_nfc')) {
      context.handle(
          _takePhotoNfcMeta,
          takePhotoNfc.isAcceptableOrUnknown(
              data['take_photo_nfc']!, _takePhotoNfcMeta));
    }
    if (data.containsKey('take_photo_single')) {
      context.handle(
          _takePhotoSingleMeta,
          takePhotoSingle.isAcceptableOrUnknown(
              data['take_photo_single']!, _takePhotoSingleMeta));
    }
    if (data.containsKey('take_photo_driver')) {
      context.handle(
          _takePhotoDriverMeta,
          takePhotoDriver.isAcceptableOrUnknown(
              data['take_photo_driver']!, _takePhotoDriverMeta));
    }
    if (data.containsKey('take_photo_qrcode')) {
      context.handle(
          _takePhotoQrcodeMeta,
          takePhotoQrcode.isAcceptableOrUnknown(
              data['take_photo_qrcode']!, _takePhotoQrcodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  ConfigurationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConfigurationTableData(
      onlyOnline: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}only_online'])!,
      operationMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_mode'])!,
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone'])!,
      takePhoto: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo'])!,
      allowChangeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_change_time']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      faceRecognition: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}face_recognition']),
      overnight: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}overnight']),
      controlOvernight: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}control_overnight']),
      gps: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gps']),
      deviceAuthorizationType: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}device_authorization_type']),
      allowDrivingTime: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}allow_driving_time']),
      allowGpoOnApp: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_gpo_on_app']),
      exportNotChecked: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}export_not_checked']),
      insightOutOfBound: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}insight_out_of_bound']),
      openExternalBrowser: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}open_external_browser']),
      allowUse: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_use']),
      externalControlTimezone: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}external_control_timezone']),
      nfcMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}nfc_mode']),
      takePhotoNfc: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_nfc']),
      takePhotoSingle: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_single']),
      takePhotoDriver: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_driver']),
      takePhotoQrcode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_qrcode']),
    );
  }

  @override
  $ConfigurationTableTable createAlias(String alias) {
    return $ConfigurationTableTable(attachedDatabase, alias);
  }
}

class ConfigurationTableData extends DataClass
    implements Insertable<ConfigurationTableData> {
  final bool onlyOnline;
  final String operationMode;
  final String timezone;
  final bool takePhoto;
  final bool? allowChangeTime;
  final String? username;
  final String employeeId;
  final bool? faceRecognition;
  final bool? overnight;
  final bool? controlOvernight;
  final bool? gps;
  final bool? deviceAuthorizationType;
  final bool? allowDrivingTime;
  final bool? allowGpoOnApp;
  final bool? exportNotChecked;
  final String? insightOutOfBound;
  final bool? openExternalBrowser;
  final bool? allowUse;
  final bool? externalControlTimezone;
  final bool? nfcMode;
  final bool? takePhotoNfc;
  final bool? takePhotoSingle;
  final bool? takePhotoDriver;
  final bool? takePhotoQrcode;
  const ConfigurationTableData(
      {required this.onlyOnline,
      required this.operationMode,
      required this.timezone,
      required this.takePhoto,
      this.allowChangeTime,
      this.username,
      required this.employeeId,
      this.faceRecognition,
      this.overnight,
      this.controlOvernight,
      this.gps,
      this.deviceAuthorizationType,
      this.allowDrivingTime,
      this.allowGpoOnApp,
      this.exportNotChecked,
      this.insightOutOfBound,
      this.openExternalBrowser,
      this.allowUse,
      this.externalControlTimezone,
      this.nfcMode,
      this.takePhotoNfc,
      this.takePhotoSingle,
      this.takePhotoDriver,
      this.takePhotoQrcode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['only_online'] = Variable<bool>(onlyOnline);
    map['operation_mode'] = Variable<String>(operationMode);
    map['timezone'] = Variable<String>(timezone);
    map['take_photo'] = Variable<bool>(takePhoto);
    if (!nullToAbsent || allowChangeTime != null) {
      map['allow_change_time'] = Variable<bool>(allowChangeTime);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['employee_id'] = Variable<String>(employeeId);
    if (!nullToAbsent || faceRecognition != null) {
      map['face_recognition'] = Variable<bool>(faceRecognition);
    }
    if (!nullToAbsent || overnight != null) {
      map['overnight'] = Variable<bool>(overnight);
    }
    if (!nullToAbsent || controlOvernight != null) {
      map['control_overnight'] = Variable<bool>(controlOvernight);
    }
    if (!nullToAbsent || gps != null) {
      map['gps'] = Variable<bool>(gps);
    }
    if (!nullToAbsent || deviceAuthorizationType != null) {
      map['device_authorization_type'] =
          Variable<bool>(deviceAuthorizationType);
    }
    if (!nullToAbsent || allowDrivingTime != null) {
      map['allow_driving_time'] = Variable<bool>(allowDrivingTime);
    }
    if (!nullToAbsent || allowGpoOnApp != null) {
      map['allow_gpo_on_app'] = Variable<bool>(allowGpoOnApp);
    }
    if (!nullToAbsent || exportNotChecked != null) {
      map['export_not_checked'] = Variable<bool>(exportNotChecked);
    }
    if (!nullToAbsent || insightOutOfBound != null) {
      map['insight_out_of_bound'] = Variable<String>(insightOutOfBound);
    }
    if (!nullToAbsent || openExternalBrowser != null) {
      map['open_external_browser'] = Variable<bool>(openExternalBrowser);
    }
    if (!nullToAbsent || allowUse != null) {
      map['allow_use'] = Variable<bool>(allowUse);
    }
    if (!nullToAbsent || externalControlTimezone != null) {
      map['external_control_timezone'] =
          Variable<bool>(externalControlTimezone);
    }
    if (!nullToAbsent || nfcMode != null) {
      map['nfc_mode'] = Variable<bool>(nfcMode);
    }
    if (!nullToAbsent || takePhotoNfc != null) {
      map['take_photo_nfc'] = Variable<bool>(takePhotoNfc);
    }
    if (!nullToAbsent || takePhotoSingle != null) {
      map['take_photo_single'] = Variable<bool>(takePhotoSingle);
    }
    if (!nullToAbsent || takePhotoDriver != null) {
      map['take_photo_driver'] = Variable<bool>(takePhotoDriver);
    }
    if (!nullToAbsent || takePhotoQrcode != null) {
      map['take_photo_qrcode'] = Variable<bool>(takePhotoQrcode);
    }
    return map;
  }

  ConfigurationTableCompanion toCompanion(bool nullToAbsent) {
    return ConfigurationTableCompanion(
      onlyOnline: Value(onlyOnline),
      operationMode: Value(operationMode),
      timezone: Value(timezone),
      takePhoto: Value(takePhoto),
      allowChangeTime: allowChangeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(allowChangeTime),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      employeeId: Value(employeeId),
      faceRecognition: faceRecognition == null && nullToAbsent
          ? const Value.absent()
          : Value(faceRecognition),
      overnight: overnight == null && nullToAbsent
          ? const Value.absent()
          : Value(overnight),
      controlOvernight: controlOvernight == null && nullToAbsent
          ? const Value.absent()
          : Value(controlOvernight),
      gps: gps == null && nullToAbsent ? const Value.absent() : Value(gps),
      deviceAuthorizationType: deviceAuthorizationType == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceAuthorizationType),
      allowDrivingTime: allowDrivingTime == null && nullToAbsent
          ? const Value.absent()
          : Value(allowDrivingTime),
      allowGpoOnApp: allowGpoOnApp == null && nullToAbsent
          ? const Value.absent()
          : Value(allowGpoOnApp),
      exportNotChecked: exportNotChecked == null && nullToAbsent
          ? const Value.absent()
          : Value(exportNotChecked),
      insightOutOfBound: insightOutOfBound == null && nullToAbsent
          ? const Value.absent()
          : Value(insightOutOfBound),
      openExternalBrowser: openExternalBrowser == null && nullToAbsent
          ? const Value.absent()
          : Value(openExternalBrowser),
      allowUse: allowUse == null && nullToAbsent
          ? const Value.absent()
          : Value(allowUse),
      externalControlTimezone: externalControlTimezone == null && nullToAbsent
          ? const Value.absent()
          : Value(externalControlTimezone),
      nfcMode: nfcMode == null && nullToAbsent
          ? const Value.absent()
          : Value(nfcMode),
      takePhotoNfc: takePhotoNfc == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoNfc),
      takePhotoSingle: takePhotoSingle == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoSingle),
      takePhotoDriver: takePhotoDriver == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoDriver),
      takePhotoQrcode: takePhotoQrcode == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoQrcode),
    );
  }

  factory ConfigurationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConfigurationTableData(
      onlyOnline: serializer.fromJson<bool>(json['onlyOnline']),
      operationMode: serializer.fromJson<String>(json['operationMode']),
      timezone: serializer.fromJson<String>(json['timezone']),
      takePhoto: serializer.fromJson<bool>(json['takePhoto']),
      allowChangeTime: serializer.fromJson<bool?>(json['allowChangeTime']),
      username: serializer.fromJson<String?>(json['username']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      faceRecognition: serializer.fromJson<bool?>(json['faceRecognition']),
      overnight: serializer.fromJson<bool?>(json['overnight']),
      controlOvernight: serializer.fromJson<bool?>(json['controlOvernight']),
      gps: serializer.fromJson<bool?>(json['gps']),
      deviceAuthorizationType:
          serializer.fromJson<bool?>(json['deviceAuthorizationType']),
      allowDrivingTime: serializer.fromJson<bool?>(json['allowDrivingTime']),
      allowGpoOnApp: serializer.fromJson<bool?>(json['allowGpoOnApp']),
      exportNotChecked: serializer.fromJson<bool?>(json['exportNotChecked']),
      insightOutOfBound:
          serializer.fromJson<String?>(json['insightOutOfBound']),
      openExternalBrowser:
          serializer.fromJson<bool?>(json['openExternalBrowser']),
      allowUse: serializer.fromJson<bool?>(json['allowUse']),
      externalControlTimezone:
          serializer.fromJson<bool?>(json['externalControlTimezone']),
      nfcMode: serializer.fromJson<bool?>(json['nfcMode']),
      takePhotoNfc: serializer.fromJson<bool?>(json['takePhotoNfc']),
      takePhotoSingle: serializer.fromJson<bool?>(json['takePhotoSingle']),
      takePhotoDriver: serializer.fromJson<bool?>(json['takePhotoDriver']),
      takePhotoQrcode: serializer.fromJson<bool?>(json['takePhotoQrcode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'onlyOnline': serializer.toJson<bool>(onlyOnline),
      'operationMode': serializer.toJson<String>(operationMode),
      'timezone': serializer.toJson<String>(timezone),
      'takePhoto': serializer.toJson<bool>(takePhoto),
      'allowChangeTime': serializer.toJson<bool?>(allowChangeTime),
      'username': serializer.toJson<String?>(username),
      'employeeId': serializer.toJson<String>(employeeId),
      'faceRecognition': serializer.toJson<bool?>(faceRecognition),
      'overnight': serializer.toJson<bool?>(overnight),
      'controlOvernight': serializer.toJson<bool?>(controlOvernight),
      'gps': serializer.toJson<bool?>(gps),
      'deviceAuthorizationType':
          serializer.toJson<bool?>(deviceAuthorizationType),
      'allowDrivingTime': serializer.toJson<bool?>(allowDrivingTime),
      'allowGpoOnApp': serializer.toJson<bool?>(allowGpoOnApp),
      'exportNotChecked': serializer.toJson<bool?>(exportNotChecked),
      'insightOutOfBound': serializer.toJson<String?>(insightOutOfBound),
      'openExternalBrowser': serializer.toJson<bool?>(openExternalBrowser),
      'allowUse': serializer.toJson<bool?>(allowUse),
      'externalControlTimezone':
          serializer.toJson<bool?>(externalControlTimezone),
      'nfcMode': serializer.toJson<bool?>(nfcMode),
      'takePhotoNfc': serializer.toJson<bool?>(takePhotoNfc),
      'takePhotoSingle': serializer.toJson<bool?>(takePhotoSingle),
      'takePhotoDriver': serializer.toJson<bool?>(takePhotoDriver),
      'takePhotoQrcode': serializer.toJson<bool?>(takePhotoQrcode),
    };
  }

  ConfigurationTableData copyWith(
          {bool? onlyOnline,
          String? operationMode,
          String? timezone,
          bool? takePhoto,
          Value<bool?> allowChangeTime = const Value.absent(),
          Value<String?> username = const Value.absent(),
          String? employeeId,
          Value<bool?> faceRecognition = const Value.absent(),
          Value<bool?> overnight = const Value.absent(),
          Value<bool?> controlOvernight = const Value.absent(),
          Value<bool?> gps = const Value.absent(),
          Value<bool?> deviceAuthorizationType = const Value.absent(),
          Value<bool?> allowDrivingTime = const Value.absent(),
          Value<bool?> allowGpoOnApp = const Value.absent(),
          Value<bool?> exportNotChecked = const Value.absent(),
          Value<String?> insightOutOfBound = const Value.absent(),
          Value<bool?> openExternalBrowser = const Value.absent(),
          Value<bool?> allowUse = const Value.absent(),
          Value<bool?> externalControlTimezone = const Value.absent(),
          Value<bool?> nfcMode = const Value.absent(),
          Value<bool?> takePhotoNfc = const Value.absent(),
          Value<bool?> takePhotoSingle = const Value.absent(),
          Value<bool?> takePhotoDriver = const Value.absent(),
          Value<bool?> takePhotoQrcode = const Value.absent()}) =>
      ConfigurationTableData(
        onlyOnline: onlyOnline ?? this.onlyOnline,
        operationMode: operationMode ?? this.operationMode,
        timezone: timezone ?? this.timezone,
        takePhoto: takePhoto ?? this.takePhoto,
        allowChangeTime: allowChangeTime.present
            ? allowChangeTime.value
            : this.allowChangeTime,
        username: username.present ? username.value : this.username,
        employeeId: employeeId ?? this.employeeId,
        faceRecognition: faceRecognition.present
            ? faceRecognition.value
            : this.faceRecognition,
        overnight: overnight.present ? overnight.value : this.overnight,
        controlOvernight: controlOvernight.present
            ? controlOvernight.value
            : this.controlOvernight,
        gps: gps.present ? gps.value : this.gps,
        deviceAuthorizationType: deviceAuthorizationType.present
            ? deviceAuthorizationType.value
            : this.deviceAuthorizationType,
        allowDrivingTime: allowDrivingTime.present
            ? allowDrivingTime.value
            : this.allowDrivingTime,
        allowGpoOnApp:
            allowGpoOnApp.present ? allowGpoOnApp.value : this.allowGpoOnApp,
        exportNotChecked: exportNotChecked.present
            ? exportNotChecked.value
            : this.exportNotChecked,
        insightOutOfBound: insightOutOfBound.present
            ? insightOutOfBound.value
            : this.insightOutOfBound,
        openExternalBrowser: openExternalBrowser.present
            ? openExternalBrowser.value
            : this.openExternalBrowser,
        allowUse: allowUse.present ? allowUse.value : this.allowUse,
        externalControlTimezone: externalControlTimezone.present
            ? externalControlTimezone.value
            : this.externalControlTimezone,
        nfcMode: nfcMode.present ? nfcMode.value : this.nfcMode,
        takePhotoNfc:
            takePhotoNfc.present ? takePhotoNfc.value : this.takePhotoNfc,
        takePhotoSingle: takePhotoSingle.present
            ? takePhotoSingle.value
            : this.takePhotoSingle,
        takePhotoDriver: takePhotoDriver.present
            ? takePhotoDriver.value
            : this.takePhotoDriver,
        takePhotoQrcode: takePhotoQrcode.present
            ? takePhotoQrcode.value
            : this.takePhotoQrcode,
      );
  ConfigurationTableData copyWithCompanion(ConfigurationTableCompanion data) {
    return ConfigurationTableData(
      onlyOnline:
          data.onlyOnline.present ? data.onlyOnline.value : this.onlyOnline,
      operationMode: data.operationMode.present
          ? data.operationMode.value
          : this.operationMode,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      takePhoto: data.takePhoto.present ? data.takePhoto.value : this.takePhoto,
      allowChangeTime: data.allowChangeTime.present
          ? data.allowChangeTime.value
          : this.allowChangeTime,
      username: data.username.present ? data.username.value : this.username,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      faceRecognition: data.faceRecognition.present
          ? data.faceRecognition.value
          : this.faceRecognition,
      overnight: data.overnight.present ? data.overnight.value : this.overnight,
      controlOvernight: data.controlOvernight.present
          ? data.controlOvernight.value
          : this.controlOvernight,
      gps: data.gps.present ? data.gps.value : this.gps,
      deviceAuthorizationType: data.deviceAuthorizationType.present
          ? data.deviceAuthorizationType.value
          : this.deviceAuthorizationType,
      allowDrivingTime: data.allowDrivingTime.present
          ? data.allowDrivingTime.value
          : this.allowDrivingTime,
      allowGpoOnApp: data.allowGpoOnApp.present
          ? data.allowGpoOnApp.value
          : this.allowGpoOnApp,
      exportNotChecked: data.exportNotChecked.present
          ? data.exportNotChecked.value
          : this.exportNotChecked,
      insightOutOfBound: data.insightOutOfBound.present
          ? data.insightOutOfBound.value
          : this.insightOutOfBound,
      openExternalBrowser: data.openExternalBrowser.present
          ? data.openExternalBrowser.value
          : this.openExternalBrowser,
      allowUse: data.allowUse.present ? data.allowUse.value : this.allowUse,
      externalControlTimezone: data.externalControlTimezone.present
          ? data.externalControlTimezone.value
          : this.externalControlTimezone,
      nfcMode: data.nfcMode.present ? data.nfcMode.value : this.nfcMode,
      takePhotoNfc: data.takePhotoNfc.present
          ? data.takePhotoNfc.value
          : this.takePhotoNfc,
      takePhotoSingle: data.takePhotoSingle.present
          ? data.takePhotoSingle.value
          : this.takePhotoSingle,
      takePhotoDriver: data.takePhotoDriver.present
          ? data.takePhotoDriver.value
          : this.takePhotoDriver,
      takePhotoQrcode: data.takePhotoQrcode.present
          ? data.takePhotoQrcode.value
          : this.takePhotoQrcode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConfigurationTableData(')
          ..write('onlyOnline: $onlyOnline, ')
          ..write('operationMode: $operationMode, ')
          ..write('timezone: $timezone, ')
          ..write('takePhoto: $takePhoto, ')
          ..write('allowChangeTime: $allowChangeTime, ')
          ..write('username: $username, ')
          ..write('employeeId: $employeeId, ')
          ..write('faceRecognition: $faceRecognition, ')
          ..write('overnight: $overnight, ')
          ..write('controlOvernight: $controlOvernight, ')
          ..write('gps: $gps, ')
          ..write('deviceAuthorizationType: $deviceAuthorizationType, ')
          ..write('allowDrivingTime: $allowDrivingTime, ')
          ..write('allowGpoOnApp: $allowGpoOnApp, ')
          ..write('exportNotChecked: $exportNotChecked, ')
          ..write('insightOutOfBound: $insightOutOfBound, ')
          ..write('openExternalBrowser: $openExternalBrowser, ')
          ..write('allowUse: $allowUse, ')
          ..write('externalControlTimezone: $externalControlTimezone, ')
          ..write('nfcMode: $nfcMode, ')
          ..write('takePhotoNfc: $takePhotoNfc, ')
          ..write('takePhotoSingle: $takePhotoSingle, ')
          ..write('takePhotoDriver: $takePhotoDriver, ')
          ..write('takePhotoQrcode: $takePhotoQrcode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        onlyOnline,
        operationMode,
        timezone,
        takePhoto,
        allowChangeTime,
        username,
        employeeId,
        faceRecognition,
        overnight,
        controlOvernight,
        gps,
        deviceAuthorizationType,
        allowDrivingTime,
        allowGpoOnApp,
        exportNotChecked,
        insightOutOfBound,
        openExternalBrowser,
        allowUse,
        externalControlTimezone,
        nfcMode,
        takePhotoNfc,
        takePhotoSingle,
        takePhotoDriver,
        takePhotoQrcode
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConfigurationTableData &&
          other.onlyOnline == this.onlyOnline &&
          other.operationMode == this.operationMode &&
          other.timezone == this.timezone &&
          other.takePhoto == this.takePhoto &&
          other.allowChangeTime == this.allowChangeTime &&
          other.username == this.username &&
          other.employeeId == this.employeeId &&
          other.faceRecognition == this.faceRecognition &&
          other.overnight == this.overnight &&
          other.controlOvernight == this.controlOvernight &&
          other.gps == this.gps &&
          other.deviceAuthorizationType == this.deviceAuthorizationType &&
          other.allowDrivingTime == this.allowDrivingTime &&
          other.allowGpoOnApp == this.allowGpoOnApp &&
          other.exportNotChecked == this.exportNotChecked &&
          other.insightOutOfBound == this.insightOutOfBound &&
          other.openExternalBrowser == this.openExternalBrowser &&
          other.allowUse == this.allowUse &&
          other.externalControlTimezone == this.externalControlTimezone &&
          other.nfcMode == this.nfcMode &&
          other.takePhotoNfc == this.takePhotoNfc &&
          other.takePhotoSingle == this.takePhotoSingle &&
          other.takePhotoDriver == this.takePhotoDriver &&
          other.takePhotoQrcode == this.takePhotoQrcode);
}

class ConfigurationTableCompanion
    extends UpdateCompanion<ConfigurationTableData> {
  final Value<bool> onlyOnline;
  final Value<String> operationMode;
  final Value<String> timezone;
  final Value<bool> takePhoto;
  final Value<bool?> allowChangeTime;
  final Value<String?> username;
  final Value<String> employeeId;
  final Value<bool?> faceRecognition;
  final Value<bool?> overnight;
  final Value<bool?> controlOvernight;
  final Value<bool?> gps;
  final Value<bool?> deviceAuthorizationType;
  final Value<bool?> allowDrivingTime;
  final Value<bool?> allowGpoOnApp;
  final Value<bool?> exportNotChecked;
  final Value<String?> insightOutOfBound;
  final Value<bool?> openExternalBrowser;
  final Value<bool?> allowUse;
  final Value<bool?> externalControlTimezone;
  final Value<bool?> nfcMode;
  final Value<bool?> takePhotoNfc;
  final Value<bool?> takePhotoSingle;
  final Value<bool?> takePhotoDriver;
  final Value<bool?> takePhotoQrcode;
  final Value<int> rowid;
  const ConfigurationTableCompanion({
    this.onlyOnline = const Value.absent(),
    this.operationMode = const Value.absent(),
    this.timezone = const Value.absent(),
    this.takePhoto = const Value.absent(),
    this.allowChangeTime = const Value.absent(),
    this.username = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.faceRecognition = const Value.absent(),
    this.overnight = const Value.absent(),
    this.controlOvernight = const Value.absent(),
    this.gps = const Value.absent(),
    this.deviceAuthorizationType = const Value.absent(),
    this.allowDrivingTime = const Value.absent(),
    this.allowGpoOnApp = const Value.absent(),
    this.exportNotChecked = const Value.absent(),
    this.insightOutOfBound = const Value.absent(),
    this.openExternalBrowser = const Value.absent(),
    this.allowUse = const Value.absent(),
    this.externalControlTimezone = const Value.absent(),
    this.nfcMode = const Value.absent(),
    this.takePhotoNfc = const Value.absent(),
    this.takePhotoSingle = const Value.absent(),
    this.takePhotoDriver = const Value.absent(),
    this.takePhotoQrcode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ConfigurationTableCompanion.insert({
    this.onlyOnline = const Value.absent(),
    required String operationMode,
    required String timezone,
    this.takePhoto = const Value.absent(),
    this.allowChangeTime = const Value.absent(),
    this.username = const Value.absent(),
    required String employeeId,
    this.faceRecognition = const Value.absent(),
    this.overnight = const Value.absent(),
    this.controlOvernight = const Value.absent(),
    this.gps = const Value.absent(),
    this.deviceAuthorizationType = const Value.absent(),
    this.allowDrivingTime = const Value.absent(),
    this.allowGpoOnApp = const Value.absent(),
    this.exportNotChecked = const Value.absent(),
    this.insightOutOfBound = const Value.absent(),
    this.openExternalBrowser = const Value.absent(),
    this.allowUse = const Value.absent(),
    this.externalControlTimezone = const Value.absent(),
    this.nfcMode = const Value.absent(),
    this.takePhotoNfc = const Value.absent(),
    this.takePhotoSingle = const Value.absent(),
    this.takePhotoDriver = const Value.absent(),
    this.takePhotoQrcode = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : operationMode = Value(operationMode),
        timezone = Value(timezone),
        employeeId = Value(employeeId);
  static Insertable<ConfigurationTableData> custom({
    Expression<bool>? onlyOnline,
    Expression<String>? operationMode,
    Expression<String>? timezone,
    Expression<bool>? takePhoto,
    Expression<bool>? allowChangeTime,
    Expression<String>? username,
    Expression<String>? employeeId,
    Expression<bool>? faceRecognition,
    Expression<bool>? overnight,
    Expression<bool>? controlOvernight,
    Expression<bool>? gps,
    Expression<bool>? deviceAuthorizationType,
    Expression<bool>? allowDrivingTime,
    Expression<bool>? allowGpoOnApp,
    Expression<bool>? exportNotChecked,
    Expression<String>? insightOutOfBound,
    Expression<bool>? openExternalBrowser,
    Expression<bool>? allowUse,
    Expression<bool>? externalControlTimezone,
    Expression<bool>? nfcMode,
    Expression<bool>? takePhotoNfc,
    Expression<bool>? takePhotoSingle,
    Expression<bool>? takePhotoDriver,
    Expression<bool>? takePhotoQrcode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (onlyOnline != null) 'only_online': onlyOnline,
      if (operationMode != null) 'operation_mode': operationMode,
      if (timezone != null) 'timezone': timezone,
      if (takePhoto != null) 'take_photo': takePhoto,
      if (allowChangeTime != null) 'allow_change_time': allowChangeTime,
      if (username != null) 'username': username,
      if (employeeId != null) 'employee_id': employeeId,
      if (faceRecognition != null) 'face_recognition': faceRecognition,
      if (overnight != null) 'overnight': overnight,
      if (controlOvernight != null) 'control_overnight': controlOvernight,
      if (gps != null) 'gps': gps,
      if (deviceAuthorizationType != null)
        'device_authorization_type': deviceAuthorizationType,
      if (allowDrivingTime != null) 'allow_driving_time': allowDrivingTime,
      if (allowGpoOnApp != null) 'allow_gpo_on_app': allowGpoOnApp,
      if (exportNotChecked != null) 'export_not_checked': exportNotChecked,
      if (insightOutOfBound != null) 'insight_out_of_bound': insightOutOfBound,
      if (openExternalBrowser != null)
        'open_external_browser': openExternalBrowser,
      if (allowUse != null) 'allow_use': allowUse,
      if (externalControlTimezone != null)
        'external_control_timezone': externalControlTimezone,
      if (nfcMode != null) 'nfc_mode': nfcMode,
      if (takePhotoNfc != null) 'take_photo_nfc': takePhotoNfc,
      if (takePhotoSingle != null) 'take_photo_single': takePhotoSingle,
      if (takePhotoDriver != null) 'take_photo_driver': takePhotoDriver,
      if (takePhotoQrcode != null) 'take_photo_qrcode': takePhotoQrcode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ConfigurationTableCompanion copyWith(
      {Value<bool>? onlyOnline,
      Value<String>? operationMode,
      Value<String>? timezone,
      Value<bool>? takePhoto,
      Value<bool?>? allowChangeTime,
      Value<String?>? username,
      Value<String>? employeeId,
      Value<bool?>? faceRecognition,
      Value<bool?>? overnight,
      Value<bool?>? controlOvernight,
      Value<bool?>? gps,
      Value<bool?>? deviceAuthorizationType,
      Value<bool?>? allowDrivingTime,
      Value<bool?>? allowGpoOnApp,
      Value<bool?>? exportNotChecked,
      Value<String?>? insightOutOfBound,
      Value<bool?>? openExternalBrowser,
      Value<bool?>? allowUse,
      Value<bool?>? externalControlTimezone,
      Value<bool?>? nfcMode,
      Value<bool?>? takePhotoNfc,
      Value<bool?>? takePhotoSingle,
      Value<bool?>? takePhotoDriver,
      Value<bool?>? takePhotoQrcode,
      Value<int>? rowid}) {
    return ConfigurationTableCompanion(
      onlyOnline: onlyOnline ?? this.onlyOnline,
      operationMode: operationMode ?? this.operationMode,
      timezone: timezone ?? this.timezone,
      takePhoto: takePhoto ?? this.takePhoto,
      allowChangeTime: allowChangeTime ?? this.allowChangeTime,
      username: username ?? this.username,
      employeeId: employeeId ?? this.employeeId,
      faceRecognition: faceRecognition ?? this.faceRecognition,
      overnight: overnight ?? this.overnight,
      controlOvernight: controlOvernight ?? this.controlOvernight,
      gps: gps ?? this.gps,
      deviceAuthorizationType:
          deviceAuthorizationType ?? this.deviceAuthorizationType,
      allowDrivingTime: allowDrivingTime ?? this.allowDrivingTime,
      allowGpoOnApp: allowGpoOnApp ?? this.allowGpoOnApp,
      exportNotChecked: exportNotChecked ?? this.exportNotChecked,
      insightOutOfBound: insightOutOfBound ?? this.insightOutOfBound,
      openExternalBrowser: openExternalBrowser ?? this.openExternalBrowser,
      allowUse: allowUse ?? this.allowUse,
      externalControlTimezone:
          externalControlTimezone ?? this.externalControlTimezone,
      nfcMode: nfcMode ?? this.nfcMode,
      takePhotoNfc: takePhotoNfc ?? this.takePhotoNfc,
      takePhotoSingle: takePhotoSingle ?? this.takePhotoSingle,
      takePhotoDriver: takePhotoDriver ?? this.takePhotoDriver,
      takePhotoQrcode: takePhotoQrcode ?? this.takePhotoQrcode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (onlyOnline.present) {
      map['only_online'] = Variable<bool>(onlyOnline.value);
    }
    if (operationMode.present) {
      map['operation_mode'] = Variable<String>(operationMode.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (takePhoto.present) {
      map['take_photo'] = Variable<bool>(takePhoto.value);
    }
    if (allowChangeTime.present) {
      map['allow_change_time'] = Variable<bool>(allowChangeTime.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (faceRecognition.present) {
      map['face_recognition'] = Variable<bool>(faceRecognition.value);
    }
    if (overnight.present) {
      map['overnight'] = Variable<bool>(overnight.value);
    }
    if (controlOvernight.present) {
      map['control_overnight'] = Variable<bool>(controlOvernight.value);
    }
    if (gps.present) {
      map['gps'] = Variable<bool>(gps.value);
    }
    if (deviceAuthorizationType.present) {
      map['device_authorization_type'] =
          Variable<bool>(deviceAuthorizationType.value);
    }
    if (allowDrivingTime.present) {
      map['allow_driving_time'] = Variable<bool>(allowDrivingTime.value);
    }
    if (allowGpoOnApp.present) {
      map['allow_gpo_on_app'] = Variable<bool>(allowGpoOnApp.value);
    }
    if (exportNotChecked.present) {
      map['export_not_checked'] = Variable<bool>(exportNotChecked.value);
    }
    if (insightOutOfBound.present) {
      map['insight_out_of_bound'] = Variable<String>(insightOutOfBound.value);
    }
    if (openExternalBrowser.present) {
      map['open_external_browser'] = Variable<bool>(openExternalBrowser.value);
    }
    if (allowUse.present) {
      map['allow_use'] = Variable<bool>(allowUse.value);
    }
    if (externalControlTimezone.present) {
      map['external_control_timezone'] =
          Variable<bool>(externalControlTimezone.value);
    }
    if (nfcMode.present) {
      map['nfc_mode'] = Variable<bool>(nfcMode.value);
    }
    if (takePhotoNfc.present) {
      map['take_photo_nfc'] = Variable<bool>(takePhotoNfc.value);
    }
    if (takePhotoSingle.present) {
      map['take_photo_single'] = Variable<bool>(takePhotoSingle.value);
    }
    if (takePhotoDriver.present) {
      map['take_photo_driver'] = Variable<bool>(takePhotoDriver.value);
    }
    if (takePhotoQrcode.present) {
      map['take_photo_qrcode'] = Variable<bool>(takePhotoQrcode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConfigurationTableCompanion(')
          ..write('onlyOnline: $onlyOnline, ')
          ..write('operationMode: $operationMode, ')
          ..write('timezone: $timezone, ')
          ..write('takePhoto: $takePhoto, ')
          ..write('allowChangeTime: $allowChangeTime, ')
          ..write('username: $username, ')
          ..write('employeeId: $employeeId, ')
          ..write('faceRecognition: $faceRecognition, ')
          ..write('overnight: $overnight, ')
          ..write('controlOvernight: $controlOvernight, ')
          ..write('gps: $gps, ')
          ..write('deviceAuthorizationType: $deviceAuthorizationType, ')
          ..write('allowDrivingTime: $allowDrivingTime, ')
          ..write('allowGpoOnApp: $allowGpoOnApp, ')
          ..write('exportNotChecked: $exportNotChecked, ')
          ..write('insightOutOfBound: $insightOutOfBound, ')
          ..write('openExternalBrowser: $openExternalBrowser, ')
          ..write('allowUse: $allowUse, ')
          ..write('externalControlTimezone: $externalControlTimezone, ')
          ..write('nfcMode: $nfcMode, ')
          ..write('takePhotoNfc: $takePhotoNfc, ')
          ..write('takePhotoSingle: $takePhotoSingle, ')
          ..write('takePhotoDriver: $takePhotoDriver, ')
          ..write('takePhotoQrcode: $takePhotoQrcode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OvernightTableTable extends OvernightTable
    with TableInfo<$OvernightTableTable, OvernightTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OvernightTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _geolocationMeta =
      const VerificationMeta('geolocation');
  @override
  late final GeneratedColumn<String> geolocation = GeneratedColumn<String>(
      'geolocation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationStatusMeta =
      const VerificationMeta('locationStatus');
  @override
  late final GeneratedColumn<String> locationStatus = GeneratedColumn<String>(
      'location_status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _synchronizedMeta =
      const VerificationMeta('synchronized');
  @override
  late final GeneratedColumn<bool> synchronized = GeneratedColumn<bool>(
      'synchronized', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("synchronized" IN (0, 1))'));
  static const VerificationMeta _employeeMeta =
      const VerificationMeta('employee');
  @override
  late final GeneratedColumn<String> employee = GeneratedColumn<String>(
      'employee', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, date, geolocation, locationStatus, type, synchronized, employee];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'overnight_table';
  @override
  VerificationContext validateIntegrity(Insertable<OvernightTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('geolocation')) {
      context.handle(
          _geolocationMeta,
          geolocation.isAcceptableOrUnknown(
              data['geolocation']!, _geolocationMeta));
    }
    if (data.containsKey('location_status')) {
      context.handle(
          _locationStatusMeta,
          locationStatus.isAcceptableOrUnknown(
              data['location_status']!, _locationStatusMeta));
    } else if (isInserting) {
      context.missing(_locationStatusMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('synchronized')) {
      context.handle(
          _synchronizedMeta,
          synchronized.isAcceptableOrUnknown(
              data['synchronized']!, _synchronizedMeta));
    } else if (isInserting) {
      context.missing(_synchronizedMeta);
    }
    if (data.containsKey('employee')) {
      context.handle(_employeeMeta,
          employee.isAcceptableOrUnknown(data['employee']!, _employeeMeta));
    } else if (isInserting) {
      context.missing(_employeeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id, employee};
  @override
  OvernightTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OvernightTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      geolocation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}geolocation']),
      locationStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}location_status'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      synchronized: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synchronized'])!,
      employee: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee'])!,
    );
  }

  @override
  $OvernightTableTable createAlias(String alias) {
    return $OvernightTableTable(attachedDatabase, alias);
  }
}

class OvernightTableData extends DataClass
    implements Insertable<OvernightTableData> {
  final String id;
  final DateTime date;
  final String? geolocation;
  final String locationStatus;
  final String type;
  final bool synchronized;
  final String employee;
  const OvernightTableData(
      {required this.id,
      required this.date,
      this.geolocation,
      required this.locationStatus,
      required this.type,
      required this.synchronized,
      required this.employee});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || geolocation != null) {
      map['geolocation'] = Variable<String>(geolocation);
    }
    map['location_status'] = Variable<String>(locationStatus);
    map['type'] = Variable<String>(type);
    map['synchronized'] = Variable<bool>(synchronized);
    map['employee'] = Variable<String>(employee);
    return map;
  }

  OvernightTableCompanion toCompanion(bool nullToAbsent) {
    return OvernightTableCompanion(
      id: Value(id),
      date: Value(date),
      geolocation: geolocation == null && nullToAbsent
          ? const Value.absent()
          : Value(geolocation),
      locationStatus: Value(locationStatus),
      type: Value(type),
      synchronized: Value(synchronized),
      employee: Value(employee),
    );
  }

  factory OvernightTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OvernightTableData(
      id: serializer.fromJson<String>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      geolocation: serializer.fromJson<String?>(json['geolocation']),
      locationStatus: serializer.fromJson<String>(json['locationStatus']),
      type: serializer.fromJson<String>(json['type']),
      synchronized: serializer.fromJson<bool>(json['synchronized']),
      employee: serializer.fromJson<String>(json['employee']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'date': serializer.toJson<DateTime>(date),
      'geolocation': serializer.toJson<String?>(geolocation),
      'locationStatus': serializer.toJson<String>(locationStatus),
      'type': serializer.toJson<String>(type),
      'synchronized': serializer.toJson<bool>(synchronized),
      'employee': serializer.toJson<String>(employee),
    };
  }

  OvernightTableData copyWith(
          {String? id,
          DateTime? date,
          Value<String?> geolocation = const Value.absent(),
          String? locationStatus,
          String? type,
          bool? synchronized,
          String? employee}) =>
      OvernightTableData(
        id: id ?? this.id,
        date: date ?? this.date,
        geolocation: geolocation.present ? geolocation.value : this.geolocation,
        locationStatus: locationStatus ?? this.locationStatus,
        type: type ?? this.type,
        synchronized: synchronized ?? this.synchronized,
        employee: employee ?? this.employee,
      );
  OvernightTableData copyWithCompanion(OvernightTableCompanion data) {
    return OvernightTableData(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      geolocation:
          data.geolocation.present ? data.geolocation.value : this.geolocation,
      locationStatus: data.locationStatus.present
          ? data.locationStatus.value
          : this.locationStatus,
      type: data.type.present ? data.type.value : this.type,
      synchronized: data.synchronized.present
          ? data.synchronized.value
          : this.synchronized,
      employee: data.employee.present ? data.employee.value : this.employee,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OvernightTableData(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('geolocation: $geolocation, ')
          ..write('locationStatus: $locationStatus, ')
          ..write('type: $type, ')
          ..write('synchronized: $synchronized, ')
          ..write('employee: $employee')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, date, geolocation, locationStatus, type, synchronized, employee);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OvernightTableData &&
          other.id == this.id &&
          other.date == this.date &&
          other.geolocation == this.geolocation &&
          other.locationStatus == this.locationStatus &&
          other.type == this.type &&
          other.synchronized == this.synchronized &&
          other.employee == this.employee);
}

class OvernightTableCompanion extends UpdateCompanion<OvernightTableData> {
  final Value<String> id;
  final Value<DateTime> date;
  final Value<String?> geolocation;
  final Value<String> locationStatus;
  final Value<String> type;
  final Value<bool> synchronized;
  final Value<String> employee;
  final Value<int> rowid;
  const OvernightTableCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.geolocation = const Value.absent(),
    this.locationStatus = const Value.absent(),
    this.type = const Value.absent(),
    this.synchronized = const Value.absent(),
    this.employee = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OvernightTableCompanion.insert({
    required String id,
    required DateTime date,
    this.geolocation = const Value.absent(),
    required String locationStatus,
    required String type,
    required bool synchronized,
    required String employee,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        date = Value(date),
        locationStatus = Value(locationStatus),
        type = Value(type),
        synchronized = Value(synchronized),
        employee = Value(employee);
  static Insertable<OvernightTableData> custom({
    Expression<String>? id,
    Expression<DateTime>? date,
    Expression<String>? geolocation,
    Expression<String>? locationStatus,
    Expression<String>? type,
    Expression<bool>? synchronized,
    Expression<String>? employee,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (geolocation != null) 'geolocation': geolocation,
      if (locationStatus != null) 'location_status': locationStatus,
      if (type != null) 'type': type,
      if (synchronized != null) 'synchronized': synchronized,
      if (employee != null) 'employee': employee,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OvernightTableCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? date,
      Value<String?>? geolocation,
      Value<String>? locationStatus,
      Value<String>? type,
      Value<bool>? synchronized,
      Value<String>? employee,
      Value<int>? rowid}) {
    return OvernightTableCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      geolocation: geolocation ?? this.geolocation,
      locationStatus: locationStatus ?? this.locationStatus,
      type: type ?? this.type,
      synchronized: synchronized ?? this.synchronized,
      employee: employee ?? this.employee,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (geolocation.present) {
      map['geolocation'] = Variable<String>(geolocation.value);
    }
    if (locationStatus.present) {
      map['location_status'] = Variable<String>(locationStatus.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (synchronized.present) {
      map['synchronized'] = Variable<bool>(synchronized.value);
    }
    if (employee.present) {
      map['employee'] = Variable<String>(employee.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OvernightTableCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('geolocation: $geolocation, ')
          ..write('locationStatus: $locationStatus, ')
          ..write('type: $type, ')
          ..write('synchronized: $synchronized, ')
          ..write('employee: $employee, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $JourneyTableTable extends JourneyTable
    with TableInfo<$JourneyTableTable, JourneyTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JourneyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _journeyNumberMeta =
      const VerificationMeta('journeyNumber');
  @override
  late final GeneratedColumn<int> journeyNumber = GeneratedColumn<int>(
      'journey_number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _overnightIdMeta =
      const VerificationMeta('overnightId');
  @override
  late final GeneratedColumn<String> overnightId = GeneratedColumn<String>(
      'overnight_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES overnight_table (id)'));
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, journeyNumber, overnightId, startDate, endDate, employeeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journey_table';
  @override
  VerificationContext validateIntegrity(Insertable<JourneyTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('journey_number')) {
      context.handle(
          _journeyNumberMeta,
          journeyNumber.isAcceptableOrUnknown(
              data['journey_number']!, _journeyNumberMeta));
    } else if (isInserting) {
      context.missing(_journeyNumberMeta);
    }
    if (data.containsKey('overnight_id')) {
      context.handle(
          _overnightIdMeta,
          overnightId.isAcceptableOrUnknown(
              data['overnight_id']!, _overnightIdMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JourneyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JourneyTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      journeyNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}journey_number'])!,
      overnightId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}overnight_id']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date']),
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
    );
  }

  @override
  $JourneyTableTable createAlias(String alias) {
    return $JourneyTableTable(attachedDatabase, alias);
  }
}

class JourneyTableData extends DataClass
    implements Insertable<JourneyTableData> {
  final String id;
  final int journeyNumber;
  final String? overnightId;
  final DateTime startDate;
  final DateTime? endDate;
  final String employeeId;
  const JourneyTableData(
      {required this.id,
      required this.journeyNumber,
      this.overnightId,
      required this.startDate,
      this.endDate,
      required this.employeeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['journey_number'] = Variable<int>(journeyNumber);
    if (!nullToAbsent || overnightId != null) {
      map['overnight_id'] = Variable<String>(overnightId);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    map['employee_id'] = Variable<String>(employeeId);
    return map;
  }

  JourneyTableCompanion toCompanion(bool nullToAbsent) {
    return JourneyTableCompanion(
      id: Value(id),
      journeyNumber: Value(journeyNumber),
      overnightId: overnightId == null && nullToAbsent
          ? const Value.absent()
          : Value(overnightId),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      employeeId: Value(employeeId),
    );
  }

  factory JourneyTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JourneyTableData(
      id: serializer.fromJson<String>(json['id']),
      journeyNumber: serializer.fromJson<int>(json['journeyNumber']),
      overnightId: serializer.fromJson<String?>(json['overnightId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'journeyNumber': serializer.toJson<int>(journeyNumber),
      'overnightId': serializer.toJson<String?>(overnightId),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'employeeId': serializer.toJson<String>(employeeId),
    };
  }

  JourneyTableData copyWith(
          {String? id,
          int? journeyNumber,
          Value<String?> overnightId = const Value.absent(),
          DateTime? startDate,
          Value<DateTime?> endDate = const Value.absent(),
          String? employeeId}) =>
      JourneyTableData(
        id: id ?? this.id,
        journeyNumber: journeyNumber ?? this.journeyNumber,
        overnightId: overnightId.present ? overnightId.value : this.overnightId,
        startDate: startDate ?? this.startDate,
        endDate: endDate.present ? endDate.value : this.endDate,
        employeeId: employeeId ?? this.employeeId,
      );
  JourneyTableData copyWithCompanion(JourneyTableCompanion data) {
    return JourneyTableData(
      id: data.id.present ? data.id.value : this.id,
      journeyNumber: data.journeyNumber.present
          ? data.journeyNumber.value
          : this.journeyNumber,
      overnightId:
          data.overnightId.present ? data.overnightId.value : this.overnightId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JourneyTableData(')
          ..write('id: $id, ')
          ..write('journeyNumber: $journeyNumber, ')
          ..write('overnightId: $overnightId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('employeeId: $employeeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, journeyNumber, overnightId, startDate, endDate, employeeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JourneyTableData &&
          other.id == this.id &&
          other.journeyNumber == this.journeyNumber &&
          other.overnightId == this.overnightId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.employeeId == this.employeeId);
}

class JourneyTableCompanion extends UpdateCompanion<JourneyTableData> {
  final Value<String> id;
  final Value<int> journeyNumber;
  final Value<String?> overnightId;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String> employeeId;
  final Value<int> rowid;
  const JourneyTableCompanion({
    this.id = const Value.absent(),
    this.journeyNumber = const Value.absent(),
    this.overnightId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JourneyTableCompanion.insert({
    required String id,
    required int journeyNumber,
    this.overnightId = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    required String employeeId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        journeyNumber = Value(journeyNumber),
        startDate = Value(startDate),
        employeeId = Value(employeeId);
  static Insertable<JourneyTableData> custom({
    Expression<String>? id,
    Expression<int>? journeyNumber,
    Expression<String>? overnightId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? employeeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (journeyNumber != null) 'journey_number': journeyNumber,
      if (overnightId != null) 'overnight_id': overnightId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (employeeId != null) 'employee_id': employeeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JourneyTableCompanion copyWith(
      {Value<String>? id,
      Value<int>? journeyNumber,
      Value<String?>? overnightId,
      Value<DateTime>? startDate,
      Value<DateTime?>? endDate,
      Value<String>? employeeId,
      Value<int>? rowid}) {
    return JourneyTableCompanion(
      id: id ?? this.id,
      journeyNumber: journeyNumber ?? this.journeyNumber,
      overnightId: overnightId ?? this.overnightId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      employeeId: employeeId ?? this.employeeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (journeyNumber.present) {
      map['journey_number'] = Variable<int>(journeyNumber.value);
    }
    if (overnightId.present) {
      map['overnight_id'] = Variable<String>(overnightId.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JourneyTableCompanion(')
          ..write('id: $id, ')
          ..write('journeyNumber: $journeyNumber, ')
          ..write('overnightId: $overnightId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('employeeId: $employeeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClockingEventTableTable extends ClockingEventTable
    with TableInfo<$ClockingEventTableTable, ClockingEventTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClockingEventTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clockingEventIdMeta =
      const VerificationMeta('clockingEventId');
  @override
  late final GeneratedColumn<String> clockingEventId = GeneratedColumn<String>(
      'clocking_event_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateTimeEventMeta =
      const VerificationMeta('dateTimeEvent');
  @override
  late final GeneratedColumn<DateTime> dateTimeEvent =
      GeneratedColumn<DateTime>('date_time_event', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _dateEventMeta =
      const VerificationMeta('dateEvent');
  @override
  late final GeneratedColumn<String> dateEvent = GeneratedColumn<String>(
      'date_event', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeEventMeta =
      const VerificationMeta('timeEvent');
  @override
  late final GeneratedColumn<String> timeEvent = GeneratedColumn<String>(
      'time_event', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timeZoneMeta =
      const VerificationMeta('timeZone');
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
      'time_zone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _companyIdentifierMeta =
      const VerificationMeta('companyIdentifier');
  @override
  late final GeneratedColumn<String> companyIdentifier =
      GeneratedColumn<String>('company_identifier', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pisMeta = const VerificationMeta('pis');
  @override
  late final GeneratedColumn<String> pis = GeneratedColumn<String>(
      'pis', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cpfMeta = const VerificationMeta('cpf');
  @override
  late final GeneratedColumn<String> cpf = GeneratedColumn<String>(
      'cpf', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _appVersionMeta =
      const VerificationMeta('appVersion');
  @override
  late final GeneratedColumn<String> appVersion = GeneratedColumn<String>(
      'app_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _platformMeta =
      const VerificationMeta('platform');
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
      'platform', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _identifierDeviceMeta =
      const VerificationMeta('identifierDevice');
  @override
  late final GeneratedColumn<String> identifierDevice = GeneratedColumn<String>(
      'identifier_device', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameDeviceMeta =
      const VerificationMeta('nameDevice');
  @override
  late final GeneratedColumn<String> nameDevice = GeneratedColumn<String>(
      'name_device', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _developerModeDeviceMeta =
      const VerificationMeta('developerModeDevice');
  @override
  late final GeneratedColumn<String> developerModeDevice =
      GeneratedColumn<String>('developer_mode_device', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _gpsOperationModeDeviceMeta =
      const VerificationMeta('gpsOperationModeDevice');
  @override
  late final GeneratedColumn<String> gpsOperationModeDevice =
      GeneratedColumn<String>('gps_operation_mode_device', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateTimeAutomaticDeviceMeta =
      const VerificationMeta('dateTimeAutomaticDevice');
  @override
  late final GeneratedColumn<bool> dateTimeAutomaticDevice =
      GeneratedColumn<bool>('date_time_automatic_device', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("date_time_automatic_device" IN (0, 1))'));
  static const VerificationMeta _timeZoneAutomaticDeviceMeta =
      const VerificationMeta('timeZoneAutomaticDevice');
  @override
  late final GeneratedColumn<bool> timeZoneAutomaticDevice =
      GeneratedColumn<bool>('time_zone_automatic_device', aliasedName, true,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("time_zone_automatic_device" IN (0, 1))'));
  static const VerificationMeta _latitudeLocationMeta =
      const VerificationMeta('latitudeLocation');
  @override
  late final GeneratedColumn<double> latitudeLocation = GeneratedColumn<double>(
      'latitude_location', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _longitudeLocationMeta =
      const VerificationMeta('longitudeLocation');
  @override
  late final GeneratedColumn<double> longitudeLocation =
      GeneratedColumn<double>('longitude_location', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _geolocationIsMockMeta =
      const VerificationMeta('geolocationIsMock');
  @override
  late final GeneratedColumn<bool> geolocationIsMock = GeneratedColumn<bool>(
      'geolocation_is_mock', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("geolocation_is_mock" IN (0, 1))'));
  static const VerificationMeta _dateAndTimeLocationMeta =
      const VerificationMeta('dateAndTimeLocation');
  @override
  late final GeneratedColumn<DateTime> dateAndTimeLocation =
      GeneratedColumn<DateTime>('date_and_time_location', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fenceStateMeta =
      const VerificationMeta('fenceState');
  @override
  late final GeneratedColumn<String> fenceState = GeneratedColumn<String>(
      'fence_state', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _useMeta = const VerificationMeta('use');
  @override
  late final GeneratedColumn<int> use = GeneratedColumn<int>(
      'use', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _modeMeta = const VerificationMeta('mode');
  @override
  late final GeneratedColumn<String> mode = GeneratedColumn<String>(
      'mode', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _onlineMeta = const VerificationMeta('online');
  @override
  late final GeneratedColumn<bool> online = GeneratedColumn<bool>(
      'online', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("online" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _originMeta = const VerificationMeta('origin');
  @override
  late final GeneratedColumn<String> origin = GeneratedColumn<String>(
      'origin', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _signatureMeta =
      const VerificationMeta('signature');
  @override
  late final GeneratedColumn<String> signature = GeneratedColumn<String>(
      'signature', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _signatureVersionMeta =
      const VerificationMeta('signatureVersion');
  @override
  late final GeneratedColumn<int> signatureVersion = GeneratedColumn<int>(
      'signature_version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _clientOriginInfoMeta =
      const VerificationMeta('clientOriginInfo');
  @override
  late final GeneratedColumn<String> clientOriginInfo = GeneratedColumn<String>(
      'client_origin_info', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _appointmentImageMeta =
      const VerificationMeta('appointmentImage');
  @override
  late final GeneratedColumn<String> appointmentImage = GeneratedColumn<String>(
      'appointment_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoNotCapturedMeta =
      const VerificationMeta('photoNotCaptured');
  @override
  late final GeneratedColumn<String> photoNotCaptured = GeneratedColumn<String>(
      'photo_not_captured', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _locationStatusMeta =
      const VerificationMeta('locationStatus');
  @override
  late final GeneratedColumn<String> locationStatus = GeneratedColumn<String>(
      'location_status', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isSynchronizedMeta =
      const VerificationMeta('isSynchronized');
  @override
  late final GeneratedColumn<bool> isSynchronized = GeneratedColumn<bool>(
      'is_synchronized', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_synchronized" IN (0, 1))'));
  static const VerificationMeta _journeyIdMeta =
      const VerificationMeta('journeyId');
  @override
  late final GeneratedColumn<String> journeyId = GeneratedColumn<String>(
      'journey_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES journey_table (id)'));
  static const VerificationMeta _isMealBreakMeta =
      const VerificationMeta('isMealBreak');
  @override
  late final GeneratedColumn<bool> isMealBreak = GeneratedColumn<bool>(
      'is_meal_break', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_meal_break" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _journeyEventNameMeta =
      const VerificationMeta('journeyEventName');
  @override
  late final GeneratedColumn<String> journeyEventName = GeneratedColumn<String>(
      'journey_event_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeNameMeta =
      const VerificationMeta('employeeName');
  @override
  late final GeneratedColumn<String> employeeName = GeneratedColumn<String>(
      'employee_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('defaultValue'));
  static const VerificationMeta _companyNameMeta =
      const VerificationMeta('companyName');
  @override
  late final GeneratedColumn<String> companyName = GeneratedColumn<String>(
      'company_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('defaultValue'));
  static const VerificationMeta _facialRecognitionStatusMeta =
      const VerificationMeta('facialRecognitionStatus');
  @override
  late final GeneratedColumn<String> facialRecognitionStatus =
      GeneratedColumn<String>('facial_recognition_status', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        clockingEventId,
        dateTimeEvent,
        dateEvent,
        timeEvent,
        timeZone,
        companyIdentifier,
        pis,
        cpf,
        appVersion,
        platform,
        identifierDevice,
        nameDevice,
        developerModeDevice,
        gpsOperationModeDevice,
        dateTimeAutomaticDevice,
        timeZoneAutomaticDevice,
        latitudeLocation,
        longitudeLocation,
        geolocationIsMock,
        dateAndTimeLocation,
        employeeId,
        fenceState,
        use,
        mode,
        online,
        origin,
        signature,
        signatureVersion,
        clientOriginInfo,
        appointmentImage,
        photoNotCaptured,
        locationStatus,
        isSynchronized,
        journeyId,
        isMealBreak,
        journeyEventName,
        employeeName,
        companyName,
        facialRecognitionStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clocking_event_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ClockingEventTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clocking_event_id')) {
      context.handle(
          _clockingEventIdMeta,
          clockingEventId.isAcceptableOrUnknown(
              data['clocking_event_id']!, _clockingEventIdMeta));
    } else if (isInserting) {
      context.missing(_clockingEventIdMeta);
    }
    if (data.containsKey('date_time_event')) {
      context.handle(
          _dateTimeEventMeta,
          dateTimeEvent.isAcceptableOrUnknown(
              data['date_time_event']!, _dateTimeEventMeta));
    } else if (isInserting) {
      context.missing(_dateTimeEventMeta);
    }
    if (data.containsKey('date_event')) {
      context.handle(_dateEventMeta,
          dateEvent.isAcceptableOrUnknown(data['date_event']!, _dateEventMeta));
    } else if (isInserting) {
      context.missing(_dateEventMeta);
    }
    if (data.containsKey('time_event')) {
      context.handle(_timeEventMeta,
          timeEvent.isAcceptableOrUnknown(data['time_event']!, _timeEventMeta));
    } else if (isInserting) {
      context.missing(_timeEventMeta);
    }
    if (data.containsKey('time_zone')) {
      context.handle(_timeZoneMeta,
          timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta));
    } else if (isInserting) {
      context.missing(_timeZoneMeta);
    }
    if (data.containsKey('company_identifier')) {
      context.handle(
          _companyIdentifierMeta,
          companyIdentifier.isAcceptableOrUnknown(
              data['company_identifier']!, _companyIdentifierMeta));
    } else if (isInserting) {
      context.missing(_companyIdentifierMeta);
    }
    if (data.containsKey('pis')) {
      context.handle(
          _pisMeta, pis.isAcceptableOrUnknown(data['pis']!, _pisMeta));
    }
    if (data.containsKey('cpf')) {
      context.handle(
          _cpfMeta, cpf.isAcceptableOrUnknown(data['cpf']!, _cpfMeta));
    } else if (isInserting) {
      context.missing(_cpfMeta);
    }
    if (data.containsKey('app_version')) {
      context.handle(
          _appVersionMeta,
          appVersion.isAcceptableOrUnknown(
              data['app_version']!, _appVersionMeta));
    } else if (isInserting) {
      context.missing(_appVersionMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(_platformMeta,
          platform.isAcceptableOrUnknown(data['platform']!, _platformMeta));
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('identifier_device')) {
      context.handle(
          _identifierDeviceMeta,
          identifierDevice.isAcceptableOrUnknown(
              data['identifier_device']!, _identifierDeviceMeta));
    }
    if (data.containsKey('name_device')) {
      context.handle(
          _nameDeviceMeta,
          nameDevice.isAcceptableOrUnknown(
              data['name_device']!, _nameDeviceMeta));
    }
    if (data.containsKey('developer_mode_device')) {
      context.handle(
          _developerModeDeviceMeta,
          developerModeDevice.isAcceptableOrUnknown(
              data['developer_mode_device']!, _developerModeDeviceMeta));
    }
    if (data.containsKey('gps_operation_mode_device')) {
      context.handle(
          _gpsOperationModeDeviceMeta,
          gpsOperationModeDevice.isAcceptableOrUnknown(
              data['gps_operation_mode_device']!, _gpsOperationModeDeviceMeta));
    }
    if (data.containsKey('date_time_automatic_device')) {
      context.handle(
          _dateTimeAutomaticDeviceMeta,
          dateTimeAutomaticDevice.isAcceptableOrUnknown(
              data['date_time_automatic_device']!,
              _dateTimeAutomaticDeviceMeta));
    }
    if (data.containsKey('time_zone_automatic_device')) {
      context.handle(
          _timeZoneAutomaticDeviceMeta,
          timeZoneAutomaticDevice.isAcceptableOrUnknown(
              data['time_zone_automatic_device']!,
              _timeZoneAutomaticDeviceMeta));
    }
    if (data.containsKey('latitude_location')) {
      context.handle(
          _latitudeLocationMeta,
          latitudeLocation.isAcceptableOrUnknown(
              data['latitude_location']!, _latitudeLocationMeta));
    }
    if (data.containsKey('longitude_location')) {
      context.handle(
          _longitudeLocationMeta,
          longitudeLocation.isAcceptableOrUnknown(
              data['longitude_location']!, _longitudeLocationMeta));
    }
    if (data.containsKey('geolocation_is_mock')) {
      context.handle(
          _geolocationIsMockMeta,
          geolocationIsMock.isAcceptableOrUnknown(
              data['geolocation_is_mock']!, _geolocationIsMockMeta));
    } else if (isInserting) {
      context.missing(_geolocationIsMockMeta);
    }
    if (data.containsKey('date_and_time_location')) {
      context.handle(
          _dateAndTimeLocationMeta,
          dateAndTimeLocation.isAcceptableOrUnknown(
              data['date_and_time_location']!, _dateAndTimeLocationMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('fence_state')) {
      context.handle(
          _fenceStateMeta,
          fenceState.isAcceptableOrUnknown(
              data['fence_state']!, _fenceStateMeta));
    }
    if (data.containsKey('use')) {
      context.handle(
          _useMeta, use.isAcceptableOrUnknown(data['use']!, _useMeta));
    } else if (isInserting) {
      context.missing(_useMeta);
    }
    if (data.containsKey('mode')) {
      context.handle(
          _modeMeta, mode.isAcceptableOrUnknown(data['mode']!, _modeMeta));
    } else if (isInserting) {
      context.missing(_modeMeta);
    }
    if (data.containsKey('online')) {
      context.handle(_onlineMeta,
          online.isAcceptableOrUnknown(data['online']!, _onlineMeta));
    }
    if (data.containsKey('origin')) {
      context.handle(_originMeta,
          origin.isAcceptableOrUnknown(data['origin']!, _originMeta));
    } else if (isInserting) {
      context.missing(_originMeta);
    }
    if (data.containsKey('signature')) {
      context.handle(_signatureMeta,
          signature.isAcceptableOrUnknown(data['signature']!, _signatureMeta));
    } else if (isInserting) {
      context.missing(_signatureMeta);
    }
    if (data.containsKey('signature_version')) {
      context.handle(
          _signatureVersionMeta,
          signatureVersion.isAcceptableOrUnknown(
              data['signature_version']!, _signatureVersionMeta));
    } else if (isInserting) {
      context.missing(_signatureVersionMeta);
    }
    if (data.containsKey('client_origin_info')) {
      context.handle(
          _clientOriginInfoMeta,
          clientOriginInfo.isAcceptableOrUnknown(
              data['client_origin_info']!, _clientOriginInfoMeta));
    }
    if (data.containsKey('appointment_image')) {
      context.handle(
          _appointmentImageMeta,
          appointmentImage.isAcceptableOrUnknown(
              data['appointment_image']!, _appointmentImageMeta));
    }
    if (data.containsKey('photo_not_captured')) {
      context.handle(
          _photoNotCapturedMeta,
          photoNotCaptured.isAcceptableOrUnknown(
              data['photo_not_captured']!, _photoNotCapturedMeta));
    }
    if (data.containsKey('location_status')) {
      context.handle(
          _locationStatusMeta,
          locationStatus.isAcceptableOrUnknown(
              data['location_status']!, _locationStatusMeta));
    }
    if (data.containsKey('is_synchronized')) {
      context.handle(
          _isSynchronizedMeta,
          isSynchronized.isAcceptableOrUnknown(
              data['is_synchronized']!, _isSynchronizedMeta));
    } else if (isInserting) {
      context.missing(_isSynchronizedMeta);
    }
    if (data.containsKey('journey_id')) {
      context.handle(_journeyIdMeta,
          journeyId.isAcceptableOrUnknown(data['journey_id']!, _journeyIdMeta));
    }
    if (data.containsKey('is_meal_break')) {
      context.handle(
          _isMealBreakMeta,
          isMealBreak.isAcceptableOrUnknown(
              data['is_meal_break']!, _isMealBreakMeta));
    }
    if (data.containsKey('journey_event_name')) {
      context.handle(
          _journeyEventNameMeta,
          journeyEventName.isAcceptableOrUnknown(
              data['journey_event_name']!, _journeyEventNameMeta));
    }
    if (data.containsKey('employee_name')) {
      context.handle(
          _employeeNameMeta,
          employeeName.isAcceptableOrUnknown(
              data['employee_name']!, _employeeNameMeta));
    }
    if (data.containsKey('company_name')) {
      context.handle(
          _companyNameMeta,
          companyName.isAcceptableOrUnknown(
              data['company_name']!, _companyNameMeta));
    }
    if (data.containsKey('facial_recognition_status')) {
      context.handle(
          _facialRecognitionStatusMeta,
          facialRecognitionStatus.isAcceptableOrUnknown(
              data['facial_recognition_status']!,
              _facialRecognitionStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clockingEventId};
  @override
  ClockingEventTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClockingEventTableData(
      clockingEventId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}clocking_event_id'])!,
      dateTimeEvent: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_time_event'])!,
      dateEvent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_event'])!,
      timeEvent: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_event'])!,
      timeZone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_zone'])!,
      companyIdentifier: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}company_identifier'])!,
      pis: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}pis']),
      cpf: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cpf'])!,
      appVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}app_version'])!,
      platform: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}platform'])!,
      identifierDevice: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}identifier_device']),
      nameDevice: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_device']),
      developerModeDevice: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}developer_mode_device']),
      gpsOperationModeDevice: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}gps_operation_mode_device']),
      dateTimeAutomaticDevice: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}date_time_automatic_device']),
      timeZoneAutomaticDevice: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}time_zone_automatic_device']),
      latitudeLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}latitude_location']),
      longitudeLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}longitude_location']),
      geolocationIsMock: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}geolocation_is_mock'])!,
      dateAndTimeLocation: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}date_and_time_location']),
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      fenceState: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fence_state']),
      use: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}use'])!,
      mode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mode'])!,
      online: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}online'])!,
      origin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}origin'])!,
      signature: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}signature'])!,
      signatureVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}signature_version'])!,
      clientOriginInfo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}client_origin_info']),
      appointmentImage: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}appointment_image']),
      photoNotCaptured: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}photo_not_captured']),
      locationStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location_status']),
      isSynchronized: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_synchronized'])!,
      journeyId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}journey_id']),
      isMealBreak: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_meal_break'])!,
      journeyEventName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}journey_event_name']),
      employeeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_name'])!,
      companyName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company_name'])!,
      facialRecognitionStatus: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}facial_recognition_status']),
    );
  }

  @override
  $ClockingEventTableTable createAlias(String alias) {
    return $ClockingEventTableTable(attachedDatabase, alias);
  }
}

class ClockingEventTableData extends DataClass
    implements Insertable<ClockingEventTableData> {
  /// Locally generated identifier
  final String clockingEventId;
  final DateTime dateTimeEvent;
  final String dateEvent;
  final String timeEvent;
  final String timeZone;
  final String companyIdentifier;
  final String? pis;
  final String cpf;
  final String appVersion;
  final String platform;
  final String? identifierDevice;
  final String? nameDevice;
  final String? developerModeDevice;
  final String? gpsOperationModeDevice;
  final bool? dateTimeAutomaticDevice;
  final bool? timeZoneAutomaticDevice;
  final double? latitudeLocation;
  final double? longitudeLocation;
  final bool geolocationIsMock;
  final DateTime? dateAndTimeLocation;
  final String employeeId;
  final String? fenceState;
  final int use;
  final String mode;
  final bool online;
  final String origin;
  final String signature;
  final int signatureVersion;
  final String? clientOriginInfo;
  final String? appointmentImage;
  final String? photoNotCaptured;
  final String? locationStatus;
  final bool isSynchronized;
  final String? journeyId;
  final bool isMealBreak;
  final String? journeyEventName;
  final String employeeName;
  final String companyName;
  final String? facialRecognitionStatus;
  const ClockingEventTableData(
      {required this.clockingEventId,
      required this.dateTimeEvent,
      required this.dateEvent,
      required this.timeEvent,
      required this.timeZone,
      required this.companyIdentifier,
      this.pis,
      required this.cpf,
      required this.appVersion,
      required this.platform,
      this.identifierDevice,
      this.nameDevice,
      this.developerModeDevice,
      this.gpsOperationModeDevice,
      this.dateTimeAutomaticDevice,
      this.timeZoneAutomaticDevice,
      this.latitudeLocation,
      this.longitudeLocation,
      required this.geolocationIsMock,
      this.dateAndTimeLocation,
      required this.employeeId,
      this.fenceState,
      required this.use,
      required this.mode,
      required this.online,
      required this.origin,
      required this.signature,
      required this.signatureVersion,
      this.clientOriginInfo,
      this.appointmentImage,
      this.photoNotCaptured,
      this.locationStatus,
      required this.isSynchronized,
      this.journeyId,
      required this.isMealBreak,
      this.journeyEventName,
      required this.employeeName,
      required this.companyName,
      this.facialRecognitionStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clocking_event_id'] = Variable<String>(clockingEventId);
    map['date_time_event'] = Variable<DateTime>(dateTimeEvent);
    map['date_event'] = Variable<String>(dateEvent);
    map['time_event'] = Variable<String>(timeEvent);
    map['time_zone'] = Variable<String>(timeZone);
    map['company_identifier'] = Variable<String>(companyIdentifier);
    if (!nullToAbsent || pis != null) {
      map['pis'] = Variable<String>(pis);
    }
    map['cpf'] = Variable<String>(cpf);
    map['app_version'] = Variable<String>(appVersion);
    map['platform'] = Variable<String>(platform);
    if (!nullToAbsent || identifierDevice != null) {
      map['identifier_device'] = Variable<String>(identifierDevice);
    }
    if (!nullToAbsent || nameDevice != null) {
      map['name_device'] = Variable<String>(nameDevice);
    }
    if (!nullToAbsent || developerModeDevice != null) {
      map['developer_mode_device'] = Variable<String>(developerModeDevice);
    }
    if (!nullToAbsent || gpsOperationModeDevice != null) {
      map['gps_operation_mode_device'] =
          Variable<String>(gpsOperationModeDevice);
    }
    if (!nullToAbsent || dateTimeAutomaticDevice != null) {
      map['date_time_automatic_device'] =
          Variable<bool>(dateTimeAutomaticDevice);
    }
    if (!nullToAbsent || timeZoneAutomaticDevice != null) {
      map['time_zone_automatic_device'] =
          Variable<bool>(timeZoneAutomaticDevice);
    }
    if (!nullToAbsent || latitudeLocation != null) {
      map['latitude_location'] = Variable<double>(latitudeLocation);
    }
    if (!nullToAbsent || longitudeLocation != null) {
      map['longitude_location'] = Variable<double>(longitudeLocation);
    }
    map['geolocation_is_mock'] = Variable<bool>(geolocationIsMock);
    if (!nullToAbsent || dateAndTimeLocation != null) {
      map['date_and_time_location'] = Variable<DateTime>(dateAndTimeLocation);
    }
    map['employee_id'] = Variable<String>(employeeId);
    if (!nullToAbsent || fenceState != null) {
      map['fence_state'] = Variable<String>(fenceState);
    }
    map['use'] = Variable<int>(use);
    map['mode'] = Variable<String>(mode);
    map['online'] = Variable<bool>(online);
    map['origin'] = Variable<String>(origin);
    map['signature'] = Variable<String>(signature);
    map['signature_version'] = Variable<int>(signatureVersion);
    if (!nullToAbsent || clientOriginInfo != null) {
      map['client_origin_info'] = Variable<String>(clientOriginInfo);
    }
    if (!nullToAbsent || appointmentImage != null) {
      map['appointment_image'] = Variable<String>(appointmentImage);
    }
    if (!nullToAbsent || photoNotCaptured != null) {
      map['photo_not_captured'] = Variable<String>(photoNotCaptured);
    }
    if (!nullToAbsent || locationStatus != null) {
      map['location_status'] = Variable<String>(locationStatus);
    }
    map['is_synchronized'] = Variable<bool>(isSynchronized);
    if (!nullToAbsent || journeyId != null) {
      map['journey_id'] = Variable<String>(journeyId);
    }
    map['is_meal_break'] = Variable<bool>(isMealBreak);
    if (!nullToAbsent || journeyEventName != null) {
      map['journey_event_name'] = Variable<String>(journeyEventName);
    }
    map['employee_name'] = Variable<String>(employeeName);
    map['company_name'] = Variable<String>(companyName);
    if (!nullToAbsent || facialRecognitionStatus != null) {
      map['facial_recognition_status'] =
          Variable<String>(facialRecognitionStatus);
    }
    return map;
  }

  ClockingEventTableCompanion toCompanion(bool nullToAbsent) {
    return ClockingEventTableCompanion(
      clockingEventId: Value(clockingEventId),
      dateTimeEvent: Value(dateTimeEvent),
      dateEvent: Value(dateEvent),
      timeEvent: Value(timeEvent),
      timeZone: Value(timeZone),
      companyIdentifier: Value(companyIdentifier),
      pis: pis == null && nullToAbsent ? const Value.absent() : Value(pis),
      cpf: Value(cpf),
      appVersion: Value(appVersion),
      platform: Value(platform),
      identifierDevice: identifierDevice == null && nullToAbsent
          ? const Value.absent()
          : Value(identifierDevice),
      nameDevice: nameDevice == null && nullToAbsent
          ? const Value.absent()
          : Value(nameDevice),
      developerModeDevice: developerModeDevice == null && nullToAbsent
          ? const Value.absent()
          : Value(developerModeDevice),
      gpsOperationModeDevice: gpsOperationModeDevice == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsOperationModeDevice),
      dateTimeAutomaticDevice: dateTimeAutomaticDevice == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTimeAutomaticDevice),
      timeZoneAutomaticDevice: timeZoneAutomaticDevice == null && nullToAbsent
          ? const Value.absent()
          : Value(timeZoneAutomaticDevice),
      latitudeLocation: latitudeLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(latitudeLocation),
      longitudeLocation: longitudeLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(longitudeLocation),
      geolocationIsMock: Value(geolocationIsMock),
      dateAndTimeLocation: dateAndTimeLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(dateAndTimeLocation),
      employeeId: Value(employeeId),
      fenceState: fenceState == null && nullToAbsent
          ? const Value.absent()
          : Value(fenceState),
      use: Value(use),
      mode: Value(mode),
      online: Value(online),
      origin: Value(origin),
      signature: Value(signature),
      signatureVersion: Value(signatureVersion),
      clientOriginInfo: clientOriginInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(clientOriginInfo),
      appointmentImage: appointmentImage == null && nullToAbsent
          ? const Value.absent()
          : Value(appointmentImage),
      photoNotCaptured: photoNotCaptured == null && nullToAbsent
          ? const Value.absent()
          : Value(photoNotCaptured),
      locationStatus: locationStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(locationStatus),
      isSynchronized: Value(isSynchronized),
      journeyId: journeyId == null && nullToAbsent
          ? const Value.absent()
          : Value(journeyId),
      isMealBreak: Value(isMealBreak),
      journeyEventName: journeyEventName == null && nullToAbsent
          ? const Value.absent()
          : Value(journeyEventName),
      employeeName: Value(employeeName),
      companyName: Value(companyName),
      facialRecognitionStatus: facialRecognitionStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(facialRecognitionStatus),
    );
  }

  factory ClockingEventTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClockingEventTableData(
      clockingEventId: serializer.fromJson<String>(json['clockingEventId']),
      dateTimeEvent: serializer.fromJson<DateTime>(json['dateTimeEvent']),
      dateEvent: serializer.fromJson<String>(json['dateEvent']),
      timeEvent: serializer.fromJson<String>(json['timeEvent']),
      timeZone: serializer.fromJson<String>(json['timeZone']),
      companyIdentifier: serializer.fromJson<String>(json['companyIdentifier']),
      pis: serializer.fromJson<String?>(json['pis']),
      cpf: serializer.fromJson<String>(json['cpf']),
      appVersion: serializer.fromJson<String>(json['appVersion']),
      platform: serializer.fromJson<String>(json['platform']),
      identifierDevice: serializer.fromJson<String?>(json['identifierDevice']),
      nameDevice: serializer.fromJson<String?>(json['nameDevice']),
      developerModeDevice:
          serializer.fromJson<String?>(json['developerModeDevice']),
      gpsOperationModeDevice:
          serializer.fromJson<String?>(json['gpsOperationModeDevice']),
      dateTimeAutomaticDevice:
          serializer.fromJson<bool?>(json['dateTimeAutomaticDevice']),
      timeZoneAutomaticDevice:
          serializer.fromJson<bool?>(json['timeZoneAutomaticDevice']),
      latitudeLocation: serializer.fromJson<double?>(json['latitudeLocation']),
      longitudeLocation:
          serializer.fromJson<double?>(json['longitudeLocation']),
      geolocationIsMock: serializer.fromJson<bool>(json['geolocationIsMock']),
      dateAndTimeLocation:
          serializer.fromJson<DateTime?>(json['dateAndTimeLocation']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
      fenceState: serializer.fromJson<String?>(json['fenceState']),
      use: serializer.fromJson<int>(json['use']),
      mode: serializer.fromJson<String>(json['mode']),
      online: serializer.fromJson<bool>(json['online']),
      origin: serializer.fromJson<String>(json['origin']),
      signature: serializer.fromJson<String>(json['signature']),
      signatureVersion: serializer.fromJson<int>(json['signatureVersion']),
      clientOriginInfo: serializer.fromJson<String?>(json['clientOriginInfo']),
      appointmentImage: serializer.fromJson<String?>(json['appointmentImage']),
      photoNotCaptured: serializer.fromJson<String?>(json['photoNotCaptured']),
      locationStatus: serializer.fromJson<String?>(json['locationStatus']),
      isSynchronized: serializer.fromJson<bool>(json['isSynchronized']),
      journeyId: serializer.fromJson<String?>(json['journeyId']),
      isMealBreak: serializer.fromJson<bool>(json['isMealBreak']),
      journeyEventName: serializer.fromJson<String?>(json['journeyEventName']),
      employeeName: serializer.fromJson<String>(json['employeeName']),
      companyName: serializer.fromJson<String>(json['companyName']),
      facialRecognitionStatus:
          serializer.fromJson<String?>(json['facialRecognitionStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clockingEventId': serializer.toJson<String>(clockingEventId),
      'dateTimeEvent': serializer.toJson<DateTime>(dateTimeEvent),
      'dateEvent': serializer.toJson<String>(dateEvent),
      'timeEvent': serializer.toJson<String>(timeEvent),
      'timeZone': serializer.toJson<String>(timeZone),
      'companyIdentifier': serializer.toJson<String>(companyIdentifier),
      'pis': serializer.toJson<String?>(pis),
      'cpf': serializer.toJson<String>(cpf),
      'appVersion': serializer.toJson<String>(appVersion),
      'platform': serializer.toJson<String>(platform),
      'identifierDevice': serializer.toJson<String?>(identifierDevice),
      'nameDevice': serializer.toJson<String?>(nameDevice),
      'developerModeDevice': serializer.toJson<String?>(developerModeDevice),
      'gpsOperationModeDevice':
          serializer.toJson<String?>(gpsOperationModeDevice),
      'dateTimeAutomaticDevice':
          serializer.toJson<bool?>(dateTimeAutomaticDevice),
      'timeZoneAutomaticDevice':
          serializer.toJson<bool?>(timeZoneAutomaticDevice),
      'latitudeLocation': serializer.toJson<double?>(latitudeLocation),
      'longitudeLocation': serializer.toJson<double?>(longitudeLocation),
      'geolocationIsMock': serializer.toJson<bool>(geolocationIsMock),
      'dateAndTimeLocation': serializer.toJson<DateTime?>(dateAndTimeLocation),
      'employeeId': serializer.toJson<String>(employeeId),
      'fenceState': serializer.toJson<String?>(fenceState),
      'use': serializer.toJson<int>(use),
      'mode': serializer.toJson<String>(mode),
      'online': serializer.toJson<bool>(online),
      'origin': serializer.toJson<String>(origin),
      'signature': serializer.toJson<String>(signature),
      'signatureVersion': serializer.toJson<int>(signatureVersion),
      'clientOriginInfo': serializer.toJson<String?>(clientOriginInfo),
      'appointmentImage': serializer.toJson<String?>(appointmentImage),
      'photoNotCaptured': serializer.toJson<String?>(photoNotCaptured),
      'locationStatus': serializer.toJson<String?>(locationStatus),
      'isSynchronized': serializer.toJson<bool>(isSynchronized),
      'journeyId': serializer.toJson<String?>(journeyId),
      'isMealBreak': serializer.toJson<bool>(isMealBreak),
      'journeyEventName': serializer.toJson<String?>(journeyEventName),
      'employeeName': serializer.toJson<String>(employeeName),
      'companyName': serializer.toJson<String>(companyName),
      'facialRecognitionStatus':
          serializer.toJson<String?>(facialRecognitionStatus),
    };
  }

  ClockingEventTableData copyWith(
          {String? clockingEventId,
          DateTime? dateTimeEvent,
          String? dateEvent,
          String? timeEvent,
          String? timeZone,
          String? companyIdentifier,
          Value<String?> pis = const Value.absent(),
          String? cpf,
          String? appVersion,
          String? platform,
          Value<String?> identifierDevice = const Value.absent(),
          Value<String?> nameDevice = const Value.absent(),
          Value<String?> developerModeDevice = const Value.absent(),
          Value<String?> gpsOperationModeDevice = const Value.absent(),
          Value<bool?> dateTimeAutomaticDevice = const Value.absent(),
          Value<bool?> timeZoneAutomaticDevice = const Value.absent(),
          Value<double?> latitudeLocation = const Value.absent(),
          Value<double?> longitudeLocation = const Value.absent(),
          bool? geolocationIsMock,
          Value<DateTime?> dateAndTimeLocation = const Value.absent(),
          String? employeeId,
          Value<String?> fenceState = const Value.absent(),
          int? use,
          String? mode,
          bool? online,
          String? origin,
          String? signature,
          int? signatureVersion,
          Value<String?> clientOriginInfo = const Value.absent(),
          Value<String?> appointmentImage = const Value.absent(),
          Value<String?> photoNotCaptured = const Value.absent(),
          Value<String?> locationStatus = const Value.absent(),
          bool? isSynchronized,
          Value<String?> journeyId = const Value.absent(),
          bool? isMealBreak,
          Value<String?> journeyEventName = const Value.absent(),
          String? employeeName,
          String? companyName,
          Value<String?> facialRecognitionStatus = const Value.absent()}) =>
      ClockingEventTableData(
        clockingEventId: clockingEventId ?? this.clockingEventId,
        dateTimeEvent: dateTimeEvent ?? this.dateTimeEvent,
        dateEvent: dateEvent ?? this.dateEvent,
        timeEvent: timeEvent ?? this.timeEvent,
        timeZone: timeZone ?? this.timeZone,
        companyIdentifier: companyIdentifier ?? this.companyIdentifier,
        pis: pis.present ? pis.value : this.pis,
        cpf: cpf ?? this.cpf,
        appVersion: appVersion ?? this.appVersion,
        platform: platform ?? this.platform,
        identifierDevice: identifierDevice.present
            ? identifierDevice.value
            : this.identifierDevice,
        nameDevice: nameDevice.present ? nameDevice.value : this.nameDevice,
        developerModeDevice: developerModeDevice.present
            ? developerModeDevice.value
            : this.developerModeDevice,
        gpsOperationModeDevice: gpsOperationModeDevice.present
            ? gpsOperationModeDevice.value
            : this.gpsOperationModeDevice,
        dateTimeAutomaticDevice: dateTimeAutomaticDevice.present
            ? dateTimeAutomaticDevice.value
            : this.dateTimeAutomaticDevice,
        timeZoneAutomaticDevice: timeZoneAutomaticDevice.present
            ? timeZoneAutomaticDevice.value
            : this.timeZoneAutomaticDevice,
        latitudeLocation: latitudeLocation.present
            ? latitudeLocation.value
            : this.latitudeLocation,
        longitudeLocation: longitudeLocation.present
            ? longitudeLocation.value
            : this.longitudeLocation,
        geolocationIsMock: geolocationIsMock ?? this.geolocationIsMock,
        dateAndTimeLocation: dateAndTimeLocation.present
            ? dateAndTimeLocation.value
            : this.dateAndTimeLocation,
        employeeId: employeeId ?? this.employeeId,
        fenceState: fenceState.present ? fenceState.value : this.fenceState,
        use: use ?? this.use,
        mode: mode ?? this.mode,
        online: online ?? this.online,
        origin: origin ?? this.origin,
        signature: signature ?? this.signature,
        signatureVersion: signatureVersion ?? this.signatureVersion,
        clientOriginInfo: clientOriginInfo.present
            ? clientOriginInfo.value
            : this.clientOriginInfo,
        appointmentImage: appointmentImage.present
            ? appointmentImage.value
            : this.appointmentImage,
        photoNotCaptured: photoNotCaptured.present
            ? photoNotCaptured.value
            : this.photoNotCaptured,
        locationStatus:
            locationStatus.present ? locationStatus.value : this.locationStatus,
        isSynchronized: isSynchronized ?? this.isSynchronized,
        journeyId: journeyId.present ? journeyId.value : this.journeyId,
        isMealBreak: isMealBreak ?? this.isMealBreak,
        journeyEventName: journeyEventName.present
            ? journeyEventName.value
            : this.journeyEventName,
        employeeName: employeeName ?? this.employeeName,
        companyName: companyName ?? this.companyName,
        facialRecognitionStatus: facialRecognitionStatus.present
            ? facialRecognitionStatus.value
            : this.facialRecognitionStatus,
      );
  ClockingEventTableData copyWithCompanion(ClockingEventTableCompanion data) {
    return ClockingEventTableData(
      clockingEventId: data.clockingEventId.present
          ? data.clockingEventId.value
          : this.clockingEventId,
      dateTimeEvent: data.dateTimeEvent.present
          ? data.dateTimeEvent.value
          : this.dateTimeEvent,
      dateEvent: data.dateEvent.present ? data.dateEvent.value : this.dateEvent,
      timeEvent: data.timeEvent.present ? data.timeEvent.value : this.timeEvent,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      companyIdentifier: data.companyIdentifier.present
          ? data.companyIdentifier.value
          : this.companyIdentifier,
      pis: data.pis.present ? data.pis.value : this.pis,
      cpf: data.cpf.present ? data.cpf.value : this.cpf,
      appVersion:
          data.appVersion.present ? data.appVersion.value : this.appVersion,
      platform: data.platform.present ? data.platform.value : this.platform,
      identifierDevice: data.identifierDevice.present
          ? data.identifierDevice.value
          : this.identifierDevice,
      nameDevice:
          data.nameDevice.present ? data.nameDevice.value : this.nameDevice,
      developerModeDevice: data.developerModeDevice.present
          ? data.developerModeDevice.value
          : this.developerModeDevice,
      gpsOperationModeDevice: data.gpsOperationModeDevice.present
          ? data.gpsOperationModeDevice.value
          : this.gpsOperationModeDevice,
      dateTimeAutomaticDevice: data.dateTimeAutomaticDevice.present
          ? data.dateTimeAutomaticDevice.value
          : this.dateTimeAutomaticDevice,
      timeZoneAutomaticDevice: data.timeZoneAutomaticDevice.present
          ? data.timeZoneAutomaticDevice.value
          : this.timeZoneAutomaticDevice,
      latitudeLocation: data.latitudeLocation.present
          ? data.latitudeLocation.value
          : this.latitudeLocation,
      longitudeLocation: data.longitudeLocation.present
          ? data.longitudeLocation.value
          : this.longitudeLocation,
      geolocationIsMock: data.geolocationIsMock.present
          ? data.geolocationIsMock.value
          : this.geolocationIsMock,
      dateAndTimeLocation: data.dateAndTimeLocation.present
          ? data.dateAndTimeLocation.value
          : this.dateAndTimeLocation,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      fenceState:
          data.fenceState.present ? data.fenceState.value : this.fenceState,
      use: data.use.present ? data.use.value : this.use,
      mode: data.mode.present ? data.mode.value : this.mode,
      online: data.online.present ? data.online.value : this.online,
      origin: data.origin.present ? data.origin.value : this.origin,
      signature: data.signature.present ? data.signature.value : this.signature,
      signatureVersion: data.signatureVersion.present
          ? data.signatureVersion.value
          : this.signatureVersion,
      clientOriginInfo: data.clientOriginInfo.present
          ? data.clientOriginInfo.value
          : this.clientOriginInfo,
      appointmentImage: data.appointmentImage.present
          ? data.appointmentImage.value
          : this.appointmentImage,
      photoNotCaptured: data.photoNotCaptured.present
          ? data.photoNotCaptured.value
          : this.photoNotCaptured,
      locationStatus: data.locationStatus.present
          ? data.locationStatus.value
          : this.locationStatus,
      isSynchronized: data.isSynchronized.present
          ? data.isSynchronized.value
          : this.isSynchronized,
      journeyId: data.journeyId.present ? data.journeyId.value : this.journeyId,
      isMealBreak:
          data.isMealBreak.present ? data.isMealBreak.value : this.isMealBreak,
      journeyEventName: data.journeyEventName.present
          ? data.journeyEventName.value
          : this.journeyEventName,
      employeeName: data.employeeName.present
          ? data.employeeName.value
          : this.employeeName,
      companyName:
          data.companyName.present ? data.companyName.value : this.companyName,
      facialRecognitionStatus: data.facialRecognitionStatus.present
          ? data.facialRecognitionStatus.value
          : this.facialRecognitionStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClockingEventTableData(')
          ..write('clockingEventId: $clockingEventId, ')
          ..write('dateTimeEvent: $dateTimeEvent, ')
          ..write('dateEvent: $dateEvent, ')
          ..write('timeEvent: $timeEvent, ')
          ..write('timeZone: $timeZone, ')
          ..write('companyIdentifier: $companyIdentifier, ')
          ..write('pis: $pis, ')
          ..write('cpf: $cpf, ')
          ..write('appVersion: $appVersion, ')
          ..write('platform: $platform, ')
          ..write('identifierDevice: $identifierDevice, ')
          ..write('nameDevice: $nameDevice, ')
          ..write('developerModeDevice: $developerModeDevice, ')
          ..write('gpsOperationModeDevice: $gpsOperationModeDevice, ')
          ..write('dateTimeAutomaticDevice: $dateTimeAutomaticDevice, ')
          ..write('timeZoneAutomaticDevice: $timeZoneAutomaticDevice, ')
          ..write('latitudeLocation: $latitudeLocation, ')
          ..write('longitudeLocation: $longitudeLocation, ')
          ..write('geolocationIsMock: $geolocationIsMock, ')
          ..write('dateAndTimeLocation: $dateAndTimeLocation, ')
          ..write('employeeId: $employeeId, ')
          ..write('fenceState: $fenceState, ')
          ..write('use: $use, ')
          ..write('mode: $mode, ')
          ..write('online: $online, ')
          ..write('origin: $origin, ')
          ..write('signature: $signature, ')
          ..write('signatureVersion: $signatureVersion, ')
          ..write('clientOriginInfo: $clientOriginInfo, ')
          ..write('appointmentImage: $appointmentImage, ')
          ..write('photoNotCaptured: $photoNotCaptured, ')
          ..write('locationStatus: $locationStatus, ')
          ..write('isSynchronized: $isSynchronized, ')
          ..write('journeyId: $journeyId, ')
          ..write('isMealBreak: $isMealBreak, ')
          ..write('journeyEventName: $journeyEventName, ')
          ..write('employeeName: $employeeName, ')
          ..write('companyName: $companyName, ')
          ..write('facialRecognitionStatus: $facialRecognitionStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        clockingEventId,
        dateTimeEvent,
        dateEvent,
        timeEvent,
        timeZone,
        companyIdentifier,
        pis,
        cpf,
        appVersion,
        platform,
        identifierDevice,
        nameDevice,
        developerModeDevice,
        gpsOperationModeDevice,
        dateTimeAutomaticDevice,
        timeZoneAutomaticDevice,
        latitudeLocation,
        longitudeLocation,
        geolocationIsMock,
        dateAndTimeLocation,
        employeeId,
        fenceState,
        use,
        mode,
        online,
        origin,
        signature,
        signatureVersion,
        clientOriginInfo,
        appointmentImage,
        photoNotCaptured,
        locationStatus,
        isSynchronized,
        journeyId,
        isMealBreak,
        journeyEventName,
        employeeName,
        companyName,
        facialRecognitionStatus
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClockingEventTableData &&
          other.clockingEventId == this.clockingEventId &&
          other.dateTimeEvent == this.dateTimeEvent &&
          other.dateEvent == this.dateEvent &&
          other.timeEvent == this.timeEvent &&
          other.timeZone == this.timeZone &&
          other.companyIdentifier == this.companyIdentifier &&
          other.pis == this.pis &&
          other.cpf == this.cpf &&
          other.appVersion == this.appVersion &&
          other.platform == this.platform &&
          other.identifierDevice == this.identifierDevice &&
          other.nameDevice == this.nameDevice &&
          other.developerModeDevice == this.developerModeDevice &&
          other.gpsOperationModeDevice == this.gpsOperationModeDevice &&
          other.dateTimeAutomaticDevice == this.dateTimeAutomaticDevice &&
          other.timeZoneAutomaticDevice == this.timeZoneAutomaticDevice &&
          other.latitudeLocation == this.latitudeLocation &&
          other.longitudeLocation == this.longitudeLocation &&
          other.geolocationIsMock == this.geolocationIsMock &&
          other.dateAndTimeLocation == this.dateAndTimeLocation &&
          other.employeeId == this.employeeId &&
          other.fenceState == this.fenceState &&
          other.use == this.use &&
          other.mode == this.mode &&
          other.online == this.online &&
          other.origin == this.origin &&
          other.signature == this.signature &&
          other.signatureVersion == this.signatureVersion &&
          other.clientOriginInfo == this.clientOriginInfo &&
          other.appointmentImage == this.appointmentImage &&
          other.photoNotCaptured == this.photoNotCaptured &&
          other.locationStatus == this.locationStatus &&
          other.isSynchronized == this.isSynchronized &&
          other.journeyId == this.journeyId &&
          other.isMealBreak == this.isMealBreak &&
          other.journeyEventName == this.journeyEventName &&
          other.employeeName == this.employeeName &&
          other.companyName == this.companyName &&
          other.facialRecognitionStatus == this.facialRecognitionStatus);
}

class ClockingEventTableCompanion
    extends UpdateCompanion<ClockingEventTableData> {
  final Value<String> clockingEventId;
  final Value<DateTime> dateTimeEvent;
  final Value<String> dateEvent;
  final Value<String> timeEvent;
  final Value<String> timeZone;
  final Value<String> companyIdentifier;
  final Value<String?> pis;
  final Value<String> cpf;
  final Value<String> appVersion;
  final Value<String> platform;
  final Value<String?> identifierDevice;
  final Value<String?> nameDevice;
  final Value<String?> developerModeDevice;
  final Value<String?> gpsOperationModeDevice;
  final Value<bool?> dateTimeAutomaticDevice;
  final Value<bool?> timeZoneAutomaticDevice;
  final Value<double?> latitudeLocation;
  final Value<double?> longitudeLocation;
  final Value<bool> geolocationIsMock;
  final Value<DateTime?> dateAndTimeLocation;
  final Value<String> employeeId;
  final Value<String?> fenceState;
  final Value<int> use;
  final Value<String> mode;
  final Value<bool> online;
  final Value<String> origin;
  final Value<String> signature;
  final Value<int> signatureVersion;
  final Value<String?> clientOriginInfo;
  final Value<String?> appointmentImage;
  final Value<String?> photoNotCaptured;
  final Value<String?> locationStatus;
  final Value<bool> isSynchronized;
  final Value<String?> journeyId;
  final Value<bool> isMealBreak;
  final Value<String?> journeyEventName;
  final Value<String> employeeName;
  final Value<String> companyName;
  final Value<String?> facialRecognitionStatus;
  final Value<int> rowid;
  const ClockingEventTableCompanion({
    this.clockingEventId = const Value.absent(),
    this.dateTimeEvent = const Value.absent(),
    this.dateEvent = const Value.absent(),
    this.timeEvent = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.companyIdentifier = const Value.absent(),
    this.pis = const Value.absent(),
    this.cpf = const Value.absent(),
    this.appVersion = const Value.absent(),
    this.platform = const Value.absent(),
    this.identifierDevice = const Value.absent(),
    this.nameDevice = const Value.absent(),
    this.developerModeDevice = const Value.absent(),
    this.gpsOperationModeDevice = const Value.absent(),
    this.dateTimeAutomaticDevice = const Value.absent(),
    this.timeZoneAutomaticDevice = const Value.absent(),
    this.latitudeLocation = const Value.absent(),
    this.longitudeLocation = const Value.absent(),
    this.geolocationIsMock = const Value.absent(),
    this.dateAndTimeLocation = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.fenceState = const Value.absent(),
    this.use = const Value.absent(),
    this.mode = const Value.absent(),
    this.online = const Value.absent(),
    this.origin = const Value.absent(),
    this.signature = const Value.absent(),
    this.signatureVersion = const Value.absent(),
    this.clientOriginInfo = const Value.absent(),
    this.appointmentImage = const Value.absent(),
    this.photoNotCaptured = const Value.absent(),
    this.locationStatus = const Value.absent(),
    this.isSynchronized = const Value.absent(),
    this.journeyId = const Value.absent(),
    this.isMealBreak = const Value.absent(),
    this.journeyEventName = const Value.absent(),
    this.employeeName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.facialRecognitionStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClockingEventTableCompanion.insert({
    required String clockingEventId,
    required DateTime dateTimeEvent,
    required String dateEvent,
    required String timeEvent,
    required String timeZone,
    required String companyIdentifier,
    this.pis = const Value.absent(),
    required String cpf,
    required String appVersion,
    required String platform,
    this.identifierDevice = const Value.absent(),
    this.nameDevice = const Value.absent(),
    this.developerModeDevice = const Value.absent(),
    this.gpsOperationModeDevice = const Value.absent(),
    this.dateTimeAutomaticDevice = const Value.absent(),
    this.timeZoneAutomaticDevice = const Value.absent(),
    this.latitudeLocation = const Value.absent(),
    this.longitudeLocation = const Value.absent(),
    required bool geolocationIsMock,
    this.dateAndTimeLocation = const Value.absent(),
    required String employeeId,
    this.fenceState = const Value.absent(),
    required int use,
    required String mode,
    this.online = const Value.absent(),
    required String origin,
    required String signature,
    required int signatureVersion,
    this.clientOriginInfo = const Value.absent(),
    this.appointmentImage = const Value.absent(),
    this.photoNotCaptured = const Value.absent(),
    this.locationStatus = const Value.absent(),
    required bool isSynchronized,
    this.journeyId = const Value.absent(),
    this.isMealBreak = const Value.absent(),
    this.journeyEventName = const Value.absent(),
    this.employeeName = const Value.absent(),
    this.companyName = const Value.absent(),
    this.facialRecognitionStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : clockingEventId = Value(clockingEventId),
        dateTimeEvent = Value(dateTimeEvent),
        dateEvent = Value(dateEvent),
        timeEvent = Value(timeEvent),
        timeZone = Value(timeZone),
        companyIdentifier = Value(companyIdentifier),
        cpf = Value(cpf),
        appVersion = Value(appVersion),
        platform = Value(platform),
        geolocationIsMock = Value(geolocationIsMock),
        employeeId = Value(employeeId),
        use = Value(use),
        mode = Value(mode),
        origin = Value(origin),
        signature = Value(signature),
        signatureVersion = Value(signatureVersion),
        isSynchronized = Value(isSynchronized);
  static Insertable<ClockingEventTableData> custom({
    Expression<String>? clockingEventId,
    Expression<DateTime>? dateTimeEvent,
    Expression<String>? dateEvent,
    Expression<String>? timeEvent,
    Expression<String>? timeZone,
    Expression<String>? companyIdentifier,
    Expression<String>? pis,
    Expression<String>? cpf,
    Expression<String>? appVersion,
    Expression<String>? platform,
    Expression<String>? identifierDevice,
    Expression<String>? nameDevice,
    Expression<String>? developerModeDevice,
    Expression<String>? gpsOperationModeDevice,
    Expression<bool>? dateTimeAutomaticDevice,
    Expression<bool>? timeZoneAutomaticDevice,
    Expression<double>? latitudeLocation,
    Expression<double>? longitudeLocation,
    Expression<bool>? geolocationIsMock,
    Expression<DateTime>? dateAndTimeLocation,
    Expression<String>? employeeId,
    Expression<String>? fenceState,
    Expression<int>? use,
    Expression<String>? mode,
    Expression<bool>? online,
    Expression<String>? origin,
    Expression<String>? signature,
    Expression<int>? signatureVersion,
    Expression<String>? clientOriginInfo,
    Expression<String>? appointmentImage,
    Expression<String>? photoNotCaptured,
    Expression<String>? locationStatus,
    Expression<bool>? isSynchronized,
    Expression<String>? journeyId,
    Expression<bool>? isMealBreak,
    Expression<String>? journeyEventName,
    Expression<String>? employeeName,
    Expression<String>? companyName,
    Expression<String>? facialRecognitionStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clockingEventId != null) 'clocking_event_id': clockingEventId,
      if (dateTimeEvent != null) 'date_time_event': dateTimeEvent,
      if (dateEvent != null) 'date_event': dateEvent,
      if (timeEvent != null) 'time_event': timeEvent,
      if (timeZone != null) 'time_zone': timeZone,
      if (companyIdentifier != null) 'company_identifier': companyIdentifier,
      if (pis != null) 'pis': pis,
      if (cpf != null) 'cpf': cpf,
      if (appVersion != null) 'app_version': appVersion,
      if (platform != null) 'platform': platform,
      if (identifierDevice != null) 'identifier_device': identifierDevice,
      if (nameDevice != null) 'name_device': nameDevice,
      if (developerModeDevice != null)
        'developer_mode_device': developerModeDevice,
      if (gpsOperationModeDevice != null)
        'gps_operation_mode_device': gpsOperationModeDevice,
      if (dateTimeAutomaticDevice != null)
        'date_time_automatic_device': dateTimeAutomaticDevice,
      if (timeZoneAutomaticDevice != null)
        'time_zone_automatic_device': timeZoneAutomaticDevice,
      if (latitudeLocation != null) 'latitude_location': latitudeLocation,
      if (longitudeLocation != null) 'longitude_location': longitudeLocation,
      if (geolocationIsMock != null) 'geolocation_is_mock': geolocationIsMock,
      if (dateAndTimeLocation != null)
        'date_and_time_location': dateAndTimeLocation,
      if (employeeId != null) 'employee_id': employeeId,
      if (fenceState != null) 'fence_state': fenceState,
      if (use != null) 'use': use,
      if (mode != null) 'mode': mode,
      if (online != null) 'online': online,
      if (origin != null) 'origin': origin,
      if (signature != null) 'signature': signature,
      if (signatureVersion != null) 'signature_version': signatureVersion,
      if (clientOriginInfo != null) 'client_origin_info': clientOriginInfo,
      if (appointmentImage != null) 'appointment_image': appointmentImage,
      if (photoNotCaptured != null) 'photo_not_captured': photoNotCaptured,
      if (locationStatus != null) 'location_status': locationStatus,
      if (isSynchronized != null) 'is_synchronized': isSynchronized,
      if (journeyId != null) 'journey_id': journeyId,
      if (isMealBreak != null) 'is_meal_break': isMealBreak,
      if (journeyEventName != null) 'journey_event_name': journeyEventName,
      if (employeeName != null) 'employee_name': employeeName,
      if (companyName != null) 'company_name': companyName,
      if (facialRecognitionStatus != null)
        'facial_recognition_status': facialRecognitionStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClockingEventTableCompanion copyWith(
      {Value<String>? clockingEventId,
      Value<DateTime>? dateTimeEvent,
      Value<String>? dateEvent,
      Value<String>? timeEvent,
      Value<String>? timeZone,
      Value<String>? companyIdentifier,
      Value<String?>? pis,
      Value<String>? cpf,
      Value<String>? appVersion,
      Value<String>? platform,
      Value<String?>? identifierDevice,
      Value<String?>? nameDevice,
      Value<String?>? developerModeDevice,
      Value<String?>? gpsOperationModeDevice,
      Value<bool?>? dateTimeAutomaticDevice,
      Value<bool?>? timeZoneAutomaticDevice,
      Value<double?>? latitudeLocation,
      Value<double?>? longitudeLocation,
      Value<bool>? geolocationIsMock,
      Value<DateTime?>? dateAndTimeLocation,
      Value<String>? employeeId,
      Value<String?>? fenceState,
      Value<int>? use,
      Value<String>? mode,
      Value<bool>? online,
      Value<String>? origin,
      Value<String>? signature,
      Value<int>? signatureVersion,
      Value<String?>? clientOriginInfo,
      Value<String?>? appointmentImage,
      Value<String?>? photoNotCaptured,
      Value<String?>? locationStatus,
      Value<bool>? isSynchronized,
      Value<String?>? journeyId,
      Value<bool>? isMealBreak,
      Value<String?>? journeyEventName,
      Value<String>? employeeName,
      Value<String>? companyName,
      Value<String?>? facialRecognitionStatus,
      Value<int>? rowid}) {
    return ClockingEventTableCompanion(
      clockingEventId: clockingEventId ?? this.clockingEventId,
      dateTimeEvent: dateTimeEvent ?? this.dateTimeEvent,
      dateEvent: dateEvent ?? this.dateEvent,
      timeEvent: timeEvent ?? this.timeEvent,
      timeZone: timeZone ?? this.timeZone,
      companyIdentifier: companyIdentifier ?? this.companyIdentifier,
      pis: pis ?? this.pis,
      cpf: cpf ?? this.cpf,
      appVersion: appVersion ?? this.appVersion,
      platform: platform ?? this.platform,
      identifierDevice: identifierDevice ?? this.identifierDevice,
      nameDevice: nameDevice ?? this.nameDevice,
      developerModeDevice: developerModeDevice ?? this.developerModeDevice,
      gpsOperationModeDevice:
          gpsOperationModeDevice ?? this.gpsOperationModeDevice,
      dateTimeAutomaticDevice:
          dateTimeAutomaticDevice ?? this.dateTimeAutomaticDevice,
      timeZoneAutomaticDevice:
          timeZoneAutomaticDevice ?? this.timeZoneAutomaticDevice,
      latitudeLocation: latitudeLocation ?? this.latitudeLocation,
      longitudeLocation: longitudeLocation ?? this.longitudeLocation,
      geolocationIsMock: geolocationIsMock ?? this.geolocationIsMock,
      dateAndTimeLocation: dateAndTimeLocation ?? this.dateAndTimeLocation,
      employeeId: employeeId ?? this.employeeId,
      fenceState: fenceState ?? this.fenceState,
      use: use ?? this.use,
      mode: mode ?? this.mode,
      online: online ?? this.online,
      origin: origin ?? this.origin,
      signature: signature ?? this.signature,
      signatureVersion: signatureVersion ?? this.signatureVersion,
      clientOriginInfo: clientOriginInfo ?? this.clientOriginInfo,
      appointmentImage: appointmentImage ?? this.appointmentImage,
      photoNotCaptured: photoNotCaptured ?? this.photoNotCaptured,
      locationStatus: locationStatus ?? this.locationStatus,
      isSynchronized: isSynchronized ?? this.isSynchronized,
      journeyId: journeyId ?? this.journeyId,
      isMealBreak: isMealBreak ?? this.isMealBreak,
      journeyEventName: journeyEventName ?? this.journeyEventName,
      employeeName: employeeName ?? this.employeeName,
      companyName: companyName ?? this.companyName,
      facialRecognitionStatus:
          facialRecognitionStatus ?? this.facialRecognitionStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clockingEventId.present) {
      map['clocking_event_id'] = Variable<String>(clockingEventId.value);
    }
    if (dateTimeEvent.present) {
      map['date_time_event'] = Variable<DateTime>(dateTimeEvent.value);
    }
    if (dateEvent.present) {
      map['date_event'] = Variable<String>(dateEvent.value);
    }
    if (timeEvent.present) {
      map['time_event'] = Variable<String>(timeEvent.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (companyIdentifier.present) {
      map['company_identifier'] = Variable<String>(companyIdentifier.value);
    }
    if (pis.present) {
      map['pis'] = Variable<String>(pis.value);
    }
    if (cpf.present) {
      map['cpf'] = Variable<String>(cpf.value);
    }
    if (appVersion.present) {
      map['app_version'] = Variable<String>(appVersion.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (identifierDevice.present) {
      map['identifier_device'] = Variable<String>(identifierDevice.value);
    }
    if (nameDevice.present) {
      map['name_device'] = Variable<String>(nameDevice.value);
    }
    if (developerModeDevice.present) {
      map['developer_mode_device'] =
          Variable<String>(developerModeDevice.value);
    }
    if (gpsOperationModeDevice.present) {
      map['gps_operation_mode_device'] =
          Variable<String>(gpsOperationModeDevice.value);
    }
    if (dateTimeAutomaticDevice.present) {
      map['date_time_automatic_device'] =
          Variable<bool>(dateTimeAutomaticDevice.value);
    }
    if (timeZoneAutomaticDevice.present) {
      map['time_zone_automatic_device'] =
          Variable<bool>(timeZoneAutomaticDevice.value);
    }
    if (latitudeLocation.present) {
      map['latitude_location'] = Variable<double>(latitudeLocation.value);
    }
    if (longitudeLocation.present) {
      map['longitude_location'] = Variable<double>(longitudeLocation.value);
    }
    if (geolocationIsMock.present) {
      map['geolocation_is_mock'] = Variable<bool>(geolocationIsMock.value);
    }
    if (dateAndTimeLocation.present) {
      map['date_and_time_location'] =
          Variable<DateTime>(dateAndTimeLocation.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (fenceState.present) {
      map['fence_state'] = Variable<String>(fenceState.value);
    }
    if (use.present) {
      map['use'] = Variable<int>(use.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(mode.value);
    }
    if (online.present) {
      map['online'] = Variable<bool>(online.value);
    }
    if (origin.present) {
      map['origin'] = Variable<String>(origin.value);
    }
    if (signature.present) {
      map['signature'] = Variable<String>(signature.value);
    }
    if (signatureVersion.present) {
      map['signature_version'] = Variable<int>(signatureVersion.value);
    }
    if (clientOriginInfo.present) {
      map['client_origin_info'] = Variable<String>(clientOriginInfo.value);
    }
    if (appointmentImage.present) {
      map['appointment_image'] = Variable<String>(appointmentImage.value);
    }
    if (photoNotCaptured.present) {
      map['photo_not_captured'] = Variable<String>(photoNotCaptured.value);
    }
    if (locationStatus.present) {
      map['location_status'] = Variable<String>(locationStatus.value);
    }
    if (isSynchronized.present) {
      map['is_synchronized'] = Variable<bool>(isSynchronized.value);
    }
    if (journeyId.present) {
      map['journey_id'] = Variable<String>(journeyId.value);
    }
    if (isMealBreak.present) {
      map['is_meal_break'] = Variable<bool>(isMealBreak.value);
    }
    if (journeyEventName.present) {
      map['journey_event_name'] = Variable<String>(journeyEventName.value);
    }
    if (employeeName.present) {
      map['employee_name'] = Variable<String>(employeeName.value);
    }
    if (companyName.present) {
      map['company_name'] = Variable<String>(companyName.value);
    }
    if (facialRecognitionStatus.present) {
      map['facial_recognition_status'] =
          Variable<String>(facialRecognitionStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClockingEventTableCompanion(')
          ..write('clockingEventId: $clockingEventId, ')
          ..write('dateTimeEvent: $dateTimeEvent, ')
          ..write('dateEvent: $dateEvent, ')
          ..write('timeEvent: $timeEvent, ')
          ..write('timeZone: $timeZone, ')
          ..write('companyIdentifier: $companyIdentifier, ')
          ..write('pis: $pis, ')
          ..write('cpf: $cpf, ')
          ..write('appVersion: $appVersion, ')
          ..write('platform: $platform, ')
          ..write('identifierDevice: $identifierDevice, ')
          ..write('nameDevice: $nameDevice, ')
          ..write('developerModeDevice: $developerModeDevice, ')
          ..write('gpsOperationModeDevice: $gpsOperationModeDevice, ')
          ..write('dateTimeAutomaticDevice: $dateTimeAutomaticDevice, ')
          ..write('timeZoneAutomaticDevice: $timeZoneAutomaticDevice, ')
          ..write('latitudeLocation: $latitudeLocation, ')
          ..write('longitudeLocation: $longitudeLocation, ')
          ..write('geolocationIsMock: $geolocationIsMock, ')
          ..write('dateAndTimeLocation: $dateAndTimeLocation, ')
          ..write('employeeId: $employeeId, ')
          ..write('fenceState: $fenceState, ')
          ..write('use: $use, ')
          ..write('mode: $mode, ')
          ..write('online: $online, ')
          ..write('origin: $origin, ')
          ..write('signature: $signature, ')
          ..write('signatureVersion: $signatureVersion, ')
          ..write('clientOriginInfo: $clientOriginInfo, ')
          ..write('appointmentImage: $appointmentImage, ')
          ..write('photoNotCaptured: $photoNotCaptured, ')
          ..write('locationStatus: $locationStatus, ')
          ..write('isSynchronized: $isSynchronized, ')
          ..write('journeyId: $journeyId, ')
          ..write('isMealBreak: $isMealBreak, ')
          ..write('journeyEventName: $journeyEventName, ')
          ..write('employeeName: $employeeName, ')
          ..write('companyName: $companyName, ')
          ..write('facialRecognitionStatus: $facialRecognitionStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FenceTableTable extends FenceTable
    with TableInfo<$FenceTableTable, FenceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FenceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fence_table';
  @override
  VerificationContext validateIntegrity(Insertable<FenceTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FenceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FenceTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $FenceTableTable createAlias(String alias) {
    return $FenceTableTable(attachedDatabase, alias);
  }
}

class FenceTableData extends DataClass implements Insertable<FenceTableData> {
  final String id;
  final String name;
  const FenceTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  FenceTableCompanion toCompanion(bool nullToAbsent) {
    return FenceTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory FenceTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FenceTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  FenceTableData copyWith({String? id, String? name}) => FenceTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  FenceTableData copyWithCompanion(FenceTableCompanion data) {
    return FenceTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FenceTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FenceTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class FenceTableCompanion extends UpdateCompanion<FenceTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const FenceTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FenceTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<FenceTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FenceTableCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return FenceTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FenceTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PerimeterTableTable extends PerimeterTable
    with TableInfo<$PerimeterTableTable, PerimeterTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PerimeterTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _latitudeMeta =
      const VerificationMeta('latitude');
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
      'latitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _longitudeMeta =
      const VerificationMeta('longitude');
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
      'longitude', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _radiusMeta = const VerificationMeta('radius');
  @override
  late final GeneratedColumn<double> radius = GeneratedColumn<double>(
      'radius', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateAndTimeMeta =
      const VerificationMeta('dateAndTime');
  @override
  late final GeneratedColumn<DateTime> dateAndTime = GeneratedColumn<DateTime>(
      'date_and_time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, type, latitude, longitude, radius, dateAndTime];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'perimeter_table';
  @override
  VerificationContext validateIntegrity(Insertable<PerimeterTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('radius')) {
      context.handle(_radiusMeta,
          radius.isAcceptableOrUnknown(data['radius']!, _radiusMeta));
    } else if (isInserting) {
      context.missing(_radiusMeta);
    }
    if (data.containsKey('date_and_time')) {
      context.handle(
          _dateAndTimeMeta,
          dateAndTime.isAcceptableOrUnknown(
              data['date_and_time']!, _dateAndTimeMeta));
    } else if (isInserting) {
      context.missing(_dateAndTimeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PerimeterTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PerimeterTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      latitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}latitude'])!,
      longitude: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}longitude'])!,
      radius: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}radius'])!,
      dateAndTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_and_time'])!,
    );
  }

  @override
  $PerimeterTableTable createAlias(String alias) {
    return $PerimeterTableTable(attachedDatabase, alias);
  }
}

class PerimeterTableData extends DataClass
    implements Insertable<PerimeterTableData> {
  final String id;
  final String type;
  final double latitude;
  final double longitude;
  final double radius;
  final DateTime dateAndTime;
  const PerimeterTableData(
      {required this.id,
      required this.type,
      required this.latitude,
      required this.longitude,
      required this.radius,
      required this.dateAndTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    map['radius'] = Variable<double>(radius);
    map['date_and_time'] = Variable<DateTime>(dateAndTime);
    return map;
  }

  PerimeterTableCompanion toCompanion(bool nullToAbsent) {
    return PerimeterTableCompanion(
      id: Value(id),
      type: Value(type),
      latitude: Value(latitude),
      longitude: Value(longitude),
      radius: Value(radius),
      dateAndTime: Value(dateAndTime),
    );
  }

  factory PerimeterTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PerimeterTableData(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      radius: serializer.fromJson<double>(json['radius']),
      dateAndTime: serializer.fromJson<DateTime>(json['dateAndTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'radius': serializer.toJson<double>(radius),
      'dateAndTime': serializer.toJson<DateTime>(dateAndTime),
    };
  }

  PerimeterTableData copyWith(
          {String? id,
          String? type,
          double? latitude,
          double? longitude,
          double? radius,
          DateTime? dateAndTime}) =>
      PerimeterTableData(
        id: id ?? this.id,
        type: type ?? this.type,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        radius: radius ?? this.radius,
        dateAndTime: dateAndTime ?? this.dateAndTime,
      );
  PerimeterTableData copyWithCompanion(PerimeterTableCompanion data) {
    return PerimeterTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      radius: data.radius.present ? data.radius.value : this.radius,
      dateAndTime:
          data.dateAndTime.present ? data.dateAndTime.value : this.dateAndTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PerimeterTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('radius: $radius, ')
          ..write('dateAndTime: $dateAndTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, type, latitude, longitude, radius, dateAndTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PerimeterTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.radius == this.radius &&
          other.dateAndTime == this.dateAndTime);
}

class PerimeterTableCompanion extends UpdateCompanion<PerimeterTableData> {
  final Value<String> id;
  final Value<String> type;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double> radius;
  final Value<DateTime> dateAndTime;
  final Value<int> rowid;
  const PerimeterTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.radius = const Value.absent(),
    this.dateAndTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PerimeterTableCompanion.insert({
    required String id,
    required String type,
    required double latitude,
    required double longitude,
    required double radius,
    required DateTime dateAndTime,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        latitude = Value(latitude),
        longitude = Value(longitude),
        radius = Value(radius),
        dateAndTime = Value(dateAndTime);
  static Insertable<PerimeterTableData> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? radius,
    Expression<DateTime>? dateAndTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (radius != null) 'radius': radius,
      if (dateAndTime != null) 'date_and_time': dateAndTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PerimeterTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? type,
      Value<double>? latitude,
      Value<double>? longitude,
      Value<double>? radius,
      Value<DateTime>? dateAndTime,
      Value<int>? rowid}) {
    return PerimeterTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      radius: radius ?? this.radius,
      dateAndTime: dateAndTime ?? this.dateAndTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (radius.present) {
      map['radius'] = Variable<double>(radius.value);
    }
    if (dateAndTime.present) {
      map['date_and_time'] = Variable<DateTime>(dateAndTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PerimeterTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('radius: $radius, ')
          ..write('dateAndTime: $dateAndTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeeFenceTableTable extends EmployeeFenceTable
    with TableInfo<$EmployeeFenceTableTable, EmployeeFenceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeFenceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  static const VerificationMeta _fenceIdMeta =
      const VerificationMeta('fenceId');
  @override
  late final GeneratedColumn<String> fenceId = GeneratedColumn<String>(
      'fence_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fence_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [employeeId, fenceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_fence_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<EmployeeFenceTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('fence_id')) {
      context.handle(_fenceIdMeta,
          fenceId.isAcceptableOrUnknown(data['fence_id']!, _fenceIdMeta));
    } else if (isInserting) {
      context.missing(_fenceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, fenceId};
  @override
  EmployeeFenceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeFenceTableData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      fenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fence_id'])!,
    );
  }

  @override
  $EmployeeFenceTableTable createAlias(String alias) {
    return $EmployeeFenceTableTable(attachedDatabase, alias);
  }
}

class EmployeeFenceTableData extends DataClass
    implements Insertable<EmployeeFenceTableData> {
  final String employeeId;
  final String fenceId;
  const EmployeeFenceTableData(
      {required this.employeeId, required this.fenceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['fence_id'] = Variable<String>(fenceId);
    return map;
  }

  EmployeeFenceTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeeFenceTableCompanion(
      employeeId: Value(employeeId),
      fenceId: Value(fenceId),
    );
  }

  factory EmployeeFenceTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeFenceTableData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      fenceId: serializer.fromJson<String>(json['fenceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'fenceId': serializer.toJson<String>(fenceId),
    };
  }

  EmployeeFenceTableData copyWith({String? employeeId, String? fenceId}) =>
      EmployeeFenceTableData(
        employeeId: employeeId ?? this.employeeId,
        fenceId: fenceId ?? this.fenceId,
      );
  EmployeeFenceTableData copyWithCompanion(EmployeeFenceTableCompanion data) {
    return EmployeeFenceTableData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      fenceId: data.fenceId.present ? data.fenceId.value : this.fenceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeFenceTableData(')
          ..write('employeeId: $employeeId, ')
          ..write('fenceId: $fenceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, fenceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeFenceTableData &&
          other.employeeId == this.employeeId &&
          other.fenceId == this.fenceId);
}

class EmployeeFenceTableCompanion
    extends UpdateCompanion<EmployeeFenceTableData> {
  final Value<String> employeeId;
  final Value<String> fenceId;
  final Value<int> rowid;
  const EmployeeFenceTableCompanion({
    this.employeeId = const Value.absent(),
    this.fenceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeeFenceTableCompanion.insert({
    required String employeeId,
    required String fenceId,
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        fenceId = Value(fenceId);
  static Insertable<EmployeeFenceTableData> custom({
    Expression<String>? employeeId,
    Expression<String>? fenceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (fenceId != null) 'fence_id': fenceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeeFenceTableCompanion copyWith(
      {Value<String>? employeeId, Value<String>? fenceId, Value<int>? rowid}) {
    return EmployeeFenceTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      fenceId: fenceId ?? this.fenceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (fenceId.present) {
      map['fence_id'] = Variable<String>(fenceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeFenceTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('fenceId: $fenceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FencePerimeterTableTable extends FencePerimeterTable
    with TableInfo<$FencePerimeterTableTable, FencePerimeterTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FencePerimeterTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _perimeterIdMeta =
      const VerificationMeta('perimeterId');
  @override
  late final GeneratedColumn<String> perimeterId = GeneratedColumn<String>(
      'perimeter_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES perimeter_table (id)'));
  static const VerificationMeta _fenceIdMeta =
      const VerificationMeta('fenceId');
  @override
  late final GeneratedColumn<String> fenceId = GeneratedColumn<String>(
      'fence_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES fence_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [perimeterId, fenceId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fence_perimeter_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<FencePerimeterTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('perimeter_id')) {
      context.handle(
          _perimeterIdMeta,
          perimeterId.isAcceptableOrUnknown(
              data['perimeter_id']!, _perimeterIdMeta));
    } else if (isInserting) {
      context.missing(_perimeterIdMeta);
    }
    if (data.containsKey('fence_id')) {
      context.handle(_fenceIdMeta,
          fenceId.isAcceptableOrUnknown(data['fence_id']!, _fenceIdMeta));
    } else if (isInserting) {
      context.missing(_fenceIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {perimeterId, fenceId};
  @override
  FencePerimeterTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FencePerimeterTableData(
      perimeterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}perimeter_id'])!,
      fenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fence_id'])!,
    );
  }

  @override
  $FencePerimeterTableTable createAlias(String alias) {
    return $FencePerimeterTableTable(attachedDatabase, alias);
  }
}

class FencePerimeterTableData extends DataClass
    implements Insertable<FencePerimeterTableData> {
  final String perimeterId;
  final String fenceId;
  const FencePerimeterTableData(
      {required this.perimeterId, required this.fenceId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['perimeter_id'] = Variable<String>(perimeterId);
    map['fence_id'] = Variable<String>(fenceId);
    return map;
  }

  FencePerimeterTableCompanion toCompanion(bool nullToAbsent) {
    return FencePerimeterTableCompanion(
      perimeterId: Value(perimeterId),
      fenceId: Value(fenceId),
    );
  }

  factory FencePerimeterTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FencePerimeterTableData(
      perimeterId: serializer.fromJson<String>(json['perimeterId']),
      fenceId: serializer.fromJson<String>(json['fenceId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'perimeterId': serializer.toJson<String>(perimeterId),
      'fenceId': serializer.toJson<String>(fenceId),
    };
  }

  FencePerimeterTableData copyWith({String? perimeterId, String? fenceId}) =>
      FencePerimeterTableData(
        perimeterId: perimeterId ?? this.perimeterId,
        fenceId: fenceId ?? this.fenceId,
      );
  FencePerimeterTableData copyWithCompanion(FencePerimeterTableCompanion data) {
    return FencePerimeterTableData(
      perimeterId:
          data.perimeterId.present ? data.perimeterId.value : this.perimeterId,
      fenceId: data.fenceId.present ? data.fenceId.value : this.fenceId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FencePerimeterTableData(')
          ..write('perimeterId: $perimeterId, ')
          ..write('fenceId: $fenceId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(perimeterId, fenceId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FencePerimeterTableData &&
          other.perimeterId == this.perimeterId &&
          other.fenceId == this.fenceId);
}

class FencePerimeterTableCompanion
    extends UpdateCompanion<FencePerimeterTableData> {
  final Value<String> perimeterId;
  final Value<String> fenceId;
  final Value<int> rowid;
  const FencePerimeterTableCompanion({
    this.perimeterId = const Value.absent(),
    this.fenceId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FencePerimeterTableCompanion.insert({
    required String perimeterId,
    required String fenceId,
    this.rowid = const Value.absent(),
  })  : perimeterId = Value(perimeterId),
        fenceId = Value(fenceId);
  static Insertable<FencePerimeterTableData> custom({
    Expression<String>? perimeterId,
    Expression<String>? fenceId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (perimeterId != null) 'perimeter_id': perimeterId,
      if (fenceId != null) 'fence_id': fenceId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FencePerimeterTableCompanion copyWith(
      {Value<String>? perimeterId, Value<String>? fenceId, Value<int>? rowid}) {
    return FencePerimeterTableCompanion(
      perimeterId: perimeterId ?? this.perimeterId,
      fenceId: fenceId ?? this.fenceId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (perimeterId.present) {
      map['perimeter_id'] = Variable<String>(perimeterId.value);
    }
    if (fenceId.present) {
      map['fence_id'] = Variable<String>(fenceId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FencePerimeterTableCompanion(')
          ..write('perimeterId: $perimeterId, ')
          ..write('fenceId: $fenceId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceTableTable extends DeviceTable
    with TableInfo<$DeviceTableTable, DeviceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _imeiMeta = const VerificationMeta('imei');
  @override
  late final GeneratedColumn<String> imei = GeneratedColumn<String>(
      'imei', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, imei, name, model, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_table';
  @override
  VerificationContext validateIntegrity(Insertable<DeviceTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('imei')) {
      context.handle(
          _imeiMeta, imei.isAcceptableOrUnknown(data['imei']!, _imeiMeta));
    } else if (isInserting) {
      context.missing(_imeiMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      imei: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}imei'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $DeviceTableTable createAlias(String alias) {
    return $DeviceTableTable(attachedDatabase, alias);
  }
}

class DeviceTableData extends DataClass implements Insertable<DeviceTableData> {
  final String id;
  final String imei;
  final String? name;
  final String? model;
  final String status;
  const DeviceTableData(
      {required this.id,
      required this.imei,
      this.name,
      this.model,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['imei'] = Variable<String>(imei);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || model != null) {
      map['model'] = Variable<String>(model);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  DeviceTableCompanion toCompanion(bool nullToAbsent) {
    return DeviceTableCompanion(
      id: Value(id),
      imei: Value(imei),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      model:
          model == null && nullToAbsent ? const Value.absent() : Value(model),
      status: Value(status),
    );
  }

  factory DeviceTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceTableData(
      id: serializer.fromJson<String>(json['id']),
      imei: serializer.fromJson<String>(json['imei']),
      name: serializer.fromJson<String?>(json['name']),
      model: serializer.fromJson<String?>(json['model']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'imei': serializer.toJson<String>(imei),
      'name': serializer.toJson<String?>(name),
      'model': serializer.toJson<String?>(model),
      'status': serializer.toJson<String>(status),
    };
  }

  DeviceTableData copyWith(
          {String? id,
          String? imei,
          Value<String?> name = const Value.absent(),
          Value<String?> model = const Value.absent(),
          String? status}) =>
      DeviceTableData(
        id: id ?? this.id,
        imei: imei ?? this.imei,
        name: name.present ? name.value : this.name,
        model: model.present ? model.value : this.model,
        status: status ?? this.status,
      );
  DeviceTableData copyWithCompanion(DeviceTableCompanion data) {
    return DeviceTableData(
      id: data.id.present ? data.id.value : this.id,
      imei: data.imei.present ? data.imei.value : this.imei,
      name: data.name.present ? data.name.value : this.name,
      model: data.model.present ? data.model.value : this.model,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTableData(')
          ..write('id: $id, ')
          ..write('imei: $imei, ')
          ..write('name: $name, ')
          ..write('model: $model, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, imei, name, model, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceTableData &&
          other.id == this.id &&
          other.imei == this.imei &&
          other.name == this.name &&
          other.model == this.model &&
          other.status == this.status);
}

class DeviceTableCompanion extends UpdateCompanion<DeviceTableData> {
  final Value<String> id;
  final Value<String> imei;
  final Value<String?> name;
  final Value<String?> model;
  final Value<String> status;
  final Value<int> rowid;
  const DeviceTableCompanion({
    this.id = const Value.absent(),
    this.imei = const Value.absent(),
    this.name = const Value.absent(),
    this.model = const Value.absent(),
    this.status = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceTableCompanion.insert({
    required String id,
    required String imei,
    this.name = const Value.absent(),
    this.model = const Value.absent(),
    required String status,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        imei = Value(imei),
        status = Value(status);
  static Insertable<DeviceTableData> custom({
    Expression<String>? id,
    Expression<String>? imei,
    Expression<String>? name,
    Expression<String>? model,
    Expression<String>? status,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (imei != null) 'imei': imei,
      if (name != null) 'name': name,
      if (model != null) 'model': model,
      if (status != null) 'status': status,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? imei,
      Value<String?>? name,
      Value<String?>? model,
      Value<String>? status,
      Value<int>? rowid}) {
    return DeviceTableCompanion(
      id: id ?? this.id,
      imei: imei ?? this.imei,
      name: name ?? this.name,
      model: model ?? this.model,
      status: status ?? this.status,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (imei.present) {
      map['imei'] = Variable<String>(imei.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTableCompanion(')
          ..write('id: $id, ')
          ..write('imei: $imei, ')
          ..write('name: $name, ')
          ..write('model: $model, ')
          ..write('status: $status, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivationTableTable extends ActivationTable
    with TableInfo<$ActivationTableTable, ActivationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _deviceSituationMeta =
      const VerificationMeta('deviceSituation');
  @override
  late final GeneratedColumn<String> deviceSituation = GeneratedColumn<String>(
      'device_situation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _employeeSituationMeta =
      const VerificationMeta('employeeSituation');
  @override
  late final GeneratedColumn<String> employeeSituation =
      GeneratedColumn<String>('employee_situation', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _requestDateTimeMeta =
      const VerificationMeta('requestDateTime');
  @override
  late final GeneratedColumn<DateTime> requestDateTime =
      GeneratedColumn<DateTime>('request_date_time', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  @override
  List<GeneratedColumn> get $columns =>
      [deviceSituation, employeeSituation, requestDateTime, employeeId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activation_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ActivationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('device_situation')) {
      context.handle(
          _deviceSituationMeta,
          deviceSituation.isAcceptableOrUnknown(
              data['device_situation']!, _deviceSituationMeta));
    } else if (isInserting) {
      context.missing(_deviceSituationMeta);
    }
    if (data.containsKey('employee_situation')) {
      context.handle(
          _employeeSituationMeta,
          employeeSituation.isAcceptableOrUnknown(
              data['employee_situation']!, _employeeSituationMeta));
    } else if (isInserting) {
      context.missing(_employeeSituationMeta);
    }
    if (data.containsKey('request_date_time')) {
      context.handle(
          _requestDateTimeMeta,
          requestDateTime.isAcceptableOrUnknown(
              data['request_date_time']!, _requestDateTimeMeta));
    } else if (isInserting) {
      context.missing(_requestDateTimeMeta);
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId};
  @override
  ActivationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivationTableData(
      deviceSituation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}device_situation'])!,
      employeeSituation: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}employee_situation'])!,
      requestDateTime: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}request_date_time'])!,
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
    );
  }

  @override
  $ActivationTableTable createAlias(String alias) {
    return $ActivationTableTable(attachedDatabase, alias);
  }
}

class ActivationTableData extends DataClass
    implements Insertable<ActivationTableData> {
  final String deviceSituation;
  final String employeeSituation;
  final DateTime requestDateTime;
  final String employeeId;
  const ActivationTableData(
      {required this.deviceSituation,
      required this.employeeSituation,
      required this.requestDateTime,
      required this.employeeId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['device_situation'] = Variable<String>(deviceSituation);
    map['employee_situation'] = Variable<String>(employeeSituation);
    map['request_date_time'] = Variable<DateTime>(requestDateTime);
    map['employee_id'] = Variable<String>(employeeId);
    return map;
  }

  ActivationTableCompanion toCompanion(bool nullToAbsent) {
    return ActivationTableCompanion(
      deviceSituation: Value(deviceSituation),
      employeeSituation: Value(employeeSituation),
      requestDateTime: Value(requestDateTime),
      employeeId: Value(employeeId),
    );
  }

  factory ActivationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivationTableData(
      deviceSituation: serializer.fromJson<String>(json['deviceSituation']),
      employeeSituation: serializer.fromJson<String>(json['employeeSituation']),
      requestDateTime: serializer.fromJson<DateTime>(json['requestDateTime']),
      employeeId: serializer.fromJson<String>(json['employeeId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'deviceSituation': serializer.toJson<String>(deviceSituation),
      'employeeSituation': serializer.toJson<String>(employeeSituation),
      'requestDateTime': serializer.toJson<DateTime>(requestDateTime),
      'employeeId': serializer.toJson<String>(employeeId),
    };
  }

  ActivationTableData copyWith(
          {String? deviceSituation,
          String? employeeSituation,
          DateTime? requestDateTime,
          String? employeeId}) =>
      ActivationTableData(
        deviceSituation: deviceSituation ?? this.deviceSituation,
        employeeSituation: employeeSituation ?? this.employeeSituation,
        requestDateTime: requestDateTime ?? this.requestDateTime,
        employeeId: employeeId ?? this.employeeId,
      );
  ActivationTableData copyWithCompanion(ActivationTableCompanion data) {
    return ActivationTableData(
      deviceSituation: data.deviceSituation.present
          ? data.deviceSituation.value
          : this.deviceSituation,
      employeeSituation: data.employeeSituation.present
          ? data.employeeSituation.value
          : this.employeeSituation,
      requestDateTime: data.requestDateTime.present
          ? data.requestDateTime.value
          : this.requestDateTime,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivationTableData(')
          ..write('deviceSituation: $deviceSituation, ')
          ..write('employeeSituation: $employeeSituation, ')
          ..write('requestDateTime: $requestDateTime, ')
          ..write('employeeId: $employeeId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      deviceSituation, employeeSituation, requestDateTime, employeeId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivationTableData &&
          other.deviceSituation == this.deviceSituation &&
          other.employeeSituation == this.employeeSituation &&
          other.requestDateTime == this.requestDateTime &&
          other.employeeId == this.employeeId);
}

class ActivationTableCompanion extends UpdateCompanion<ActivationTableData> {
  final Value<String> deviceSituation;
  final Value<String> employeeSituation;
  final Value<DateTime> requestDateTime;
  final Value<String> employeeId;
  final Value<int> rowid;
  const ActivationTableCompanion({
    this.deviceSituation = const Value.absent(),
    this.employeeSituation = const Value.absent(),
    this.requestDateTime = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivationTableCompanion.insert({
    required String deviceSituation,
    required String employeeSituation,
    required DateTime requestDateTime,
    required String employeeId,
    this.rowid = const Value.absent(),
  })  : deviceSituation = Value(deviceSituation),
        employeeSituation = Value(employeeSituation),
        requestDateTime = Value(requestDateTime),
        employeeId = Value(employeeId);
  static Insertable<ActivationTableData> custom({
    Expression<String>? deviceSituation,
    Expression<String>? employeeSituation,
    Expression<DateTime>? requestDateTime,
    Expression<String>? employeeId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (deviceSituation != null) 'device_situation': deviceSituation,
      if (employeeSituation != null) 'employee_situation': employeeSituation,
      if (requestDateTime != null) 'request_date_time': requestDateTime,
      if (employeeId != null) 'employee_id': employeeId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivationTableCompanion copyWith(
      {Value<String>? deviceSituation,
      Value<String>? employeeSituation,
      Value<DateTime>? requestDateTime,
      Value<String>? employeeId,
      Value<int>? rowid}) {
    return ActivationTableCompanion(
      deviceSituation: deviceSituation ?? this.deviceSituation,
      employeeSituation: employeeSituation ?? this.employeeSituation,
      requestDateTime: requestDateTime ?? this.requestDateTime,
      employeeId: employeeId ?? this.employeeId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (deviceSituation.present) {
      map['device_situation'] = Variable<String>(deviceSituation.value);
    }
    if (employeeSituation.present) {
      map['employee_situation'] = Variable<String>(employeeSituation.value);
    }
    if (requestDateTime.present) {
      map['request_date_time'] = Variable<DateTime>(requestDateTime.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivationTableCompanion(')
          ..write('deviceSituation: $deviceSituation, ')
          ..write('employeeSituation: $employeeSituation, ')
          ..write('requestDateTime: $requestDateTime, ')
          ..write('employeeId: $employeeId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApplicationTableTable extends ApplicationTable
    with TableInfo<$ApplicationTableTable, ApplicationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tenantNameMeta =
      const VerificationMeta('tenantName');
  @override
  late final GeneratedColumn<String> tenantName = GeneratedColumn<String>(
      'tenant_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _accessKeyMeta =
      const VerificationMeta('accessKey');
  @override
  late final GeneratedColumn<String> accessKey = GeneratedColumn<String>(
      'access_key', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _secretMeta = const VerificationMeta('secret');
  @override
  late final GeneratedColumn<String> secret = GeneratedColumn<String>(
      'secret', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
      'last_update', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [tenantName, accessKey, secret, lastUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ApplicationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tenant_name')) {
      context.handle(
          _tenantNameMeta,
          tenantName.isAcceptableOrUnknown(
              data['tenant_name']!, _tenantNameMeta));
    } else if (isInserting) {
      context.missing(_tenantNameMeta);
    }
    if (data.containsKey('access_key')) {
      context.handle(_accessKeyMeta,
          accessKey.isAcceptableOrUnknown(data['access_key']!, _accessKeyMeta));
    } else if (isInserting) {
      context.missing(_accessKeyMeta);
    }
    if (data.containsKey('secret')) {
      context.handle(_secretMeta,
          secret.isAcceptableOrUnknown(data['secret']!, _secretMeta));
    } else if (isInserting) {
      context.missing(_secretMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tenantName};
  @override
  ApplicationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationTableData(
      tenantName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_name'])!,
      accessKey: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}access_key'])!,
      secret: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}secret'])!,
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_update']),
    );
  }

  @override
  $ApplicationTableTable createAlias(String alias) {
    return $ApplicationTableTable(attachedDatabase, alias);
  }
}

class ApplicationTableData extends DataClass
    implements Insertable<ApplicationTableData> {
  final String tenantName;
  final String accessKey;
  final String secret;
  final DateTime? lastUpdate;
  const ApplicationTableData(
      {required this.tenantName,
      required this.accessKey,
      required this.secret,
      this.lastUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tenant_name'] = Variable<String>(tenantName);
    map['access_key'] = Variable<String>(accessKey);
    map['secret'] = Variable<String>(secret);
    if (!nullToAbsent || lastUpdate != null) {
      map['last_update'] = Variable<DateTime>(lastUpdate);
    }
    return map;
  }

  ApplicationTableCompanion toCompanion(bool nullToAbsent) {
    return ApplicationTableCompanion(
      tenantName: Value(tenantName),
      accessKey: Value(accessKey),
      secret: Value(secret),
      lastUpdate: lastUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdate),
    );
  }

  factory ApplicationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicationTableData(
      tenantName: serializer.fromJson<String>(json['tenantName']),
      accessKey: serializer.fromJson<String>(json['accessKey']),
      secret: serializer.fromJson<String>(json['secret']),
      lastUpdate: serializer.fromJson<DateTime?>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tenantName': serializer.toJson<String>(tenantName),
      'accessKey': serializer.toJson<String>(accessKey),
      'secret': serializer.toJson<String>(secret),
      'lastUpdate': serializer.toJson<DateTime?>(lastUpdate),
    };
  }

  ApplicationTableData copyWith(
          {String? tenantName,
          String? accessKey,
          String? secret,
          Value<DateTime?> lastUpdate = const Value.absent()}) =>
      ApplicationTableData(
        tenantName: tenantName ?? this.tenantName,
        accessKey: accessKey ?? this.accessKey,
        secret: secret ?? this.secret,
        lastUpdate: lastUpdate.present ? lastUpdate.value : this.lastUpdate,
      );
  ApplicationTableData copyWithCompanion(ApplicationTableCompanion data) {
    return ApplicationTableData(
      tenantName:
          data.tenantName.present ? data.tenantName.value : this.tenantName,
      accessKey: data.accessKey.present ? data.accessKey.value : this.accessKey,
      secret: data.secret.present ? data.secret.value : this.secret,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationTableData(')
          ..write('tenantName: $tenantName, ')
          ..write('accessKey: $accessKey, ')
          ..write('secret: $secret, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(tenantName, accessKey, secret, lastUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicationTableData &&
          other.tenantName == this.tenantName &&
          other.accessKey == this.accessKey &&
          other.secret == this.secret &&
          other.lastUpdate == this.lastUpdate);
}

class ApplicationTableCompanion extends UpdateCompanion<ApplicationTableData> {
  final Value<String> tenantName;
  final Value<String> accessKey;
  final Value<String> secret;
  final Value<DateTime?> lastUpdate;
  final Value<int> rowid;
  const ApplicationTableCompanion({
    this.tenantName = const Value.absent(),
    this.accessKey = const Value.absent(),
    this.secret = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApplicationTableCompanion.insert({
    required String tenantName,
    required String accessKey,
    required String secret,
    this.lastUpdate = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : tenantName = Value(tenantName),
        accessKey = Value(accessKey),
        secret = Value(secret);
  static Insertable<ApplicationTableData> custom({
    Expression<String>? tenantName,
    Expression<String>? accessKey,
    Expression<String>? secret,
    Expression<DateTime>? lastUpdate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tenantName != null) 'tenant_name': tenantName,
      if (accessKey != null) 'access_key': accessKey,
      if (secret != null) 'secret': secret,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApplicationTableCompanion copyWith(
      {Value<String>? tenantName,
      Value<String>? accessKey,
      Value<String>? secret,
      Value<DateTime?>? lastUpdate,
      Value<int>? rowid}) {
    return ApplicationTableCompanion(
      tenantName: tenantName ?? this.tenantName,
      accessKey: accessKey ?? this.accessKey,
      secret: secret ?? this.secret,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tenantName.present) {
      map['tenant_name'] = Variable<String>(tenantName.value);
    }
    if (accessKey.present) {
      map['access_key'] = Variable<String>(accessKey.value);
    }
    if (secret.present) {
      map['secret'] = Variable<String>(secret.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationTableCompanion(')
          ..write('tenantName: $tenantName, ')
          ..write('accessKey: $accessKey, ')
          ..write('secret: $secret, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceConfigurationTableTable extends DeviceConfigurationTable
    with
        TableInfo<$DeviceConfigurationTableTable,
            DeviceConfigurationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceConfigurationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _enableNfcMeta =
      const VerificationMeta('enableNfc');
  @override
  late final GeneratedColumn<bool> enableNfc = GeneratedColumn<bool>(
      'enable_nfc', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enable_nfc" IN (0, 1))'));
  static const VerificationMeta _enableQrCodeMeta =
      const VerificationMeta('enableQrCode');
  @override
  late final GeneratedColumn<bool> enableQrCode = GeneratedColumn<bool>(
      'enable_qr_code', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_qr_code" IN (0, 1))'));
  static const VerificationMeta _enableFacialMeta =
      const VerificationMeta('enableFacial');
  @override
  late final GeneratedColumn<bool> enableFacial = GeneratedColumn<bool>(
      'enable_facial', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_facial" IN (0, 1))'));
  static const VerificationMeta _timeZoneMeta =
      const VerificationMeta('timeZone');
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
      'time_zone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
      'last_update', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _takePhotoMultiMeta =
      const VerificationMeta('takePhotoMulti');
  @override
  late final GeneratedColumn<bool> takePhotoMulti = GeneratedColumn<bool>(
      'take_photo_multi', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_multi" IN (0, 1))'));
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _enableUserPasswordMeta =
      const VerificationMeta('enableUserPassword');
  @override
  late final GeneratedColumn<bool> enableUserPassword = GeneratedColumn<bool>(
      'enable_user_password', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("enable_user_password" IN (0, 1))'));
  static const VerificationMeta _allowChangeTimeMeta =
      const VerificationMeta('allowChangeTime');
  @override
  late final GeneratedColumn<bool> allowChangeTime = GeneratedColumn<bool>(
      'allow_change_time', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_change_time" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        enableNfc,
        enableQrCode,
        enableFacial,
        timeZone,
        lastUpdate,
        takePhotoMulti,
        lastSync,
        enableUserPassword,
        allowChangeTime
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_configuration_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<DeviceConfigurationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('enable_nfc')) {
      context.handle(_enableNfcMeta,
          enableNfc.isAcceptableOrUnknown(data['enable_nfc']!, _enableNfcMeta));
    } else if (isInserting) {
      context.missing(_enableNfcMeta);
    }
    if (data.containsKey('enable_qr_code')) {
      context.handle(
          _enableQrCodeMeta,
          enableQrCode.isAcceptableOrUnknown(
              data['enable_qr_code']!, _enableQrCodeMeta));
    } else if (isInserting) {
      context.missing(_enableQrCodeMeta);
    }
    if (data.containsKey('enable_facial')) {
      context.handle(
          _enableFacialMeta,
          enableFacial.isAcceptableOrUnknown(
              data['enable_facial']!, _enableFacialMeta));
    } else if (isInserting) {
      context.missing(_enableFacialMeta);
    }
    if (data.containsKey('time_zone')) {
      context.handle(_timeZoneMeta,
          timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta));
    } else if (isInserting) {
      context.missing(_timeZoneMeta);
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    if (data.containsKey('take_photo_multi')) {
      context.handle(
          _takePhotoMultiMeta,
          takePhotoMulti.isAcceptableOrUnknown(
              data['take_photo_multi']!, _takePhotoMultiMeta));
    } else if (isInserting) {
      context.missing(_takePhotoMultiMeta);
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    } else if (isInserting) {
      context.missing(_lastSyncMeta);
    }
    if (data.containsKey('enable_user_password')) {
      context.handle(
          _enableUserPasswordMeta,
          enableUserPassword.isAcceptableOrUnknown(
              data['enable_user_password']!, _enableUserPasswordMeta));
    }
    if (data.containsKey('allow_change_time')) {
      context.handle(
          _allowChangeTimeMeta,
          allowChangeTime.isAcceptableOrUnknown(
              data['allow_change_time']!, _allowChangeTimeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceConfigurationTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceConfigurationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      enableNfc: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable_nfc'])!,
      enableQrCode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable_qr_code'])!,
      enableFacial: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enable_facial'])!,
      timeZone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_zone'])!,
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_update'])!,
      takePhotoMulti: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_multi'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync'])!,
      enableUserPassword: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}enable_user_password']),
      allowChangeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_change_time']),
    );
  }

  @override
  $DeviceConfigurationTableTable createAlias(String alias) {
    return $DeviceConfigurationTableTable(attachedDatabase, alias);
  }
}

class DeviceConfigurationTableData extends DataClass
    implements Insertable<DeviceConfigurationTableData> {
  final String id;
  final bool enableNfc;
  final bool enableQrCode;
  final bool enableFacial;
  final String timeZone;
  final DateTime lastUpdate;
  final bool takePhotoMulti;
  final DateTime lastSync;
  final bool? enableUserPassword;
  final bool? allowChangeTime;
  const DeviceConfigurationTableData(
      {required this.id,
      required this.enableNfc,
      required this.enableQrCode,
      required this.enableFacial,
      required this.timeZone,
      required this.lastUpdate,
      required this.takePhotoMulti,
      required this.lastSync,
      this.enableUserPassword,
      this.allowChangeTime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['enable_nfc'] = Variable<bool>(enableNfc);
    map['enable_qr_code'] = Variable<bool>(enableQrCode);
    map['enable_facial'] = Variable<bool>(enableFacial);
    map['time_zone'] = Variable<String>(timeZone);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    map['take_photo_multi'] = Variable<bool>(takePhotoMulti);
    map['last_sync'] = Variable<DateTime>(lastSync);
    if (!nullToAbsent || enableUserPassword != null) {
      map['enable_user_password'] = Variable<bool>(enableUserPassword);
    }
    if (!nullToAbsent || allowChangeTime != null) {
      map['allow_change_time'] = Variable<bool>(allowChangeTime);
    }
    return map;
  }

  DeviceConfigurationTableCompanion toCompanion(bool nullToAbsent) {
    return DeviceConfigurationTableCompanion(
      id: Value(id),
      enableNfc: Value(enableNfc),
      enableQrCode: Value(enableQrCode),
      enableFacial: Value(enableFacial),
      timeZone: Value(timeZone),
      lastUpdate: Value(lastUpdate),
      takePhotoMulti: Value(takePhotoMulti),
      lastSync: Value(lastSync),
      enableUserPassword: enableUserPassword == null && nullToAbsent
          ? const Value.absent()
          : Value(enableUserPassword),
      allowChangeTime: allowChangeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(allowChangeTime),
    );
  }

  factory DeviceConfigurationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceConfigurationTableData(
      id: serializer.fromJson<String>(json['id']),
      enableNfc: serializer.fromJson<bool>(json['enableNfc']),
      enableQrCode: serializer.fromJson<bool>(json['enableQrCode']),
      enableFacial: serializer.fromJson<bool>(json['enableFacial']),
      timeZone: serializer.fromJson<String>(json['timeZone']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
      takePhotoMulti: serializer.fromJson<bool>(json['takePhotoMulti']),
      lastSync: serializer.fromJson<DateTime>(json['lastSync']),
      enableUserPassword:
          serializer.fromJson<bool?>(json['enableUserPassword']),
      allowChangeTime: serializer.fromJson<bool?>(json['allowChangeTime']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'enableNfc': serializer.toJson<bool>(enableNfc),
      'enableQrCode': serializer.toJson<bool>(enableQrCode),
      'enableFacial': serializer.toJson<bool>(enableFacial),
      'timeZone': serializer.toJson<String>(timeZone),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
      'takePhotoMulti': serializer.toJson<bool>(takePhotoMulti),
      'lastSync': serializer.toJson<DateTime>(lastSync),
      'enableUserPassword': serializer.toJson<bool?>(enableUserPassword),
      'allowChangeTime': serializer.toJson<bool?>(allowChangeTime),
    };
  }

  DeviceConfigurationTableData copyWith(
          {String? id,
          bool? enableNfc,
          bool? enableQrCode,
          bool? enableFacial,
          String? timeZone,
          DateTime? lastUpdate,
          bool? takePhotoMulti,
          DateTime? lastSync,
          Value<bool?> enableUserPassword = const Value.absent(),
          Value<bool?> allowChangeTime = const Value.absent()}) =>
      DeviceConfigurationTableData(
        id: id ?? this.id,
        enableNfc: enableNfc ?? this.enableNfc,
        enableQrCode: enableQrCode ?? this.enableQrCode,
        enableFacial: enableFacial ?? this.enableFacial,
        timeZone: timeZone ?? this.timeZone,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        takePhotoMulti: takePhotoMulti ?? this.takePhotoMulti,
        lastSync: lastSync ?? this.lastSync,
        enableUserPassword: enableUserPassword.present
            ? enableUserPassword.value
            : this.enableUserPassword,
        allowChangeTime: allowChangeTime.present
            ? allowChangeTime.value
            : this.allowChangeTime,
      );
  DeviceConfigurationTableData copyWithCompanion(
      DeviceConfigurationTableCompanion data) {
    return DeviceConfigurationTableData(
      id: data.id.present ? data.id.value : this.id,
      enableNfc: data.enableNfc.present ? data.enableNfc.value : this.enableNfc,
      enableQrCode: data.enableQrCode.present
          ? data.enableQrCode.value
          : this.enableQrCode,
      enableFacial: data.enableFacial.present
          ? data.enableFacial.value
          : this.enableFacial,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
      takePhotoMulti: data.takePhotoMulti.present
          ? data.takePhotoMulti.value
          : this.takePhotoMulti,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      enableUserPassword: data.enableUserPassword.present
          ? data.enableUserPassword.value
          : this.enableUserPassword,
      allowChangeTime: data.allowChangeTime.present
          ? data.allowChangeTime.value
          : this.allowChangeTime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceConfigurationTableData(')
          ..write('id: $id, ')
          ..write('enableNfc: $enableNfc, ')
          ..write('enableQrCode: $enableQrCode, ')
          ..write('enableFacial: $enableFacial, ')
          ..write('timeZone: $timeZone, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('takePhotoMulti: $takePhotoMulti, ')
          ..write('lastSync: $lastSync, ')
          ..write('enableUserPassword: $enableUserPassword, ')
          ..write('allowChangeTime: $allowChangeTime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      enableNfc,
      enableQrCode,
      enableFacial,
      timeZone,
      lastUpdate,
      takePhotoMulti,
      lastSync,
      enableUserPassword,
      allowChangeTime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceConfigurationTableData &&
          other.id == this.id &&
          other.enableNfc == this.enableNfc &&
          other.enableQrCode == this.enableQrCode &&
          other.enableFacial == this.enableFacial &&
          other.timeZone == this.timeZone &&
          other.lastUpdate == this.lastUpdate &&
          other.takePhotoMulti == this.takePhotoMulti &&
          other.lastSync == this.lastSync &&
          other.enableUserPassword == this.enableUserPassword &&
          other.allowChangeTime == this.allowChangeTime);
}

class DeviceConfigurationTableCompanion
    extends UpdateCompanion<DeviceConfigurationTableData> {
  final Value<String> id;
  final Value<bool> enableNfc;
  final Value<bool> enableQrCode;
  final Value<bool> enableFacial;
  final Value<String> timeZone;
  final Value<DateTime> lastUpdate;
  final Value<bool> takePhotoMulti;
  final Value<DateTime> lastSync;
  final Value<bool?> enableUserPassword;
  final Value<bool?> allowChangeTime;
  final Value<int> rowid;
  const DeviceConfigurationTableCompanion({
    this.id = const Value.absent(),
    this.enableNfc = const Value.absent(),
    this.enableQrCode = const Value.absent(),
    this.enableFacial = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.takePhotoMulti = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.enableUserPassword = const Value.absent(),
    this.allowChangeTime = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceConfigurationTableCompanion.insert({
    required String id,
    required bool enableNfc,
    required bool enableQrCode,
    required bool enableFacial,
    required String timeZone,
    required DateTime lastUpdate,
    required bool takePhotoMulti,
    required DateTime lastSync,
    this.enableUserPassword = const Value.absent(),
    this.allowChangeTime = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        enableNfc = Value(enableNfc),
        enableQrCode = Value(enableQrCode),
        enableFacial = Value(enableFacial),
        timeZone = Value(timeZone),
        lastUpdate = Value(lastUpdate),
        takePhotoMulti = Value(takePhotoMulti),
        lastSync = Value(lastSync);
  static Insertable<DeviceConfigurationTableData> custom({
    Expression<String>? id,
    Expression<bool>? enableNfc,
    Expression<bool>? enableQrCode,
    Expression<bool>? enableFacial,
    Expression<String>? timeZone,
    Expression<DateTime>? lastUpdate,
    Expression<bool>? takePhotoMulti,
    Expression<DateTime>? lastSync,
    Expression<bool>? enableUserPassword,
    Expression<bool>? allowChangeTime,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (enableNfc != null) 'enable_nfc': enableNfc,
      if (enableQrCode != null) 'enable_qr_code': enableQrCode,
      if (enableFacial != null) 'enable_facial': enableFacial,
      if (timeZone != null) 'time_zone': timeZone,
      if (lastUpdate != null) 'last_update': lastUpdate,
      if (takePhotoMulti != null) 'take_photo_multi': takePhotoMulti,
      if (lastSync != null) 'last_sync': lastSync,
      if (enableUserPassword != null)
        'enable_user_password': enableUserPassword,
      if (allowChangeTime != null) 'allow_change_time': allowChangeTime,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceConfigurationTableCompanion copyWith(
      {Value<String>? id,
      Value<bool>? enableNfc,
      Value<bool>? enableQrCode,
      Value<bool>? enableFacial,
      Value<String>? timeZone,
      Value<DateTime>? lastUpdate,
      Value<bool>? takePhotoMulti,
      Value<DateTime>? lastSync,
      Value<bool?>? enableUserPassword,
      Value<bool?>? allowChangeTime,
      Value<int>? rowid}) {
    return DeviceConfigurationTableCompanion(
      id: id ?? this.id,
      enableNfc: enableNfc ?? this.enableNfc,
      enableQrCode: enableQrCode ?? this.enableQrCode,
      enableFacial: enableFacial ?? this.enableFacial,
      timeZone: timeZone ?? this.timeZone,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      takePhotoMulti: takePhotoMulti ?? this.takePhotoMulti,
      lastSync: lastSync ?? this.lastSync,
      enableUserPassword: enableUserPassword ?? this.enableUserPassword,
      allowChangeTime: allowChangeTime ?? this.allowChangeTime,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (enableNfc.present) {
      map['enable_nfc'] = Variable<bool>(enableNfc.value);
    }
    if (enableQrCode.present) {
      map['enable_qr_code'] = Variable<bool>(enableQrCode.value);
    }
    if (enableFacial.present) {
      map['enable_facial'] = Variable<bool>(enableFacial.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    if (takePhotoMulti.present) {
      map['take_photo_multi'] = Variable<bool>(takePhotoMulti.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (enableUserPassword.present) {
      map['enable_user_password'] = Variable<bool>(enableUserPassword.value);
    }
    if (allowChangeTime.present) {
      map['allow_change_time'] = Variable<bool>(allowChangeTime.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceConfigurationTableCompanion(')
          ..write('id: $id, ')
          ..write('enableNfc: $enableNfc, ')
          ..write('enableQrCode: $enableQrCode, ')
          ..write('enableFacial: $enableFacial, ')
          ..write('timeZone: $timeZone, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('takePhotoMulti: $takePhotoMulti, ')
          ..write('lastSync: $lastSync, ')
          ..write('enableUserPassword: $enableUserPassword, ')
          ..write('allowChangeTime: $allowChangeTime, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GlobalConfigurationTableTable extends GlobalConfigurationTable
    with
        TableInfo<$GlobalConfigurationTableTable,
            GlobalConfigurationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlobalConfigurationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gpsMeta = const VerificationMeta('gps');
  @override
  late final GeneratedColumn<bool> gps = GeneratedColumn<bool>(
      'gps', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("gps" IN (0, 1))'));
  static const VerificationMeta _onlineMeta = const VerificationMeta('online');
  @override
  late final GeneratedColumn<bool> online = GeneratedColumn<bool>(
      'online', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("online" IN (0, 1))'));
  static const VerificationMeta _timeoutMeta =
      const VerificationMeta('timeout');
  @override
  late final GeneratedColumn<String> timeout = GeneratedColumn<String>(
      'timeout', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _operationModeMeta =
      const VerificationMeta('operationMode');
  @override
  late final GeneratedColumn<String> operationMode = GeneratedColumn<String>(
      'operation_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nfcModeMeta =
      const VerificationMeta('nfcMode');
  @override
  late final GeneratedColumn<bool> nfcMode = GeneratedColumn<bool>(
      'nfc_mode', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("nfc_mode" IN (0, 1))'));
  static const VerificationMeta _allowChangeTimeMeta =
      const VerificationMeta('allowChangeTime');
  @override
  late final GeneratedColumn<bool> allowChangeTime = GeneratedColumn<bool>(
      'allow_change_time', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_change_time" IN (0, 1))'));
  static const VerificationMeta _timezoneMeta =
      const VerificationMeta('timezone');
  @override
  late final GeneratedColumn<String> timezone = GeneratedColumn<String>(
      'timezone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deviceAuthModeSingleModeMeta =
      const VerificationMeta('deviceAuthModeSingleMode');
  @override
  late final GeneratedColumn<String> deviceAuthModeSingleMode =
      GeneratedColumn<String>('device_auth_mode_single_mode', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deviceAuthModeMultiModeMeta =
      const VerificationMeta('deviceAuthModeMultiMode');
  @override
  late final GeneratedColumn<String> deviceAuthModeMultiMode =
      GeneratedColumn<String>('device_auth_mode_multi_mode', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deviceAuthModeDriverModeMeta =
      const VerificationMeta('deviceAuthModeDriverMode');
  @override
  late final GeneratedColumn<String> deviceAuthModeDriverMode =
      GeneratedColumn<String>('device_auth_mode_driver_mode', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _allowDrivingTimeMeta =
      const VerificationMeta('allowDrivingTime');
  @override
  late final GeneratedColumn<bool> allowDrivingTime = GeneratedColumn<bool>(
      'allow_driving_time', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_driving_time" IN (0, 1))'));
  static const VerificationMeta _overnightMeta =
      const VerificationMeta('overnight');
  @override
  late final GeneratedColumn<bool> overnight = GeneratedColumn<bool>(
      'overnight', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("overnight" IN (0, 1))'));
  static const VerificationMeta _controlOvernightMeta =
      const VerificationMeta('controlOvernight');
  @override
  late final GeneratedColumn<bool> controlOvernight = GeneratedColumn<bool>(
      'control_overnight', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("control_overnight" IN (0, 1))'));
  static const VerificationMeta _allowGpoOnAppMeta =
      const VerificationMeta('allowGpoOnApp');
  @override
  late final GeneratedColumn<bool> allowGpoOnApp = GeneratedColumn<bool>(
      'allow_gpo_on_app', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_gpo_on_app" IN (0, 1))'));
  static const VerificationMeta _exportNotCheckedMeta =
      const VerificationMeta('exportNotChecked');
  @override
  late final GeneratedColumn<bool> exportNotChecked = GeneratedColumn<bool>(
      'export_not_checked', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("export_not_checked" IN (0, 1))'));
  static const VerificationMeta _insightOutOfBoundMeta =
      const VerificationMeta('insightOutOfBound');
  @override
  late final GeneratedColumn<String> insightOutOfBound =
      GeneratedColumn<String>('insight_out_of_bound', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _takePhotoSingleMeta =
      const VerificationMeta('takePhotoSingle');
  @override
  late final GeneratedColumn<bool> takePhotoSingle = GeneratedColumn<bool>(
      'take_photo_single', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_single" IN (0, 1))'));
  static const VerificationMeta _takePhotoMultiMeta =
      const VerificationMeta('takePhotoMulti');
  @override
  late final GeneratedColumn<bool> takePhotoMulti = GeneratedColumn<bool>(
      'take_photo_multi', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_multi" IN (0, 1))'));
  static const VerificationMeta _takePhotoDriverMeta =
      const VerificationMeta('takePhotoDriver');
  @override
  late final GeneratedColumn<bool> takePhotoDriver = GeneratedColumn<bool>(
      'take_photo_driver', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_driver" IN (0, 1))'));
  static const VerificationMeta _takePhotoQrcodeMeta =
      const VerificationMeta('takePhotoQrcode');
  @override
  late final GeneratedColumn<bool> takePhotoQrcode = GeneratedColumn<bool>(
      'take_photo_qrcode', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_qrcode" IN (0, 1))'));
  static const VerificationMeta _takePhotoNfcMeta =
      const VerificationMeta('takePhotoNfc');
  @override
  late final GeneratedColumn<bool> takePhotoNfc = GeneratedColumn<bool>(
      'take_photo_nfc', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("take_photo_nfc" IN (0, 1))'));
  static const VerificationMeta _openExternalBrowserMeta =
      const VerificationMeta('openExternalBrowser');
  @override
  late final GeneratedColumn<bool> openExternalBrowser = GeneratedColumn<bool>(
      'open_external_browser', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("open_external_browser" IN (0, 1))'));
  static const VerificationMeta _clockingEventUsesMeta =
      const VerificationMeta('clockingEventUses');
  @override
  late final GeneratedColumn<String> clockingEventUses =
      GeneratedColumn<String>('clocking_event_uses', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _allowUseMeta =
      const VerificationMeta('allowUse');
  @override
  late final GeneratedColumn<bool> allowUse = GeneratedColumn<bool>(
      'allow_use', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("allow_use" IN (0, 1))'));
  static const VerificationMeta _externalControlTimezoneMeta =
      const VerificationMeta('externalControlTimezone');
  @override
  late final GeneratedColumn<bool> externalControlTimezone =
      GeneratedColumn<bool>('external_control_timezone', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: false,
          defaultConstraints: GeneratedColumn.constraintIsAlways(
              'CHECK ("external_control_timezone" IN (0, 1))'),
          defaultValue: const Constant(false));
  static const VerificationMeta _faceRecognitionMeta =
      const VerificationMeta('faceRecognition');
  @override
  late final GeneratedColumn<bool> faceRecognition = GeneratedColumn<bool>(
      'face_recognition', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("face_recognition" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        gps,
        online,
        timeout,
        operationMode,
        nfcMode,
        allowChangeTime,
        timezone,
        deviceAuthModeSingleMode,
        deviceAuthModeMultiMode,
        deviceAuthModeDriverMode,
        allowDrivingTime,
        overnight,
        controlOvernight,
        allowGpoOnApp,
        exportNotChecked,
        insightOutOfBound,
        takePhotoSingle,
        takePhotoMulti,
        takePhotoDriver,
        takePhotoQrcode,
        takePhotoNfc,
        openExternalBrowser,
        clockingEventUses,
        allowUse,
        externalControlTimezone,
        faceRecognition
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'global_configuration_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<GlobalConfigurationTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('gps')) {
      context.handle(
          _gpsMeta, gps.isAcceptableOrUnknown(data['gps']!, _gpsMeta));
    }
    if (data.containsKey('online')) {
      context.handle(_onlineMeta,
          online.isAcceptableOrUnknown(data['online']!, _onlineMeta));
    }
    if (data.containsKey('timeout')) {
      context.handle(_timeoutMeta,
          timeout.isAcceptableOrUnknown(data['timeout']!, _timeoutMeta));
    }
    if (data.containsKey('operation_mode')) {
      context.handle(
          _operationModeMeta,
          operationMode.isAcceptableOrUnknown(
              data['operation_mode']!, _operationModeMeta));
    }
    if (data.containsKey('nfc_mode')) {
      context.handle(_nfcModeMeta,
          nfcMode.isAcceptableOrUnknown(data['nfc_mode']!, _nfcModeMeta));
    }
    if (data.containsKey('allow_change_time')) {
      context.handle(
          _allowChangeTimeMeta,
          allowChangeTime.isAcceptableOrUnknown(
              data['allow_change_time']!, _allowChangeTimeMeta));
    }
    if (data.containsKey('timezone')) {
      context.handle(_timezoneMeta,
          timezone.isAcceptableOrUnknown(data['timezone']!, _timezoneMeta));
    }
    if (data.containsKey('device_auth_mode_single_mode')) {
      context.handle(
          _deviceAuthModeSingleModeMeta,
          deviceAuthModeSingleMode.isAcceptableOrUnknown(
              data['device_auth_mode_single_mode']!,
              _deviceAuthModeSingleModeMeta));
    }
    if (data.containsKey('device_auth_mode_multi_mode')) {
      context.handle(
          _deviceAuthModeMultiModeMeta,
          deviceAuthModeMultiMode.isAcceptableOrUnknown(
              data['device_auth_mode_multi_mode']!,
              _deviceAuthModeMultiModeMeta));
    }
    if (data.containsKey('device_auth_mode_driver_mode')) {
      context.handle(
          _deviceAuthModeDriverModeMeta,
          deviceAuthModeDriverMode.isAcceptableOrUnknown(
              data['device_auth_mode_driver_mode']!,
              _deviceAuthModeDriverModeMeta));
    }
    if (data.containsKey('allow_driving_time')) {
      context.handle(
          _allowDrivingTimeMeta,
          allowDrivingTime.isAcceptableOrUnknown(
              data['allow_driving_time']!, _allowDrivingTimeMeta));
    }
    if (data.containsKey('overnight')) {
      context.handle(_overnightMeta,
          overnight.isAcceptableOrUnknown(data['overnight']!, _overnightMeta));
    }
    if (data.containsKey('control_overnight')) {
      context.handle(
          _controlOvernightMeta,
          controlOvernight.isAcceptableOrUnknown(
              data['control_overnight']!, _controlOvernightMeta));
    }
    if (data.containsKey('allow_gpo_on_app')) {
      context.handle(
          _allowGpoOnAppMeta,
          allowGpoOnApp.isAcceptableOrUnknown(
              data['allow_gpo_on_app']!, _allowGpoOnAppMeta));
    }
    if (data.containsKey('export_not_checked')) {
      context.handle(
          _exportNotCheckedMeta,
          exportNotChecked.isAcceptableOrUnknown(
              data['export_not_checked']!, _exportNotCheckedMeta));
    }
    if (data.containsKey('insight_out_of_bound')) {
      context.handle(
          _insightOutOfBoundMeta,
          insightOutOfBound.isAcceptableOrUnknown(
              data['insight_out_of_bound']!, _insightOutOfBoundMeta));
    }
    if (data.containsKey('take_photo_single')) {
      context.handle(
          _takePhotoSingleMeta,
          takePhotoSingle.isAcceptableOrUnknown(
              data['take_photo_single']!, _takePhotoSingleMeta));
    }
    if (data.containsKey('take_photo_multi')) {
      context.handle(
          _takePhotoMultiMeta,
          takePhotoMulti.isAcceptableOrUnknown(
              data['take_photo_multi']!, _takePhotoMultiMeta));
    }
    if (data.containsKey('take_photo_driver')) {
      context.handle(
          _takePhotoDriverMeta,
          takePhotoDriver.isAcceptableOrUnknown(
              data['take_photo_driver']!, _takePhotoDriverMeta));
    }
    if (data.containsKey('take_photo_qrcode')) {
      context.handle(
          _takePhotoQrcodeMeta,
          takePhotoQrcode.isAcceptableOrUnknown(
              data['take_photo_qrcode']!, _takePhotoQrcodeMeta));
    }
    if (data.containsKey('take_photo_nfc')) {
      context.handle(
          _takePhotoNfcMeta,
          takePhotoNfc.isAcceptableOrUnknown(
              data['take_photo_nfc']!, _takePhotoNfcMeta));
    }
    if (data.containsKey('open_external_browser')) {
      context.handle(
          _openExternalBrowserMeta,
          openExternalBrowser.isAcceptableOrUnknown(
              data['open_external_browser']!, _openExternalBrowserMeta));
    }
    if (data.containsKey('clocking_event_uses')) {
      context.handle(
          _clockingEventUsesMeta,
          clockingEventUses.isAcceptableOrUnknown(
              data['clocking_event_uses']!, _clockingEventUsesMeta));
    }
    if (data.containsKey('allow_use')) {
      context.handle(_allowUseMeta,
          allowUse.isAcceptableOrUnknown(data['allow_use']!, _allowUseMeta));
    }
    if (data.containsKey('external_control_timezone')) {
      context.handle(
          _externalControlTimezoneMeta,
          externalControlTimezone.isAcceptableOrUnknown(
              data['external_control_timezone']!,
              _externalControlTimezoneMeta));
    }
    if (data.containsKey('face_recognition')) {
      context.handle(
          _faceRecognitionMeta,
          faceRecognition.isAcceptableOrUnknown(
              data['face_recognition']!, _faceRecognitionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlobalConfigurationTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlobalConfigurationTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      gps: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}gps']),
      online: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}online']),
      timeout: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timeout']),
      operationMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation_mode']),
      nfcMode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}nfc_mode']),
      allowChangeTime: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_change_time']),
      timezone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timezone']),
      deviceAuthModeSingleMode: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}device_auth_mode_single_mode']),
      deviceAuthModeMultiMode: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}device_auth_mode_multi_mode']),
      deviceAuthModeDriverMode: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}device_auth_mode_driver_mode']),
      allowDrivingTime: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}allow_driving_time']),
      overnight: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}overnight']),
      controlOvernight: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}control_overnight']),
      allowGpoOnApp: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_gpo_on_app']),
      exportNotChecked: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}export_not_checked']),
      insightOutOfBound: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}insight_out_of_bound']),
      takePhotoSingle: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_single']),
      takePhotoMulti: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_multi']),
      takePhotoDriver: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_driver']),
      takePhotoQrcode: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_qrcode']),
      takePhotoNfc: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}take_photo_nfc']),
      openExternalBrowser: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}open_external_browser']),
      clockingEventUses: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}clocking_event_uses']),
      allowUse: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}allow_use']),
      externalControlTimezone: attachedDatabase.typeMapping.read(
          DriftSqlType.bool,
          data['${effectivePrefix}external_control_timezone'])!,
      faceRecognition: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}face_recognition'])!,
    );
  }

  @override
  $GlobalConfigurationTableTable createAlias(String alias) {
    return $GlobalConfigurationTableTable(attachedDatabase, alias);
  }
}

class GlobalConfigurationTableData extends DataClass
    implements Insertable<GlobalConfigurationTableData> {
  final String id;
  final bool? gps;
  final bool? online;
  final String? timeout;
  final String? operationMode;
  final bool? nfcMode;
  final bool? allowChangeTime;
  final String? timezone;
  final String? deviceAuthModeSingleMode;
  final String? deviceAuthModeMultiMode;
  final String? deviceAuthModeDriverMode;
  final bool? allowDrivingTime;
  final bool? overnight;
  final bool? controlOvernight;
  final bool? allowGpoOnApp;
  final bool? exportNotChecked;
  final String? insightOutOfBound;
  final bool? takePhotoSingle;
  final bool? takePhotoMulti;
  final bool? takePhotoDriver;
  final bool? takePhotoQrcode;
  final bool? takePhotoNfc;
  final bool? openExternalBrowser;
  final String? clockingEventUses;
  final bool? allowUse;
  final bool externalControlTimezone;
  final bool faceRecognition;
  const GlobalConfigurationTableData(
      {required this.id,
      this.gps,
      this.online,
      this.timeout,
      this.operationMode,
      this.nfcMode,
      this.allowChangeTime,
      this.timezone,
      this.deviceAuthModeSingleMode,
      this.deviceAuthModeMultiMode,
      this.deviceAuthModeDriverMode,
      this.allowDrivingTime,
      this.overnight,
      this.controlOvernight,
      this.allowGpoOnApp,
      this.exportNotChecked,
      this.insightOutOfBound,
      this.takePhotoSingle,
      this.takePhotoMulti,
      this.takePhotoDriver,
      this.takePhotoQrcode,
      this.takePhotoNfc,
      this.openExternalBrowser,
      this.clockingEventUses,
      this.allowUse,
      required this.externalControlTimezone,
      required this.faceRecognition});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || gps != null) {
      map['gps'] = Variable<bool>(gps);
    }
    if (!nullToAbsent || online != null) {
      map['online'] = Variable<bool>(online);
    }
    if (!nullToAbsent || timeout != null) {
      map['timeout'] = Variable<String>(timeout);
    }
    if (!nullToAbsent || operationMode != null) {
      map['operation_mode'] = Variable<String>(operationMode);
    }
    if (!nullToAbsent || nfcMode != null) {
      map['nfc_mode'] = Variable<bool>(nfcMode);
    }
    if (!nullToAbsent || allowChangeTime != null) {
      map['allow_change_time'] = Variable<bool>(allowChangeTime);
    }
    if (!nullToAbsent || timezone != null) {
      map['timezone'] = Variable<String>(timezone);
    }
    if (!nullToAbsent || deviceAuthModeSingleMode != null) {
      map['device_auth_mode_single_mode'] =
          Variable<String>(deviceAuthModeSingleMode);
    }
    if (!nullToAbsent || deviceAuthModeMultiMode != null) {
      map['device_auth_mode_multi_mode'] =
          Variable<String>(deviceAuthModeMultiMode);
    }
    if (!nullToAbsent || deviceAuthModeDriverMode != null) {
      map['device_auth_mode_driver_mode'] =
          Variable<String>(deviceAuthModeDriverMode);
    }
    if (!nullToAbsent || allowDrivingTime != null) {
      map['allow_driving_time'] = Variable<bool>(allowDrivingTime);
    }
    if (!nullToAbsent || overnight != null) {
      map['overnight'] = Variable<bool>(overnight);
    }
    if (!nullToAbsent || controlOvernight != null) {
      map['control_overnight'] = Variable<bool>(controlOvernight);
    }
    if (!nullToAbsent || allowGpoOnApp != null) {
      map['allow_gpo_on_app'] = Variable<bool>(allowGpoOnApp);
    }
    if (!nullToAbsent || exportNotChecked != null) {
      map['export_not_checked'] = Variable<bool>(exportNotChecked);
    }
    if (!nullToAbsent || insightOutOfBound != null) {
      map['insight_out_of_bound'] = Variable<String>(insightOutOfBound);
    }
    if (!nullToAbsent || takePhotoSingle != null) {
      map['take_photo_single'] = Variable<bool>(takePhotoSingle);
    }
    if (!nullToAbsent || takePhotoMulti != null) {
      map['take_photo_multi'] = Variable<bool>(takePhotoMulti);
    }
    if (!nullToAbsent || takePhotoDriver != null) {
      map['take_photo_driver'] = Variable<bool>(takePhotoDriver);
    }
    if (!nullToAbsent || takePhotoQrcode != null) {
      map['take_photo_qrcode'] = Variable<bool>(takePhotoQrcode);
    }
    if (!nullToAbsent || takePhotoNfc != null) {
      map['take_photo_nfc'] = Variable<bool>(takePhotoNfc);
    }
    if (!nullToAbsent || openExternalBrowser != null) {
      map['open_external_browser'] = Variable<bool>(openExternalBrowser);
    }
    if (!nullToAbsent || clockingEventUses != null) {
      map['clocking_event_uses'] = Variable<String>(clockingEventUses);
    }
    if (!nullToAbsent || allowUse != null) {
      map['allow_use'] = Variable<bool>(allowUse);
    }
    map['external_control_timezone'] = Variable<bool>(externalControlTimezone);
    map['face_recognition'] = Variable<bool>(faceRecognition);
    return map;
  }

  GlobalConfigurationTableCompanion toCompanion(bool nullToAbsent) {
    return GlobalConfigurationTableCompanion(
      id: Value(id),
      gps: gps == null && nullToAbsent ? const Value.absent() : Value(gps),
      online:
          online == null && nullToAbsent ? const Value.absent() : Value(online),
      timeout: timeout == null && nullToAbsent
          ? const Value.absent()
          : Value(timeout),
      operationMode: operationMode == null && nullToAbsent
          ? const Value.absent()
          : Value(operationMode),
      nfcMode: nfcMode == null && nullToAbsent
          ? const Value.absent()
          : Value(nfcMode),
      allowChangeTime: allowChangeTime == null && nullToAbsent
          ? const Value.absent()
          : Value(allowChangeTime),
      timezone: timezone == null && nullToAbsent
          ? const Value.absent()
          : Value(timezone),
      deviceAuthModeSingleMode: deviceAuthModeSingleMode == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceAuthModeSingleMode),
      deviceAuthModeMultiMode: deviceAuthModeMultiMode == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceAuthModeMultiMode),
      deviceAuthModeDriverMode: deviceAuthModeDriverMode == null && nullToAbsent
          ? const Value.absent()
          : Value(deviceAuthModeDriverMode),
      allowDrivingTime: allowDrivingTime == null && nullToAbsent
          ? const Value.absent()
          : Value(allowDrivingTime),
      overnight: overnight == null && nullToAbsent
          ? const Value.absent()
          : Value(overnight),
      controlOvernight: controlOvernight == null && nullToAbsent
          ? const Value.absent()
          : Value(controlOvernight),
      allowGpoOnApp: allowGpoOnApp == null && nullToAbsent
          ? const Value.absent()
          : Value(allowGpoOnApp),
      exportNotChecked: exportNotChecked == null && nullToAbsent
          ? const Value.absent()
          : Value(exportNotChecked),
      insightOutOfBound: insightOutOfBound == null && nullToAbsent
          ? const Value.absent()
          : Value(insightOutOfBound),
      takePhotoSingle: takePhotoSingle == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoSingle),
      takePhotoMulti: takePhotoMulti == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoMulti),
      takePhotoDriver: takePhotoDriver == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoDriver),
      takePhotoQrcode: takePhotoQrcode == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoQrcode),
      takePhotoNfc: takePhotoNfc == null && nullToAbsent
          ? const Value.absent()
          : Value(takePhotoNfc),
      openExternalBrowser: openExternalBrowser == null && nullToAbsent
          ? const Value.absent()
          : Value(openExternalBrowser),
      clockingEventUses: clockingEventUses == null && nullToAbsent
          ? const Value.absent()
          : Value(clockingEventUses),
      allowUse: allowUse == null && nullToAbsent
          ? const Value.absent()
          : Value(allowUse),
      externalControlTimezone: Value(externalControlTimezone),
      faceRecognition: Value(faceRecognition),
    );
  }

  factory GlobalConfigurationTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlobalConfigurationTableData(
      id: serializer.fromJson<String>(json['id']),
      gps: serializer.fromJson<bool?>(json['gps']),
      online: serializer.fromJson<bool?>(json['online']),
      timeout: serializer.fromJson<String?>(json['timeout']),
      operationMode: serializer.fromJson<String?>(json['operationMode']),
      nfcMode: serializer.fromJson<bool?>(json['nfcMode']),
      allowChangeTime: serializer.fromJson<bool?>(json['allowChangeTime']),
      timezone: serializer.fromJson<String?>(json['timezone']),
      deviceAuthModeSingleMode:
          serializer.fromJson<String?>(json['deviceAuthModeSingleMode']),
      deviceAuthModeMultiMode:
          serializer.fromJson<String?>(json['deviceAuthModeMultiMode']),
      deviceAuthModeDriverMode:
          serializer.fromJson<String?>(json['deviceAuthModeDriverMode']),
      allowDrivingTime: serializer.fromJson<bool?>(json['allowDrivingTime']),
      overnight: serializer.fromJson<bool?>(json['overnight']),
      controlOvernight: serializer.fromJson<bool?>(json['controlOvernight']),
      allowGpoOnApp: serializer.fromJson<bool?>(json['allowGpoOnApp']),
      exportNotChecked: serializer.fromJson<bool?>(json['exportNotChecked']),
      insightOutOfBound:
          serializer.fromJson<String?>(json['insightOutOfBound']),
      takePhotoSingle: serializer.fromJson<bool?>(json['takePhotoSingle']),
      takePhotoMulti: serializer.fromJson<bool?>(json['takePhotoMulti']),
      takePhotoDriver: serializer.fromJson<bool?>(json['takePhotoDriver']),
      takePhotoQrcode: serializer.fromJson<bool?>(json['takePhotoQrcode']),
      takePhotoNfc: serializer.fromJson<bool?>(json['takePhotoNfc']),
      openExternalBrowser:
          serializer.fromJson<bool?>(json['openExternalBrowser']),
      clockingEventUses:
          serializer.fromJson<String?>(json['clockingEventUses']),
      allowUse: serializer.fromJson<bool?>(json['allowUse']),
      externalControlTimezone:
          serializer.fromJson<bool>(json['externalControlTimezone']),
      faceRecognition: serializer.fromJson<bool>(json['faceRecognition']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'gps': serializer.toJson<bool?>(gps),
      'online': serializer.toJson<bool?>(online),
      'timeout': serializer.toJson<String?>(timeout),
      'operationMode': serializer.toJson<String?>(operationMode),
      'nfcMode': serializer.toJson<bool?>(nfcMode),
      'allowChangeTime': serializer.toJson<bool?>(allowChangeTime),
      'timezone': serializer.toJson<String?>(timezone),
      'deviceAuthModeSingleMode':
          serializer.toJson<String?>(deviceAuthModeSingleMode),
      'deviceAuthModeMultiMode':
          serializer.toJson<String?>(deviceAuthModeMultiMode),
      'deviceAuthModeDriverMode':
          serializer.toJson<String?>(deviceAuthModeDriverMode),
      'allowDrivingTime': serializer.toJson<bool?>(allowDrivingTime),
      'overnight': serializer.toJson<bool?>(overnight),
      'controlOvernight': serializer.toJson<bool?>(controlOvernight),
      'allowGpoOnApp': serializer.toJson<bool?>(allowGpoOnApp),
      'exportNotChecked': serializer.toJson<bool?>(exportNotChecked),
      'insightOutOfBound': serializer.toJson<String?>(insightOutOfBound),
      'takePhotoSingle': serializer.toJson<bool?>(takePhotoSingle),
      'takePhotoMulti': serializer.toJson<bool?>(takePhotoMulti),
      'takePhotoDriver': serializer.toJson<bool?>(takePhotoDriver),
      'takePhotoQrcode': serializer.toJson<bool?>(takePhotoQrcode),
      'takePhotoNfc': serializer.toJson<bool?>(takePhotoNfc),
      'openExternalBrowser': serializer.toJson<bool?>(openExternalBrowser),
      'clockingEventUses': serializer.toJson<String?>(clockingEventUses),
      'allowUse': serializer.toJson<bool?>(allowUse),
      'externalControlTimezone':
          serializer.toJson<bool>(externalControlTimezone),
      'faceRecognition': serializer.toJson<bool>(faceRecognition),
    };
  }

  GlobalConfigurationTableData copyWith(
          {String? id,
          Value<bool?> gps = const Value.absent(),
          Value<bool?> online = const Value.absent(),
          Value<String?> timeout = const Value.absent(),
          Value<String?> operationMode = const Value.absent(),
          Value<bool?> nfcMode = const Value.absent(),
          Value<bool?> allowChangeTime = const Value.absent(),
          Value<String?> timezone = const Value.absent(),
          Value<String?> deviceAuthModeSingleMode = const Value.absent(),
          Value<String?> deviceAuthModeMultiMode = const Value.absent(),
          Value<String?> deviceAuthModeDriverMode = const Value.absent(),
          Value<bool?> allowDrivingTime = const Value.absent(),
          Value<bool?> overnight = const Value.absent(),
          Value<bool?> controlOvernight = const Value.absent(),
          Value<bool?> allowGpoOnApp = const Value.absent(),
          Value<bool?> exportNotChecked = const Value.absent(),
          Value<String?> insightOutOfBound = const Value.absent(),
          Value<bool?> takePhotoSingle = const Value.absent(),
          Value<bool?> takePhotoMulti = const Value.absent(),
          Value<bool?> takePhotoDriver = const Value.absent(),
          Value<bool?> takePhotoQrcode = const Value.absent(),
          Value<bool?> takePhotoNfc = const Value.absent(),
          Value<bool?> openExternalBrowser = const Value.absent(),
          Value<String?> clockingEventUses = const Value.absent(),
          Value<bool?> allowUse = const Value.absent(),
          bool? externalControlTimezone,
          bool? faceRecognition}) =>
      GlobalConfigurationTableData(
        id: id ?? this.id,
        gps: gps.present ? gps.value : this.gps,
        online: online.present ? online.value : this.online,
        timeout: timeout.present ? timeout.value : this.timeout,
        operationMode:
            operationMode.present ? operationMode.value : this.operationMode,
        nfcMode: nfcMode.present ? nfcMode.value : this.nfcMode,
        allowChangeTime: allowChangeTime.present
            ? allowChangeTime.value
            : this.allowChangeTime,
        timezone: timezone.present ? timezone.value : this.timezone,
        deviceAuthModeSingleMode: deviceAuthModeSingleMode.present
            ? deviceAuthModeSingleMode.value
            : this.deviceAuthModeSingleMode,
        deviceAuthModeMultiMode: deviceAuthModeMultiMode.present
            ? deviceAuthModeMultiMode.value
            : this.deviceAuthModeMultiMode,
        deviceAuthModeDriverMode: deviceAuthModeDriverMode.present
            ? deviceAuthModeDriverMode.value
            : this.deviceAuthModeDriverMode,
        allowDrivingTime: allowDrivingTime.present
            ? allowDrivingTime.value
            : this.allowDrivingTime,
        overnight: overnight.present ? overnight.value : this.overnight,
        controlOvernight: controlOvernight.present
            ? controlOvernight.value
            : this.controlOvernight,
        allowGpoOnApp:
            allowGpoOnApp.present ? allowGpoOnApp.value : this.allowGpoOnApp,
        exportNotChecked: exportNotChecked.present
            ? exportNotChecked.value
            : this.exportNotChecked,
        insightOutOfBound: insightOutOfBound.present
            ? insightOutOfBound.value
            : this.insightOutOfBound,
        takePhotoSingle: takePhotoSingle.present
            ? takePhotoSingle.value
            : this.takePhotoSingle,
        takePhotoMulti:
            takePhotoMulti.present ? takePhotoMulti.value : this.takePhotoMulti,
        takePhotoDriver: takePhotoDriver.present
            ? takePhotoDriver.value
            : this.takePhotoDriver,
        takePhotoQrcode: takePhotoQrcode.present
            ? takePhotoQrcode.value
            : this.takePhotoQrcode,
        takePhotoNfc:
            takePhotoNfc.present ? takePhotoNfc.value : this.takePhotoNfc,
        openExternalBrowser: openExternalBrowser.present
            ? openExternalBrowser.value
            : this.openExternalBrowser,
        clockingEventUses: clockingEventUses.present
            ? clockingEventUses.value
            : this.clockingEventUses,
        allowUse: allowUse.present ? allowUse.value : this.allowUse,
        externalControlTimezone:
            externalControlTimezone ?? this.externalControlTimezone,
        faceRecognition: faceRecognition ?? this.faceRecognition,
      );
  GlobalConfigurationTableData copyWithCompanion(
      GlobalConfigurationTableCompanion data) {
    return GlobalConfigurationTableData(
      id: data.id.present ? data.id.value : this.id,
      gps: data.gps.present ? data.gps.value : this.gps,
      online: data.online.present ? data.online.value : this.online,
      timeout: data.timeout.present ? data.timeout.value : this.timeout,
      operationMode: data.operationMode.present
          ? data.operationMode.value
          : this.operationMode,
      nfcMode: data.nfcMode.present ? data.nfcMode.value : this.nfcMode,
      allowChangeTime: data.allowChangeTime.present
          ? data.allowChangeTime.value
          : this.allowChangeTime,
      timezone: data.timezone.present ? data.timezone.value : this.timezone,
      deviceAuthModeSingleMode: data.deviceAuthModeSingleMode.present
          ? data.deviceAuthModeSingleMode.value
          : this.deviceAuthModeSingleMode,
      deviceAuthModeMultiMode: data.deviceAuthModeMultiMode.present
          ? data.deviceAuthModeMultiMode.value
          : this.deviceAuthModeMultiMode,
      deviceAuthModeDriverMode: data.deviceAuthModeDriverMode.present
          ? data.deviceAuthModeDriverMode.value
          : this.deviceAuthModeDriverMode,
      allowDrivingTime: data.allowDrivingTime.present
          ? data.allowDrivingTime.value
          : this.allowDrivingTime,
      overnight: data.overnight.present ? data.overnight.value : this.overnight,
      controlOvernight: data.controlOvernight.present
          ? data.controlOvernight.value
          : this.controlOvernight,
      allowGpoOnApp: data.allowGpoOnApp.present
          ? data.allowGpoOnApp.value
          : this.allowGpoOnApp,
      exportNotChecked: data.exportNotChecked.present
          ? data.exportNotChecked.value
          : this.exportNotChecked,
      insightOutOfBound: data.insightOutOfBound.present
          ? data.insightOutOfBound.value
          : this.insightOutOfBound,
      takePhotoSingle: data.takePhotoSingle.present
          ? data.takePhotoSingle.value
          : this.takePhotoSingle,
      takePhotoMulti: data.takePhotoMulti.present
          ? data.takePhotoMulti.value
          : this.takePhotoMulti,
      takePhotoDriver: data.takePhotoDriver.present
          ? data.takePhotoDriver.value
          : this.takePhotoDriver,
      takePhotoQrcode: data.takePhotoQrcode.present
          ? data.takePhotoQrcode.value
          : this.takePhotoQrcode,
      takePhotoNfc: data.takePhotoNfc.present
          ? data.takePhotoNfc.value
          : this.takePhotoNfc,
      openExternalBrowser: data.openExternalBrowser.present
          ? data.openExternalBrowser.value
          : this.openExternalBrowser,
      clockingEventUses: data.clockingEventUses.present
          ? data.clockingEventUses.value
          : this.clockingEventUses,
      allowUse: data.allowUse.present ? data.allowUse.value : this.allowUse,
      externalControlTimezone: data.externalControlTimezone.present
          ? data.externalControlTimezone.value
          : this.externalControlTimezone,
      faceRecognition: data.faceRecognition.present
          ? data.faceRecognition.value
          : this.faceRecognition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlobalConfigurationTableData(')
          ..write('id: $id, ')
          ..write('gps: $gps, ')
          ..write('online: $online, ')
          ..write('timeout: $timeout, ')
          ..write('operationMode: $operationMode, ')
          ..write('nfcMode: $nfcMode, ')
          ..write('allowChangeTime: $allowChangeTime, ')
          ..write('timezone: $timezone, ')
          ..write('deviceAuthModeSingleMode: $deviceAuthModeSingleMode, ')
          ..write('deviceAuthModeMultiMode: $deviceAuthModeMultiMode, ')
          ..write('deviceAuthModeDriverMode: $deviceAuthModeDriverMode, ')
          ..write('allowDrivingTime: $allowDrivingTime, ')
          ..write('overnight: $overnight, ')
          ..write('controlOvernight: $controlOvernight, ')
          ..write('allowGpoOnApp: $allowGpoOnApp, ')
          ..write('exportNotChecked: $exportNotChecked, ')
          ..write('insightOutOfBound: $insightOutOfBound, ')
          ..write('takePhotoSingle: $takePhotoSingle, ')
          ..write('takePhotoMulti: $takePhotoMulti, ')
          ..write('takePhotoDriver: $takePhotoDriver, ')
          ..write('takePhotoQrcode: $takePhotoQrcode, ')
          ..write('takePhotoNfc: $takePhotoNfc, ')
          ..write('openExternalBrowser: $openExternalBrowser, ')
          ..write('clockingEventUses: $clockingEventUses, ')
          ..write('allowUse: $allowUse, ')
          ..write('externalControlTimezone: $externalControlTimezone, ')
          ..write('faceRecognition: $faceRecognition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        gps,
        online,
        timeout,
        operationMode,
        nfcMode,
        allowChangeTime,
        timezone,
        deviceAuthModeSingleMode,
        deviceAuthModeMultiMode,
        deviceAuthModeDriverMode,
        allowDrivingTime,
        overnight,
        controlOvernight,
        allowGpoOnApp,
        exportNotChecked,
        insightOutOfBound,
        takePhotoSingle,
        takePhotoMulti,
        takePhotoDriver,
        takePhotoQrcode,
        takePhotoNfc,
        openExternalBrowser,
        clockingEventUses,
        allowUse,
        externalControlTimezone,
        faceRecognition
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlobalConfigurationTableData &&
          other.id == this.id &&
          other.gps == this.gps &&
          other.online == this.online &&
          other.timeout == this.timeout &&
          other.operationMode == this.operationMode &&
          other.nfcMode == this.nfcMode &&
          other.allowChangeTime == this.allowChangeTime &&
          other.timezone == this.timezone &&
          other.deviceAuthModeSingleMode == this.deviceAuthModeSingleMode &&
          other.deviceAuthModeMultiMode == this.deviceAuthModeMultiMode &&
          other.deviceAuthModeDriverMode == this.deviceAuthModeDriverMode &&
          other.allowDrivingTime == this.allowDrivingTime &&
          other.overnight == this.overnight &&
          other.controlOvernight == this.controlOvernight &&
          other.allowGpoOnApp == this.allowGpoOnApp &&
          other.exportNotChecked == this.exportNotChecked &&
          other.insightOutOfBound == this.insightOutOfBound &&
          other.takePhotoSingle == this.takePhotoSingle &&
          other.takePhotoMulti == this.takePhotoMulti &&
          other.takePhotoDriver == this.takePhotoDriver &&
          other.takePhotoQrcode == this.takePhotoQrcode &&
          other.takePhotoNfc == this.takePhotoNfc &&
          other.openExternalBrowser == this.openExternalBrowser &&
          other.clockingEventUses == this.clockingEventUses &&
          other.allowUse == this.allowUse &&
          other.externalControlTimezone == this.externalControlTimezone &&
          other.faceRecognition == this.faceRecognition);
}

class GlobalConfigurationTableCompanion
    extends UpdateCompanion<GlobalConfigurationTableData> {
  final Value<String> id;
  final Value<bool?> gps;
  final Value<bool?> online;
  final Value<String?> timeout;
  final Value<String?> operationMode;
  final Value<bool?> nfcMode;
  final Value<bool?> allowChangeTime;
  final Value<String?> timezone;
  final Value<String?> deviceAuthModeSingleMode;
  final Value<String?> deviceAuthModeMultiMode;
  final Value<String?> deviceAuthModeDriverMode;
  final Value<bool?> allowDrivingTime;
  final Value<bool?> overnight;
  final Value<bool?> controlOvernight;
  final Value<bool?> allowGpoOnApp;
  final Value<bool?> exportNotChecked;
  final Value<String?> insightOutOfBound;
  final Value<bool?> takePhotoSingle;
  final Value<bool?> takePhotoMulti;
  final Value<bool?> takePhotoDriver;
  final Value<bool?> takePhotoQrcode;
  final Value<bool?> takePhotoNfc;
  final Value<bool?> openExternalBrowser;
  final Value<String?> clockingEventUses;
  final Value<bool?> allowUse;
  final Value<bool> externalControlTimezone;
  final Value<bool> faceRecognition;
  final Value<int> rowid;
  const GlobalConfigurationTableCompanion({
    this.id = const Value.absent(),
    this.gps = const Value.absent(),
    this.online = const Value.absent(),
    this.timeout = const Value.absent(),
    this.operationMode = const Value.absent(),
    this.nfcMode = const Value.absent(),
    this.allowChangeTime = const Value.absent(),
    this.timezone = const Value.absent(),
    this.deviceAuthModeSingleMode = const Value.absent(),
    this.deviceAuthModeMultiMode = const Value.absent(),
    this.deviceAuthModeDriverMode = const Value.absent(),
    this.allowDrivingTime = const Value.absent(),
    this.overnight = const Value.absent(),
    this.controlOvernight = const Value.absent(),
    this.allowGpoOnApp = const Value.absent(),
    this.exportNotChecked = const Value.absent(),
    this.insightOutOfBound = const Value.absent(),
    this.takePhotoSingle = const Value.absent(),
    this.takePhotoMulti = const Value.absent(),
    this.takePhotoDriver = const Value.absent(),
    this.takePhotoQrcode = const Value.absent(),
    this.takePhotoNfc = const Value.absent(),
    this.openExternalBrowser = const Value.absent(),
    this.clockingEventUses = const Value.absent(),
    this.allowUse = const Value.absent(),
    this.externalControlTimezone = const Value.absent(),
    this.faceRecognition = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GlobalConfigurationTableCompanion.insert({
    required String id,
    this.gps = const Value.absent(),
    this.online = const Value.absent(),
    this.timeout = const Value.absent(),
    this.operationMode = const Value.absent(),
    this.nfcMode = const Value.absent(),
    this.allowChangeTime = const Value.absent(),
    this.timezone = const Value.absent(),
    this.deviceAuthModeSingleMode = const Value.absent(),
    this.deviceAuthModeMultiMode = const Value.absent(),
    this.deviceAuthModeDriverMode = const Value.absent(),
    this.allowDrivingTime = const Value.absent(),
    this.overnight = const Value.absent(),
    this.controlOvernight = const Value.absent(),
    this.allowGpoOnApp = const Value.absent(),
    this.exportNotChecked = const Value.absent(),
    this.insightOutOfBound = const Value.absent(),
    this.takePhotoSingle = const Value.absent(),
    this.takePhotoMulti = const Value.absent(),
    this.takePhotoDriver = const Value.absent(),
    this.takePhotoQrcode = const Value.absent(),
    this.takePhotoNfc = const Value.absent(),
    this.openExternalBrowser = const Value.absent(),
    this.clockingEventUses = const Value.absent(),
    this.allowUse = const Value.absent(),
    this.externalControlTimezone = const Value.absent(),
    this.faceRecognition = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<GlobalConfigurationTableData> custom({
    Expression<String>? id,
    Expression<bool>? gps,
    Expression<bool>? online,
    Expression<String>? timeout,
    Expression<String>? operationMode,
    Expression<bool>? nfcMode,
    Expression<bool>? allowChangeTime,
    Expression<String>? timezone,
    Expression<String>? deviceAuthModeSingleMode,
    Expression<String>? deviceAuthModeMultiMode,
    Expression<String>? deviceAuthModeDriverMode,
    Expression<bool>? allowDrivingTime,
    Expression<bool>? overnight,
    Expression<bool>? controlOvernight,
    Expression<bool>? allowGpoOnApp,
    Expression<bool>? exportNotChecked,
    Expression<String>? insightOutOfBound,
    Expression<bool>? takePhotoSingle,
    Expression<bool>? takePhotoMulti,
    Expression<bool>? takePhotoDriver,
    Expression<bool>? takePhotoQrcode,
    Expression<bool>? takePhotoNfc,
    Expression<bool>? openExternalBrowser,
    Expression<String>? clockingEventUses,
    Expression<bool>? allowUse,
    Expression<bool>? externalControlTimezone,
    Expression<bool>? faceRecognition,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gps != null) 'gps': gps,
      if (online != null) 'online': online,
      if (timeout != null) 'timeout': timeout,
      if (operationMode != null) 'operation_mode': operationMode,
      if (nfcMode != null) 'nfc_mode': nfcMode,
      if (allowChangeTime != null) 'allow_change_time': allowChangeTime,
      if (timezone != null) 'timezone': timezone,
      if (deviceAuthModeSingleMode != null)
        'device_auth_mode_single_mode': deviceAuthModeSingleMode,
      if (deviceAuthModeMultiMode != null)
        'device_auth_mode_multi_mode': deviceAuthModeMultiMode,
      if (deviceAuthModeDriverMode != null)
        'device_auth_mode_driver_mode': deviceAuthModeDriverMode,
      if (allowDrivingTime != null) 'allow_driving_time': allowDrivingTime,
      if (overnight != null) 'overnight': overnight,
      if (controlOvernight != null) 'control_overnight': controlOvernight,
      if (allowGpoOnApp != null) 'allow_gpo_on_app': allowGpoOnApp,
      if (exportNotChecked != null) 'export_not_checked': exportNotChecked,
      if (insightOutOfBound != null) 'insight_out_of_bound': insightOutOfBound,
      if (takePhotoSingle != null) 'take_photo_single': takePhotoSingle,
      if (takePhotoMulti != null) 'take_photo_multi': takePhotoMulti,
      if (takePhotoDriver != null) 'take_photo_driver': takePhotoDriver,
      if (takePhotoQrcode != null) 'take_photo_qrcode': takePhotoQrcode,
      if (takePhotoNfc != null) 'take_photo_nfc': takePhotoNfc,
      if (openExternalBrowser != null)
        'open_external_browser': openExternalBrowser,
      if (clockingEventUses != null) 'clocking_event_uses': clockingEventUses,
      if (allowUse != null) 'allow_use': allowUse,
      if (externalControlTimezone != null)
        'external_control_timezone': externalControlTimezone,
      if (faceRecognition != null) 'face_recognition': faceRecognition,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GlobalConfigurationTableCompanion copyWith(
      {Value<String>? id,
      Value<bool?>? gps,
      Value<bool?>? online,
      Value<String?>? timeout,
      Value<String?>? operationMode,
      Value<bool?>? nfcMode,
      Value<bool?>? allowChangeTime,
      Value<String?>? timezone,
      Value<String?>? deviceAuthModeSingleMode,
      Value<String?>? deviceAuthModeMultiMode,
      Value<String?>? deviceAuthModeDriverMode,
      Value<bool?>? allowDrivingTime,
      Value<bool?>? overnight,
      Value<bool?>? controlOvernight,
      Value<bool?>? allowGpoOnApp,
      Value<bool?>? exportNotChecked,
      Value<String?>? insightOutOfBound,
      Value<bool?>? takePhotoSingle,
      Value<bool?>? takePhotoMulti,
      Value<bool?>? takePhotoDriver,
      Value<bool?>? takePhotoQrcode,
      Value<bool?>? takePhotoNfc,
      Value<bool?>? openExternalBrowser,
      Value<String?>? clockingEventUses,
      Value<bool?>? allowUse,
      Value<bool>? externalControlTimezone,
      Value<bool>? faceRecognition,
      Value<int>? rowid}) {
    return GlobalConfigurationTableCompanion(
      id: id ?? this.id,
      gps: gps ?? this.gps,
      online: online ?? this.online,
      timeout: timeout ?? this.timeout,
      operationMode: operationMode ?? this.operationMode,
      nfcMode: nfcMode ?? this.nfcMode,
      allowChangeTime: allowChangeTime ?? this.allowChangeTime,
      timezone: timezone ?? this.timezone,
      deviceAuthModeSingleMode:
          deviceAuthModeSingleMode ?? this.deviceAuthModeSingleMode,
      deviceAuthModeMultiMode:
          deviceAuthModeMultiMode ?? this.deviceAuthModeMultiMode,
      deviceAuthModeDriverMode:
          deviceAuthModeDriverMode ?? this.deviceAuthModeDriverMode,
      allowDrivingTime: allowDrivingTime ?? this.allowDrivingTime,
      overnight: overnight ?? this.overnight,
      controlOvernight: controlOvernight ?? this.controlOvernight,
      allowGpoOnApp: allowGpoOnApp ?? this.allowGpoOnApp,
      exportNotChecked: exportNotChecked ?? this.exportNotChecked,
      insightOutOfBound: insightOutOfBound ?? this.insightOutOfBound,
      takePhotoSingle: takePhotoSingle ?? this.takePhotoSingle,
      takePhotoMulti: takePhotoMulti ?? this.takePhotoMulti,
      takePhotoDriver: takePhotoDriver ?? this.takePhotoDriver,
      takePhotoQrcode: takePhotoQrcode ?? this.takePhotoQrcode,
      takePhotoNfc: takePhotoNfc ?? this.takePhotoNfc,
      openExternalBrowser: openExternalBrowser ?? this.openExternalBrowser,
      clockingEventUses: clockingEventUses ?? this.clockingEventUses,
      allowUse: allowUse ?? this.allowUse,
      externalControlTimezone:
          externalControlTimezone ?? this.externalControlTimezone,
      faceRecognition: faceRecognition ?? this.faceRecognition,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (gps.present) {
      map['gps'] = Variable<bool>(gps.value);
    }
    if (online.present) {
      map['online'] = Variable<bool>(online.value);
    }
    if (timeout.present) {
      map['timeout'] = Variable<String>(timeout.value);
    }
    if (operationMode.present) {
      map['operation_mode'] = Variable<String>(operationMode.value);
    }
    if (nfcMode.present) {
      map['nfc_mode'] = Variable<bool>(nfcMode.value);
    }
    if (allowChangeTime.present) {
      map['allow_change_time'] = Variable<bool>(allowChangeTime.value);
    }
    if (timezone.present) {
      map['timezone'] = Variable<String>(timezone.value);
    }
    if (deviceAuthModeSingleMode.present) {
      map['device_auth_mode_single_mode'] =
          Variable<String>(deviceAuthModeSingleMode.value);
    }
    if (deviceAuthModeMultiMode.present) {
      map['device_auth_mode_multi_mode'] =
          Variable<String>(deviceAuthModeMultiMode.value);
    }
    if (deviceAuthModeDriverMode.present) {
      map['device_auth_mode_driver_mode'] =
          Variable<String>(deviceAuthModeDriverMode.value);
    }
    if (allowDrivingTime.present) {
      map['allow_driving_time'] = Variable<bool>(allowDrivingTime.value);
    }
    if (overnight.present) {
      map['overnight'] = Variable<bool>(overnight.value);
    }
    if (controlOvernight.present) {
      map['control_overnight'] = Variable<bool>(controlOvernight.value);
    }
    if (allowGpoOnApp.present) {
      map['allow_gpo_on_app'] = Variable<bool>(allowGpoOnApp.value);
    }
    if (exportNotChecked.present) {
      map['export_not_checked'] = Variable<bool>(exportNotChecked.value);
    }
    if (insightOutOfBound.present) {
      map['insight_out_of_bound'] = Variable<String>(insightOutOfBound.value);
    }
    if (takePhotoSingle.present) {
      map['take_photo_single'] = Variable<bool>(takePhotoSingle.value);
    }
    if (takePhotoMulti.present) {
      map['take_photo_multi'] = Variable<bool>(takePhotoMulti.value);
    }
    if (takePhotoDriver.present) {
      map['take_photo_driver'] = Variable<bool>(takePhotoDriver.value);
    }
    if (takePhotoQrcode.present) {
      map['take_photo_qrcode'] = Variable<bool>(takePhotoQrcode.value);
    }
    if (takePhotoNfc.present) {
      map['take_photo_nfc'] = Variable<bool>(takePhotoNfc.value);
    }
    if (openExternalBrowser.present) {
      map['open_external_browser'] = Variable<bool>(openExternalBrowser.value);
    }
    if (clockingEventUses.present) {
      map['clocking_event_uses'] = Variable<String>(clockingEventUses.value);
    }
    if (allowUse.present) {
      map['allow_use'] = Variable<bool>(allowUse.value);
    }
    if (externalControlTimezone.present) {
      map['external_control_timezone'] =
          Variable<bool>(externalControlTimezone.value);
    }
    if (faceRecognition.present) {
      map['face_recognition'] = Variable<bool>(faceRecognition.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlobalConfigurationTableCompanion(')
          ..write('id: $id, ')
          ..write('gps: $gps, ')
          ..write('online: $online, ')
          ..write('timeout: $timeout, ')
          ..write('operationMode: $operationMode, ')
          ..write('nfcMode: $nfcMode, ')
          ..write('allowChangeTime: $allowChangeTime, ')
          ..write('timezone: $timezone, ')
          ..write('deviceAuthModeSingleMode: $deviceAuthModeSingleMode, ')
          ..write('deviceAuthModeMultiMode: $deviceAuthModeMultiMode, ')
          ..write('deviceAuthModeDriverMode: $deviceAuthModeDriverMode, ')
          ..write('allowDrivingTime: $allowDrivingTime, ')
          ..write('overnight: $overnight, ')
          ..write('controlOvernight: $controlOvernight, ')
          ..write('allowGpoOnApp: $allowGpoOnApp, ')
          ..write('exportNotChecked: $exportNotChecked, ')
          ..write('insightOutOfBound: $insightOutOfBound, ')
          ..write('takePhotoSingle: $takePhotoSingle, ')
          ..write('takePhotoMulti: $takePhotoMulti, ')
          ..write('takePhotoDriver: $takePhotoDriver, ')
          ..write('takePhotoQrcode: $takePhotoQrcode, ')
          ..write('takePhotoNfc: $takePhotoNfc, ')
          ..write('openExternalBrowser: $openExternalBrowser, ')
          ..write('clockingEventUses: $clockingEventUses, ')
          ..write('allowUse: $allowUse, ')
          ..write('externalControlTimezone: $externalControlTimezone, ')
          ..write('faceRecognition: $faceRecognition, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ManagerTableTable extends ManagerTable
    with TableInfo<$ManagerTableTable, ManagerTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ManagerTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mailMeta = const VerificationMeta('mail');
  @override
  late final GeneratedColumn<String> mail = GeneratedColumn<String>(
      'mail', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _platformUserNameMeta =
      const VerificationMeta('platformUserName');
  @override
  late final GeneratedColumn<String> platformUserName = GeneratedColumn<String>(
      'platform_user_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, mail, platformUserName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'manager_table';
  @override
  VerificationContext validateIntegrity(Insertable<ManagerTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('mail')) {
      context.handle(
          _mailMeta, mail.isAcceptableOrUnknown(data['mail']!, _mailMeta));
    }
    if (data.containsKey('platform_user_name')) {
      context.handle(
          _platformUserNameMeta,
          platformUserName.isAcceptableOrUnknown(
              data['platform_user_name']!, _platformUserNameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ManagerTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ManagerTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      mail: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mail']),
      platformUserName: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}platform_user_name']),
    );
  }

  @override
  $ManagerTableTable createAlias(String alias) {
    return $ManagerTableTable(attachedDatabase, alias);
  }
}

class ManagerTableData extends DataClass
    implements Insertable<ManagerTableData> {
  final String id;
  final String? mail;
  final String? platformUserName;
  const ManagerTableData({required this.id, this.mail, this.platformUserName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || mail != null) {
      map['mail'] = Variable<String>(mail);
    }
    if (!nullToAbsent || platformUserName != null) {
      map['platform_user_name'] = Variable<String>(platformUserName);
    }
    return map;
  }

  ManagerTableCompanion toCompanion(bool nullToAbsent) {
    return ManagerTableCompanion(
      id: Value(id),
      mail: mail == null && nullToAbsent ? const Value.absent() : Value(mail),
      platformUserName: platformUserName == null && nullToAbsent
          ? const Value.absent()
          : Value(platformUserName),
    );
  }

  factory ManagerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ManagerTableData(
      id: serializer.fromJson<String>(json['id']),
      mail: serializer.fromJson<String?>(json['mail']),
      platformUserName: serializer.fromJson<String?>(json['platformUserName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'mail': serializer.toJson<String?>(mail),
      'platformUserName': serializer.toJson<String?>(platformUserName),
    };
  }

  ManagerTableData copyWith(
          {String? id,
          Value<String?> mail = const Value.absent(),
          Value<String?> platformUserName = const Value.absent()}) =>
      ManagerTableData(
        id: id ?? this.id,
        mail: mail.present ? mail.value : this.mail,
        platformUserName: platformUserName.present
            ? platformUserName.value
            : this.platformUserName,
      );
  ManagerTableData copyWithCompanion(ManagerTableCompanion data) {
    return ManagerTableData(
      id: data.id.present ? data.id.value : this.id,
      mail: data.mail.present ? data.mail.value : this.mail,
      platformUserName: data.platformUserName.present
          ? data.platformUserName.value
          : this.platformUserName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ManagerTableData(')
          ..write('id: $id, ')
          ..write('mail: $mail, ')
          ..write('platformUserName: $platformUserName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, mail, platformUserName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ManagerTableData &&
          other.id == this.id &&
          other.mail == this.mail &&
          other.platformUserName == this.platformUserName);
}

class ManagerTableCompanion extends UpdateCompanion<ManagerTableData> {
  final Value<String> id;
  final Value<String?> mail;
  final Value<String?> platformUserName;
  final Value<int> rowid;
  const ManagerTableCompanion({
    this.id = const Value.absent(),
    this.mail = const Value.absent(),
    this.platformUserName = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ManagerTableCompanion.insert({
    required String id,
    this.mail = const Value.absent(),
    this.platformUserName = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<ManagerTableData> custom({
    Expression<String>? id,
    Expression<String>? mail,
    Expression<String>? platformUserName,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mail != null) 'mail': mail,
      if (platformUserName != null) 'platform_user_name': platformUserName,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ManagerTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? mail,
      Value<String?>? platformUserName,
      Value<int>? rowid}) {
    return ManagerTableCompanion(
      id: id ?? this.id,
      mail: mail ?? this.mail,
      platformUserName: platformUserName ?? this.platformUserName,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (mail.present) {
      map['mail'] = Variable<String>(mail.value);
    }
    if (platformUserName.present) {
      map['platform_user_name'] = Variable<String>(platformUserName.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ManagerTableCompanion(')
          ..write('id: $id, ')
          ..write('mail: $mail, ')
          ..write('platformUserName: $platformUserName, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlatformUsersTableTable extends PlatformUsersTable
    with TableInfo<$PlatformUsersTableTable, PlatformUsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlatformUsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'platform_users_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PlatformUsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlatformUsersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlatformUsersTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $PlatformUsersTableTable createAlias(String alias) {
    return $PlatformUsersTableTable(attachedDatabase, alias);
  }
}

class PlatformUsersTableData extends DataClass
    implements Insertable<PlatformUsersTableData> {
  final String id;
  final String name;
  const PlatformUsersTableData({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlatformUsersTableCompanion toCompanion(bool nullToAbsent) {
    return PlatformUsersTableCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory PlatformUsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlatformUsersTableData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  PlatformUsersTableData copyWith({String? id, String? name}) =>
      PlatformUsersTableData(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  PlatformUsersTableData copyWithCompanion(PlatformUsersTableCompanion data) {
    return PlatformUsersTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlatformUsersTableData(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlatformUsersTableData &&
          other.id == this.id &&
          other.name == this.name);
}

class PlatformUsersTableCompanion
    extends UpdateCompanion<PlatformUsersTableData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const PlatformUsersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlatformUsersTableCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<PlatformUsersTableData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlatformUsersTableCompanion copyWith(
      {Value<String>? id, Value<String>? name, Value<int>? rowid}) {
    return PlatformUsersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlatformUsersTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeeManagersTableTable extends EmployeeManagersTable
    with TableInfo<$EmployeeManagersTableTable, EmployeeManagersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeeManagersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  static const VerificationMeta _managerIdMeta =
      const VerificationMeta('managerId');
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
      'manager_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES manager_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [employeeId, managerId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_managers_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<EmployeeManagersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('manager_id')) {
      context.handle(_managerIdMeta,
          managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta));
    } else if (isInserting) {
      context.missing(_managerIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, managerId};
  @override
  EmployeeManagersTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeeManagersTableData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      managerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manager_id'])!,
    );
  }

  @override
  $EmployeeManagersTableTable createAlias(String alias) {
    return $EmployeeManagersTableTable(attachedDatabase, alias);
  }
}

class EmployeeManagersTableData extends DataClass
    implements Insertable<EmployeeManagersTableData> {
  final String employeeId;
  final String managerId;
  const EmployeeManagersTableData(
      {required this.employeeId, required this.managerId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['manager_id'] = Variable<String>(managerId);
    return map;
  }

  EmployeeManagersTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeeManagersTableCompanion(
      employeeId: Value(employeeId),
      managerId: Value(managerId),
    );
  }

  factory EmployeeManagersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeeManagersTableData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      managerId: serializer.fromJson<String>(json['managerId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'managerId': serializer.toJson<String>(managerId),
    };
  }

  EmployeeManagersTableData copyWith({String? employeeId, String? managerId}) =>
      EmployeeManagersTableData(
        employeeId: employeeId ?? this.employeeId,
        managerId: managerId ?? this.managerId,
      );
  EmployeeManagersTableData copyWithCompanion(
      EmployeeManagersTableCompanion data) {
    return EmployeeManagersTableData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeManagersTableData(')
          ..write('employeeId: $employeeId, ')
          ..write('managerId: $managerId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, managerId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeeManagersTableData &&
          other.employeeId == this.employeeId &&
          other.managerId == this.managerId);
}

class EmployeeManagersTableCompanion
    extends UpdateCompanion<EmployeeManagersTableData> {
  final Value<String> employeeId;
  final Value<String> managerId;
  final Value<int> rowid;
  const EmployeeManagersTableCompanion({
    this.employeeId = const Value.absent(),
    this.managerId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeeManagersTableCompanion.insert({
    required String employeeId,
    required String managerId,
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        managerId = Value(managerId);
  static Insertable<EmployeeManagersTableData> custom({
    Expression<String>? employeeId,
    Expression<String>? managerId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (managerId != null) 'manager_id': managerId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeeManagersTableCompanion copyWith(
      {Value<String>? employeeId,
      Value<String>? managerId,
      Value<int>? rowid}) {
    return EmployeeManagersTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      managerId: managerId ?? this.managerId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeeManagersTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('managerId: $managerId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EmployeePlatformUsersTableTable extends EmployeePlatformUsersTable
    with
        TableInfo<$EmployeePlatformUsersTableTable,
            EmployeePlatformUsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeePlatformUsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  static const VerificationMeta _platforUsersIdMeta =
      const VerificationMeta('platforUsersId');
  @override
  late final GeneratedColumn<String> platforUsersId = GeneratedColumn<String>(
      'platfor_users_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES platform_users_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [employeeId, platforUsersId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employee_platform_users_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<EmployeePlatformUsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('platfor_users_id')) {
      context.handle(
          _platforUsersIdMeta,
          platforUsersId.isAcceptableOrUnknown(
              data['platfor_users_id']!, _platforUsersIdMeta));
    } else if (isInserting) {
      context.missing(_platforUsersIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, platforUsersId};
  @override
  EmployeePlatformUsersTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmployeePlatformUsersTableData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      platforUsersId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}platfor_users_id'])!,
    );
  }

  @override
  $EmployeePlatformUsersTableTable createAlias(String alias) {
    return $EmployeePlatformUsersTableTable(attachedDatabase, alias);
  }
}

class EmployeePlatformUsersTableData extends DataClass
    implements Insertable<EmployeePlatformUsersTableData> {
  final String employeeId;
  final String platforUsersId;
  const EmployeePlatformUsersTableData(
      {required this.employeeId, required this.platforUsersId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['platfor_users_id'] = Variable<String>(platforUsersId);
    return map;
  }

  EmployeePlatformUsersTableCompanion toCompanion(bool nullToAbsent) {
    return EmployeePlatformUsersTableCompanion(
      employeeId: Value(employeeId),
      platforUsersId: Value(platforUsersId),
    );
  }

  factory EmployeePlatformUsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmployeePlatformUsersTableData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      platforUsersId: serializer.fromJson<String>(json['platforUsersId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'platforUsersId': serializer.toJson<String>(platforUsersId),
    };
  }

  EmployeePlatformUsersTableData copyWith(
          {String? employeeId, String? platforUsersId}) =>
      EmployeePlatformUsersTableData(
        employeeId: employeeId ?? this.employeeId,
        platforUsersId: platforUsersId ?? this.platforUsersId,
      );
  EmployeePlatformUsersTableData copyWithCompanion(
      EmployeePlatformUsersTableCompanion data) {
    return EmployeePlatformUsersTableData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      platforUsersId: data.platforUsersId.present
          ? data.platforUsersId.value
          : this.platforUsersId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmployeePlatformUsersTableData(')
          ..write('employeeId: $employeeId, ')
          ..write('platforUsersId: $platforUsersId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, platforUsersId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmployeePlatformUsersTableData &&
          other.employeeId == this.employeeId &&
          other.platforUsersId == this.platforUsersId);
}

class EmployeePlatformUsersTableCompanion
    extends UpdateCompanion<EmployeePlatformUsersTableData> {
  final Value<String> employeeId;
  final Value<String> platforUsersId;
  final Value<int> rowid;
  const EmployeePlatformUsersTableCompanion({
    this.employeeId = const Value.absent(),
    this.platforUsersId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EmployeePlatformUsersTableCompanion.insert({
    required String employeeId,
    required String platforUsersId,
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        platforUsersId = Value(platforUsersId);
  static Insertable<EmployeePlatformUsersTableData> custom({
    Expression<String>? employeeId,
    Expression<String>? platforUsersId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (platforUsersId != null) 'platfor_users_id': platforUsersId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EmployeePlatformUsersTableCompanion copyWith(
      {Value<String>? employeeId,
      Value<String>? platforUsersId,
      Value<int>? rowid}) {
    return EmployeePlatformUsersTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      platforUsersId: platforUsersId ?? this.platforUsersId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (platforUsersId.present) {
      map['platfor_users_id'] = Variable<String>(platforUsersId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmployeePlatformUsersTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('platforUsersId: $platforUsersId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ManagersPlatformUsersTableTable extends ManagersPlatformUsersTable
    with
        TableInfo<$ManagersPlatformUsersTableTable,
            ManagersPlatformUsersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ManagersPlatformUsersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _managerIdMeta =
      const VerificationMeta('managerId');
  @override
  late final GeneratedColumn<String> managerId = GeneratedColumn<String>(
      'manager_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES manager_table (id)'));
  static const VerificationMeta _platforUsersIdMeta =
      const VerificationMeta('platforUsersId');
  @override
  late final GeneratedColumn<String> platforUsersId = GeneratedColumn<String>(
      'platfor_users_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES platform_users_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [managerId, platforUsersId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'managers_platform_users_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ManagersPlatformUsersTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('manager_id')) {
      context.handle(_managerIdMeta,
          managerId.isAcceptableOrUnknown(data['manager_id']!, _managerIdMeta));
    } else if (isInserting) {
      context.missing(_managerIdMeta);
    }
    if (data.containsKey('platfor_users_id')) {
      context.handle(
          _platforUsersIdMeta,
          platforUsersId.isAcceptableOrUnknown(
              data['platfor_users_id']!, _platforUsersIdMeta));
    } else if (isInserting) {
      context.missing(_platforUsersIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {managerId, platforUsersId};
  @override
  ManagersPlatformUsersTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ManagersPlatformUsersTableData(
      managerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}manager_id'])!,
      platforUsersId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}platfor_users_id'])!,
    );
  }

  @override
  $ManagersPlatformUsersTableTable createAlias(String alias) {
    return $ManagersPlatformUsersTableTable(attachedDatabase, alias);
  }
}

class ManagersPlatformUsersTableData extends DataClass
    implements Insertable<ManagersPlatformUsersTableData> {
  final String managerId;
  final String platforUsersId;
  const ManagersPlatformUsersTableData(
      {required this.managerId, required this.platforUsersId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['manager_id'] = Variable<String>(managerId);
    map['platfor_users_id'] = Variable<String>(platforUsersId);
    return map;
  }

  ManagersPlatformUsersTableCompanion toCompanion(bool nullToAbsent) {
    return ManagersPlatformUsersTableCompanion(
      managerId: Value(managerId),
      platforUsersId: Value(platforUsersId),
    );
  }

  factory ManagersPlatformUsersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ManagersPlatformUsersTableData(
      managerId: serializer.fromJson<String>(json['managerId']),
      platforUsersId: serializer.fromJson<String>(json['platforUsersId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'managerId': serializer.toJson<String>(managerId),
      'platforUsersId': serializer.toJson<String>(platforUsersId),
    };
  }

  ManagersPlatformUsersTableData copyWith(
          {String? managerId, String? platforUsersId}) =>
      ManagersPlatformUsersTableData(
        managerId: managerId ?? this.managerId,
        platforUsersId: platforUsersId ?? this.platforUsersId,
      );
  ManagersPlatformUsersTableData copyWithCompanion(
      ManagersPlatformUsersTableCompanion data) {
    return ManagersPlatformUsersTableData(
      managerId: data.managerId.present ? data.managerId.value : this.managerId,
      platforUsersId: data.platforUsersId.present
          ? data.platforUsersId.value
          : this.platforUsersId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ManagersPlatformUsersTableData(')
          ..write('managerId: $managerId, ')
          ..write('platforUsersId: $platforUsersId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(managerId, platforUsersId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ManagersPlatformUsersTableData &&
          other.managerId == this.managerId &&
          other.platforUsersId == this.platforUsersId);
}

class ManagersPlatformUsersTableCompanion
    extends UpdateCompanion<ManagersPlatformUsersTableData> {
  final Value<String> managerId;
  final Value<String> platforUsersId;
  final Value<int> rowid;
  const ManagersPlatformUsersTableCompanion({
    this.managerId = const Value.absent(),
    this.platforUsersId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ManagersPlatformUsersTableCompanion.insert({
    required String managerId,
    required String platforUsersId,
    this.rowid = const Value.absent(),
  })  : managerId = Value(managerId),
        platforUsersId = Value(platforUsersId);
  static Insertable<ManagersPlatformUsersTableData> custom({
    Expression<String>? managerId,
    Expression<String>? platforUsersId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (managerId != null) 'manager_id': managerId,
      if (platforUsersId != null) 'platfor_users_id': platforUsersId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ManagersPlatformUsersTableCompanion copyWith(
      {Value<String>? managerId,
      Value<String>? platforUsersId,
      Value<int>? rowid}) {
    return ManagersPlatformUsersTableCompanion(
      managerId: managerId ?? this.managerId,
      platforUsersId: platforUsersId ?? this.platforUsersId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (managerId.present) {
      map['manager_id'] = Variable<String>(managerId.value);
    }
    if (platforUsersId.present) {
      map['platfor_users_id'] = Variable<String>(platforUsersId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ManagersPlatformUsersTableCompanion(')
          ..write('managerId: $managerId, ')
          ..write('platforUsersId: $platforUsersId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LogsTableTable extends LogsTable
    with TableInfo<$LogsTableTable, LogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
      'created_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deviceIdMeta =
      const VerificationMeta('deviceId');
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
      'device_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userPlatformMeta =
      const VerificationMeta('userPlatform');
  @override
  late final GeneratedColumn<String> userPlatform = GeneratedColumn<String>(
      'user_platform', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _employeeExternalIdMeta =
      const VerificationMeta('employeeExternalId');
  @override
  late final GeneratedColumn<String> employeeExternalId =
      GeneratedColumn<String>('employee_external_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logMeta = const VerificationMeta('log');
  @override
  late final GeneratedColumn<String> log = GeneratedColumn<String>(
      'log', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        createdAt,
        deviceId,
        userPlatform,
        employeeId,
        employeeExternalId,
        log
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'logs_table';
  @override
  VerificationContext validateIntegrity(Insertable<LogsTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('device_id')) {
      context.handle(_deviceIdMeta,
          deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta));
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('user_platform')) {
      context.handle(
          _userPlatformMeta,
          userPlatform.isAcceptableOrUnknown(
              data['user_platform']!, _userPlatformMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    }
    if (data.containsKey('employee_external_id')) {
      context.handle(
          _employeeExternalIdMeta,
          employeeExternalId.isAcceptableOrUnknown(
              data['employee_external_id']!, _employeeExternalIdMeta));
    }
    if (data.containsKey('log')) {
      context.handle(
          _logMeta, log.isAcceptableOrUnknown(data['log']!, _logMeta));
    } else if (isInserting) {
      context.missing(_logMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogsTableData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_at']),
      deviceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}device_id'])!,
      userPlatform: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_platform']),
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id']),
      employeeExternalId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}employee_external_id']),
      log: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}log'])!,
    );
  }

  @override
  $LogsTableTable createAlias(String alias) {
    return $LogsTableTable(attachedDatabase, alias);
  }
}

class LogsTableData extends DataClass implements Insertable<LogsTableData> {
  final String id;
  final String? createdAt;
  final String deviceId;
  final String? userPlatform;
  final String? employeeId;
  final String? employeeExternalId;
  final String log;
  const LogsTableData(
      {required this.id,
      this.createdAt,
      required this.deviceId,
      this.userPlatform,
      this.employeeId,
      this.employeeExternalId,
      required this.log});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    map['device_id'] = Variable<String>(deviceId);
    if (!nullToAbsent || userPlatform != null) {
      map['user_platform'] = Variable<String>(userPlatform);
    }
    if (!nullToAbsent || employeeId != null) {
      map['employee_id'] = Variable<String>(employeeId);
    }
    if (!nullToAbsent || employeeExternalId != null) {
      map['employee_external_id'] = Variable<String>(employeeExternalId);
    }
    map['log'] = Variable<String>(log);
    return map;
  }

  LogsTableCompanion toCompanion(bool nullToAbsent) {
    return LogsTableCompanion(
      id: Value(id),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      deviceId: Value(deviceId),
      userPlatform: userPlatform == null && nullToAbsent
          ? const Value.absent()
          : Value(userPlatform),
      employeeId: employeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeId),
      employeeExternalId: employeeExternalId == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeExternalId),
      log: Value(log),
    );
  }

  factory LogsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogsTableData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      userPlatform: serializer.fromJson<String?>(json['userPlatform']),
      employeeId: serializer.fromJson<String?>(json['employeeId']),
      employeeExternalId:
          serializer.fromJson<String?>(json['employeeExternalId']),
      log: serializer.fromJson<String>(json['log']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<String?>(createdAt),
      'deviceId': serializer.toJson<String>(deviceId),
      'userPlatform': serializer.toJson<String?>(userPlatform),
      'employeeId': serializer.toJson<String?>(employeeId),
      'employeeExternalId': serializer.toJson<String?>(employeeExternalId),
      'log': serializer.toJson<String>(log),
    };
  }

  LogsTableData copyWith(
          {String? id,
          Value<String?> createdAt = const Value.absent(),
          String? deviceId,
          Value<String?> userPlatform = const Value.absent(),
          Value<String?> employeeId = const Value.absent(),
          Value<String?> employeeExternalId = const Value.absent(),
          String? log}) =>
      LogsTableData(
        id: id ?? this.id,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        deviceId: deviceId ?? this.deviceId,
        userPlatform:
            userPlatform.present ? userPlatform.value : this.userPlatform,
        employeeId: employeeId.present ? employeeId.value : this.employeeId,
        employeeExternalId: employeeExternalId.present
            ? employeeExternalId.value
            : this.employeeExternalId,
        log: log ?? this.log,
      );
  LogsTableData copyWithCompanion(LogsTableCompanion data) {
    return LogsTableData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      userPlatform: data.userPlatform.present
          ? data.userPlatform.value
          : this.userPlatform,
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      employeeExternalId: data.employeeExternalId.present
          ? data.employeeExternalId.value
          : this.employeeExternalId,
      log: data.log.present ? data.log.value : this.log,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('userPlatform: $userPlatform, ')
          ..write('employeeId: $employeeId, ')
          ..write('employeeExternalId: $employeeExternalId, ')
          ..write('log: $log')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, deviceId, userPlatform,
      employeeId, employeeExternalId, log);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogsTableData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.deviceId == this.deviceId &&
          other.userPlatform == this.userPlatform &&
          other.employeeId == this.employeeId &&
          other.employeeExternalId == this.employeeExternalId &&
          other.log == this.log);
}

class LogsTableCompanion extends UpdateCompanion<LogsTableData> {
  final Value<String> id;
  final Value<String?> createdAt;
  final Value<String> deviceId;
  final Value<String?> userPlatform;
  final Value<String?> employeeId;
  final Value<String?> employeeExternalId;
  final Value<String> log;
  final Value<int> rowid;
  const LogsTableCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.userPlatform = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.employeeExternalId = const Value.absent(),
    this.log = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogsTableCompanion.insert({
    required String id,
    this.createdAt = const Value.absent(),
    required String deviceId,
    this.userPlatform = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.employeeExternalId = const Value.absent(),
    required String log,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        deviceId = Value(deviceId),
        log = Value(log);
  static Insertable<LogsTableData> custom({
    Expression<String>? id,
    Expression<String>? createdAt,
    Expression<String>? deviceId,
    Expression<String>? userPlatform,
    Expression<String>? employeeId,
    Expression<String>? employeeExternalId,
    Expression<String>? log,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (deviceId != null) 'device_id': deviceId,
      if (userPlatform != null) 'user_platform': userPlatform,
      if (employeeId != null) 'employee_id': employeeId,
      if (employeeExternalId != null)
        'employee_external_id': employeeExternalId,
      if (log != null) 'log': log,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogsTableCompanion copyWith(
      {Value<String>? id,
      Value<String?>? createdAt,
      Value<String>? deviceId,
      Value<String?>? userPlatform,
      Value<String?>? employeeId,
      Value<String?>? employeeExternalId,
      Value<String>? log,
      Value<int>? rowid}) {
    return LogsTableCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      deviceId: deviceId ?? this.deviceId,
      userPlatform: userPlatform ?? this.userPlatform,
      employeeId: employeeId ?? this.employeeId,
      employeeExternalId: employeeExternalId ?? this.employeeExternalId,
      log: log ?? this.log,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (userPlatform.present) {
      map['user_platform'] = Variable<String>(userPlatform.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (employeeExternalId.present) {
      map['employee_external_id'] = Variable<String>(employeeExternalId.value);
    }
    if (log.present) {
      map['log'] = Variable<String>(log.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogsTableCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('deviceId: $deviceId, ')
          ..write('userPlatform: $userPlatform, ')
          ..write('employeeId: $employeeId, ')
          ..write('employeeExternalId: $employeeExternalId, ')
          ..write('log: $log, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClockingEventUseTableTable extends ClockingEventUseTable
    with TableInfo<$ClockingEventUseTableTable, ClockingEventUseTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClockingEventUseTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _clockingEventUseTypeMeta =
      const VerificationMeta('clockingEventUseType');
  @override
  late final GeneratedColumn<String> clockingEventUseType =
      GeneratedColumn<String>('clocking_event_use_type', aliasedName, false,
          type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [employeeId, description, code, clockingEventUseType];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clocking_event_use_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<ClockingEventUseTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('clocking_event_use_type')) {
      context.handle(
          _clockingEventUseTypeMeta,
          clockingEventUseType.isAcceptableOrUnknown(
              data['clocking_event_use_type']!, _clockingEventUseTypeMeta));
    } else if (isInserting) {
      context.missing(_clockingEventUseTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, clockingEventUseType};
  @override
  ClockingEventUseTableData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClockingEventUseTableData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      clockingEventUseType: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}clocking_event_use_type'])!,
    );
  }

  @override
  $ClockingEventUseTableTable createAlias(String alias) {
    return $ClockingEventUseTableTable(attachedDatabase, alias);
  }
}

class ClockingEventUseTableData extends DataClass
    implements Insertable<ClockingEventUseTableData> {
  final String employeeId;
  final String description;
  final String code;
  final String clockingEventUseType;
  const ClockingEventUseTableData(
      {required this.employeeId,
      required this.description,
      required this.code,
      required this.clockingEventUseType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['description'] = Variable<String>(description);
    map['code'] = Variable<String>(code);
    map['clocking_event_use_type'] = Variable<String>(clockingEventUseType);
    return map;
  }

  ClockingEventUseTableCompanion toCompanion(bool nullToAbsent) {
    return ClockingEventUseTableCompanion(
      employeeId: Value(employeeId),
      description: Value(description),
      code: Value(code),
      clockingEventUseType: Value(clockingEventUseType),
    );
  }

  factory ClockingEventUseTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClockingEventUseTableData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      description: serializer.fromJson<String>(json['description']),
      code: serializer.fromJson<String>(json['code']),
      clockingEventUseType:
          serializer.fromJson<String>(json['clockingEventUseType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'description': serializer.toJson<String>(description),
      'code': serializer.toJson<String>(code),
      'clockingEventUseType': serializer.toJson<String>(clockingEventUseType),
    };
  }

  ClockingEventUseTableData copyWith(
          {String? employeeId,
          String? description,
          String? code,
          String? clockingEventUseType}) =>
      ClockingEventUseTableData(
        employeeId: employeeId ?? this.employeeId,
        description: description ?? this.description,
        code: code ?? this.code,
        clockingEventUseType: clockingEventUseType ?? this.clockingEventUseType,
      );
  ClockingEventUseTableData copyWithCompanion(
      ClockingEventUseTableCompanion data) {
    return ClockingEventUseTableData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      description:
          data.description.present ? data.description.value : this.description,
      code: data.code.present ? data.code.value : this.code,
      clockingEventUseType: data.clockingEventUseType.present
          ? data.clockingEventUseType.value
          : this.clockingEventUseType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClockingEventUseTableData(')
          ..write('employeeId: $employeeId, ')
          ..write('description: $description, ')
          ..write('code: $code, ')
          ..write('clockingEventUseType: $clockingEventUseType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(employeeId, description, code, clockingEventUseType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClockingEventUseTableData &&
          other.employeeId == this.employeeId &&
          other.description == this.description &&
          other.code == this.code &&
          other.clockingEventUseType == this.clockingEventUseType);
}

class ClockingEventUseTableCompanion
    extends UpdateCompanion<ClockingEventUseTableData> {
  final Value<String> employeeId;
  final Value<String> description;
  final Value<String> code;
  final Value<String> clockingEventUseType;
  final Value<int> rowid;
  const ClockingEventUseTableCompanion({
    this.employeeId = const Value.absent(),
    this.description = const Value.absent(),
    this.code = const Value.absent(),
    this.clockingEventUseType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClockingEventUseTableCompanion.insert({
    required String employeeId,
    required String description,
    required String code,
    required String clockingEventUseType,
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        description = Value(description),
        code = Value(code),
        clockingEventUseType = Value(clockingEventUseType);
  static Insertable<ClockingEventUseTableData> custom({
    Expression<String>? employeeId,
    Expression<String>? description,
    Expression<String>? code,
    Expression<String>? clockingEventUseType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (description != null) 'description': description,
      if (code != null) 'code': code,
      if (clockingEventUseType != null)
        'clocking_event_use_type': clockingEventUseType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClockingEventUseTableCompanion copyWith(
      {Value<String>? employeeId,
      Value<String>? description,
      Value<String>? code,
      Value<String>? clockingEventUseType,
      Value<int>? rowid}) {
    return ClockingEventUseTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      description: description ?? this.description,
      code: code ?? this.code,
      clockingEventUseType: clockingEventUseType ?? this.clockingEventUseType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (clockingEventUseType.present) {
      map['clocking_event_use_type'] =
          Variable<String>(clockingEventUseType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClockingEventUseTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('description: $description, ')
          ..write('code: $code, ')
          ..write('clockingEventUseType: $clockingEventUseType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReminderTableTable extends ReminderTable
    with TableInfo<$ReminderTableTable, ReminderTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _employeeIdMeta =
      const VerificationMeta('employeeId');
  @override
  late final GeneratedColumn<String> employeeId = GeneratedColumn<String>(
      'employee_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES employee_table (id)'));
  static const VerificationMeta _periodMeta = const VerificationMeta('period');
  @override
  late final GeneratedColumn<DateTime> period = GeneratedColumn<DateTime>(
      'period', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _enabledMeta =
      const VerificationMeta('enabled');
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
      'enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _reminderMeta =
      const VerificationMeta('reminder');
  @override
  late final GeneratedColumn<String> reminder = GeneratedColumn<String>(
      'reminder', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [employeeId, period, enabled, reminder];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_table';
  @override
  VerificationContext validateIntegrity(Insertable<ReminderTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('employee_id')) {
      context.handle(
          _employeeIdMeta,
          employeeId.isAcceptableOrUnknown(
              data['employee_id']!, _employeeIdMeta));
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('period')) {
      context.handle(_periodMeta,
          period.isAcceptableOrUnknown(data['period']!, _periodMeta));
    } else if (isInserting) {
      context.missing(_periodMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(_enabledMeta,
          enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta));
    }
    if (data.containsKey('reminder')) {
      context.handle(_reminderMeta,
          reminder.isAcceptableOrUnknown(data['reminder']!, _reminderMeta));
    } else if (isInserting) {
      context.missing(_reminderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {employeeId, reminder};
  @override
  ReminderTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderTableData(
      employeeId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}employee_id'])!,
      period: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}period'])!,
      enabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}enabled'])!,
      reminder: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reminder'])!,
    );
  }

  @override
  $ReminderTableTable createAlias(String alias) {
    return $ReminderTableTable(attachedDatabase, alias);
  }
}

class ReminderTableData extends DataClass
    implements Insertable<ReminderTableData> {
  final String employeeId;
  final DateTime period;
  final bool enabled;
  final String reminder;
  const ReminderTableData(
      {required this.employeeId,
      required this.period,
      required this.enabled,
      required this.reminder});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['employee_id'] = Variable<String>(employeeId);
    map['period'] = Variable<DateTime>(period);
    map['enabled'] = Variable<bool>(enabled);
    map['reminder'] = Variable<String>(reminder);
    return map;
  }

  ReminderTableCompanion toCompanion(bool nullToAbsent) {
    return ReminderTableCompanion(
      employeeId: Value(employeeId),
      period: Value(period),
      enabled: Value(enabled),
      reminder: Value(reminder),
    );
  }

  factory ReminderTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderTableData(
      employeeId: serializer.fromJson<String>(json['employeeId']),
      period: serializer.fromJson<DateTime>(json['period']),
      enabled: serializer.fromJson<bool>(json['enabled']),
      reminder: serializer.fromJson<String>(json['reminder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'employeeId': serializer.toJson<String>(employeeId),
      'period': serializer.toJson<DateTime>(period),
      'enabled': serializer.toJson<bool>(enabled),
      'reminder': serializer.toJson<String>(reminder),
    };
  }

  ReminderTableData copyWith(
          {String? employeeId,
          DateTime? period,
          bool? enabled,
          String? reminder}) =>
      ReminderTableData(
        employeeId: employeeId ?? this.employeeId,
        period: period ?? this.period,
        enabled: enabled ?? this.enabled,
        reminder: reminder ?? this.reminder,
      );
  ReminderTableData copyWithCompanion(ReminderTableCompanion data) {
    return ReminderTableData(
      employeeId:
          data.employeeId.present ? data.employeeId.value : this.employeeId,
      period: data.period.present ? data.period.value : this.period,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      reminder: data.reminder.present ? data.reminder.value : this.reminder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderTableData(')
          ..write('employeeId: $employeeId, ')
          ..write('period: $period, ')
          ..write('enabled: $enabled, ')
          ..write('reminder: $reminder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(employeeId, period, enabled, reminder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderTableData &&
          other.employeeId == this.employeeId &&
          other.period == this.period &&
          other.enabled == this.enabled &&
          other.reminder == this.reminder);
}

class ReminderTableCompanion extends UpdateCompanion<ReminderTableData> {
  final Value<String> employeeId;
  final Value<DateTime> period;
  final Value<bool> enabled;
  final Value<String> reminder;
  final Value<int> rowid;
  const ReminderTableCompanion({
    this.employeeId = const Value.absent(),
    this.period = const Value.absent(),
    this.enabled = const Value.absent(),
    this.reminder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReminderTableCompanion.insert({
    required String employeeId,
    required DateTime period,
    this.enabled = const Value.absent(),
    required String reminder,
    this.rowid = const Value.absent(),
  })  : employeeId = Value(employeeId),
        period = Value(period),
        reminder = Value(reminder);
  static Insertable<ReminderTableData> custom({
    Expression<String>? employeeId,
    Expression<DateTime>? period,
    Expression<bool>? enabled,
    Expression<String>? reminder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (employeeId != null) 'employee_id': employeeId,
      if (period != null) 'period': period,
      if (enabled != null) 'enabled': enabled,
      if (reminder != null) 'reminder': reminder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReminderTableCompanion copyWith(
      {Value<String>? employeeId,
      Value<DateTime>? period,
      Value<bool>? enabled,
      Value<String>? reminder,
      Value<int>? rowid}) {
    return ReminderTableCompanion(
      employeeId: employeeId ?? this.employeeId,
      period: period ?? this.period,
      enabled: enabled ?? this.enabled,
      reminder: reminder ?? this.reminder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (employeeId.present) {
      map['employee_id'] = Variable<String>(employeeId.value);
    }
    if (period.present) {
      map['period'] = Variable<DateTime>(period.value);
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (reminder.present) {
      map['reminder'] = Variable<String>(reminder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderTableCompanion(')
          ..write('employeeId: $employeeId, ')
          ..write('period: $period, ')
          ..write('enabled: $enabled, ')
          ..write('reminder: $reminder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PrivacyPolicyTableTable extends PrivacyPolicyTable
    with TableInfo<$PrivacyPolicyTableTable, PrivacyPolicyTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PrivacyPolicyTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateTimeCreatedMeta =
      const VerificationMeta('dateTimeCreated');
  @override
  late final GeneratedColumn<DateTime> dateTimeCreated =
      GeneratedColumn<DateTime>('date_time_created', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _dateTimeEventReadMeta =
      const VerificationMeta('dateTimeEventRead');
  @override
  late final GeneratedColumn<DateTime> dateTimeEventRead =
      GeneratedColumn<DateTime>('date_time_event_read', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
      'version', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _urlVersionMeta =
      const VerificationMeta('urlVersion');
  @override
  late final GeneratedColumn<String> urlVersion = GeneratedColumn<String>(
      'url_version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [dateTimeCreated, dateTimeEventRead, version, urlVersion];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'privacy_policy_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<PrivacyPolicyTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date_time_created')) {
      context.handle(
          _dateTimeCreatedMeta,
          dateTimeCreated.isAcceptableOrUnknown(
              data['date_time_created']!, _dateTimeCreatedMeta));
    }
    if (data.containsKey('date_time_event_read')) {
      context.handle(
          _dateTimeEventReadMeta,
          dateTimeEventRead.isAcceptableOrUnknown(
              data['date_time_event_read']!, _dateTimeEventReadMeta));
    }
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    }
    if (data.containsKey('url_version')) {
      context.handle(
          _urlVersionMeta,
          urlVersion.isAcceptableOrUnknown(
              data['url_version']!, _urlVersionMeta));
    } else if (isInserting) {
      context.missing(_urlVersionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {version};
  @override
  PrivacyPolicyTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PrivacyPolicyTableData(
      dateTimeCreated: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}date_time_created']),
      dateTimeEventRead: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}date_time_event_read']),
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}version'])!,
      urlVersion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url_version'])!,
    );
  }

  @override
  $PrivacyPolicyTableTable createAlias(String alias) {
    return $PrivacyPolicyTableTable(attachedDatabase, alias);
  }
}

class PrivacyPolicyTableData extends DataClass
    implements Insertable<PrivacyPolicyTableData> {
  final DateTime? dateTimeCreated;
  final DateTime? dateTimeEventRead;
  final int version;
  final String urlVersion;
  const PrivacyPolicyTableData(
      {this.dateTimeCreated,
      this.dateTimeEventRead,
      required this.version,
      required this.urlVersion});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || dateTimeCreated != null) {
      map['date_time_created'] = Variable<DateTime>(dateTimeCreated);
    }
    if (!nullToAbsent || dateTimeEventRead != null) {
      map['date_time_event_read'] = Variable<DateTime>(dateTimeEventRead);
    }
    map['version'] = Variable<int>(version);
    map['url_version'] = Variable<String>(urlVersion);
    return map;
  }

  PrivacyPolicyTableCompanion toCompanion(bool nullToAbsent) {
    return PrivacyPolicyTableCompanion(
      dateTimeCreated: dateTimeCreated == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTimeCreated),
      dateTimeEventRead: dateTimeEventRead == null && nullToAbsent
          ? const Value.absent()
          : Value(dateTimeEventRead),
      version: Value(version),
      urlVersion: Value(urlVersion),
    );
  }

  factory PrivacyPolicyTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PrivacyPolicyTableData(
      dateTimeCreated: serializer.fromJson<DateTime?>(json['dateTimeCreated']),
      dateTimeEventRead:
          serializer.fromJson<DateTime?>(json['dateTimeEventRead']),
      version: serializer.fromJson<int>(json['version']),
      urlVersion: serializer.fromJson<String>(json['urlVersion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dateTimeCreated': serializer.toJson<DateTime?>(dateTimeCreated),
      'dateTimeEventRead': serializer.toJson<DateTime?>(dateTimeEventRead),
      'version': serializer.toJson<int>(version),
      'urlVersion': serializer.toJson<String>(urlVersion),
    };
  }

  PrivacyPolicyTableData copyWith(
          {Value<DateTime?> dateTimeCreated = const Value.absent(),
          Value<DateTime?> dateTimeEventRead = const Value.absent(),
          int? version,
          String? urlVersion}) =>
      PrivacyPolicyTableData(
        dateTimeCreated: dateTimeCreated.present
            ? dateTimeCreated.value
            : this.dateTimeCreated,
        dateTimeEventRead: dateTimeEventRead.present
            ? dateTimeEventRead.value
            : this.dateTimeEventRead,
        version: version ?? this.version,
        urlVersion: urlVersion ?? this.urlVersion,
      );
  PrivacyPolicyTableData copyWithCompanion(PrivacyPolicyTableCompanion data) {
    return PrivacyPolicyTableData(
      dateTimeCreated: data.dateTimeCreated.present
          ? data.dateTimeCreated.value
          : this.dateTimeCreated,
      dateTimeEventRead: data.dateTimeEventRead.present
          ? data.dateTimeEventRead.value
          : this.dateTimeEventRead,
      version: data.version.present ? data.version.value : this.version,
      urlVersion:
          data.urlVersion.present ? data.urlVersion.value : this.urlVersion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PrivacyPolicyTableData(')
          ..write('dateTimeCreated: $dateTimeCreated, ')
          ..write('dateTimeEventRead: $dateTimeEventRead, ')
          ..write('version: $version, ')
          ..write('urlVersion: $urlVersion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(dateTimeCreated, dateTimeEventRead, version, urlVersion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PrivacyPolicyTableData &&
          other.dateTimeCreated == this.dateTimeCreated &&
          other.dateTimeEventRead == this.dateTimeEventRead &&
          other.version == this.version &&
          other.urlVersion == this.urlVersion);
}

class PrivacyPolicyTableCompanion
    extends UpdateCompanion<PrivacyPolicyTableData> {
  final Value<DateTime?> dateTimeCreated;
  final Value<DateTime?> dateTimeEventRead;
  final Value<int> version;
  final Value<String> urlVersion;
  const PrivacyPolicyTableCompanion({
    this.dateTimeCreated = const Value.absent(),
    this.dateTimeEventRead = const Value.absent(),
    this.version = const Value.absent(),
    this.urlVersion = const Value.absent(),
  });
  PrivacyPolicyTableCompanion.insert({
    this.dateTimeCreated = const Value.absent(),
    this.dateTimeEventRead = const Value.absent(),
    this.version = const Value.absent(),
    required String urlVersion,
  }) : urlVersion = Value(urlVersion);
  static Insertable<PrivacyPolicyTableData> custom({
    Expression<DateTime>? dateTimeCreated,
    Expression<DateTime>? dateTimeEventRead,
    Expression<int>? version,
    Expression<String>? urlVersion,
  }) {
    return RawValuesInsertable({
      if (dateTimeCreated != null) 'date_time_created': dateTimeCreated,
      if (dateTimeEventRead != null) 'date_time_event_read': dateTimeEventRead,
      if (version != null) 'version': version,
      if (urlVersion != null) 'url_version': urlVersion,
    });
  }

  PrivacyPolicyTableCompanion copyWith(
      {Value<DateTime?>? dateTimeCreated,
      Value<DateTime?>? dateTimeEventRead,
      Value<int>? version,
      Value<String>? urlVersion}) {
    return PrivacyPolicyTableCompanion(
      dateTimeCreated: dateTimeCreated ?? this.dateTimeCreated,
      dateTimeEventRead: dateTimeEventRead ?? this.dateTimeEventRead,
      version: version ?? this.version,
      urlVersion: urlVersion ?? this.urlVersion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dateTimeCreated.present) {
      map['date_time_created'] = Variable<DateTime>(dateTimeCreated.value);
    }
    if (dateTimeEventRead.present) {
      map['date_time_event_read'] = Variable<DateTime>(dateTimeEventRead.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (urlVersion.present) {
      map['url_version'] = Variable<String>(urlVersion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PrivacyPolicyTableCompanion(')
          ..write('dateTimeCreated: $dateTimeCreated, ')
          ..write('dateTimeEventRead: $dateTimeEventRead, ')
          ..write('version: $version, ')
          ..write('urlVersion: $urlVersion')
          ..write(')'))
        .toString();
  }
}

abstract class _$CollectorDatabase extends GeneratedDatabase {
  _$CollectorDatabase(QueryExecutor e) : super(e);
  $CollectorDatabaseManager get managers => $CollectorDatabaseManager(this);
  late final $CompanyTableTable companyTable = $CompanyTableTable(this);
  late final $EmployeeTableTable employeeTable = $EmployeeTableTable(this);
  late final $ConfigurationTableTable configurationTable =
      $ConfigurationTableTable(this);
  late final $OvernightTableTable overnightTable = $OvernightTableTable(this);
  late final $JourneyTableTable journeyTable = $JourneyTableTable(this);
  late final $ClockingEventTableTable clockingEventTable =
      $ClockingEventTableTable(this);
  late final $FenceTableTable fenceTable = $FenceTableTable(this);
  late final $PerimeterTableTable perimeterTable = $PerimeterTableTable(this);
  late final $EmployeeFenceTableTable employeeFenceTable =
      $EmployeeFenceTableTable(this);
  late final $FencePerimeterTableTable fencePerimeterTable =
      $FencePerimeterTableTable(this);
  late final $DeviceTableTable deviceTable = $DeviceTableTable(this);
  late final $ActivationTableTable activationTable =
      $ActivationTableTable(this);
  late final $ApplicationTableTable applicationTable =
      $ApplicationTableTable(this);
  late final $DeviceConfigurationTableTable deviceConfigurationTable =
      $DeviceConfigurationTableTable(this);
  late final $GlobalConfigurationTableTable globalConfigurationTable =
      $GlobalConfigurationTableTable(this);
  late final $ManagerTableTable managerTable = $ManagerTableTable(this);
  late final $PlatformUsersTableTable platformUsersTable =
      $PlatformUsersTableTable(this);
  late final $EmployeeManagersTableTable employeeManagersTable =
      $EmployeeManagersTableTable(this);
  late final $EmployeePlatformUsersTableTable employeePlatformUsersTable =
      $EmployeePlatformUsersTableTable(this);
  late final $ManagersPlatformUsersTableTable managersPlatformUsersTable =
      $ManagersPlatformUsersTableTable(this);
  late final $LogsTableTable logsTable = $LogsTableTable(this);
  late final $ClockingEventUseTableTable clockingEventUseTable =
      $ClockingEventUseTableTable(this);
  late final $ReminderTableTable reminderTable = $ReminderTableTable(this);
  late final $PrivacyPolicyTableTable privacyPolicyTable =
      $PrivacyPolicyTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        companyTable,
        employeeTable,
        configurationTable,
        overnightTable,
        journeyTable,
        clockingEventTable,
        fenceTable,
        perimeterTable,
        employeeFenceTable,
        fencePerimeterTable,
        deviceTable,
        activationTable,
        applicationTable,
        deviceConfigurationTable,
        globalConfigurationTable,
        managerTable,
        platformUsersTable,
        employeeManagersTable,
        employeePlatformUsersTable,
        managersPlatformUsersTable,
        logsTable,
        clockingEventUseTable,
        reminderTable,
        privacyPolicyTable
      ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CompanyTableTableCreateCompanionBuilder = CompanyTableCompanion
    Function({
  required String id,
  required String identifier,
  required String name,
  required String timeZone,
  Value<String?> arpId,
  Value<String?> caepf,
  Value<String?> cnoNumber,
  Value<int> rowid,
});
typedef $$CompanyTableTableUpdateCompanionBuilder = CompanyTableCompanion
    Function({
  Value<String> id,
  Value<String> identifier,
  Value<String> name,
  Value<String> timeZone,
  Value<String?> arpId,
  Value<String?> caepf,
  Value<String?> cnoNumber,
  Value<int> rowid,
});

final class $$CompanyTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $CompanyTableTable, CompanyTableData> {
  $$CompanyTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EmployeeTableTable, List<EmployeeTableData>>
      _employeeTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.employeeTable,
              aliasName: $_aliasNameGenerator(
                  db.companyTable.id, db.employeeTable.companyId));

  $$EmployeeTableTableProcessedTableManager get employeeTableRefs {
    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.companyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_employeeTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CompanyTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $CompanyTableTable> {
  $$CompanyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identifier => $composableBuilder(
      column: $table.identifier, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeZone => $composableBuilder(
      column: $table.timeZone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arpId => $composableBuilder(
      column: $table.arpId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get caepf => $composableBuilder(
      column: $table.caepf, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cnoNumber => $composableBuilder(
      column: $table.cnoNumber, builder: (column) => ColumnFilters(column));

  Expression<bool> employeeTableRefs(
      Expression<bool> Function($$EmployeeTableTableFilterComposer f) f) {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.companyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CompanyTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $CompanyTableTable> {
  $$CompanyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identifier => $composableBuilder(
      column: $table.identifier, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeZone => $composableBuilder(
      column: $table.timeZone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arpId => $composableBuilder(
      column: $table.arpId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get caepf => $composableBuilder(
      column: $table.caepf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cnoNumber => $composableBuilder(
      column: $table.cnoNumber, builder: (column) => ColumnOrderings(column));
}

class $$CompanyTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $CompanyTableTable> {
  $$CompanyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get identifier => $composableBuilder(
      column: $table.identifier, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumn<String> get arpId =>
      $composableBuilder(column: $table.arpId, builder: (column) => column);

  GeneratedColumn<String> get caepf =>
      $composableBuilder(column: $table.caepf, builder: (column) => column);

  GeneratedColumn<String> get cnoNumber =>
      $composableBuilder(column: $table.cnoNumber, builder: (column) => column);

  Expression<T> employeeTableRefs<T extends Object>(
      Expression<T> Function($$EmployeeTableTableAnnotationComposer a) f) {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.companyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$CompanyTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $CompanyTableTable,
    CompanyTableData,
    $$CompanyTableTableFilterComposer,
    $$CompanyTableTableOrderingComposer,
    $$CompanyTableTableAnnotationComposer,
    $$CompanyTableTableCreateCompanionBuilder,
    $$CompanyTableTableUpdateCompanionBuilder,
    (CompanyTableData, $$CompanyTableTableReferences),
    CompanyTableData,
    PrefetchHooks Function({bool employeeTableRefs})> {
  $$CompanyTableTableTableManager(
      _$CollectorDatabase db, $CompanyTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompanyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompanyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompanyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> identifier = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> timeZone = const Value.absent(),
            Value<String?> arpId = const Value.absent(),
            Value<String?> caepf = const Value.absent(),
            Value<String?> cnoNumber = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyTableCompanion(
            id: id,
            identifier: identifier,
            name: name,
            timeZone: timeZone,
            arpId: arpId,
            caepf: caepf,
            cnoNumber: cnoNumber,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String identifier,
            required String name,
            required String timeZone,
            Value<String?> arpId = const Value.absent(),
            Value<String?> caepf = const Value.absent(),
            Value<String?> cnoNumber = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CompanyTableCompanion.insert(
            id: id,
            identifier: identifier,
            name: name,
            timeZone: timeZone,
            arpId: arpId,
            caepf: caepf,
            cnoNumber: cnoNumber,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$CompanyTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (employeeTableRefs) db.employeeTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (employeeTableRefs)
                    await $_getPrefetchedData<CompanyTableData,
                            $CompanyTableTable, EmployeeTableData>(
                        currentTable: table,
                        referencedTable: $$CompanyTableTableReferences
                            ._employeeTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$CompanyTableTableReferences(db, table, p0)
                                .employeeTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.companyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$CompanyTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $CompanyTableTable,
    CompanyTableData,
    $$CompanyTableTableFilterComposer,
    $$CompanyTableTableOrderingComposer,
    $$CompanyTableTableAnnotationComposer,
    $$CompanyTableTableCreateCompanionBuilder,
    $$CompanyTableTableUpdateCompanionBuilder,
    (CompanyTableData, $$CompanyTableTableReferences),
    CompanyTableData,
    PrefetchHooks Function({bool employeeTableRefs})>;
typedef $$EmployeeTableTableCreateCompanionBuilder = EmployeeTableCompanion
    Function({
  required String id,
  required String name,
  Value<String?> pis,
  required String cpfNumber,
  Value<String?> mail,
  required String companyId,
  Value<String?> nfcCode,
  required String employeeType,
  Value<String?> registrationNumber,
  Value<String?> arpId,
  Value<bool?> enable,
  Value<String?> faceRegistered,
  Value<String?> employeeCode,
  Value<int> rowid,
});
typedef $$EmployeeTableTableUpdateCompanionBuilder = EmployeeTableCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> pis,
  Value<String> cpfNumber,
  Value<String?> mail,
  Value<String> companyId,
  Value<String?> nfcCode,
  Value<String> employeeType,
  Value<String?> registrationNumber,
  Value<String?> arpId,
  Value<bool?> enable,
  Value<String?> faceRegistered,
  Value<String?> employeeCode,
  Value<int> rowid,
});

final class $$EmployeeTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $EmployeeTableTable, EmployeeTableData> {
  $$EmployeeTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $CompanyTableTable _companyIdTable(_$CollectorDatabase db) =>
      db.companyTable.createAlias(
          $_aliasNameGenerator(db.employeeTable.companyId, db.companyTable.id));

  $$CompanyTableTableProcessedTableManager get companyId {
    final $_column = $_itemColumn<String>('company_id')!;

    final manager = $$CompanyTableTableTableManager($_db, $_db.companyTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ConfigurationTableTable,
      List<ConfigurationTableData>> _configurationTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.configurationTable,
          aliasName: $_aliasNameGenerator(
              db.employeeTable.id, db.configurationTable.employeeId));

  $$ConfigurationTableTableProcessedTableManager get configurationTableRefs {
    final manager = $$ConfigurationTableTableTableManager(
            $_db, $_db.configurationTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_configurationTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$OvernightTableTable, List<OvernightTableData>>
      _overnightTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.overnightTable,
              aliasName: $_aliasNameGenerator(
                  db.employeeTable.id, db.overnightTable.employee));

  $$OvernightTableTableProcessedTableManager get overnightTableRefs {
    final manager = $$OvernightTableTableTableManager($_db, $_db.overnightTable)
        .filter((f) => f.employee.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_overnightTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$JourneyTableTable, List<JourneyTableData>>
      _journeyTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.journeyTable,
              aliasName: $_aliasNameGenerator(
                  db.employeeTable.id, db.journeyTable.employeeId));

  $$JourneyTableTableProcessedTableManager get journeyTableRefs {
    final manager = $$JourneyTableTableTableManager($_db, $_db.journeyTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journeyTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EmployeeFenceTableTable,
      List<EmployeeFenceTableData>> _employeeFenceTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.employeeFenceTable,
          aliasName: $_aliasNameGenerator(
              db.employeeTable.id, db.employeeFenceTable.employeeId));

  $$EmployeeFenceTableTableProcessedTableManager get employeeFenceTableRefs {
    final manager = $$EmployeeFenceTableTableTableManager(
            $_db, $_db.employeeFenceTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_employeeFenceTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ActivationTableTable, List<ActivationTableData>>
      _activationTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.activationTable,
              aliasName: $_aliasNameGenerator(
                  db.employeeTable.id, db.activationTable.employeeId));

  $$ActivationTableTableProcessedTableManager get activationTableRefs {
    final manager = $$ActivationTableTableTableManager(
            $_db, $_db.activationTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_activationTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EmployeeManagersTableTable,
      List<EmployeeManagersTableData>> _employeeManagersTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.employeeManagersTable,
          aliasName: $_aliasNameGenerator(
              db.employeeTable.id, db.employeeManagersTable.employeeId));

  $$EmployeeManagersTableTableProcessedTableManager
      get employeeManagersTableRefs {
    final manager = $$EmployeeManagersTableTableTableManager(
            $_db, $_db.employeeManagersTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_employeeManagersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EmployeePlatformUsersTableTable,
          List<EmployeePlatformUsersTableData>>
      _employeePlatformUsersTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.employeePlatformUsersTable,
              aliasName: $_aliasNameGenerator(db.employeeTable.id,
                  db.employeePlatformUsersTable.employeeId));

  $$EmployeePlatformUsersTableTableProcessedTableManager
      get employeePlatformUsersTableRefs {
    final manager = $$EmployeePlatformUsersTableTableTableManager(
            $_db, $_db.employeePlatformUsersTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_employeePlatformUsersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ClockingEventUseTableTable,
      List<ClockingEventUseTableData>> _clockingEventUseTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.clockingEventUseTable,
          aliasName: $_aliasNameGenerator(
              db.employeeTable.id, db.clockingEventUseTable.employeeId));

  $$ClockingEventUseTableTableProcessedTableManager
      get clockingEventUseTableRefs {
    final manager = $$ClockingEventUseTableTableTableManager(
            $_db, $_db.clockingEventUseTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_clockingEventUseTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ReminderTableTable, List<ReminderTableData>>
      _reminderTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.reminderTable,
              aliasName: $_aliasNameGenerator(
                  db.employeeTable.id, db.reminderTable.employeeId));

  $$ReminderTableTableProcessedTableManager get reminderTableRefs {
    final manager = $$ReminderTableTableTableManager($_db, $_db.reminderTable)
        .filter((f) => f.employeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_reminderTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EmployeeTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $EmployeeTableTable> {
  $$EmployeeTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pis => $composableBuilder(
      column: $table.pis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpfNumber => $composableBuilder(
      column: $table.cpfNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mail => $composableBuilder(
      column: $table.mail, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nfcCode => $composableBuilder(
      column: $table.nfcCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeType => $composableBuilder(
      column: $table.employeeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get arpId => $composableBuilder(
      column: $table.arpId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enable => $composableBuilder(
      column: $table.enable, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get faceRegistered => $composableBuilder(
      column: $table.faceRegistered,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeCode => $composableBuilder(
      column: $table.employeeCode, builder: (column) => ColumnFilters(column));

  $$CompanyTableTableFilterComposer get companyId {
    final $$CompanyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyTableTableFilterComposer(
              $db: $db,
              $table: $db.companyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> configurationTableRefs(
      Expression<bool> Function($$ConfigurationTableTableFilterComposer f) f) {
    final $$ConfigurationTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.configurationTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ConfigurationTableTableFilterComposer(
              $db: $db,
              $table: $db.configurationTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> overnightTableRefs(
      Expression<bool> Function($$OvernightTableTableFilterComposer f) f) {
    final $$OvernightTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.overnightTable,
        getReferencedColumn: (t) => t.employee,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OvernightTableTableFilterComposer(
              $db: $db,
              $table: $db.overnightTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> journeyTableRefs(
      Expression<bool> Function($$JourneyTableTableFilterComposer f) f) {
    final $$JourneyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableFilterComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> employeeFenceTableRefs(
      Expression<bool> Function($$EmployeeFenceTableTableFilterComposer f) f) {
    final $$EmployeeFenceTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.employeeFenceTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeFenceTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeFenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> activationTableRefs(
      Expression<bool> Function($$ActivationTableTableFilterComposer f) f) {
    final $$ActivationTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.activationTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivationTableTableFilterComposer(
              $db: $db,
              $table: $db.activationTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> employeeManagersTableRefs(
      Expression<bool> Function($$EmployeeManagersTableTableFilterComposer f)
          f) {
    final $$EmployeeManagersTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeeManagersTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeeManagersTableTableFilterComposer(
                  $db: $db,
                  $table: $db.employeeManagersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> employeePlatformUsersTableRefs(
      Expression<bool> Function(
              $$EmployeePlatformUsersTableTableFilterComposer f)
          f) {
    final $$EmployeePlatformUsersTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeePlatformUsersTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeePlatformUsersTableTableFilterComposer(
                  $db: $db,
                  $table: $db.employeePlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> clockingEventUseTableRefs(
      Expression<bool> Function($$ClockingEventUseTableTableFilterComposer f)
          f) {
    final $$ClockingEventUseTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.clockingEventUseTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ClockingEventUseTableTableFilterComposer(
                  $db: $db,
                  $table: $db.clockingEventUseTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> reminderTableRefs(
      Expression<bool> Function($$ReminderTableTableFilterComposer f) f) {
    final $$ReminderTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reminderTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReminderTableTableFilterComposer(
              $db: $db,
              $table: $db.reminderTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EmployeeTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $EmployeeTableTable> {
  $$EmployeeTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pis => $composableBuilder(
      column: $table.pis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpfNumber => $composableBuilder(
      column: $table.cpfNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mail => $composableBuilder(
      column: $table.mail, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nfcCode => $composableBuilder(
      column: $table.nfcCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeType => $composableBuilder(
      column: $table.employeeType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get arpId => $composableBuilder(
      column: $table.arpId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enable => $composableBuilder(
      column: $table.enable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get faceRegistered => $composableBuilder(
      column: $table.faceRegistered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeCode => $composableBuilder(
      column: $table.employeeCode,
      builder: (column) => ColumnOrderings(column));

  $$CompanyTableTableOrderingComposer get companyId {
    final $$CompanyTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyTableTableOrderingComposer(
              $db: $db,
              $table: $db.companyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $EmployeeTableTable> {
  $$EmployeeTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get pis =>
      $composableBuilder(column: $table.pis, builder: (column) => column);

  GeneratedColumn<String> get cpfNumber =>
      $composableBuilder(column: $table.cpfNumber, builder: (column) => column);

  GeneratedColumn<String> get mail =>
      $composableBuilder(column: $table.mail, builder: (column) => column);

  GeneratedColumn<String> get nfcCode =>
      $composableBuilder(column: $table.nfcCode, builder: (column) => column);

  GeneratedColumn<String> get employeeType => $composableBuilder(
      column: $table.employeeType, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
      column: $table.registrationNumber, builder: (column) => column);

  GeneratedColumn<String> get arpId =>
      $composableBuilder(column: $table.arpId, builder: (column) => column);

  GeneratedColumn<bool> get enable =>
      $composableBuilder(column: $table.enable, builder: (column) => column);

  GeneratedColumn<String> get faceRegistered => $composableBuilder(
      column: $table.faceRegistered, builder: (column) => column);

  GeneratedColumn<String> get employeeCode => $composableBuilder(
      column: $table.employeeCode, builder: (column) => column);

  $$CompanyTableTableAnnotationComposer get companyId {
    final $$CompanyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.companyId,
        referencedTable: $db.companyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$CompanyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.companyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> configurationTableRefs<T extends Object>(
      Expression<T> Function($$ConfigurationTableTableAnnotationComposer a) f) {
    final $$ConfigurationTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.configurationTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ConfigurationTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.configurationTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> overnightTableRefs<T extends Object>(
      Expression<T> Function($$OvernightTableTableAnnotationComposer a) f) {
    final $$OvernightTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.overnightTable,
        getReferencedColumn: (t) => t.employee,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OvernightTableTableAnnotationComposer(
              $db: $db,
              $table: $db.overnightTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> journeyTableRefs<T extends Object>(
      Expression<T> Function($$JourneyTableTableAnnotationComposer a) f) {
    final $$JourneyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> employeeFenceTableRefs<T extends Object>(
      Expression<T> Function($$EmployeeFenceTableTableAnnotationComposer a) f) {
    final $$EmployeeFenceTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeeFenceTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeeFenceTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.employeeFenceTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> activationTableRefs<T extends Object>(
      Expression<T> Function($$ActivationTableTableAnnotationComposer a) f) {
    final $$ActivationTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.activationTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ActivationTableTableAnnotationComposer(
              $db: $db,
              $table: $db.activationTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> employeeManagersTableRefs<T extends Object>(
      Expression<T> Function($$EmployeeManagersTableTableAnnotationComposer a)
          f) {
    final $$EmployeeManagersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeeManagersTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeeManagersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.employeeManagersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> employeePlatformUsersTableRefs<T extends Object>(
      Expression<T> Function(
              $$EmployeePlatformUsersTableTableAnnotationComposer a)
          f) {
    final $$EmployeePlatformUsersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeePlatformUsersTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeePlatformUsersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.employeePlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> clockingEventUseTableRefs<T extends Object>(
      Expression<T> Function($$ClockingEventUseTableTableAnnotationComposer a)
          f) {
    final $$ClockingEventUseTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.clockingEventUseTable,
            getReferencedColumn: (t) => t.employeeId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ClockingEventUseTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.clockingEventUseTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> reminderTableRefs<T extends Object>(
      Expression<T> Function($$ReminderTableTableAnnotationComposer a) f) {
    final $$ReminderTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.reminderTable,
        getReferencedColumn: (t) => t.employeeId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ReminderTableTableAnnotationComposer(
              $db: $db,
              $table: $db.reminderTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EmployeeTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $EmployeeTableTable,
    EmployeeTableData,
    $$EmployeeTableTableFilterComposer,
    $$EmployeeTableTableOrderingComposer,
    $$EmployeeTableTableAnnotationComposer,
    $$EmployeeTableTableCreateCompanionBuilder,
    $$EmployeeTableTableUpdateCompanionBuilder,
    (EmployeeTableData, $$EmployeeTableTableReferences),
    EmployeeTableData,
    PrefetchHooks Function(
        {bool companyId,
        bool configurationTableRefs,
        bool overnightTableRefs,
        bool journeyTableRefs,
        bool employeeFenceTableRefs,
        bool activationTableRefs,
        bool employeeManagersTableRefs,
        bool employeePlatformUsersTableRefs,
        bool clockingEventUseTableRefs,
        bool reminderTableRefs})> {
  $$EmployeeTableTableTableManager(
      _$CollectorDatabase db, $EmployeeTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeeTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeeTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeeTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> pis = const Value.absent(),
            Value<String> cpfNumber = const Value.absent(),
            Value<String?> mail = const Value.absent(),
            Value<String> companyId = const Value.absent(),
            Value<String?> nfcCode = const Value.absent(),
            Value<String> employeeType = const Value.absent(),
            Value<String?> registrationNumber = const Value.absent(),
            Value<String?> arpId = const Value.absent(),
            Value<bool?> enable = const Value.absent(),
            Value<String?> faceRegistered = const Value.absent(),
            Value<String?> employeeCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeeTableCompanion(
            id: id,
            name: name,
            pis: pis,
            cpfNumber: cpfNumber,
            mail: mail,
            companyId: companyId,
            nfcCode: nfcCode,
            employeeType: employeeType,
            registrationNumber: registrationNumber,
            arpId: arpId,
            enable: enable,
            faceRegistered: faceRegistered,
            employeeCode: employeeCode,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> pis = const Value.absent(),
            required String cpfNumber,
            Value<String?> mail = const Value.absent(),
            required String companyId,
            Value<String?> nfcCode = const Value.absent(),
            required String employeeType,
            Value<String?> registrationNumber = const Value.absent(),
            Value<String?> arpId = const Value.absent(),
            Value<bool?> enable = const Value.absent(),
            Value<String?> faceRegistered = const Value.absent(),
            Value<String?> employeeCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeeTableCompanion.insert(
            id: id,
            name: name,
            pis: pis,
            cpfNumber: cpfNumber,
            mail: mail,
            companyId: companyId,
            nfcCode: nfcCode,
            employeeType: employeeType,
            registrationNumber: registrationNumber,
            arpId: arpId,
            enable: enable,
            faceRegistered: faceRegistered,
            employeeCode: employeeCode,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EmployeeTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {companyId = false,
              configurationTableRefs = false,
              overnightTableRefs = false,
              journeyTableRefs = false,
              employeeFenceTableRefs = false,
              activationTableRefs = false,
              employeeManagersTableRefs = false,
              employeePlatformUsersTableRefs = false,
              clockingEventUseTableRefs = false,
              reminderTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (configurationTableRefs) db.configurationTable,
                if (overnightTableRefs) db.overnightTable,
                if (journeyTableRefs) db.journeyTable,
                if (employeeFenceTableRefs) db.employeeFenceTable,
                if (activationTableRefs) db.activationTable,
                if (employeeManagersTableRefs) db.employeeManagersTable,
                if (employeePlatformUsersTableRefs)
                  db.employeePlatformUsersTable,
                if (clockingEventUseTableRefs) db.clockingEventUseTable,
                if (reminderTableRefs) db.reminderTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (companyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.companyId,
                    referencedTable:
                        $$EmployeeTableTableReferences._companyIdTable(db),
                    referencedColumn:
                        $$EmployeeTableTableReferences._companyIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (configurationTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, ConfigurationTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._configurationTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .configurationTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (overnightTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, OvernightTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._overnightTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .overnightTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.employee == item.id),
                        typedResults: items),
                  if (journeyTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, JourneyTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._journeyTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .journeyTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (employeeFenceTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, EmployeeFenceTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._employeeFenceTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .employeeFenceTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (activationTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, ActivationTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._activationTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .activationTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (employeeManagersTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, EmployeeManagersTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._employeeManagersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .employeeManagersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (employeePlatformUsersTableRefs)
                    await $_getPrefetchedData<
                            EmployeeTableData,
                            $EmployeeTableTable,
                            EmployeePlatformUsersTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._employeePlatformUsersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .employeePlatformUsersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (clockingEventUseTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, ClockingEventUseTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._clockingEventUseTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .clockingEventUseTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items),
                  if (reminderTableRefs)
                    await $_getPrefetchedData<EmployeeTableData,
                            $EmployeeTableTable, ReminderTableData>(
                        currentTable: table,
                        referencedTable: $$EmployeeTableTableReferences
                            ._reminderTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EmployeeTableTableReferences(db, table, p0)
                                .reminderTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.employeeId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EmployeeTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $EmployeeTableTable,
    EmployeeTableData,
    $$EmployeeTableTableFilterComposer,
    $$EmployeeTableTableOrderingComposer,
    $$EmployeeTableTableAnnotationComposer,
    $$EmployeeTableTableCreateCompanionBuilder,
    $$EmployeeTableTableUpdateCompanionBuilder,
    (EmployeeTableData, $$EmployeeTableTableReferences),
    EmployeeTableData,
    PrefetchHooks Function(
        {bool companyId,
        bool configurationTableRefs,
        bool overnightTableRefs,
        bool journeyTableRefs,
        bool employeeFenceTableRefs,
        bool activationTableRefs,
        bool employeeManagersTableRefs,
        bool employeePlatformUsersTableRefs,
        bool clockingEventUseTableRefs,
        bool reminderTableRefs})>;
typedef $$ConfigurationTableTableCreateCompanionBuilder
    = ConfigurationTableCompanion Function({
  Value<bool> onlyOnline,
  required String operationMode,
  required String timezone,
  Value<bool> takePhoto,
  Value<bool?> allowChangeTime,
  Value<String?> username,
  required String employeeId,
  Value<bool?> faceRecognition,
  Value<bool?> overnight,
  Value<bool?> controlOvernight,
  Value<bool?> gps,
  Value<bool?> deviceAuthorizationType,
  Value<bool?> allowDrivingTime,
  Value<bool?> allowGpoOnApp,
  Value<bool?> exportNotChecked,
  Value<String?> insightOutOfBound,
  Value<bool?> openExternalBrowser,
  Value<bool?> allowUse,
  Value<bool?> externalControlTimezone,
  Value<bool?> nfcMode,
  Value<bool?> takePhotoNfc,
  Value<bool?> takePhotoSingle,
  Value<bool?> takePhotoDriver,
  Value<bool?> takePhotoQrcode,
  Value<int> rowid,
});
typedef $$ConfigurationTableTableUpdateCompanionBuilder
    = ConfigurationTableCompanion Function({
  Value<bool> onlyOnline,
  Value<String> operationMode,
  Value<String> timezone,
  Value<bool> takePhoto,
  Value<bool?> allowChangeTime,
  Value<String?> username,
  Value<String> employeeId,
  Value<bool?> faceRecognition,
  Value<bool?> overnight,
  Value<bool?> controlOvernight,
  Value<bool?> gps,
  Value<bool?> deviceAuthorizationType,
  Value<bool?> allowDrivingTime,
  Value<bool?> allowGpoOnApp,
  Value<bool?> exportNotChecked,
  Value<String?> insightOutOfBound,
  Value<bool?> openExternalBrowser,
  Value<bool?> allowUse,
  Value<bool?> externalControlTimezone,
  Value<bool?> nfcMode,
  Value<bool?> takePhotoNfc,
  Value<bool?> takePhotoSingle,
  Value<bool?> takePhotoDriver,
  Value<bool?> takePhotoQrcode,
  Value<int> rowid,
});

final class $$ConfigurationTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $ConfigurationTableTable, ConfigurationTableData> {
  $$ConfigurationTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.configurationTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ConfigurationTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ConfigurationTableTable> {
  $$ConfigurationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<bool> get onlyOnline => $composableBuilder(
      column: $table.onlyOnline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operationMode => $composableBuilder(
      column: $table.operationMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhoto => $composableBuilder(
      column: $table.takePhoto, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get faceRecognition => $composableBuilder(
      column: $table.faceRecognition,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get overnight => $composableBuilder(
      column: $table.overnight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get controlOvernight => $composableBuilder(
      column: $table.controlOvernight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get gps => $composableBuilder(
      column: $table.gps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get deviceAuthorizationType => $composableBuilder(
      column: $table.deviceAuthorizationType,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowDrivingTime => $composableBuilder(
      column: $table.allowDrivingTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowGpoOnApp => $composableBuilder(
      column: $table.allowGpoOnApp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get exportNotChecked => $composableBuilder(
      column: $table.exportNotChecked,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insightOutOfBound => $composableBuilder(
      column: $table.insightOutOfBound,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get openExternalBrowser => $composableBuilder(
      column: $table.openExternalBrowser,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowUse => $composableBuilder(
      column: $table.allowUse, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get externalControlTimezone => $composableBuilder(
      column: $table.externalControlTimezone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get nfcMode => $composableBuilder(
      column: $table.nfcMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoNfc => $composableBuilder(
      column: $table.takePhotoNfc, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoSingle => $composableBuilder(
      column: $table.takePhotoSingle,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoDriver => $composableBuilder(
      column: $table.takePhotoDriver,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoQrcode => $composableBuilder(
      column: $table.takePhotoQrcode,
      builder: (column) => ColumnFilters(column));

  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConfigurationTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ConfigurationTableTable> {
  $$ConfigurationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<bool> get onlyOnline => $composableBuilder(
      column: $table.onlyOnline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operationMode => $composableBuilder(
      column: $table.operationMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhoto => $composableBuilder(
      column: $table.takePhoto, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get faceRecognition => $composableBuilder(
      column: $table.faceRecognition,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get overnight => $composableBuilder(
      column: $table.overnight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get controlOvernight => $composableBuilder(
      column: $table.controlOvernight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gps => $composableBuilder(
      column: $table.gps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get deviceAuthorizationType => $composableBuilder(
      column: $table.deviceAuthorizationType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowDrivingTime => $composableBuilder(
      column: $table.allowDrivingTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowGpoOnApp => $composableBuilder(
      column: $table.allowGpoOnApp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get exportNotChecked => $composableBuilder(
      column: $table.exportNotChecked,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insightOutOfBound => $composableBuilder(
      column: $table.insightOutOfBound,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get openExternalBrowser => $composableBuilder(
      column: $table.openExternalBrowser,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowUse => $composableBuilder(
      column: $table.allowUse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get externalControlTimezone => $composableBuilder(
      column: $table.externalControlTimezone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get nfcMode => $composableBuilder(
      column: $table.nfcMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoNfc => $composableBuilder(
      column: $table.takePhotoNfc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoSingle => $composableBuilder(
      column: $table.takePhotoSingle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoDriver => $composableBuilder(
      column: $table.takePhotoDriver,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoQrcode => $composableBuilder(
      column: $table.takePhotoQrcode,
      builder: (column) => ColumnOrderings(column));

  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConfigurationTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ConfigurationTableTable> {
  $$ConfigurationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<bool> get onlyOnline => $composableBuilder(
      column: $table.onlyOnline, builder: (column) => column);

  GeneratedColumn<String> get operationMode => $composableBuilder(
      column: $table.operationMode, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<bool> get takePhoto =>
      $composableBuilder(column: $table.takePhoto, builder: (column) => column);

  GeneratedColumn<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<bool> get faceRecognition => $composableBuilder(
      column: $table.faceRecognition, builder: (column) => column);

  GeneratedColumn<bool> get overnight =>
      $composableBuilder(column: $table.overnight, builder: (column) => column);

  GeneratedColumn<bool> get controlOvernight => $composableBuilder(
      column: $table.controlOvernight, builder: (column) => column);

  GeneratedColumn<bool> get gps =>
      $composableBuilder(column: $table.gps, builder: (column) => column);

  GeneratedColumn<bool> get deviceAuthorizationType => $composableBuilder(
      column: $table.deviceAuthorizationType, builder: (column) => column);

  GeneratedColumn<bool> get allowDrivingTime => $composableBuilder(
      column: $table.allowDrivingTime, builder: (column) => column);

  GeneratedColumn<bool> get allowGpoOnApp => $composableBuilder(
      column: $table.allowGpoOnApp, builder: (column) => column);

  GeneratedColumn<bool> get exportNotChecked => $composableBuilder(
      column: $table.exportNotChecked, builder: (column) => column);

  GeneratedColumn<String> get insightOutOfBound => $composableBuilder(
      column: $table.insightOutOfBound, builder: (column) => column);

  GeneratedColumn<bool> get openExternalBrowser => $composableBuilder(
      column: $table.openExternalBrowser, builder: (column) => column);

  GeneratedColumn<bool> get allowUse =>
      $composableBuilder(column: $table.allowUse, builder: (column) => column);

  GeneratedColumn<bool> get externalControlTimezone => $composableBuilder(
      column: $table.externalControlTimezone, builder: (column) => column);

  GeneratedColumn<bool> get nfcMode =>
      $composableBuilder(column: $table.nfcMode, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoNfc => $composableBuilder(
      column: $table.takePhotoNfc, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoSingle => $composableBuilder(
      column: $table.takePhotoSingle, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoDriver => $composableBuilder(
      column: $table.takePhotoDriver, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoQrcode => $composableBuilder(
      column: $table.takePhotoQrcode, builder: (column) => column);

  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ConfigurationTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ConfigurationTableTable,
    ConfigurationTableData,
    $$ConfigurationTableTableFilterComposer,
    $$ConfigurationTableTableOrderingComposer,
    $$ConfigurationTableTableAnnotationComposer,
    $$ConfigurationTableTableCreateCompanionBuilder,
    $$ConfigurationTableTableUpdateCompanionBuilder,
    (ConfigurationTableData, $$ConfigurationTableTableReferences),
    ConfigurationTableData,
    PrefetchHooks Function({bool employeeId})> {
  $$ConfigurationTableTableTableManager(
      _$CollectorDatabase db, $ConfigurationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConfigurationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConfigurationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConfigurationTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<bool> onlyOnline = const Value.absent(),
            Value<String> operationMode = const Value.absent(),
            Value<String> timezone = const Value.absent(),
            Value<bool> takePhoto = const Value.absent(),
            Value<bool?> allowChangeTime = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<bool?> faceRecognition = const Value.absent(),
            Value<bool?> overnight = const Value.absent(),
            Value<bool?> controlOvernight = const Value.absent(),
            Value<bool?> gps = const Value.absent(),
            Value<bool?> deviceAuthorizationType = const Value.absent(),
            Value<bool?> allowDrivingTime = const Value.absent(),
            Value<bool?> allowGpoOnApp = const Value.absent(),
            Value<bool?> exportNotChecked = const Value.absent(),
            Value<String?> insightOutOfBound = const Value.absent(),
            Value<bool?> openExternalBrowser = const Value.absent(),
            Value<bool?> allowUse = const Value.absent(),
            Value<bool?> externalControlTimezone = const Value.absent(),
            Value<bool?> nfcMode = const Value.absent(),
            Value<bool?> takePhotoNfc = const Value.absent(),
            Value<bool?> takePhotoSingle = const Value.absent(),
            Value<bool?> takePhotoDriver = const Value.absent(),
            Value<bool?> takePhotoQrcode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConfigurationTableCompanion(
            onlyOnline: onlyOnline,
            operationMode: operationMode,
            timezone: timezone,
            takePhoto: takePhoto,
            allowChangeTime: allowChangeTime,
            username: username,
            employeeId: employeeId,
            faceRecognition: faceRecognition,
            overnight: overnight,
            controlOvernight: controlOvernight,
            gps: gps,
            deviceAuthorizationType: deviceAuthorizationType,
            allowDrivingTime: allowDrivingTime,
            allowGpoOnApp: allowGpoOnApp,
            exportNotChecked: exportNotChecked,
            insightOutOfBound: insightOutOfBound,
            openExternalBrowser: openExternalBrowser,
            allowUse: allowUse,
            externalControlTimezone: externalControlTimezone,
            nfcMode: nfcMode,
            takePhotoNfc: takePhotoNfc,
            takePhotoSingle: takePhotoSingle,
            takePhotoDriver: takePhotoDriver,
            takePhotoQrcode: takePhotoQrcode,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            Value<bool> onlyOnline = const Value.absent(),
            required String operationMode,
            required String timezone,
            Value<bool> takePhoto = const Value.absent(),
            Value<bool?> allowChangeTime = const Value.absent(),
            Value<String?> username = const Value.absent(),
            required String employeeId,
            Value<bool?> faceRecognition = const Value.absent(),
            Value<bool?> overnight = const Value.absent(),
            Value<bool?> controlOvernight = const Value.absent(),
            Value<bool?> gps = const Value.absent(),
            Value<bool?> deviceAuthorizationType = const Value.absent(),
            Value<bool?> allowDrivingTime = const Value.absent(),
            Value<bool?> allowGpoOnApp = const Value.absent(),
            Value<bool?> exportNotChecked = const Value.absent(),
            Value<String?> insightOutOfBound = const Value.absent(),
            Value<bool?> openExternalBrowser = const Value.absent(),
            Value<bool?> allowUse = const Value.absent(),
            Value<bool?> externalControlTimezone = const Value.absent(),
            Value<bool?> nfcMode = const Value.absent(),
            Value<bool?> takePhotoNfc = const Value.absent(),
            Value<bool?> takePhotoSingle = const Value.absent(),
            Value<bool?> takePhotoDriver = const Value.absent(),
            Value<bool?> takePhotoQrcode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ConfigurationTableCompanion.insert(
            onlyOnline: onlyOnline,
            operationMode: operationMode,
            timezone: timezone,
            takePhoto: takePhoto,
            allowChangeTime: allowChangeTime,
            username: username,
            employeeId: employeeId,
            faceRecognition: faceRecognition,
            overnight: overnight,
            controlOvernight: controlOvernight,
            gps: gps,
            deviceAuthorizationType: deviceAuthorizationType,
            allowDrivingTime: allowDrivingTime,
            allowGpoOnApp: allowGpoOnApp,
            exportNotChecked: exportNotChecked,
            insightOutOfBound: insightOutOfBound,
            openExternalBrowser: openExternalBrowser,
            allowUse: allowUse,
            externalControlTimezone: externalControlTimezone,
            nfcMode: nfcMode,
            takePhotoNfc: takePhotoNfc,
            takePhotoSingle: takePhotoSingle,
            takePhotoDriver: takePhotoDriver,
            takePhotoQrcode: takePhotoQrcode,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ConfigurationTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable: $$ConfigurationTableTableReferences
                        ._employeeIdTable(db),
                    referencedColumn: $$ConfigurationTableTableReferences
                        ._employeeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ConfigurationTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $ConfigurationTableTable,
    ConfigurationTableData,
    $$ConfigurationTableTableFilterComposer,
    $$ConfigurationTableTableOrderingComposer,
    $$ConfigurationTableTableAnnotationComposer,
    $$ConfigurationTableTableCreateCompanionBuilder,
    $$ConfigurationTableTableUpdateCompanionBuilder,
    (ConfigurationTableData, $$ConfigurationTableTableReferences),
    ConfigurationTableData,
    PrefetchHooks Function({bool employeeId})>;
typedef $$OvernightTableTableCreateCompanionBuilder = OvernightTableCompanion
    Function({
  required String id,
  required DateTime date,
  Value<String?> geolocation,
  required String locationStatus,
  required String type,
  required bool synchronized,
  required String employee,
  Value<int> rowid,
});
typedef $$OvernightTableTableUpdateCompanionBuilder = OvernightTableCompanion
    Function({
  Value<String> id,
  Value<DateTime> date,
  Value<String?> geolocation,
  Value<String> locationStatus,
  Value<String> type,
  Value<bool> synchronized,
  Value<String> employee,
  Value<int> rowid,
});

final class $$OvernightTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $OvernightTableTable, OvernightTableData> {
  $$OvernightTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.overnightTable.employee, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employee {
    final $_column = $_itemColumn<String>('employee')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$JourneyTableTable, List<JourneyTableData>>
      _journeyTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.journeyTable,
              aliasName: $_aliasNameGenerator(
                  db.overnightTable.id, db.journeyTable.overnightId));

  $$JourneyTableTableProcessedTableManager get journeyTableRefs {
    final manager = $$JourneyTableTableTableManager($_db, $_db.journeyTable)
        .filter((f) => f.overnightId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_journeyTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OvernightTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $OvernightTableTable> {
  $$OvernightTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get geolocation => $composableBuilder(
      column: $table.geolocation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationStatus => $composableBuilder(
      column: $table.locationStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synchronized => $composableBuilder(
      column: $table.synchronized, builder: (column) => ColumnFilters(column));

  $$EmployeeTableTableFilterComposer get employee {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employee,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> journeyTableRefs(
      Expression<bool> Function($$JourneyTableTableFilterComposer f) f) {
    final $$JourneyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.overnightId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableFilterComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OvernightTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $OvernightTableTable> {
  $$OvernightTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get geolocation => $composableBuilder(
      column: $table.geolocation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationStatus => $composableBuilder(
      column: $table.locationStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synchronized => $composableBuilder(
      column: $table.synchronized,
      builder: (column) => ColumnOrderings(column));

  $$EmployeeTableTableOrderingComposer get employee {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employee,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OvernightTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $OvernightTableTable> {
  $$OvernightTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get geolocation => $composableBuilder(
      column: $table.geolocation, builder: (column) => column);

  GeneratedColumn<String> get locationStatus => $composableBuilder(
      column: $table.locationStatus, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get synchronized => $composableBuilder(
      column: $table.synchronized, builder: (column) => column);

  $$EmployeeTableTableAnnotationComposer get employee {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employee,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> journeyTableRefs<T extends Object>(
      Expression<T> Function($$JourneyTableTableAnnotationComposer a) f) {
    final $$JourneyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.overnightId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OvernightTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $OvernightTableTable,
    OvernightTableData,
    $$OvernightTableTableFilterComposer,
    $$OvernightTableTableOrderingComposer,
    $$OvernightTableTableAnnotationComposer,
    $$OvernightTableTableCreateCompanionBuilder,
    $$OvernightTableTableUpdateCompanionBuilder,
    (OvernightTableData, $$OvernightTableTableReferences),
    OvernightTableData,
    PrefetchHooks Function({bool employee, bool journeyTableRefs})> {
  $$OvernightTableTableTableManager(
      _$CollectorDatabase db, $OvernightTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OvernightTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OvernightTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OvernightTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> geolocation = const Value.absent(),
            Value<String> locationStatus = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<bool> synchronized = const Value.absent(),
            Value<String> employee = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              OvernightTableCompanion(
            id: id,
            date: date,
            geolocation: geolocation,
            locationStatus: locationStatus,
            type: type,
            synchronized: synchronized,
            employee: employee,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime date,
            Value<String?> geolocation = const Value.absent(),
            required String locationStatus,
            required String type,
            required bool synchronized,
            required String employee,
            Value<int> rowid = const Value.absent(),
          }) =>
              OvernightTableCompanion.insert(
            id: id,
            date: date,
            geolocation: geolocation,
            locationStatus: locationStatus,
            type: type,
            synchronized: synchronized,
            employee: employee,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$OvernightTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {employee = false, journeyTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (journeyTableRefs) db.journeyTable],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employee) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employee,
                    referencedTable:
                        $$OvernightTableTableReferences._employeeTable(db),
                    referencedColumn:
                        $$OvernightTableTableReferences._employeeTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (journeyTableRefs)
                    await $_getPrefetchedData<OvernightTableData,
                            $OvernightTableTable, JourneyTableData>(
                        currentTable: table,
                        referencedTable: $$OvernightTableTableReferences
                            ._journeyTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OvernightTableTableReferences(db, table, p0)
                                .journeyTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.overnightId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OvernightTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $OvernightTableTable,
    OvernightTableData,
    $$OvernightTableTableFilterComposer,
    $$OvernightTableTableOrderingComposer,
    $$OvernightTableTableAnnotationComposer,
    $$OvernightTableTableCreateCompanionBuilder,
    $$OvernightTableTableUpdateCompanionBuilder,
    (OvernightTableData, $$OvernightTableTableReferences),
    OvernightTableData,
    PrefetchHooks Function({bool employee, bool journeyTableRefs})>;
typedef $$JourneyTableTableCreateCompanionBuilder = JourneyTableCompanion
    Function({
  required String id,
  required int journeyNumber,
  Value<String?> overnightId,
  required DateTime startDate,
  Value<DateTime?> endDate,
  required String employeeId,
  Value<int> rowid,
});
typedef $$JourneyTableTableUpdateCompanionBuilder = JourneyTableCompanion
    Function({
  Value<String> id,
  Value<int> journeyNumber,
  Value<String?> overnightId,
  Value<DateTime> startDate,
  Value<DateTime?> endDate,
  Value<String> employeeId,
  Value<int> rowid,
});

final class $$JourneyTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $JourneyTableTable, JourneyTableData> {
  $$JourneyTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OvernightTableTable _overnightIdTable(_$CollectorDatabase db) =>
      db.overnightTable.createAlias($_aliasNameGenerator(
          db.journeyTable.overnightId, db.overnightTable.id));

  $$OvernightTableTableProcessedTableManager? get overnightId {
    final $_column = $_itemColumn<String>('overnight_id');
    if ($_column == null) return null;
    final manager = $$OvernightTableTableTableManager($_db, $_db.overnightTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_overnightIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.journeyTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ClockingEventTableTable,
      List<ClockingEventTableData>> _clockingEventTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.clockingEventTable,
          aliasName: $_aliasNameGenerator(
              db.journeyTable.id, db.clockingEventTable.journeyId));

  $$ClockingEventTableTableProcessedTableManager get clockingEventTableRefs {
    final manager = $$ClockingEventTableTableTableManager(
            $_db, $_db.clockingEventTable)
        .filter((f) => f.journeyId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_clockingEventTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$JourneyTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $JourneyTableTable> {
  $$JourneyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get journeyNumber => $composableBuilder(
      column: $table.journeyNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  $$OvernightTableTableFilterComposer get overnightId {
    final $$OvernightTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.overnightId,
        referencedTable: $db.overnightTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OvernightTableTableFilterComposer(
              $db: $db,
              $table: $db.overnightTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> clockingEventTableRefs(
      Expression<bool> Function($$ClockingEventTableTableFilterComposer f) f) {
    final $$ClockingEventTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.clockingEventTable,
        getReferencedColumn: (t) => t.journeyId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClockingEventTableTableFilterComposer(
              $db: $db,
              $table: $db.clockingEventTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$JourneyTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $JourneyTableTable> {
  $$JourneyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get journeyNumber => $composableBuilder(
      column: $table.journeyNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  $$OvernightTableTableOrderingComposer get overnightId {
    final $$OvernightTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.overnightId,
        referencedTable: $db.overnightTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OvernightTableTableOrderingComposer(
              $db: $db,
              $table: $db.overnightTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$JourneyTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $JourneyTableTable> {
  $$JourneyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get journeyNumber => $composableBuilder(
      column: $table.journeyNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  $$OvernightTableTableAnnotationComposer get overnightId {
    final $$OvernightTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.overnightId,
        referencedTable: $db.overnightTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OvernightTableTableAnnotationComposer(
              $db: $db,
              $table: $db.overnightTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> clockingEventTableRefs<T extends Object>(
      Expression<T> Function($$ClockingEventTableTableAnnotationComposer a) f) {
    final $$ClockingEventTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.clockingEventTable,
            getReferencedColumn: (t) => t.journeyId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ClockingEventTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.clockingEventTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$JourneyTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $JourneyTableTable,
    JourneyTableData,
    $$JourneyTableTableFilterComposer,
    $$JourneyTableTableOrderingComposer,
    $$JourneyTableTableAnnotationComposer,
    $$JourneyTableTableCreateCompanionBuilder,
    $$JourneyTableTableUpdateCompanionBuilder,
    (JourneyTableData, $$JourneyTableTableReferences),
    JourneyTableData,
    PrefetchHooks Function(
        {bool overnightId, bool employeeId, bool clockingEventTableRefs})> {
  $$JourneyTableTableTableManager(
      _$CollectorDatabase db, $JourneyTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JourneyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JourneyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JourneyTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> journeyNumber = const Value.absent(),
            Value<String?> overnightId = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime?> endDate = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JourneyTableCompanion(
            id: id,
            journeyNumber: journeyNumber,
            overnightId: overnightId,
            startDate: startDate,
            endDate: endDate,
            employeeId: employeeId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int journeyNumber,
            Value<String?> overnightId = const Value.absent(),
            required DateTime startDate,
            Value<DateTime?> endDate = const Value.absent(),
            required String employeeId,
            Value<int> rowid = const Value.absent(),
          }) =>
              JourneyTableCompanion.insert(
            id: id,
            journeyNumber: journeyNumber,
            overnightId: overnightId,
            startDate: startDate,
            endDate: endDate,
            employeeId: employeeId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$JourneyTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {overnightId = false,
              employeeId = false,
              clockingEventTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (clockingEventTableRefs) db.clockingEventTable
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (overnightId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.overnightId,
                    referencedTable:
                        $$JourneyTableTableReferences._overnightIdTable(db),
                    referencedColumn:
                        $$JourneyTableTableReferences._overnightIdTable(db).id,
                  ) as T;
                }
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable:
                        $$JourneyTableTableReferences._employeeIdTable(db),
                    referencedColumn:
                        $$JourneyTableTableReferences._employeeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (clockingEventTableRefs)
                    await $_getPrefetchedData<JourneyTableData,
                            $JourneyTableTable, ClockingEventTableData>(
                        currentTable: table,
                        referencedTable: $$JourneyTableTableReferences
                            ._clockingEventTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$JourneyTableTableReferences(db, table, p0)
                                .clockingEventTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.journeyId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$JourneyTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $JourneyTableTable,
    JourneyTableData,
    $$JourneyTableTableFilterComposer,
    $$JourneyTableTableOrderingComposer,
    $$JourneyTableTableAnnotationComposer,
    $$JourneyTableTableCreateCompanionBuilder,
    $$JourneyTableTableUpdateCompanionBuilder,
    (JourneyTableData, $$JourneyTableTableReferences),
    JourneyTableData,
    PrefetchHooks Function(
        {bool overnightId, bool employeeId, bool clockingEventTableRefs})>;
typedef $$ClockingEventTableTableCreateCompanionBuilder
    = ClockingEventTableCompanion Function({
  required String clockingEventId,
  required DateTime dateTimeEvent,
  required String dateEvent,
  required String timeEvent,
  required String timeZone,
  required String companyIdentifier,
  Value<String?> pis,
  required String cpf,
  required String appVersion,
  required String platform,
  Value<String?> identifierDevice,
  Value<String?> nameDevice,
  Value<String?> developerModeDevice,
  Value<String?> gpsOperationModeDevice,
  Value<bool?> dateTimeAutomaticDevice,
  Value<bool?> timeZoneAutomaticDevice,
  Value<double?> latitudeLocation,
  Value<double?> longitudeLocation,
  required bool geolocationIsMock,
  Value<DateTime?> dateAndTimeLocation,
  required String employeeId,
  Value<String?> fenceState,
  required int use,
  required String mode,
  Value<bool> online,
  required String origin,
  required String signature,
  required int signatureVersion,
  Value<String?> clientOriginInfo,
  Value<String?> appointmentImage,
  Value<String?> photoNotCaptured,
  Value<String?> locationStatus,
  required bool isSynchronized,
  Value<String?> journeyId,
  Value<bool> isMealBreak,
  Value<String?> journeyEventName,
  Value<String> employeeName,
  Value<String> companyName,
  Value<String?> facialRecognitionStatus,
  Value<int> rowid,
});
typedef $$ClockingEventTableTableUpdateCompanionBuilder
    = ClockingEventTableCompanion Function({
  Value<String> clockingEventId,
  Value<DateTime> dateTimeEvent,
  Value<String> dateEvent,
  Value<String> timeEvent,
  Value<String> timeZone,
  Value<String> companyIdentifier,
  Value<String?> pis,
  Value<String> cpf,
  Value<String> appVersion,
  Value<String> platform,
  Value<String?> identifierDevice,
  Value<String?> nameDevice,
  Value<String?> developerModeDevice,
  Value<String?> gpsOperationModeDevice,
  Value<bool?> dateTimeAutomaticDevice,
  Value<bool?> timeZoneAutomaticDevice,
  Value<double?> latitudeLocation,
  Value<double?> longitudeLocation,
  Value<bool> geolocationIsMock,
  Value<DateTime?> dateAndTimeLocation,
  Value<String> employeeId,
  Value<String?> fenceState,
  Value<int> use,
  Value<String> mode,
  Value<bool> online,
  Value<String> origin,
  Value<String> signature,
  Value<int> signatureVersion,
  Value<String?> clientOriginInfo,
  Value<String?> appointmentImage,
  Value<String?> photoNotCaptured,
  Value<String?> locationStatus,
  Value<bool> isSynchronized,
  Value<String?> journeyId,
  Value<bool> isMealBreak,
  Value<String?> journeyEventName,
  Value<String> employeeName,
  Value<String> companyName,
  Value<String?> facialRecognitionStatus,
  Value<int> rowid,
});

final class $$ClockingEventTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $ClockingEventTableTable, ClockingEventTableData> {
  $$ClockingEventTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $JourneyTableTable _journeyIdTable(_$CollectorDatabase db) =>
      db.journeyTable.createAlias($_aliasNameGenerator(
          db.clockingEventTable.journeyId, db.journeyTable.id));

  $$JourneyTableTableProcessedTableManager? get journeyId {
    final $_column = $_itemColumn<String>('journey_id');
    if ($_column == null) return null;
    final manager = $$JourneyTableTableTableManager($_db, $_db.journeyTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_journeyIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ClockingEventTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ClockingEventTableTable> {
  $$ClockingEventTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clockingEventId => $composableBuilder(
      column: $table.clockingEventId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateTimeEvent => $composableBuilder(
      column: $table.dateTimeEvent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dateEvent => $composableBuilder(
      column: $table.dateEvent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeEvent => $composableBuilder(
      column: $table.timeEvent, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeZone => $composableBuilder(
      column: $table.timeZone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get companyIdentifier => $composableBuilder(
      column: $table.companyIdentifier,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get pis => $composableBuilder(
      column: $table.pis, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cpf => $composableBuilder(
      column: $table.cpf, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get identifierDevice => $composableBuilder(
      column: $table.identifierDevice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameDevice => $composableBuilder(
      column: $table.nameDevice, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get developerModeDevice => $composableBuilder(
      column: $table.developerModeDevice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gpsOperationModeDevice => $composableBuilder(
      column: $table.gpsOperationModeDevice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get dateTimeAutomaticDevice => $composableBuilder(
      column: $table.dateTimeAutomaticDevice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get timeZoneAutomaticDevice => $composableBuilder(
      column: $table.timeZoneAutomaticDevice,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitudeLocation => $composableBuilder(
      column: $table.latitudeLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitudeLocation => $composableBuilder(
      column: $table.longitudeLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get geolocationIsMock => $composableBuilder(
      column: $table.geolocationIsMock,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateAndTimeLocation => $composableBuilder(
      column: $table.dateAndTimeLocation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fenceState => $composableBuilder(
      column: $table.fenceState, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get use => $composableBuilder(
      column: $table.use, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get online => $composableBuilder(
      column: $table.online, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get signature => $composableBuilder(
      column: $table.signature, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get signatureVersion => $composableBuilder(
      column: $table.signatureVersion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clientOriginInfo => $composableBuilder(
      column: $table.clientOriginInfo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get appointmentImage => $composableBuilder(
      column: $table.appointmentImage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoNotCaptured => $composableBuilder(
      column: $table.photoNotCaptured,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get locationStatus => $composableBuilder(
      column: $table.locationStatus,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSynchronized => $composableBuilder(
      column: $table.isSynchronized,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isMealBreak => $composableBuilder(
      column: $table.isMealBreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get journeyEventName => $composableBuilder(
      column: $table.journeyEventName,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeName => $composableBuilder(
      column: $table.employeeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get companyName => $composableBuilder(
      column: $table.companyName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get facialRecognitionStatus => $composableBuilder(
      column: $table.facialRecognitionStatus,
      builder: (column) => ColumnFilters(column));

  $$JourneyTableTableFilterComposer get journeyId {
    final $$JourneyTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableFilterComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClockingEventTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ClockingEventTableTable> {
  $$ClockingEventTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clockingEventId => $composableBuilder(
      column: $table.clockingEventId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateTimeEvent => $composableBuilder(
      column: $table.dateTimeEvent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dateEvent => $composableBuilder(
      column: $table.dateEvent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeEvent => $composableBuilder(
      column: $table.timeEvent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeZone => $composableBuilder(
      column: $table.timeZone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get companyIdentifier => $composableBuilder(
      column: $table.companyIdentifier,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get pis => $composableBuilder(
      column: $table.pis, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cpf => $composableBuilder(
      column: $table.cpf, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platform => $composableBuilder(
      column: $table.platform, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get identifierDevice => $composableBuilder(
      column: $table.identifierDevice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameDevice => $composableBuilder(
      column: $table.nameDevice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get developerModeDevice => $composableBuilder(
      column: $table.developerModeDevice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gpsOperationModeDevice => $composableBuilder(
      column: $table.gpsOperationModeDevice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get dateTimeAutomaticDevice => $composableBuilder(
      column: $table.dateTimeAutomaticDevice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get timeZoneAutomaticDevice => $composableBuilder(
      column: $table.timeZoneAutomaticDevice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitudeLocation => $composableBuilder(
      column: $table.latitudeLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitudeLocation => $composableBuilder(
      column: $table.longitudeLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get geolocationIsMock => $composableBuilder(
      column: $table.geolocationIsMock,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateAndTimeLocation => $composableBuilder(
      column: $table.dateAndTimeLocation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fenceState => $composableBuilder(
      column: $table.fenceState, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get use => $composableBuilder(
      column: $table.use, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mode => $composableBuilder(
      column: $table.mode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get online => $composableBuilder(
      column: $table.online, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get origin => $composableBuilder(
      column: $table.origin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get signature => $composableBuilder(
      column: $table.signature, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get signatureVersion => $composableBuilder(
      column: $table.signatureVersion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clientOriginInfo => $composableBuilder(
      column: $table.clientOriginInfo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get appointmentImage => $composableBuilder(
      column: $table.appointmentImage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoNotCaptured => $composableBuilder(
      column: $table.photoNotCaptured,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get locationStatus => $composableBuilder(
      column: $table.locationStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSynchronized => $composableBuilder(
      column: $table.isSynchronized,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isMealBreak => $composableBuilder(
      column: $table.isMealBreak, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get journeyEventName => $composableBuilder(
      column: $table.journeyEventName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeName => $composableBuilder(
      column: $table.employeeName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get companyName => $composableBuilder(
      column: $table.companyName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get facialRecognitionStatus => $composableBuilder(
      column: $table.facialRecognitionStatus,
      builder: (column) => ColumnOrderings(column));

  $$JourneyTableTableOrderingComposer get journeyId {
    final $$JourneyTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableOrderingComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClockingEventTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ClockingEventTableTable> {
  $$ClockingEventTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clockingEventId => $composableBuilder(
      column: $table.clockingEventId, builder: (column) => column);

  GeneratedColumn<DateTime> get dateTimeEvent => $composableBuilder(
      column: $table.dateTimeEvent, builder: (column) => column);

  GeneratedColumn<String> get dateEvent =>
      $composableBuilder(column: $table.dateEvent, builder: (column) => column);

  GeneratedColumn<String> get timeEvent =>
      $composableBuilder(column: $table.timeEvent, builder: (column) => column);

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumn<String> get companyIdentifier => $composableBuilder(
      column: $table.companyIdentifier, builder: (column) => column);

  GeneratedColumn<String> get pis =>
      $composableBuilder(column: $table.pis, builder: (column) => column);

  GeneratedColumn<String> get cpf =>
      $composableBuilder(column: $table.cpf, builder: (column) => column);

  GeneratedColumn<String> get appVersion => $composableBuilder(
      column: $table.appVersion, builder: (column) => column);

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get identifierDevice => $composableBuilder(
      column: $table.identifierDevice, builder: (column) => column);

  GeneratedColumn<String> get nameDevice => $composableBuilder(
      column: $table.nameDevice, builder: (column) => column);

  GeneratedColumn<String> get developerModeDevice => $composableBuilder(
      column: $table.developerModeDevice, builder: (column) => column);

  GeneratedColumn<String> get gpsOperationModeDevice => $composableBuilder(
      column: $table.gpsOperationModeDevice, builder: (column) => column);

  GeneratedColumn<bool> get dateTimeAutomaticDevice => $composableBuilder(
      column: $table.dateTimeAutomaticDevice, builder: (column) => column);

  GeneratedColumn<bool> get timeZoneAutomaticDevice => $composableBuilder(
      column: $table.timeZoneAutomaticDevice, builder: (column) => column);

  GeneratedColumn<double> get latitudeLocation => $composableBuilder(
      column: $table.latitudeLocation, builder: (column) => column);

  GeneratedColumn<double> get longitudeLocation => $composableBuilder(
      column: $table.longitudeLocation, builder: (column) => column);

  GeneratedColumn<bool> get geolocationIsMock => $composableBuilder(
      column: $table.geolocationIsMock, builder: (column) => column);

  GeneratedColumn<DateTime> get dateAndTimeLocation => $composableBuilder(
      column: $table.dateAndTimeLocation, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<String> get fenceState => $composableBuilder(
      column: $table.fenceState, builder: (column) => column);

  GeneratedColumn<int> get use =>
      $composableBuilder(column: $table.use, builder: (column) => column);

  GeneratedColumn<String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<bool> get online =>
      $composableBuilder(column: $table.online, builder: (column) => column);

  GeneratedColumn<String> get origin =>
      $composableBuilder(column: $table.origin, builder: (column) => column);

  GeneratedColumn<String> get signature =>
      $composableBuilder(column: $table.signature, builder: (column) => column);

  GeneratedColumn<int> get signatureVersion => $composableBuilder(
      column: $table.signatureVersion, builder: (column) => column);

  GeneratedColumn<String> get clientOriginInfo => $composableBuilder(
      column: $table.clientOriginInfo, builder: (column) => column);

  GeneratedColumn<String> get appointmentImage => $composableBuilder(
      column: $table.appointmentImage, builder: (column) => column);

  GeneratedColumn<String> get photoNotCaptured => $composableBuilder(
      column: $table.photoNotCaptured, builder: (column) => column);

  GeneratedColumn<String> get locationStatus => $composableBuilder(
      column: $table.locationStatus, builder: (column) => column);

  GeneratedColumn<bool> get isSynchronized => $composableBuilder(
      column: $table.isSynchronized, builder: (column) => column);

  GeneratedColumn<bool> get isMealBreak => $composableBuilder(
      column: $table.isMealBreak, builder: (column) => column);

  GeneratedColumn<String> get journeyEventName => $composableBuilder(
      column: $table.journeyEventName, builder: (column) => column);

  GeneratedColumn<String> get employeeName => $composableBuilder(
      column: $table.employeeName, builder: (column) => column);

  GeneratedColumn<String> get companyName => $composableBuilder(
      column: $table.companyName, builder: (column) => column);

  GeneratedColumn<String> get facialRecognitionStatus => $composableBuilder(
      column: $table.facialRecognitionStatus, builder: (column) => column);

  $$JourneyTableTableAnnotationComposer get journeyId {
    final $$JourneyTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.journeyId,
        referencedTable: $db.journeyTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$JourneyTableTableAnnotationComposer(
              $db: $db,
              $table: $db.journeyTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClockingEventTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ClockingEventTableTable,
    ClockingEventTableData,
    $$ClockingEventTableTableFilterComposer,
    $$ClockingEventTableTableOrderingComposer,
    $$ClockingEventTableTableAnnotationComposer,
    $$ClockingEventTableTableCreateCompanionBuilder,
    $$ClockingEventTableTableUpdateCompanionBuilder,
    (ClockingEventTableData, $$ClockingEventTableTableReferences),
    ClockingEventTableData,
    PrefetchHooks Function({bool journeyId})> {
  $$ClockingEventTableTableTableManager(
      _$CollectorDatabase db, $ClockingEventTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClockingEventTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClockingEventTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClockingEventTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clockingEventId = const Value.absent(),
            Value<DateTime> dateTimeEvent = const Value.absent(),
            Value<String> dateEvent = const Value.absent(),
            Value<String> timeEvent = const Value.absent(),
            Value<String> timeZone = const Value.absent(),
            Value<String> companyIdentifier = const Value.absent(),
            Value<String?> pis = const Value.absent(),
            Value<String> cpf = const Value.absent(),
            Value<String> appVersion = const Value.absent(),
            Value<String> platform = const Value.absent(),
            Value<String?> identifierDevice = const Value.absent(),
            Value<String?> nameDevice = const Value.absent(),
            Value<String?> developerModeDevice = const Value.absent(),
            Value<String?> gpsOperationModeDevice = const Value.absent(),
            Value<bool?> dateTimeAutomaticDevice = const Value.absent(),
            Value<bool?> timeZoneAutomaticDevice = const Value.absent(),
            Value<double?> latitudeLocation = const Value.absent(),
            Value<double?> longitudeLocation = const Value.absent(),
            Value<bool> geolocationIsMock = const Value.absent(),
            Value<DateTime?> dateAndTimeLocation = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<String?> fenceState = const Value.absent(),
            Value<int> use = const Value.absent(),
            Value<String> mode = const Value.absent(),
            Value<bool> online = const Value.absent(),
            Value<String> origin = const Value.absent(),
            Value<String> signature = const Value.absent(),
            Value<int> signatureVersion = const Value.absent(),
            Value<String?> clientOriginInfo = const Value.absent(),
            Value<String?> appointmentImage = const Value.absent(),
            Value<String?> photoNotCaptured = const Value.absent(),
            Value<String?> locationStatus = const Value.absent(),
            Value<bool> isSynchronized = const Value.absent(),
            Value<String?> journeyId = const Value.absent(),
            Value<bool> isMealBreak = const Value.absent(),
            Value<String?> journeyEventName = const Value.absent(),
            Value<String> employeeName = const Value.absent(),
            Value<String> companyName = const Value.absent(),
            Value<String?> facialRecognitionStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClockingEventTableCompanion(
            clockingEventId: clockingEventId,
            dateTimeEvent: dateTimeEvent,
            dateEvent: dateEvent,
            timeEvent: timeEvent,
            timeZone: timeZone,
            companyIdentifier: companyIdentifier,
            pis: pis,
            cpf: cpf,
            appVersion: appVersion,
            platform: platform,
            identifierDevice: identifierDevice,
            nameDevice: nameDevice,
            developerModeDevice: developerModeDevice,
            gpsOperationModeDevice: gpsOperationModeDevice,
            dateTimeAutomaticDevice: dateTimeAutomaticDevice,
            timeZoneAutomaticDevice: timeZoneAutomaticDevice,
            latitudeLocation: latitudeLocation,
            longitudeLocation: longitudeLocation,
            geolocationIsMock: geolocationIsMock,
            dateAndTimeLocation: dateAndTimeLocation,
            employeeId: employeeId,
            fenceState: fenceState,
            use: use,
            mode: mode,
            online: online,
            origin: origin,
            signature: signature,
            signatureVersion: signatureVersion,
            clientOriginInfo: clientOriginInfo,
            appointmentImage: appointmentImage,
            photoNotCaptured: photoNotCaptured,
            locationStatus: locationStatus,
            isSynchronized: isSynchronized,
            journeyId: journeyId,
            isMealBreak: isMealBreak,
            journeyEventName: journeyEventName,
            employeeName: employeeName,
            companyName: companyName,
            facialRecognitionStatus: facialRecognitionStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clockingEventId,
            required DateTime dateTimeEvent,
            required String dateEvent,
            required String timeEvent,
            required String timeZone,
            required String companyIdentifier,
            Value<String?> pis = const Value.absent(),
            required String cpf,
            required String appVersion,
            required String platform,
            Value<String?> identifierDevice = const Value.absent(),
            Value<String?> nameDevice = const Value.absent(),
            Value<String?> developerModeDevice = const Value.absent(),
            Value<String?> gpsOperationModeDevice = const Value.absent(),
            Value<bool?> dateTimeAutomaticDevice = const Value.absent(),
            Value<bool?> timeZoneAutomaticDevice = const Value.absent(),
            Value<double?> latitudeLocation = const Value.absent(),
            Value<double?> longitudeLocation = const Value.absent(),
            required bool geolocationIsMock,
            Value<DateTime?> dateAndTimeLocation = const Value.absent(),
            required String employeeId,
            Value<String?> fenceState = const Value.absent(),
            required int use,
            required String mode,
            Value<bool> online = const Value.absent(),
            required String origin,
            required String signature,
            required int signatureVersion,
            Value<String?> clientOriginInfo = const Value.absent(),
            Value<String?> appointmentImage = const Value.absent(),
            Value<String?> photoNotCaptured = const Value.absent(),
            Value<String?> locationStatus = const Value.absent(),
            required bool isSynchronized,
            Value<String?> journeyId = const Value.absent(),
            Value<bool> isMealBreak = const Value.absent(),
            Value<String?> journeyEventName = const Value.absent(),
            Value<String> employeeName = const Value.absent(),
            Value<String> companyName = const Value.absent(),
            Value<String?> facialRecognitionStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClockingEventTableCompanion.insert(
            clockingEventId: clockingEventId,
            dateTimeEvent: dateTimeEvent,
            dateEvent: dateEvent,
            timeEvent: timeEvent,
            timeZone: timeZone,
            companyIdentifier: companyIdentifier,
            pis: pis,
            cpf: cpf,
            appVersion: appVersion,
            platform: platform,
            identifierDevice: identifierDevice,
            nameDevice: nameDevice,
            developerModeDevice: developerModeDevice,
            gpsOperationModeDevice: gpsOperationModeDevice,
            dateTimeAutomaticDevice: dateTimeAutomaticDevice,
            timeZoneAutomaticDevice: timeZoneAutomaticDevice,
            latitudeLocation: latitudeLocation,
            longitudeLocation: longitudeLocation,
            geolocationIsMock: geolocationIsMock,
            dateAndTimeLocation: dateAndTimeLocation,
            employeeId: employeeId,
            fenceState: fenceState,
            use: use,
            mode: mode,
            online: online,
            origin: origin,
            signature: signature,
            signatureVersion: signatureVersion,
            clientOriginInfo: clientOriginInfo,
            appointmentImage: appointmentImage,
            photoNotCaptured: photoNotCaptured,
            locationStatus: locationStatus,
            isSynchronized: isSynchronized,
            journeyId: journeyId,
            isMealBreak: isMealBreak,
            journeyEventName: journeyEventName,
            employeeName: employeeName,
            companyName: companyName,
            facialRecognitionStatus: facialRecognitionStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClockingEventTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({journeyId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (journeyId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.journeyId,
                    referencedTable:
                        $$ClockingEventTableTableReferences._journeyIdTable(db),
                    referencedColumn: $$ClockingEventTableTableReferences
                        ._journeyIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ClockingEventTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $ClockingEventTableTable,
    ClockingEventTableData,
    $$ClockingEventTableTableFilterComposer,
    $$ClockingEventTableTableOrderingComposer,
    $$ClockingEventTableTableAnnotationComposer,
    $$ClockingEventTableTableCreateCompanionBuilder,
    $$ClockingEventTableTableUpdateCompanionBuilder,
    (ClockingEventTableData, $$ClockingEventTableTableReferences),
    ClockingEventTableData,
    PrefetchHooks Function({bool journeyId})>;
typedef $$FenceTableTableCreateCompanionBuilder = FenceTableCompanion Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$FenceTableTableUpdateCompanionBuilder = FenceTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$FenceTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $FenceTableTable, FenceTableData> {
  $$FenceTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EmployeeFenceTableTable,
      List<EmployeeFenceTableData>> _employeeFenceTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.employeeFenceTable,
          aliasName: $_aliasNameGenerator(
              db.fenceTable.id, db.employeeFenceTable.fenceId));

  $$EmployeeFenceTableTableProcessedTableManager get employeeFenceTableRefs {
    final manager =
        $$EmployeeFenceTableTableTableManager($_db, $_db.employeeFenceTable)
            .filter((f) => f.fenceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_employeeFenceTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$FencePerimeterTableTable,
      List<FencePerimeterTableData>> _fencePerimeterTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.fencePerimeterTable,
          aliasName: $_aliasNameGenerator(
              db.fenceTable.id, db.fencePerimeterTable.fenceId));

  $$FencePerimeterTableTableProcessedTableManager get fencePerimeterTableRefs {
    final manager =
        $$FencePerimeterTableTableTableManager($_db, $_db.fencePerimeterTable)
            .filter((f) => f.fenceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_fencePerimeterTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$FenceTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $FenceTableTable> {
  $$FenceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> employeeFenceTableRefs(
      Expression<bool> Function($$EmployeeFenceTableTableFilterComposer f) f) {
    final $$EmployeeFenceTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.employeeFenceTable,
        getReferencedColumn: (t) => t.fenceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeFenceTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeFenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> fencePerimeterTableRefs(
      Expression<bool> Function($$FencePerimeterTableTableFilterComposer f) f) {
    final $$FencePerimeterTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.fencePerimeterTable,
        getReferencedColumn: (t) => t.fenceId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FencePerimeterTableTableFilterComposer(
              $db: $db,
              $table: $db.fencePerimeterTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$FenceTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $FenceTableTable> {
  $$FenceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$FenceTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $FenceTableTable> {
  $$FenceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> employeeFenceTableRefs<T extends Object>(
      Expression<T> Function($$EmployeeFenceTableTableAnnotationComposer a) f) {
    final $$EmployeeFenceTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeeFenceTable,
            getReferencedColumn: (t) => t.fenceId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeeFenceTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.employeeFenceTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> fencePerimeterTableRefs<T extends Object>(
      Expression<T> Function($$FencePerimeterTableTableAnnotationComposer a)
          f) {
    final $$FencePerimeterTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.fencePerimeterTable,
            getReferencedColumn: (t) => t.fenceId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FencePerimeterTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.fencePerimeterTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$FenceTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $FenceTableTable,
    FenceTableData,
    $$FenceTableTableFilterComposer,
    $$FenceTableTableOrderingComposer,
    $$FenceTableTableAnnotationComposer,
    $$FenceTableTableCreateCompanionBuilder,
    $$FenceTableTableUpdateCompanionBuilder,
    (FenceTableData, $$FenceTableTableReferences),
    FenceTableData,
    PrefetchHooks Function(
        {bool employeeFenceTableRefs, bool fencePerimeterTableRefs})> {
  $$FenceTableTableTableManager(_$CollectorDatabase db, $FenceTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FenceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FenceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FenceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FenceTableCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              FenceTableCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FenceTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {employeeFenceTableRefs = false,
              fencePerimeterTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (employeeFenceTableRefs) db.employeeFenceTable,
                if (fencePerimeterTableRefs) db.fencePerimeterTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (employeeFenceTableRefs)
                    await $_getPrefetchedData<FenceTableData, $FenceTableTable,
                            EmployeeFenceTableData>(
                        currentTable: table,
                        referencedTable: $$FenceTableTableReferences
                            ._employeeFenceTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FenceTableTableReferences(db, table, p0)
                                .employeeFenceTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.fenceId == item.id),
                        typedResults: items),
                  if (fencePerimeterTableRefs)
                    await $_getPrefetchedData<FenceTableData, $FenceTableTable,
                            FencePerimeterTableData>(
                        currentTable: table,
                        referencedTable: $$FenceTableTableReferences
                            ._fencePerimeterTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$FenceTableTableReferences(db, table, p0)
                                .fencePerimeterTableRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.fenceId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$FenceTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $FenceTableTable,
    FenceTableData,
    $$FenceTableTableFilterComposer,
    $$FenceTableTableOrderingComposer,
    $$FenceTableTableAnnotationComposer,
    $$FenceTableTableCreateCompanionBuilder,
    $$FenceTableTableUpdateCompanionBuilder,
    (FenceTableData, $$FenceTableTableReferences),
    FenceTableData,
    PrefetchHooks Function(
        {bool employeeFenceTableRefs, bool fencePerimeterTableRefs})>;
typedef $$PerimeterTableTableCreateCompanionBuilder = PerimeterTableCompanion
    Function({
  required String id,
  required String type,
  required double latitude,
  required double longitude,
  required double radius,
  required DateTime dateAndTime,
  Value<int> rowid,
});
typedef $$PerimeterTableTableUpdateCompanionBuilder = PerimeterTableCompanion
    Function({
  Value<String> id,
  Value<String> type,
  Value<double> latitude,
  Value<double> longitude,
  Value<double> radius,
  Value<DateTime> dateAndTime,
  Value<int> rowid,
});

final class $$PerimeterTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $PerimeterTableTable, PerimeterTableData> {
  $$PerimeterTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$FencePerimeterTableTable,
      List<FencePerimeterTableData>> _fencePerimeterTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.fencePerimeterTable,
          aliasName: $_aliasNameGenerator(
              db.perimeterTable.id, db.fencePerimeterTable.perimeterId));

  $$FencePerimeterTableTableProcessedTableManager get fencePerimeterTableRefs {
    final manager = $$FencePerimeterTableTableTableManager(
            $_db, $_db.fencePerimeterTable)
        .filter((f) => f.perimeterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_fencePerimeterTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PerimeterTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $PerimeterTableTable> {
  $$PerimeterTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get radius => $composableBuilder(
      column: $table.radius, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateAndTime => $composableBuilder(
      column: $table.dateAndTime, builder: (column) => ColumnFilters(column));

  Expression<bool> fencePerimeterTableRefs(
      Expression<bool> Function($$FencePerimeterTableTableFilterComposer f) f) {
    final $$FencePerimeterTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.fencePerimeterTable,
        getReferencedColumn: (t) => t.perimeterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FencePerimeterTableTableFilterComposer(
              $db: $db,
              $table: $db.fencePerimeterTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$PerimeterTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $PerimeterTableTable> {
  $$PerimeterTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get latitude => $composableBuilder(
      column: $table.latitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get longitude => $composableBuilder(
      column: $table.longitude, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get radius => $composableBuilder(
      column: $table.radius, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateAndTime => $composableBuilder(
      column: $table.dateAndTime, builder: (column) => ColumnOrderings(column));
}

class $$PerimeterTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $PerimeterTableTable> {
  $$PerimeterTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get radius =>
      $composableBuilder(column: $table.radius, builder: (column) => column);

  GeneratedColumn<DateTime> get dateAndTime => $composableBuilder(
      column: $table.dateAndTime, builder: (column) => column);

  Expression<T> fencePerimeterTableRefs<T extends Object>(
      Expression<T> Function($$FencePerimeterTableTableAnnotationComposer a)
          f) {
    final $$FencePerimeterTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.fencePerimeterTable,
            getReferencedColumn: (t) => t.perimeterId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$FencePerimeterTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.fencePerimeterTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PerimeterTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $PerimeterTableTable,
    PerimeterTableData,
    $$PerimeterTableTableFilterComposer,
    $$PerimeterTableTableOrderingComposer,
    $$PerimeterTableTableAnnotationComposer,
    $$PerimeterTableTableCreateCompanionBuilder,
    $$PerimeterTableTableUpdateCompanionBuilder,
    (PerimeterTableData, $$PerimeterTableTableReferences),
    PerimeterTableData,
    PrefetchHooks Function({bool fencePerimeterTableRefs})> {
  $$PerimeterTableTableTableManager(
      _$CollectorDatabase db, $PerimeterTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PerimeterTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PerimeterTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PerimeterTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<double> latitude = const Value.absent(),
            Value<double> longitude = const Value.absent(),
            Value<double> radius = const Value.absent(),
            Value<DateTime> dateAndTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PerimeterTableCompanion(
            id: id,
            type: type,
            latitude: latitude,
            longitude: longitude,
            radius: radius,
            dateAndTime: dateAndTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String type,
            required double latitude,
            required double longitude,
            required double radius,
            required DateTime dateAndTime,
            Value<int> rowid = const Value.absent(),
          }) =>
              PerimeterTableCompanion.insert(
            id: id,
            type: type,
            latitude: latitude,
            longitude: longitude,
            radius: radius,
            dateAndTime: dateAndTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PerimeterTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({fencePerimeterTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (fencePerimeterTableRefs) db.fencePerimeterTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (fencePerimeterTableRefs)
                    await $_getPrefetchedData<PerimeterTableData,
                            $PerimeterTableTable, FencePerimeterTableData>(
                        currentTable: table,
                        referencedTable: $$PerimeterTableTableReferences
                            ._fencePerimeterTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PerimeterTableTableReferences(db, table, p0)
                                .fencePerimeterTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.perimeterId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PerimeterTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $PerimeterTableTable,
    PerimeterTableData,
    $$PerimeterTableTableFilterComposer,
    $$PerimeterTableTableOrderingComposer,
    $$PerimeterTableTableAnnotationComposer,
    $$PerimeterTableTableCreateCompanionBuilder,
    $$PerimeterTableTableUpdateCompanionBuilder,
    (PerimeterTableData, $$PerimeterTableTableReferences),
    PerimeterTableData,
    PrefetchHooks Function({bool fencePerimeterTableRefs})>;
typedef $$EmployeeFenceTableTableCreateCompanionBuilder
    = EmployeeFenceTableCompanion Function({
  required String employeeId,
  required String fenceId,
  Value<int> rowid,
});
typedef $$EmployeeFenceTableTableUpdateCompanionBuilder
    = EmployeeFenceTableCompanion Function({
  Value<String> employeeId,
  Value<String> fenceId,
  Value<int> rowid,
});

final class $$EmployeeFenceTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $EmployeeFenceTableTable, EmployeeFenceTableData> {
  $$EmployeeFenceTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.employeeFenceTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FenceTableTable _fenceIdTable(_$CollectorDatabase db) =>
      db.fenceTable.createAlias($_aliasNameGenerator(
          db.employeeFenceTable.fenceId, db.fenceTable.id));

  $$FenceTableTableProcessedTableManager get fenceId {
    final $_column = $_itemColumn<String>('fence_id')!;

    final manager = $$FenceTableTableTableManager($_db, $_db.fenceTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fenceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EmployeeFenceTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $EmployeeFenceTableTable> {
  $$EmployeeFenceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FenceTableTableFilterComposer get fenceId {
    final $$FenceTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fenceId,
        referencedTable: $db.fenceTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FenceTableTableFilterComposer(
              $db: $db,
              $table: $db.fenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeFenceTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $EmployeeFenceTableTable> {
  $$EmployeeFenceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FenceTableTableOrderingComposer get fenceId {
    final $$FenceTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fenceId,
        referencedTable: $db.fenceTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FenceTableTableOrderingComposer(
              $db: $db,
              $table: $db.fenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeFenceTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $EmployeeFenceTableTable> {
  $$EmployeeFenceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FenceTableTableAnnotationComposer get fenceId {
    final $$FenceTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fenceId,
        referencedTable: $db.fenceTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FenceTableTableAnnotationComposer(
              $db: $db,
              $table: $db.fenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeFenceTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $EmployeeFenceTableTable,
    EmployeeFenceTableData,
    $$EmployeeFenceTableTableFilterComposer,
    $$EmployeeFenceTableTableOrderingComposer,
    $$EmployeeFenceTableTableAnnotationComposer,
    $$EmployeeFenceTableTableCreateCompanionBuilder,
    $$EmployeeFenceTableTableUpdateCompanionBuilder,
    (EmployeeFenceTableData, $$EmployeeFenceTableTableReferences),
    EmployeeFenceTableData,
    PrefetchHooks Function({bool employeeId, bool fenceId})> {
  $$EmployeeFenceTableTableTableManager(
      _$CollectorDatabase db, $EmployeeFenceTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeeFenceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeeFenceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeeFenceTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<String> fenceId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeeFenceTableCompanion(
            employeeId: employeeId,
            fenceId: fenceId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required String fenceId,
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeeFenceTableCompanion.insert(
            employeeId: employeeId,
            fenceId: fenceId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EmployeeFenceTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeId = false, fenceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable: $$EmployeeFenceTableTableReferences
                        ._employeeIdTable(db),
                    referencedColumn: $$EmployeeFenceTableTableReferences
                        ._employeeIdTable(db)
                        .id,
                  ) as T;
                }
                if (fenceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fenceId,
                    referencedTable:
                        $$EmployeeFenceTableTableReferences._fenceIdTable(db),
                    referencedColumn: $$EmployeeFenceTableTableReferences
                        ._fenceIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EmployeeFenceTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $EmployeeFenceTableTable,
    EmployeeFenceTableData,
    $$EmployeeFenceTableTableFilterComposer,
    $$EmployeeFenceTableTableOrderingComposer,
    $$EmployeeFenceTableTableAnnotationComposer,
    $$EmployeeFenceTableTableCreateCompanionBuilder,
    $$EmployeeFenceTableTableUpdateCompanionBuilder,
    (EmployeeFenceTableData, $$EmployeeFenceTableTableReferences),
    EmployeeFenceTableData,
    PrefetchHooks Function({bool employeeId, bool fenceId})>;
typedef $$FencePerimeterTableTableCreateCompanionBuilder
    = FencePerimeterTableCompanion Function({
  required String perimeterId,
  required String fenceId,
  Value<int> rowid,
});
typedef $$FencePerimeterTableTableUpdateCompanionBuilder
    = FencePerimeterTableCompanion Function({
  Value<String> perimeterId,
  Value<String> fenceId,
  Value<int> rowid,
});

final class $$FencePerimeterTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $FencePerimeterTableTable, FencePerimeterTableData> {
  $$FencePerimeterTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $PerimeterTableTable _perimeterIdTable(_$CollectorDatabase db) =>
      db.perimeterTable.createAlias($_aliasNameGenerator(
          db.fencePerimeterTable.perimeterId, db.perimeterTable.id));

  $$PerimeterTableTableProcessedTableManager get perimeterId {
    final $_column = $_itemColumn<String>('perimeter_id')!;

    final manager = $$PerimeterTableTableTableManager($_db, $_db.perimeterTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_perimeterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $FenceTableTable _fenceIdTable(_$CollectorDatabase db) =>
      db.fenceTable.createAlias($_aliasNameGenerator(
          db.fencePerimeterTable.fenceId, db.fenceTable.id));

  $$FenceTableTableProcessedTableManager get fenceId {
    final $_column = $_itemColumn<String>('fence_id')!;

    final manager = $$FenceTableTableTableManager($_db, $_db.fenceTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fenceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$FencePerimeterTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $FencePerimeterTableTable> {
  $$FencePerimeterTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PerimeterTableTableFilterComposer get perimeterId {
    final $$PerimeterTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perimeterId,
        referencedTable: $db.perimeterTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PerimeterTableTableFilterComposer(
              $db: $db,
              $table: $db.perimeterTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FenceTableTableFilterComposer get fenceId {
    final $$FenceTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fenceId,
        referencedTable: $db.fenceTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FenceTableTableFilterComposer(
              $db: $db,
              $table: $db.fenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FencePerimeterTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $FencePerimeterTableTable> {
  $$FencePerimeterTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PerimeterTableTableOrderingComposer get perimeterId {
    final $$PerimeterTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perimeterId,
        referencedTable: $db.perimeterTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PerimeterTableTableOrderingComposer(
              $db: $db,
              $table: $db.perimeterTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FenceTableTableOrderingComposer get fenceId {
    final $$FenceTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fenceId,
        referencedTable: $db.fenceTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FenceTableTableOrderingComposer(
              $db: $db,
              $table: $db.fenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FencePerimeterTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $FencePerimeterTableTable> {
  $$FencePerimeterTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$PerimeterTableTableAnnotationComposer get perimeterId {
    final $$PerimeterTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.perimeterId,
        referencedTable: $db.perimeterTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PerimeterTableTableAnnotationComposer(
              $db: $db,
              $table: $db.perimeterTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$FenceTableTableAnnotationComposer get fenceId {
    final $$FenceTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.fenceId,
        referencedTable: $db.fenceTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$FenceTableTableAnnotationComposer(
              $db: $db,
              $table: $db.fenceTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$FencePerimeterTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $FencePerimeterTableTable,
    FencePerimeterTableData,
    $$FencePerimeterTableTableFilterComposer,
    $$FencePerimeterTableTableOrderingComposer,
    $$FencePerimeterTableTableAnnotationComposer,
    $$FencePerimeterTableTableCreateCompanionBuilder,
    $$FencePerimeterTableTableUpdateCompanionBuilder,
    (FencePerimeterTableData, $$FencePerimeterTableTableReferences),
    FencePerimeterTableData,
    PrefetchHooks Function({bool perimeterId, bool fenceId})> {
  $$FencePerimeterTableTableTableManager(
      _$CollectorDatabase db, $FencePerimeterTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FencePerimeterTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FencePerimeterTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FencePerimeterTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> perimeterId = const Value.absent(),
            Value<String> fenceId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FencePerimeterTableCompanion(
            perimeterId: perimeterId,
            fenceId: fenceId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String perimeterId,
            required String fenceId,
            Value<int> rowid = const Value.absent(),
          }) =>
              FencePerimeterTableCompanion.insert(
            perimeterId: perimeterId,
            fenceId: fenceId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$FencePerimeterTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({perimeterId = false, fenceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (perimeterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.perimeterId,
                    referencedTable: $$FencePerimeterTableTableReferences
                        ._perimeterIdTable(db),
                    referencedColumn: $$FencePerimeterTableTableReferences
                        ._perimeterIdTable(db)
                        .id,
                  ) as T;
                }
                if (fenceId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.fenceId,
                    referencedTable:
                        $$FencePerimeterTableTableReferences._fenceIdTable(db),
                    referencedColumn: $$FencePerimeterTableTableReferences
                        ._fenceIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$FencePerimeterTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $FencePerimeterTableTable,
    FencePerimeterTableData,
    $$FencePerimeterTableTableFilterComposer,
    $$FencePerimeterTableTableOrderingComposer,
    $$FencePerimeterTableTableAnnotationComposer,
    $$FencePerimeterTableTableCreateCompanionBuilder,
    $$FencePerimeterTableTableUpdateCompanionBuilder,
    (FencePerimeterTableData, $$FencePerimeterTableTableReferences),
    FencePerimeterTableData,
    PrefetchHooks Function({bool perimeterId, bool fenceId})>;
typedef $$DeviceTableTableCreateCompanionBuilder = DeviceTableCompanion
    Function({
  required String id,
  required String imei,
  Value<String?> name,
  Value<String?> model,
  required String status,
  Value<int> rowid,
});
typedef $$DeviceTableTableUpdateCompanionBuilder = DeviceTableCompanion
    Function({
  Value<String> id,
  Value<String> imei,
  Value<String?> name,
  Value<String?> model,
  Value<String> status,
  Value<int> rowid,
});

class $$DeviceTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $DeviceTableTable> {
  $$DeviceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imei => $composableBuilder(
      column: $table.imei, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));
}

class $$DeviceTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $DeviceTableTable> {
  $$DeviceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imei => $composableBuilder(
      column: $table.imei, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$DeviceTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $DeviceTableTable> {
  $$DeviceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get imei =>
      $composableBuilder(column: $table.imei, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$DeviceTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $DeviceTableTable,
    DeviceTableData,
    $$DeviceTableTableFilterComposer,
    $$DeviceTableTableOrderingComposer,
    $$DeviceTableTableAnnotationComposer,
    $$DeviceTableTableCreateCompanionBuilder,
    $$DeviceTableTableUpdateCompanionBuilder,
    (
      DeviceTableData,
      BaseReferences<_$CollectorDatabase, $DeviceTableTable, DeviceTableData>
    ),
    DeviceTableData,
    PrefetchHooks Function()> {
  $$DeviceTableTableTableManager(
      _$CollectorDatabase db, $DeviceTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> imei = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> model = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceTableCompanion(
            id: id,
            imei: imei,
            name: name,
            model: model,
            status: status,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String imei,
            Value<String?> name = const Value.absent(),
            Value<String?> model = const Value.absent(),
            required String status,
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceTableCompanion.insert(
            id: id,
            imei: imei,
            name: name,
            model: model,
            status: status,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeviceTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $DeviceTableTable,
    DeviceTableData,
    $$DeviceTableTableFilterComposer,
    $$DeviceTableTableOrderingComposer,
    $$DeviceTableTableAnnotationComposer,
    $$DeviceTableTableCreateCompanionBuilder,
    $$DeviceTableTableUpdateCompanionBuilder,
    (
      DeviceTableData,
      BaseReferences<_$CollectorDatabase, $DeviceTableTable, DeviceTableData>
    ),
    DeviceTableData,
    PrefetchHooks Function()>;
typedef $$ActivationTableTableCreateCompanionBuilder = ActivationTableCompanion
    Function({
  required String deviceSituation,
  required String employeeSituation,
  required DateTime requestDateTime,
  required String employeeId,
  Value<int> rowid,
});
typedef $$ActivationTableTableUpdateCompanionBuilder = ActivationTableCompanion
    Function({
  Value<String> deviceSituation,
  Value<String> employeeSituation,
  Value<DateTime> requestDateTime,
  Value<String> employeeId,
  Value<int> rowid,
});

final class $$ActivationTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $ActivationTableTable, ActivationTableData> {
  $$ActivationTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.activationTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ActivationTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ActivationTableTable> {
  $$ActivationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get deviceSituation => $composableBuilder(
      column: $table.deviceSituation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeSituation => $composableBuilder(
      column: $table.employeeSituation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get requestDateTime => $composableBuilder(
      column: $table.requestDateTime,
      builder: (column) => ColumnFilters(column));

  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActivationTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ActivationTableTable> {
  $$ActivationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get deviceSituation => $composableBuilder(
      column: $table.deviceSituation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeSituation => $composableBuilder(
      column: $table.employeeSituation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get requestDateTime => $composableBuilder(
      column: $table.requestDateTime,
      builder: (column) => ColumnOrderings(column));

  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActivationTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ActivationTableTable> {
  $$ActivationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get deviceSituation => $composableBuilder(
      column: $table.deviceSituation, builder: (column) => column);

  GeneratedColumn<String> get employeeSituation => $composableBuilder(
      column: $table.employeeSituation, builder: (column) => column);

  GeneratedColumn<DateTime> get requestDateTime => $composableBuilder(
      column: $table.requestDateTime, builder: (column) => column);

  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ActivationTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ActivationTableTable,
    ActivationTableData,
    $$ActivationTableTableFilterComposer,
    $$ActivationTableTableOrderingComposer,
    $$ActivationTableTableAnnotationComposer,
    $$ActivationTableTableCreateCompanionBuilder,
    $$ActivationTableTableUpdateCompanionBuilder,
    (ActivationTableData, $$ActivationTableTableReferences),
    ActivationTableData,
    PrefetchHooks Function({bool employeeId})> {
  $$ActivationTableTableTableManager(
      _$CollectorDatabase db, $ActivationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivationTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> deviceSituation = const Value.absent(),
            Value<String> employeeSituation = const Value.absent(),
            Value<DateTime> requestDateTime = const Value.absent(),
            Value<String> employeeId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivationTableCompanion(
            deviceSituation: deviceSituation,
            employeeSituation: employeeSituation,
            requestDateTime: requestDateTime,
            employeeId: employeeId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String deviceSituation,
            required String employeeSituation,
            required DateTime requestDateTime,
            required String employeeId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivationTableCompanion.insert(
            deviceSituation: deviceSituation,
            employeeSituation: employeeSituation,
            requestDateTime: requestDateTime,
            employeeId: employeeId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ActivationTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable:
                        $$ActivationTableTableReferences._employeeIdTable(db),
                    referencedColumn: $$ActivationTableTableReferences
                        ._employeeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ActivationTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $ActivationTableTable,
    ActivationTableData,
    $$ActivationTableTableFilterComposer,
    $$ActivationTableTableOrderingComposer,
    $$ActivationTableTableAnnotationComposer,
    $$ActivationTableTableCreateCompanionBuilder,
    $$ActivationTableTableUpdateCompanionBuilder,
    (ActivationTableData, $$ActivationTableTableReferences),
    ActivationTableData,
    PrefetchHooks Function({bool employeeId})>;
typedef $$ApplicationTableTableCreateCompanionBuilder
    = ApplicationTableCompanion Function({
  required String tenantName,
  required String accessKey,
  required String secret,
  Value<DateTime?> lastUpdate,
  Value<int> rowid,
});
typedef $$ApplicationTableTableUpdateCompanionBuilder
    = ApplicationTableCompanion Function({
  Value<String> tenantName,
  Value<String> accessKey,
  Value<String> secret,
  Value<DateTime?> lastUpdate,
  Value<int> rowid,
});

class $$ApplicationTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ApplicationTableTable> {
  $$ApplicationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get tenantName => $composableBuilder(
      column: $table.tenantName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get accessKey => $composableBuilder(
      column: $table.accessKey, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get secret => $composableBuilder(
      column: $table.secret, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnFilters(column));
}

class $$ApplicationTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ApplicationTableTable> {
  $$ApplicationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get tenantName => $composableBuilder(
      column: $table.tenantName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get accessKey => $composableBuilder(
      column: $table.accessKey, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get secret => $composableBuilder(
      column: $table.secret, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnOrderings(column));
}

class $$ApplicationTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ApplicationTableTable> {
  $$ApplicationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get tenantName => $composableBuilder(
      column: $table.tenantName, builder: (column) => column);

  GeneratedColumn<String> get accessKey =>
      $composableBuilder(column: $table.accessKey, builder: (column) => column);

  GeneratedColumn<String> get secret =>
      $composableBuilder(column: $table.secret, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => column);
}

class $$ApplicationTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ApplicationTableTable,
    ApplicationTableData,
    $$ApplicationTableTableFilterComposer,
    $$ApplicationTableTableOrderingComposer,
    $$ApplicationTableTableAnnotationComposer,
    $$ApplicationTableTableCreateCompanionBuilder,
    $$ApplicationTableTableUpdateCompanionBuilder,
    (
      ApplicationTableData,
      BaseReferences<_$CollectorDatabase, $ApplicationTableTable,
          ApplicationTableData>
    ),
    ApplicationTableData,
    PrefetchHooks Function()> {
  $$ApplicationTableTableTableManager(
      _$CollectorDatabase db, $ApplicationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApplicationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApplicationTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> tenantName = const Value.absent(),
            Value<String> accessKey = const Value.absent(),
            Value<String> secret = const Value.absent(),
            Value<DateTime?> lastUpdate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ApplicationTableCompanion(
            tenantName: tenantName,
            accessKey: accessKey,
            secret: secret,
            lastUpdate: lastUpdate,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String tenantName,
            required String accessKey,
            required String secret,
            Value<DateTime?> lastUpdate = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ApplicationTableCompanion.insert(
            tenantName: tenantName,
            accessKey: accessKey,
            secret: secret,
            lastUpdate: lastUpdate,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ApplicationTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $ApplicationTableTable,
    ApplicationTableData,
    $$ApplicationTableTableFilterComposer,
    $$ApplicationTableTableOrderingComposer,
    $$ApplicationTableTableAnnotationComposer,
    $$ApplicationTableTableCreateCompanionBuilder,
    $$ApplicationTableTableUpdateCompanionBuilder,
    (
      ApplicationTableData,
      BaseReferences<_$CollectorDatabase, $ApplicationTableTable,
          ApplicationTableData>
    ),
    ApplicationTableData,
    PrefetchHooks Function()>;
typedef $$DeviceConfigurationTableTableCreateCompanionBuilder
    = DeviceConfigurationTableCompanion Function({
  required String id,
  required bool enableNfc,
  required bool enableQrCode,
  required bool enableFacial,
  required String timeZone,
  required DateTime lastUpdate,
  required bool takePhotoMulti,
  required DateTime lastSync,
  Value<bool?> enableUserPassword,
  Value<bool?> allowChangeTime,
  Value<int> rowid,
});
typedef $$DeviceConfigurationTableTableUpdateCompanionBuilder
    = DeviceConfigurationTableCompanion Function({
  Value<String> id,
  Value<bool> enableNfc,
  Value<bool> enableQrCode,
  Value<bool> enableFacial,
  Value<String> timeZone,
  Value<DateTime> lastUpdate,
  Value<bool> takePhotoMulti,
  Value<DateTime> lastSync,
  Value<bool?> enableUserPassword,
  Value<bool?> allowChangeTime,
  Value<int> rowid,
});

class $$DeviceConfigurationTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $DeviceConfigurationTableTable> {
  $$DeviceConfigurationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableNfc => $composableBuilder(
      column: $table.enableNfc, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableQrCode => $composableBuilder(
      column: $table.enableQrCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableFacial => $composableBuilder(
      column: $table.enableFacial, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeZone => $composableBuilder(
      column: $table.timeZone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoMulti => $composableBuilder(
      column: $table.takePhotoMulti,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enableUserPassword => $composableBuilder(
      column: $table.enableUserPassword,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime,
      builder: (column) => ColumnFilters(column));
}

class $$DeviceConfigurationTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $DeviceConfigurationTableTable> {
  $$DeviceConfigurationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableNfc => $composableBuilder(
      column: $table.enableNfc, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableQrCode => $composableBuilder(
      column: $table.enableQrCode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableFacial => $composableBuilder(
      column: $table.enableFacial,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeZone => $composableBuilder(
      column: $table.timeZone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoMulti => $composableBuilder(
      column: $table.takePhotoMulti,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enableUserPassword => $composableBuilder(
      column: $table.enableUserPassword,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime,
      builder: (column) => ColumnOrderings(column));
}

class $$DeviceConfigurationTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $DeviceConfigurationTableTable> {
  $$DeviceConfigurationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get enableNfc =>
      $composableBuilder(column: $table.enableNfc, builder: (column) => column);

  GeneratedColumn<bool> get enableQrCode => $composableBuilder(
      column: $table.enableQrCode, builder: (column) => column);

  GeneratedColumn<bool> get enableFacial => $composableBuilder(
      column: $table.enableFacial, builder: (column) => column);

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoMulti => $composableBuilder(
      column: $table.takePhotoMulti, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<bool> get enableUserPassword => $composableBuilder(
      column: $table.enableUserPassword, builder: (column) => column);

  GeneratedColumn<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime, builder: (column) => column);
}

class $$DeviceConfigurationTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $DeviceConfigurationTableTable,
    DeviceConfigurationTableData,
    $$DeviceConfigurationTableTableFilterComposer,
    $$DeviceConfigurationTableTableOrderingComposer,
    $$DeviceConfigurationTableTableAnnotationComposer,
    $$DeviceConfigurationTableTableCreateCompanionBuilder,
    $$DeviceConfigurationTableTableUpdateCompanionBuilder,
    (
      DeviceConfigurationTableData,
      BaseReferences<_$CollectorDatabase, $DeviceConfigurationTableTable,
          DeviceConfigurationTableData>
    ),
    DeviceConfigurationTableData,
    PrefetchHooks Function()> {
  $$DeviceConfigurationTableTableTableManager(
      _$CollectorDatabase db, $DeviceConfigurationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceConfigurationTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceConfigurationTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceConfigurationTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<bool> enableNfc = const Value.absent(),
            Value<bool> enableQrCode = const Value.absent(),
            Value<bool> enableFacial = const Value.absent(),
            Value<String> timeZone = const Value.absent(),
            Value<DateTime> lastUpdate = const Value.absent(),
            Value<bool> takePhotoMulti = const Value.absent(),
            Value<DateTime> lastSync = const Value.absent(),
            Value<bool?> enableUserPassword = const Value.absent(),
            Value<bool?> allowChangeTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceConfigurationTableCompanion(
            id: id,
            enableNfc: enableNfc,
            enableQrCode: enableQrCode,
            enableFacial: enableFacial,
            timeZone: timeZone,
            lastUpdate: lastUpdate,
            takePhotoMulti: takePhotoMulti,
            lastSync: lastSync,
            enableUserPassword: enableUserPassword,
            allowChangeTime: allowChangeTime,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required bool enableNfc,
            required bool enableQrCode,
            required bool enableFacial,
            required String timeZone,
            required DateTime lastUpdate,
            required bool takePhotoMulti,
            required DateTime lastSync,
            Value<bool?> enableUserPassword = const Value.absent(),
            Value<bool?> allowChangeTime = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DeviceConfigurationTableCompanion.insert(
            id: id,
            enableNfc: enableNfc,
            enableQrCode: enableQrCode,
            enableFacial: enableFacial,
            timeZone: timeZone,
            lastUpdate: lastUpdate,
            takePhotoMulti: takePhotoMulti,
            lastSync: lastSync,
            enableUserPassword: enableUserPassword,
            allowChangeTime: allowChangeTime,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DeviceConfigurationTableTableProcessedTableManager
    = ProcessedTableManager<
        _$CollectorDatabase,
        $DeviceConfigurationTableTable,
        DeviceConfigurationTableData,
        $$DeviceConfigurationTableTableFilterComposer,
        $$DeviceConfigurationTableTableOrderingComposer,
        $$DeviceConfigurationTableTableAnnotationComposer,
        $$DeviceConfigurationTableTableCreateCompanionBuilder,
        $$DeviceConfigurationTableTableUpdateCompanionBuilder,
        (
          DeviceConfigurationTableData,
          BaseReferences<_$CollectorDatabase, $DeviceConfigurationTableTable,
              DeviceConfigurationTableData>
        ),
        DeviceConfigurationTableData,
        PrefetchHooks Function()>;
typedef $$GlobalConfigurationTableTableCreateCompanionBuilder
    = GlobalConfigurationTableCompanion Function({
  required String id,
  Value<bool?> gps,
  Value<bool?> online,
  Value<String?> timeout,
  Value<String?> operationMode,
  Value<bool?> nfcMode,
  Value<bool?> allowChangeTime,
  Value<String?> timezone,
  Value<String?> deviceAuthModeSingleMode,
  Value<String?> deviceAuthModeMultiMode,
  Value<String?> deviceAuthModeDriverMode,
  Value<bool?> allowDrivingTime,
  Value<bool?> overnight,
  Value<bool?> controlOvernight,
  Value<bool?> allowGpoOnApp,
  Value<bool?> exportNotChecked,
  Value<String?> insightOutOfBound,
  Value<bool?> takePhotoSingle,
  Value<bool?> takePhotoMulti,
  Value<bool?> takePhotoDriver,
  Value<bool?> takePhotoQrcode,
  Value<bool?> takePhotoNfc,
  Value<bool?> openExternalBrowser,
  Value<String?> clockingEventUses,
  Value<bool?> allowUse,
  Value<bool> externalControlTimezone,
  Value<bool> faceRecognition,
  Value<int> rowid,
});
typedef $$GlobalConfigurationTableTableUpdateCompanionBuilder
    = GlobalConfigurationTableCompanion Function({
  Value<String> id,
  Value<bool?> gps,
  Value<bool?> online,
  Value<String?> timeout,
  Value<String?> operationMode,
  Value<bool?> nfcMode,
  Value<bool?> allowChangeTime,
  Value<String?> timezone,
  Value<String?> deviceAuthModeSingleMode,
  Value<String?> deviceAuthModeMultiMode,
  Value<String?> deviceAuthModeDriverMode,
  Value<bool?> allowDrivingTime,
  Value<bool?> overnight,
  Value<bool?> controlOvernight,
  Value<bool?> allowGpoOnApp,
  Value<bool?> exportNotChecked,
  Value<String?> insightOutOfBound,
  Value<bool?> takePhotoSingle,
  Value<bool?> takePhotoMulti,
  Value<bool?> takePhotoDriver,
  Value<bool?> takePhotoQrcode,
  Value<bool?> takePhotoNfc,
  Value<bool?> openExternalBrowser,
  Value<String?> clockingEventUses,
  Value<bool?> allowUse,
  Value<bool> externalControlTimezone,
  Value<bool> faceRecognition,
  Value<int> rowid,
});

class $$GlobalConfigurationTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $GlobalConfigurationTableTable> {
  $$GlobalConfigurationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get gps => $composableBuilder(
      column: $table.gps, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get online => $composableBuilder(
      column: $table.online, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeout => $composableBuilder(
      column: $table.timeout, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operationMode => $composableBuilder(
      column: $table.operationMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get nfcMode => $composableBuilder(
      column: $table.nfcMode, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAuthModeSingleMode => $composableBuilder(
      column: $table.deviceAuthModeSingleMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAuthModeMultiMode => $composableBuilder(
      column: $table.deviceAuthModeMultiMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceAuthModeDriverMode => $composableBuilder(
      column: $table.deviceAuthModeDriverMode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowDrivingTime => $composableBuilder(
      column: $table.allowDrivingTime,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get overnight => $composableBuilder(
      column: $table.overnight, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get controlOvernight => $composableBuilder(
      column: $table.controlOvernight,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowGpoOnApp => $composableBuilder(
      column: $table.allowGpoOnApp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get exportNotChecked => $composableBuilder(
      column: $table.exportNotChecked,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get insightOutOfBound => $composableBuilder(
      column: $table.insightOutOfBound,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoSingle => $composableBuilder(
      column: $table.takePhotoSingle,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoMulti => $composableBuilder(
      column: $table.takePhotoMulti,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoDriver => $composableBuilder(
      column: $table.takePhotoDriver,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoQrcode => $composableBuilder(
      column: $table.takePhotoQrcode,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get takePhotoNfc => $composableBuilder(
      column: $table.takePhotoNfc, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get openExternalBrowser => $composableBuilder(
      column: $table.openExternalBrowser,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clockingEventUses => $composableBuilder(
      column: $table.clockingEventUses,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowUse => $composableBuilder(
      column: $table.allowUse, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get externalControlTimezone => $composableBuilder(
      column: $table.externalControlTimezone,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get faceRecognition => $composableBuilder(
      column: $table.faceRecognition,
      builder: (column) => ColumnFilters(column));
}

class $$GlobalConfigurationTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $GlobalConfigurationTableTable> {
  $$GlobalConfigurationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get gps => $composableBuilder(
      column: $table.gps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get online => $composableBuilder(
      column: $table.online, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeout => $composableBuilder(
      column: $table.timeout, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operationMode => $composableBuilder(
      column: $table.operationMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get nfcMode => $composableBuilder(
      column: $table.nfcMode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timezone => $composableBuilder(
      column: $table.timezone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAuthModeSingleMode => $composableBuilder(
      column: $table.deviceAuthModeSingleMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAuthModeMultiMode => $composableBuilder(
      column: $table.deviceAuthModeMultiMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceAuthModeDriverMode => $composableBuilder(
      column: $table.deviceAuthModeDriverMode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowDrivingTime => $composableBuilder(
      column: $table.allowDrivingTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get overnight => $composableBuilder(
      column: $table.overnight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get controlOvernight => $composableBuilder(
      column: $table.controlOvernight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowGpoOnApp => $composableBuilder(
      column: $table.allowGpoOnApp,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get exportNotChecked => $composableBuilder(
      column: $table.exportNotChecked,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get insightOutOfBound => $composableBuilder(
      column: $table.insightOutOfBound,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoSingle => $composableBuilder(
      column: $table.takePhotoSingle,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoMulti => $composableBuilder(
      column: $table.takePhotoMulti,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoDriver => $composableBuilder(
      column: $table.takePhotoDriver,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoQrcode => $composableBuilder(
      column: $table.takePhotoQrcode,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get takePhotoNfc => $composableBuilder(
      column: $table.takePhotoNfc,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get openExternalBrowser => $composableBuilder(
      column: $table.openExternalBrowser,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clockingEventUses => $composableBuilder(
      column: $table.clockingEventUses,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowUse => $composableBuilder(
      column: $table.allowUse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get externalControlTimezone => $composableBuilder(
      column: $table.externalControlTimezone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get faceRecognition => $composableBuilder(
      column: $table.faceRecognition,
      builder: (column) => ColumnOrderings(column));
}

class $$GlobalConfigurationTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $GlobalConfigurationTableTable> {
  $$GlobalConfigurationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get gps =>
      $composableBuilder(column: $table.gps, builder: (column) => column);

  GeneratedColumn<bool> get online =>
      $composableBuilder(column: $table.online, builder: (column) => column);

  GeneratedColumn<String> get timeout =>
      $composableBuilder(column: $table.timeout, builder: (column) => column);

  GeneratedColumn<String> get operationMode => $composableBuilder(
      column: $table.operationMode, builder: (column) => column);

  GeneratedColumn<bool> get nfcMode =>
      $composableBuilder(column: $table.nfcMode, builder: (column) => column);

  GeneratedColumn<bool> get allowChangeTime => $composableBuilder(
      column: $table.allowChangeTime, builder: (column) => column);

  GeneratedColumn<String> get timezone =>
      $composableBuilder(column: $table.timezone, builder: (column) => column);

  GeneratedColumn<String> get deviceAuthModeSingleMode => $composableBuilder(
      column: $table.deviceAuthModeSingleMode, builder: (column) => column);

  GeneratedColumn<String> get deviceAuthModeMultiMode => $composableBuilder(
      column: $table.deviceAuthModeMultiMode, builder: (column) => column);

  GeneratedColumn<String> get deviceAuthModeDriverMode => $composableBuilder(
      column: $table.deviceAuthModeDriverMode, builder: (column) => column);

  GeneratedColumn<bool> get allowDrivingTime => $composableBuilder(
      column: $table.allowDrivingTime, builder: (column) => column);

  GeneratedColumn<bool> get overnight =>
      $composableBuilder(column: $table.overnight, builder: (column) => column);

  GeneratedColumn<bool> get controlOvernight => $composableBuilder(
      column: $table.controlOvernight, builder: (column) => column);

  GeneratedColumn<bool> get allowGpoOnApp => $composableBuilder(
      column: $table.allowGpoOnApp, builder: (column) => column);

  GeneratedColumn<bool> get exportNotChecked => $composableBuilder(
      column: $table.exportNotChecked, builder: (column) => column);

  GeneratedColumn<String> get insightOutOfBound => $composableBuilder(
      column: $table.insightOutOfBound, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoSingle => $composableBuilder(
      column: $table.takePhotoSingle, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoMulti => $composableBuilder(
      column: $table.takePhotoMulti, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoDriver => $composableBuilder(
      column: $table.takePhotoDriver, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoQrcode => $composableBuilder(
      column: $table.takePhotoQrcode, builder: (column) => column);

  GeneratedColumn<bool> get takePhotoNfc => $composableBuilder(
      column: $table.takePhotoNfc, builder: (column) => column);

  GeneratedColumn<bool> get openExternalBrowser => $composableBuilder(
      column: $table.openExternalBrowser, builder: (column) => column);

  GeneratedColumn<String> get clockingEventUses => $composableBuilder(
      column: $table.clockingEventUses, builder: (column) => column);

  GeneratedColumn<bool> get allowUse =>
      $composableBuilder(column: $table.allowUse, builder: (column) => column);

  GeneratedColumn<bool> get externalControlTimezone => $composableBuilder(
      column: $table.externalControlTimezone, builder: (column) => column);

  GeneratedColumn<bool> get faceRecognition => $composableBuilder(
      column: $table.faceRecognition, builder: (column) => column);
}

class $$GlobalConfigurationTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $GlobalConfigurationTableTable,
    GlobalConfigurationTableData,
    $$GlobalConfigurationTableTableFilterComposer,
    $$GlobalConfigurationTableTableOrderingComposer,
    $$GlobalConfigurationTableTableAnnotationComposer,
    $$GlobalConfigurationTableTableCreateCompanionBuilder,
    $$GlobalConfigurationTableTableUpdateCompanionBuilder,
    (
      GlobalConfigurationTableData,
      BaseReferences<_$CollectorDatabase, $GlobalConfigurationTableTable,
          GlobalConfigurationTableData>
    ),
    GlobalConfigurationTableData,
    PrefetchHooks Function()> {
  $$GlobalConfigurationTableTableTableManager(
      _$CollectorDatabase db, $GlobalConfigurationTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlobalConfigurationTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$GlobalConfigurationTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlobalConfigurationTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<bool?> gps = const Value.absent(),
            Value<bool?> online = const Value.absent(),
            Value<String?> timeout = const Value.absent(),
            Value<String?> operationMode = const Value.absent(),
            Value<bool?> nfcMode = const Value.absent(),
            Value<bool?> allowChangeTime = const Value.absent(),
            Value<String?> timezone = const Value.absent(),
            Value<String?> deviceAuthModeSingleMode = const Value.absent(),
            Value<String?> deviceAuthModeMultiMode = const Value.absent(),
            Value<String?> deviceAuthModeDriverMode = const Value.absent(),
            Value<bool?> allowDrivingTime = const Value.absent(),
            Value<bool?> overnight = const Value.absent(),
            Value<bool?> controlOvernight = const Value.absent(),
            Value<bool?> allowGpoOnApp = const Value.absent(),
            Value<bool?> exportNotChecked = const Value.absent(),
            Value<String?> insightOutOfBound = const Value.absent(),
            Value<bool?> takePhotoSingle = const Value.absent(),
            Value<bool?> takePhotoMulti = const Value.absent(),
            Value<bool?> takePhotoDriver = const Value.absent(),
            Value<bool?> takePhotoQrcode = const Value.absent(),
            Value<bool?> takePhotoNfc = const Value.absent(),
            Value<bool?> openExternalBrowser = const Value.absent(),
            Value<String?> clockingEventUses = const Value.absent(),
            Value<bool?> allowUse = const Value.absent(),
            Value<bool> externalControlTimezone = const Value.absent(),
            Value<bool> faceRecognition = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GlobalConfigurationTableCompanion(
            id: id,
            gps: gps,
            online: online,
            timeout: timeout,
            operationMode: operationMode,
            nfcMode: nfcMode,
            allowChangeTime: allowChangeTime,
            timezone: timezone,
            deviceAuthModeSingleMode: deviceAuthModeSingleMode,
            deviceAuthModeMultiMode: deviceAuthModeMultiMode,
            deviceAuthModeDriverMode: deviceAuthModeDriverMode,
            allowDrivingTime: allowDrivingTime,
            overnight: overnight,
            controlOvernight: controlOvernight,
            allowGpoOnApp: allowGpoOnApp,
            exportNotChecked: exportNotChecked,
            insightOutOfBound: insightOutOfBound,
            takePhotoSingle: takePhotoSingle,
            takePhotoMulti: takePhotoMulti,
            takePhotoDriver: takePhotoDriver,
            takePhotoQrcode: takePhotoQrcode,
            takePhotoNfc: takePhotoNfc,
            openExternalBrowser: openExternalBrowser,
            clockingEventUses: clockingEventUses,
            allowUse: allowUse,
            externalControlTimezone: externalControlTimezone,
            faceRecognition: faceRecognition,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<bool?> gps = const Value.absent(),
            Value<bool?> online = const Value.absent(),
            Value<String?> timeout = const Value.absent(),
            Value<String?> operationMode = const Value.absent(),
            Value<bool?> nfcMode = const Value.absent(),
            Value<bool?> allowChangeTime = const Value.absent(),
            Value<String?> timezone = const Value.absent(),
            Value<String?> deviceAuthModeSingleMode = const Value.absent(),
            Value<String?> deviceAuthModeMultiMode = const Value.absent(),
            Value<String?> deviceAuthModeDriverMode = const Value.absent(),
            Value<bool?> allowDrivingTime = const Value.absent(),
            Value<bool?> overnight = const Value.absent(),
            Value<bool?> controlOvernight = const Value.absent(),
            Value<bool?> allowGpoOnApp = const Value.absent(),
            Value<bool?> exportNotChecked = const Value.absent(),
            Value<String?> insightOutOfBound = const Value.absent(),
            Value<bool?> takePhotoSingle = const Value.absent(),
            Value<bool?> takePhotoMulti = const Value.absent(),
            Value<bool?> takePhotoDriver = const Value.absent(),
            Value<bool?> takePhotoQrcode = const Value.absent(),
            Value<bool?> takePhotoNfc = const Value.absent(),
            Value<bool?> openExternalBrowser = const Value.absent(),
            Value<String?> clockingEventUses = const Value.absent(),
            Value<bool?> allowUse = const Value.absent(),
            Value<bool> externalControlTimezone = const Value.absent(),
            Value<bool> faceRecognition = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GlobalConfigurationTableCompanion.insert(
            id: id,
            gps: gps,
            online: online,
            timeout: timeout,
            operationMode: operationMode,
            nfcMode: nfcMode,
            allowChangeTime: allowChangeTime,
            timezone: timezone,
            deviceAuthModeSingleMode: deviceAuthModeSingleMode,
            deviceAuthModeMultiMode: deviceAuthModeMultiMode,
            deviceAuthModeDriverMode: deviceAuthModeDriverMode,
            allowDrivingTime: allowDrivingTime,
            overnight: overnight,
            controlOvernight: controlOvernight,
            allowGpoOnApp: allowGpoOnApp,
            exportNotChecked: exportNotChecked,
            insightOutOfBound: insightOutOfBound,
            takePhotoSingle: takePhotoSingle,
            takePhotoMulti: takePhotoMulti,
            takePhotoDriver: takePhotoDriver,
            takePhotoQrcode: takePhotoQrcode,
            takePhotoNfc: takePhotoNfc,
            openExternalBrowser: openExternalBrowser,
            clockingEventUses: clockingEventUses,
            allowUse: allowUse,
            externalControlTimezone: externalControlTimezone,
            faceRecognition: faceRecognition,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GlobalConfigurationTableTableProcessedTableManager
    = ProcessedTableManager<
        _$CollectorDatabase,
        $GlobalConfigurationTableTable,
        GlobalConfigurationTableData,
        $$GlobalConfigurationTableTableFilterComposer,
        $$GlobalConfigurationTableTableOrderingComposer,
        $$GlobalConfigurationTableTableAnnotationComposer,
        $$GlobalConfigurationTableTableCreateCompanionBuilder,
        $$GlobalConfigurationTableTableUpdateCompanionBuilder,
        (
          GlobalConfigurationTableData,
          BaseReferences<_$CollectorDatabase, $GlobalConfigurationTableTable,
              GlobalConfigurationTableData>
        ),
        GlobalConfigurationTableData,
        PrefetchHooks Function()>;
typedef $$ManagerTableTableCreateCompanionBuilder = ManagerTableCompanion
    Function({
  required String id,
  Value<String?> mail,
  Value<String?> platformUserName,
  Value<int> rowid,
});
typedef $$ManagerTableTableUpdateCompanionBuilder = ManagerTableCompanion
    Function({
  Value<String> id,
  Value<String?> mail,
  Value<String?> platformUserName,
  Value<int> rowid,
});

final class $$ManagerTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $ManagerTableTable, ManagerTableData> {
  $$ManagerTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EmployeeManagersTableTable,
      List<EmployeeManagersTableData>> _employeeManagersTableRefsTable(
          _$CollectorDatabase db) =>
      MultiTypedResultKey.fromTable(db.employeeManagersTable,
          aliasName: $_aliasNameGenerator(
              db.managerTable.id, db.employeeManagersTable.managerId));

  $$EmployeeManagersTableTableProcessedTableManager
      get employeeManagersTableRefs {
    final manager = $$EmployeeManagersTableTableTableManager(
            $_db, $_db.employeeManagersTable)
        .filter((f) => f.managerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_employeeManagersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ManagersPlatformUsersTableTable,
          List<ManagersPlatformUsersTableData>>
      _managersPlatformUsersTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.managersPlatformUsersTable,
              aliasName: $_aliasNameGenerator(
                  db.managerTable.id, db.managersPlatformUsersTable.managerId));

  $$ManagersPlatformUsersTableTableProcessedTableManager
      get managersPlatformUsersTableRefs {
    final manager = $$ManagersPlatformUsersTableTableTableManager(
            $_db, $_db.managersPlatformUsersTable)
        .filter((f) => f.managerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_managersPlatformUsersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ManagerTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ManagerTableTable> {
  $$ManagerTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mail => $composableBuilder(
      column: $table.mail, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get platformUserName => $composableBuilder(
      column: $table.platformUserName,
      builder: (column) => ColumnFilters(column));

  Expression<bool> employeeManagersTableRefs(
      Expression<bool> Function($$EmployeeManagersTableTableFilterComposer f)
          f) {
    final $$EmployeeManagersTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeeManagersTable,
            getReferencedColumn: (t) => t.managerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeeManagersTableTableFilterComposer(
                  $db: $db,
                  $table: $db.employeeManagersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> managersPlatformUsersTableRefs(
      Expression<bool> Function(
              $$ManagersPlatformUsersTableTableFilterComposer f)
          f) {
    final $$ManagersPlatformUsersTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.managersPlatformUsersTable,
            getReferencedColumn: (t) => t.managerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ManagersPlatformUsersTableTableFilterComposer(
                  $db: $db,
                  $table: $db.managersPlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ManagerTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ManagerTableTable> {
  $$ManagerTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mail => $composableBuilder(
      column: $table.mail, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get platformUserName => $composableBuilder(
      column: $table.platformUserName,
      builder: (column) => ColumnOrderings(column));
}

class $$ManagerTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ManagerTableTable> {
  $$ManagerTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mail =>
      $composableBuilder(column: $table.mail, builder: (column) => column);

  GeneratedColumn<String> get platformUserName => $composableBuilder(
      column: $table.platformUserName, builder: (column) => column);

  Expression<T> employeeManagersTableRefs<T extends Object>(
      Expression<T> Function($$EmployeeManagersTableTableAnnotationComposer a)
          f) {
    final $$EmployeeManagersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeeManagersTable,
            getReferencedColumn: (t) => t.managerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeeManagersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.employeeManagersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> managersPlatformUsersTableRefs<T extends Object>(
      Expression<T> Function(
              $$ManagersPlatformUsersTableTableAnnotationComposer a)
          f) {
    final $$ManagersPlatformUsersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.managersPlatformUsersTable,
            getReferencedColumn: (t) => t.managerId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ManagersPlatformUsersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.managersPlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$ManagerTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ManagerTableTable,
    ManagerTableData,
    $$ManagerTableTableFilterComposer,
    $$ManagerTableTableOrderingComposer,
    $$ManagerTableTableAnnotationComposer,
    $$ManagerTableTableCreateCompanionBuilder,
    $$ManagerTableTableUpdateCompanionBuilder,
    (ManagerTableData, $$ManagerTableTableReferences),
    ManagerTableData,
    PrefetchHooks Function(
        {bool employeeManagersTableRefs,
        bool managersPlatformUsersTableRefs})> {
  $$ManagerTableTableTableManager(
      _$CollectorDatabase db, $ManagerTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ManagerTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ManagerTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ManagerTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> mail = const Value.absent(),
            Value<String?> platformUserName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ManagerTableCompanion(
            id: id,
            mail: mail,
            platformUserName: platformUserName,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> mail = const Value.absent(),
            Value<String?> platformUserName = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ManagerTableCompanion.insert(
            id: id,
            mail: mail,
            platformUserName: platformUserName,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ManagerTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {employeeManagersTableRefs = false,
              managersPlatformUsersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (employeeManagersTableRefs) db.employeeManagersTable,
                if (managersPlatformUsersTableRefs)
                  db.managersPlatformUsersTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (employeeManagersTableRefs)
                    await $_getPrefetchedData<ManagerTableData,
                            $ManagerTableTable, EmployeeManagersTableData>(
                        currentTable: table,
                        referencedTable: $$ManagerTableTableReferences
                            ._employeeManagersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ManagerTableTableReferences(db, table, p0)
                                .employeeManagersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.managerId == item.id),
                        typedResults: items),
                  if (managersPlatformUsersTableRefs)
                    await $_getPrefetchedData<ManagerTableData,
                            $ManagerTableTable, ManagersPlatformUsersTableData>(
                        currentTable: table,
                        referencedTable: $$ManagerTableTableReferences
                            ._managersPlatformUsersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ManagerTableTableReferences(db, table, p0)
                                .managersPlatformUsersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.managerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ManagerTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $ManagerTableTable,
    ManagerTableData,
    $$ManagerTableTableFilterComposer,
    $$ManagerTableTableOrderingComposer,
    $$ManagerTableTableAnnotationComposer,
    $$ManagerTableTableCreateCompanionBuilder,
    $$ManagerTableTableUpdateCompanionBuilder,
    (ManagerTableData, $$ManagerTableTableReferences),
    ManagerTableData,
    PrefetchHooks Function(
        {bool employeeManagersTableRefs, bool managersPlatformUsersTableRefs})>;
typedef $$PlatformUsersTableTableCreateCompanionBuilder
    = PlatformUsersTableCompanion Function({
  required String id,
  required String name,
  Value<int> rowid,
});
typedef $$PlatformUsersTableTableUpdateCompanionBuilder
    = PlatformUsersTableCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<int> rowid,
});

final class $$PlatformUsersTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $PlatformUsersTableTable, PlatformUsersTableData> {
  $$PlatformUsersTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EmployeePlatformUsersTableTable,
          List<EmployeePlatformUsersTableData>>
      _employeePlatformUsersTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.employeePlatformUsersTable,
              aliasName: $_aliasNameGenerator(db.platformUsersTable.id,
                  db.employeePlatformUsersTable.platforUsersId));

  $$EmployeePlatformUsersTableTableProcessedTableManager
      get employeePlatformUsersTableRefs {
    final manager = $$EmployeePlatformUsersTableTableTableManager(
            $_db, $_db.employeePlatformUsersTable)
        .filter(
            (f) => f.platforUsersId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_employeePlatformUsersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ManagersPlatformUsersTableTable,
          List<ManagersPlatformUsersTableData>>
      _managersPlatformUsersTableRefsTable(_$CollectorDatabase db) =>
          MultiTypedResultKey.fromTable(db.managersPlatformUsersTable,
              aliasName: $_aliasNameGenerator(db.platformUsersTable.id,
                  db.managersPlatformUsersTable.platforUsersId));

  $$ManagersPlatformUsersTableTableProcessedTableManager
      get managersPlatformUsersTableRefs {
    final manager = $$ManagersPlatformUsersTableTableTableManager(
            $_db, $_db.managersPlatformUsersTable)
        .filter(
            (f) => f.platforUsersId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult
        .readTableOrNull(_managersPlatformUsersTableRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PlatformUsersTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $PlatformUsersTableTable> {
  $$PlatformUsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  Expression<bool> employeePlatformUsersTableRefs(
      Expression<bool> Function(
              $$EmployeePlatformUsersTableTableFilterComposer f)
          f) {
    final $$EmployeePlatformUsersTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeePlatformUsersTable,
            getReferencedColumn: (t) => t.platforUsersId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeePlatformUsersTableTableFilterComposer(
                  $db: $db,
                  $table: $db.employeePlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> managersPlatformUsersTableRefs(
      Expression<bool> Function(
              $$ManagersPlatformUsersTableTableFilterComposer f)
          f) {
    final $$ManagersPlatformUsersTableTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.managersPlatformUsersTable,
            getReferencedColumn: (t) => t.platforUsersId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ManagersPlatformUsersTableTableFilterComposer(
                  $db: $db,
                  $table: $db.managersPlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlatformUsersTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $PlatformUsersTableTable> {
  $$PlatformUsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$PlatformUsersTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $PlatformUsersTableTable> {
  $$PlatformUsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> employeePlatformUsersTableRefs<T extends Object>(
      Expression<T> Function(
              $$EmployeePlatformUsersTableTableAnnotationComposer a)
          f) {
    final $$EmployeePlatformUsersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.employeePlatformUsersTable,
            getReferencedColumn: (t) => t.platforUsersId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$EmployeePlatformUsersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.employeePlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> managersPlatformUsersTableRefs<T extends Object>(
      Expression<T> Function(
              $$ManagersPlatformUsersTableTableAnnotationComposer a)
          f) {
    final $$ManagersPlatformUsersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.managersPlatformUsersTable,
            getReferencedColumn: (t) => t.platforUsersId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$ManagersPlatformUsersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.managersPlatformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$PlatformUsersTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $PlatformUsersTableTable,
    PlatformUsersTableData,
    $$PlatformUsersTableTableFilterComposer,
    $$PlatformUsersTableTableOrderingComposer,
    $$PlatformUsersTableTableAnnotationComposer,
    $$PlatformUsersTableTableCreateCompanionBuilder,
    $$PlatformUsersTableTableUpdateCompanionBuilder,
    (PlatformUsersTableData, $$PlatformUsersTableTableReferences),
    PlatformUsersTableData,
    PrefetchHooks Function(
        {bool employeePlatformUsersTableRefs,
        bool managersPlatformUsersTableRefs})> {
  $$PlatformUsersTableTableTableManager(
      _$CollectorDatabase db, $PlatformUsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlatformUsersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlatformUsersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlatformUsersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PlatformUsersTableCompanion(
            id: id,
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              PlatformUsersTableCompanion.insert(
            id: id,
            name: name,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$PlatformUsersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {employeePlatformUsersTableRefs = false,
              managersPlatformUsersTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (employeePlatformUsersTableRefs)
                  db.employeePlatformUsersTable,
                if (managersPlatformUsersTableRefs)
                  db.managersPlatformUsersTable
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (employeePlatformUsersTableRefs)
                    await $_getPrefetchedData<
                            PlatformUsersTableData,
                            $PlatformUsersTableTable,
                            EmployeePlatformUsersTableData>(
                        currentTable: table,
                        referencedTable: $$PlatformUsersTableTableReferences
                            ._employeePlatformUsersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlatformUsersTableTableReferences(db, table, p0)
                                .employeePlatformUsersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.platforUsersId == item.id),
                        typedResults: items),
                  if (managersPlatformUsersTableRefs)
                    await $_getPrefetchedData<
                            PlatformUsersTableData,
                            $PlatformUsersTableTable,
                            ManagersPlatformUsersTableData>(
                        currentTable: table,
                        referencedTable: $$PlatformUsersTableTableReferences
                            ._managersPlatformUsersTableRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$PlatformUsersTableTableReferences(db, table, p0)
                                .managersPlatformUsersTableRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.platforUsersId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$PlatformUsersTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $PlatformUsersTableTable,
    PlatformUsersTableData,
    $$PlatformUsersTableTableFilterComposer,
    $$PlatformUsersTableTableOrderingComposer,
    $$PlatformUsersTableTableAnnotationComposer,
    $$PlatformUsersTableTableCreateCompanionBuilder,
    $$PlatformUsersTableTableUpdateCompanionBuilder,
    (PlatformUsersTableData, $$PlatformUsersTableTableReferences),
    PlatformUsersTableData,
    PrefetchHooks Function(
        {bool employeePlatformUsersTableRefs,
        bool managersPlatformUsersTableRefs})>;
typedef $$EmployeeManagersTableTableCreateCompanionBuilder
    = EmployeeManagersTableCompanion Function({
  required String employeeId,
  required String managerId,
  Value<int> rowid,
});
typedef $$EmployeeManagersTableTableUpdateCompanionBuilder
    = EmployeeManagersTableCompanion Function({
  Value<String> employeeId,
  Value<String> managerId,
  Value<int> rowid,
});

final class $$EmployeeManagersTableTableReferences extends BaseReferences<
    _$CollectorDatabase,
    $EmployeeManagersTableTable,
    EmployeeManagersTableData> {
  $$EmployeeManagersTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.employeeManagersTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ManagerTableTable _managerIdTable(_$CollectorDatabase db) =>
      db.managerTable.createAlias($_aliasNameGenerator(
          db.employeeManagersTable.managerId, db.managerTable.id));

  $$ManagerTableTableProcessedTableManager get managerId {
    final $_column = $_itemColumn<String>('manager_id')!;

    final manager = $$ManagerTableTableTableManager($_db, $_db.managerTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EmployeeManagersTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $EmployeeManagersTableTable> {
  $$EmployeeManagersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ManagerTableTableFilterComposer get managerId {
    final $$ManagerTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managerId,
        referencedTable: $db.managerTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagerTableTableFilterComposer(
              $db: $db,
              $table: $db.managerTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeManagersTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $EmployeeManagersTableTable> {
  $$EmployeeManagersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ManagerTableTableOrderingComposer get managerId {
    final $$ManagerTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managerId,
        referencedTable: $db.managerTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagerTableTableOrderingComposer(
              $db: $db,
              $table: $db.managerTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeManagersTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $EmployeeManagersTableTable> {
  $$EmployeeManagersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ManagerTableTableAnnotationComposer get managerId {
    final $$ManagerTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managerId,
        referencedTable: $db.managerTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagerTableTableAnnotationComposer(
              $db: $db,
              $table: $db.managerTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeeManagersTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $EmployeeManagersTableTable,
    EmployeeManagersTableData,
    $$EmployeeManagersTableTableFilterComposer,
    $$EmployeeManagersTableTableOrderingComposer,
    $$EmployeeManagersTableTableAnnotationComposer,
    $$EmployeeManagersTableTableCreateCompanionBuilder,
    $$EmployeeManagersTableTableUpdateCompanionBuilder,
    (EmployeeManagersTableData, $$EmployeeManagersTableTableReferences),
    EmployeeManagersTableData,
    PrefetchHooks Function({bool employeeId, bool managerId})> {
  $$EmployeeManagersTableTableTableManager(
      _$CollectorDatabase db, $EmployeeManagersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeeManagersTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeeManagersTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeeManagersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<String> managerId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeeManagersTableCompanion(
            employeeId: employeeId,
            managerId: managerId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required String managerId,
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeeManagersTableCompanion.insert(
            employeeId: employeeId,
            managerId: managerId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EmployeeManagersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeId = false, managerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable: $$EmployeeManagersTableTableReferences
                        ._employeeIdTable(db),
                    referencedColumn: $$EmployeeManagersTableTableReferences
                        ._employeeIdTable(db)
                        .id,
                  ) as T;
                }
                if (managerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.managerId,
                    referencedTable: $$EmployeeManagersTableTableReferences
                        ._managerIdTable(db),
                    referencedColumn: $$EmployeeManagersTableTableReferences
                        ._managerIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EmployeeManagersTableTableProcessedTableManager
    = ProcessedTableManager<
        _$CollectorDatabase,
        $EmployeeManagersTableTable,
        EmployeeManagersTableData,
        $$EmployeeManagersTableTableFilterComposer,
        $$EmployeeManagersTableTableOrderingComposer,
        $$EmployeeManagersTableTableAnnotationComposer,
        $$EmployeeManagersTableTableCreateCompanionBuilder,
        $$EmployeeManagersTableTableUpdateCompanionBuilder,
        (EmployeeManagersTableData, $$EmployeeManagersTableTableReferences),
        EmployeeManagersTableData,
        PrefetchHooks Function({bool employeeId, bool managerId})>;
typedef $$EmployeePlatformUsersTableTableCreateCompanionBuilder
    = EmployeePlatformUsersTableCompanion Function({
  required String employeeId,
  required String platforUsersId,
  Value<int> rowid,
});
typedef $$EmployeePlatformUsersTableTableUpdateCompanionBuilder
    = EmployeePlatformUsersTableCompanion Function({
  Value<String> employeeId,
  Value<String> platforUsersId,
  Value<int> rowid,
});

final class $$EmployeePlatformUsersTableTableReferences extends BaseReferences<
    _$CollectorDatabase,
    $EmployeePlatformUsersTableTable,
    EmployeePlatformUsersTableData> {
  $$EmployeePlatformUsersTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.employeePlatformUsersTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlatformUsersTableTable _platforUsersIdTable(
          _$CollectorDatabase db) =>
      db.platformUsersTable.createAlias($_aliasNameGenerator(
          db.employeePlatformUsersTable.platforUsersId,
          db.platformUsersTable.id));

  $$PlatformUsersTableTableProcessedTableManager get platforUsersId {
    final $_column = $_itemColumn<String>('platfor_users_id')!;

    final manager =
        $$PlatformUsersTableTableTableManager($_db, $_db.platformUsersTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_platforUsersIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EmployeePlatformUsersTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $EmployeePlatformUsersTableTable> {
  $$EmployeePlatformUsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlatformUsersTableTableFilterComposer get platforUsersId {
    final $$PlatformUsersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.platforUsersId,
        referencedTable: $db.platformUsersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlatformUsersTableTableFilterComposer(
              $db: $db,
              $table: $db.platformUsersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeePlatformUsersTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $EmployeePlatformUsersTableTable> {
  $$EmployeePlatformUsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlatformUsersTableTableOrderingComposer get platforUsersId {
    final $$PlatformUsersTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.platforUsersId,
        referencedTable: $db.platformUsersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlatformUsersTableTableOrderingComposer(
              $db: $db,
              $table: $db.platformUsersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EmployeePlatformUsersTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $EmployeePlatformUsersTableTable> {
  $$EmployeePlatformUsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlatformUsersTableTableAnnotationComposer get platforUsersId {
    final $$PlatformUsersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.platforUsersId,
            referencedTable: $db.platformUsersTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlatformUsersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.platformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$EmployeePlatformUsersTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $EmployeePlatformUsersTableTable,
    EmployeePlatformUsersTableData,
    $$EmployeePlatformUsersTableTableFilterComposer,
    $$EmployeePlatformUsersTableTableOrderingComposer,
    $$EmployeePlatformUsersTableTableAnnotationComposer,
    $$EmployeePlatformUsersTableTableCreateCompanionBuilder,
    $$EmployeePlatformUsersTableTableUpdateCompanionBuilder,
    (
      EmployeePlatformUsersTableData,
      $$EmployeePlatformUsersTableTableReferences
    ),
    EmployeePlatformUsersTableData,
    PrefetchHooks Function({bool employeeId, bool platforUsersId})> {
  $$EmployeePlatformUsersTableTableTableManager(
      _$CollectorDatabase db, $EmployeePlatformUsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeePlatformUsersTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeePlatformUsersTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeePlatformUsersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<String> platforUsersId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeePlatformUsersTableCompanion(
            employeeId: employeeId,
            platforUsersId: platforUsersId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required String platforUsersId,
            Value<int> rowid = const Value.absent(),
          }) =>
              EmployeePlatformUsersTableCompanion.insert(
            employeeId: employeeId,
            platforUsersId: platforUsersId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EmployeePlatformUsersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {employeeId = false, platforUsersId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable: $$EmployeePlatformUsersTableTableReferences
                        ._employeeIdTable(db),
                    referencedColumn:
                        $$EmployeePlatformUsersTableTableReferences
                            ._employeeIdTable(db)
                            .id,
                  ) as T;
                }
                if (platforUsersId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.platforUsersId,
                    referencedTable: $$EmployeePlatformUsersTableTableReferences
                        ._platforUsersIdTable(db),
                    referencedColumn:
                        $$EmployeePlatformUsersTableTableReferences
                            ._platforUsersIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EmployeePlatformUsersTableTableProcessedTableManager
    = ProcessedTableManager<
        _$CollectorDatabase,
        $EmployeePlatformUsersTableTable,
        EmployeePlatformUsersTableData,
        $$EmployeePlatformUsersTableTableFilterComposer,
        $$EmployeePlatformUsersTableTableOrderingComposer,
        $$EmployeePlatformUsersTableTableAnnotationComposer,
        $$EmployeePlatformUsersTableTableCreateCompanionBuilder,
        $$EmployeePlatformUsersTableTableUpdateCompanionBuilder,
        (
          EmployeePlatformUsersTableData,
          $$EmployeePlatformUsersTableTableReferences
        ),
        EmployeePlatformUsersTableData,
        PrefetchHooks Function({bool employeeId, bool platforUsersId})>;
typedef $$ManagersPlatformUsersTableTableCreateCompanionBuilder
    = ManagersPlatformUsersTableCompanion Function({
  required String managerId,
  required String platforUsersId,
  Value<int> rowid,
});
typedef $$ManagersPlatformUsersTableTableUpdateCompanionBuilder
    = ManagersPlatformUsersTableCompanion Function({
  Value<String> managerId,
  Value<String> platforUsersId,
  Value<int> rowid,
});

final class $$ManagersPlatformUsersTableTableReferences extends BaseReferences<
    _$CollectorDatabase,
    $ManagersPlatformUsersTableTable,
    ManagersPlatformUsersTableData> {
  $$ManagersPlatformUsersTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ManagerTableTable _managerIdTable(_$CollectorDatabase db) =>
      db.managerTable.createAlias($_aliasNameGenerator(
          db.managersPlatformUsersTable.managerId, db.managerTable.id));

  $$ManagerTableTableProcessedTableManager get managerId {
    final $_column = $_itemColumn<String>('manager_id')!;

    final manager = $$ManagerTableTableTableManager($_db, $_db.managerTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_managerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $PlatformUsersTableTable _platforUsersIdTable(
          _$CollectorDatabase db) =>
      db.platformUsersTable.createAlias($_aliasNameGenerator(
          db.managersPlatformUsersTable.platforUsersId,
          db.platformUsersTable.id));

  $$PlatformUsersTableTableProcessedTableManager get platforUsersId {
    final $_column = $_itemColumn<String>('platfor_users_id')!;

    final manager =
        $$PlatformUsersTableTableTableManager($_db, $_db.platformUsersTable)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_platforUsersIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ManagersPlatformUsersTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ManagersPlatformUsersTableTable> {
  $$ManagersPlatformUsersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ManagerTableTableFilterComposer get managerId {
    final $$ManagerTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managerId,
        referencedTable: $db.managerTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagerTableTableFilterComposer(
              $db: $db,
              $table: $db.managerTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlatformUsersTableTableFilterComposer get platforUsersId {
    final $$PlatformUsersTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.platforUsersId,
        referencedTable: $db.platformUsersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlatformUsersTableTableFilterComposer(
              $db: $db,
              $table: $db.platformUsersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ManagersPlatformUsersTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ManagersPlatformUsersTableTable> {
  $$ManagersPlatformUsersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ManagerTableTableOrderingComposer get managerId {
    final $$ManagerTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managerId,
        referencedTable: $db.managerTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagerTableTableOrderingComposer(
              $db: $db,
              $table: $db.managerTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlatformUsersTableTableOrderingComposer get platforUsersId {
    final $$PlatformUsersTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.platforUsersId,
        referencedTable: $db.platformUsersTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$PlatformUsersTableTableOrderingComposer(
              $db: $db,
              $table: $db.platformUsersTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ManagersPlatformUsersTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ManagersPlatformUsersTableTable> {
  $$ManagersPlatformUsersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ManagerTableTableAnnotationComposer get managerId {
    final $$ManagerTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.managerId,
        referencedTable: $db.managerTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ManagerTableTableAnnotationComposer(
              $db: $db,
              $table: $db.managerTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$PlatformUsersTableTableAnnotationComposer get platforUsersId {
    final $$PlatformUsersTableTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.platforUsersId,
            referencedTable: $db.platformUsersTable,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$PlatformUsersTableTableAnnotationComposer(
                  $db: $db,
                  $table: $db.platformUsersTable,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$ManagersPlatformUsersTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ManagersPlatformUsersTableTable,
    ManagersPlatformUsersTableData,
    $$ManagersPlatformUsersTableTableFilterComposer,
    $$ManagersPlatformUsersTableTableOrderingComposer,
    $$ManagersPlatformUsersTableTableAnnotationComposer,
    $$ManagersPlatformUsersTableTableCreateCompanionBuilder,
    $$ManagersPlatformUsersTableTableUpdateCompanionBuilder,
    (
      ManagersPlatformUsersTableData,
      $$ManagersPlatformUsersTableTableReferences
    ),
    ManagersPlatformUsersTableData,
    PrefetchHooks Function({bool managerId, bool platforUsersId})> {
  $$ManagersPlatformUsersTableTableTableManager(
      _$CollectorDatabase db, $ManagersPlatformUsersTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ManagersPlatformUsersTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ManagersPlatformUsersTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ManagersPlatformUsersTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> managerId = const Value.absent(),
            Value<String> platforUsersId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ManagersPlatformUsersTableCompanion(
            managerId: managerId,
            platforUsersId: platforUsersId,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String managerId,
            required String platforUsersId,
            Value<int> rowid = const Value.absent(),
          }) =>
              ManagersPlatformUsersTableCompanion.insert(
            managerId: managerId,
            platforUsersId: platforUsersId,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ManagersPlatformUsersTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({managerId = false, platforUsersId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (managerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.managerId,
                    referencedTable: $$ManagersPlatformUsersTableTableReferences
                        ._managerIdTable(db),
                    referencedColumn:
                        $$ManagersPlatformUsersTableTableReferences
                            ._managerIdTable(db)
                            .id,
                  ) as T;
                }
                if (platforUsersId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.platforUsersId,
                    referencedTable: $$ManagersPlatformUsersTableTableReferences
                        ._platforUsersIdTable(db),
                    referencedColumn:
                        $$ManagersPlatformUsersTableTableReferences
                            ._platforUsersIdTable(db)
                            .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ManagersPlatformUsersTableTableProcessedTableManager
    = ProcessedTableManager<
        _$CollectorDatabase,
        $ManagersPlatformUsersTableTable,
        ManagersPlatformUsersTableData,
        $$ManagersPlatformUsersTableTableFilterComposer,
        $$ManagersPlatformUsersTableTableOrderingComposer,
        $$ManagersPlatformUsersTableTableAnnotationComposer,
        $$ManagersPlatformUsersTableTableCreateCompanionBuilder,
        $$ManagersPlatformUsersTableTableUpdateCompanionBuilder,
        (
          ManagersPlatformUsersTableData,
          $$ManagersPlatformUsersTableTableReferences
        ),
        ManagersPlatformUsersTableData,
        PrefetchHooks Function({bool managerId, bool platforUsersId})>;
typedef $$LogsTableTableCreateCompanionBuilder = LogsTableCompanion Function({
  required String id,
  Value<String?> createdAt,
  required String deviceId,
  Value<String?> userPlatform,
  Value<String?> employeeId,
  Value<String?> employeeExternalId,
  required String log,
  Value<int> rowid,
});
typedef $$LogsTableTableUpdateCompanionBuilder = LogsTableCompanion Function({
  Value<String> id,
  Value<String?> createdAt,
  Value<String> deviceId,
  Value<String?> userPlatform,
  Value<String?> employeeId,
  Value<String?> employeeExternalId,
  Value<String> log,
  Value<int> rowid,
});

class $$LogsTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $LogsTableTable> {
  $$LogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userPlatform => $composableBuilder(
      column: $table.userPlatform, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get employeeExternalId => $composableBuilder(
      column: $table.employeeExternalId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get log => $composableBuilder(
      column: $table.log, builder: (column) => ColumnFilters(column));
}

class $$LogsTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $LogsTableTable> {
  $$LogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deviceId => $composableBuilder(
      column: $table.deviceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userPlatform => $composableBuilder(
      column: $table.userPlatform,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get employeeExternalId => $composableBuilder(
      column: $table.employeeExternalId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get log => $composableBuilder(
      column: $table.log, builder: (column) => ColumnOrderings(column));
}

class $$LogsTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $LogsTableTable> {
  $$LogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get userPlatform => $composableBuilder(
      column: $table.userPlatform, builder: (column) => column);

  GeneratedColumn<String> get employeeId => $composableBuilder(
      column: $table.employeeId, builder: (column) => column);

  GeneratedColumn<String> get employeeExternalId => $composableBuilder(
      column: $table.employeeExternalId, builder: (column) => column);

  GeneratedColumn<String> get log =>
      $composableBuilder(column: $table.log, builder: (column) => column);
}

class $$LogsTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $LogsTableTable,
    LogsTableData,
    $$LogsTableTableFilterComposer,
    $$LogsTableTableOrderingComposer,
    $$LogsTableTableAnnotationComposer,
    $$LogsTableTableCreateCompanionBuilder,
    $$LogsTableTableUpdateCompanionBuilder,
    (
      LogsTableData,
      BaseReferences<_$CollectorDatabase, $LogsTableTable, LogsTableData>
    ),
    LogsTableData,
    PrefetchHooks Function()> {
  $$LogsTableTableTableManager(_$CollectorDatabase db, $LogsTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> createdAt = const Value.absent(),
            Value<String> deviceId = const Value.absent(),
            Value<String?> userPlatform = const Value.absent(),
            Value<String?> employeeId = const Value.absent(),
            Value<String?> employeeExternalId = const Value.absent(),
            Value<String> log = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LogsTableCompanion(
            id: id,
            createdAt: createdAt,
            deviceId: deviceId,
            userPlatform: userPlatform,
            employeeId: employeeId,
            employeeExternalId: employeeExternalId,
            log: log,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> createdAt = const Value.absent(),
            required String deviceId,
            Value<String?> userPlatform = const Value.absent(),
            Value<String?> employeeId = const Value.absent(),
            Value<String?> employeeExternalId = const Value.absent(),
            required String log,
            Value<int> rowid = const Value.absent(),
          }) =>
              LogsTableCompanion.insert(
            id: id,
            createdAt: createdAt,
            deviceId: deviceId,
            userPlatform: userPlatform,
            employeeId: employeeId,
            employeeExternalId: employeeExternalId,
            log: log,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LogsTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $LogsTableTable,
    LogsTableData,
    $$LogsTableTableFilterComposer,
    $$LogsTableTableOrderingComposer,
    $$LogsTableTableAnnotationComposer,
    $$LogsTableTableCreateCompanionBuilder,
    $$LogsTableTableUpdateCompanionBuilder,
    (
      LogsTableData,
      BaseReferences<_$CollectorDatabase, $LogsTableTable, LogsTableData>
    ),
    LogsTableData,
    PrefetchHooks Function()>;
typedef $$ClockingEventUseTableTableCreateCompanionBuilder
    = ClockingEventUseTableCompanion Function({
  required String employeeId,
  required String description,
  required String code,
  required String clockingEventUseType,
  Value<int> rowid,
});
typedef $$ClockingEventUseTableTableUpdateCompanionBuilder
    = ClockingEventUseTableCompanion Function({
  Value<String> employeeId,
  Value<String> description,
  Value<String> code,
  Value<String> clockingEventUseType,
  Value<int> rowid,
});

final class $$ClockingEventUseTableTableReferences extends BaseReferences<
    _$CollectorDatabase,
    $ClockingEventUseTableTable,
    ClockingEventUseTableData> {
  $$ClockingEventUseTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.clockingEventUseTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ClockingEventUseTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ClockingEventUseTableTable> {
  $$ClockingEventUseTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get clockingEventUseType => $composableBuilder(
      column: $table.clockingEventUseType,
      builder: (column) => ColumnFilters(column));

  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClockingEventUseTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ClockingEventUseTableTable> {
  $$ClockingEventUseTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get clockingEventUseType => $composableBuilder(
      column: $table.clockingEventUseType,
      builder: (column) => ColumnOrderings(column));

  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClockingEventUseTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ClockingEventUseTableTable> {
  $$ClockingEventUseTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get clockingEventUseType => $composableBuilder(
      column: $table.clockingEventUseType, builder: (column) => column);

  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClockingEventUseTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ClockingEventUseTableTable,
    ClockingEventUseTableData,
    $$ClockingEventUseTableTableFilterComposer,
    $$ClockingEventUseTableTableOrderingComposer,
    $$ClockingEventUseTableTableAnnotationComposer,
    $$ClockingEventUseTableTableCreateCompanionBuilder,
    $$ClockingEventUseTableTableUpdateCompanionBuilder,
    (ClockingEventUseTableData, $$ClockingEventUseTableTableReferences),
    ClockingEventUseTableData,
    PrefetchHooks Function({bool employeeId})> {
  $$ClockingEventUseTableTableTableManager(
      _$CollectorDatabase db, $ClockingEventUseTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClockingEventUseTableTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$ClockingEventUseTableTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClockingEventUseTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> clockingEventUseType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClockingEventUseTableCompanion(
            employeeId: employeeId,
            description: description,
            code: code,
            clockingEventUseType: clockingEventUseType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required String description,
            required String code,
            required String clockingEventUseType,
            Value<int> rowid = const Value.absent(),
          }) =>
              ClockingEventUseTableCompanion.insert(
            employeeId: employeeId,
            description: description,
            code: code,
            clockingEventUseType: clockingEventUseType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ClockingEventUseTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable: $$ClockingEventUseTableTableReferences
                        ._employeeIdTable(db),
                    referencedColumn: $$ClockingEventUseTableTableReferences
                        ._employeeIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ClockingEventUseTableTableProcessedTableManager
    = ProcessedTableManager<
        _$CollectorDatabase,
        $ClockingEventUseTableTable,
        ClockingEventUseTableData,
        $$ClockingEventUseTableTableFilterComposer,
        $$ClockingEventUseTableTableOrderingComposer,
        $$ClockingEventUseTableTableAnnotationComposer,
        $$ClockingEventUseTableTableCreateCompanionBuilder,
        $$ClockingEventUseTableTableUpdateCompanionBuilder,
        (ClockingEventUseTableData, $$ClockingEventUseTableTableReferences),
        ClockingEventUseTableData,
        PrefetchHooks Function({bool employeeId})>;
typedef $$ReminderTableTableCreateCompanionBuilder = ReminderTableCompanion
    Function({
  required String employeeId,
  required DateTime period,
  Value<bool> enabled,
  required String reminder,
  Value<int> rowid,
});
typedef $$ReminderTableTableUpdateCompanionBuilder = ReminderTableCompanion
    Function({
  Value<String> employeeId,
  Value<DateTime> period,
  Value<bool> enabled,
  Value<String> reminder,
  Value<int> rowid,
});

final class $$ReminderTableTableReferences extends BaseReferences<
    _$CollectorDatabase, $ReminderTableTable, ReminderTableData> {
  $$ReminderTableTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EmployeeTableTable _employeeIdTable(_$CollectorDatabase db) =>
      db.employeeTable.createAlias($_aliasNameGenerator(
          db.reminderTable.employeeId, db.employeeTable.id));

  $$EmployeeTableTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<String>('employee_id')!;

    final manager = $$EmployeeTableTableTableManager($_db, $_db.employeeTable)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ReminderTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $ReminderTableTable> {
  $$ReminderTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reminder => $composableBuilder(
      column: $table.reminder, builder: (column) => ColumnFilters(column));

  $$EmployeeTableTableFilterComposer get employeeId {
    final $$EmployeeTableTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableFilterComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReminderTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $ReminderTableTable> {
  $$ReminderTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get period => $composableBuilder(
      column: $table.period, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get enabled => $composableBuilder(
      column: $table.enabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reminder => $composableBuilder(
      column: $table.reminder, builder: (column) => ColumnOrderings(column));

  $$EmployeeTableTableOrderingComposer get employeeId {
    final $$EmployeeTableTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableOrderingComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReminderTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $ReminderTableTable> {
  $$ReminderTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get period =>
      $composableBuilder(column: $table.period, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<String> get reminder =>
      $composableBuilder(column: $table.reminder, builder: (column) => column);

  $$EmployeeTableTableAnnotationComposer get employeeId {
    final $$EmployeeTableTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.employeeId,
        referencedTable: $db.employeeTable,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EmployeeTableTableAnnotationComposer(
              $db: $db,
              $table: $db.employeeTable,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ReminderTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $ReminderTableTable,
    ReminderTableData,
    $$ReminderTableTableFilterComposer,
    $$ReminderTableTableOrderingComposer,
    $$ReminderTableTableAnnotationComposer,
    $$ReminderTableTableCreateCompanionBuilder,
    $$ReminderTableTableUpdateCompanionBuilder,
    (ReminderTableData, $$ReminderTableTableReferences),
    ReminderTableData,
    PrefetchHooks Function({bool employeeId})> {
  $$ReminderTableTableTableManager(
      _$CollectorDatabase db, $ReminderTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> employeeId = const Value.absent(),
            Value<DateTime> period = const Value.absent(),
            Value<bool> enabled = const Value.absent(),
            Value<String> reminder = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ReminderTableCompanion(
            employeeId: employeeId,
            period: period,
            enabled: enabled,
            reminder: reminder,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String employeeId,
            required DateTime period,
            Value<bool> enabled = const Value.absent(),
            required String reminder,
            Value<int> rowid = const Value.absent(),
          }) =>
              ReminderTableCompanion.insert(
            employeeId: employeeId,
            period: period,
            enabled: enabled,
            reminder: reminder,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ReminderTableTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (employeeId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.employeeId,
                    referencedTable:
                        $$ReminderTableTableReferences._employeeIdTable(db),
                    referencedColumn:
                        $$ReminderTableTableReferences._employeeIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ReminderTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $ReminderTableTable,
    ReminderTableData,
    $$ReminderTableTableFilterComposer,
    $$ReminderTableTableOrderingComposer,
    $$ReminderTableTableAnnotationComposer,
    $$ReminderTableTableCreateCompanionBuilder,
    $$ReminderTableTableUpdateCompanionBuilder,
    (ReminderTableData, $$ReminderTableTableReferences),
    ReminderTableData,
    PrefetchHooks Function({bool employeeId})>;
typedef $$PrivacyPolicyTableTableCreateCompanionBuilder
    = PrivacyPolicyTableCompanion Function({
  Value<DateTime?> dateTimeCreated,
  Value<DateTime?> dateTimeEventRead,
  Value<int> version,
  required String urlVersion,
});
typedef $$PrivacyPolicyTableTableUpdateCompanionBuilder
    = PrivacyPolicyTableCompanion Function({
  Value<DateTime?> dateTimeCreated,
  Value<DateTime?> dateTimeEventRead,
  Value<int> version,
  Value<String> urlVersion,
});

class $$PrivacyPolicyTableTableFilterComposer
    extends Composer<_$CollectorDatabase, $PrivacyPolicyTableTable> {
  $$PrivacyPolicyTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get dateTimeCreated => $composableBuilder(
      column: $table.dateTimeCreated,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dateTimeEventRead => $composableBuilder(
      column: $table.dateTimeEventRead,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get urlVersion => $composableBuilder(
      column: $table.urlVersion, builder: (column) => ColumnFilters(column));
}

class $$PrivacyPolicyTableTableOrderingComposer
    extends Composer<_$CollectorDatabase, $PrivacyPolicyTableTable> {
  $$PrivacyPolicyTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get dateTimeCreated => $composableBuilder(
      column: $table.dateTimeCreated,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dateTimeEventRead => $composableBuilder(
      column: $table.dateTimeEventRead,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get version => $composableBuilder(
      column: $table.version, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get urlVersion => $composableBuilder(
      column: $table.urlVersion, builder: (column) => ColumnOrderings(column));
}

class $$PrivacyPolicyTableTableAnnotationComposer
    extends Composer<_$CollectorDatabase, $PrivacyPolicyTableTable> {
  $$PrivacyPolicyTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get dateTimeCreated => $composableBuilder(
      column: $table.dateTimeCreated, builder: (column) => column);

  GeneratedColumn<DateTime> get dateTimeEventRead => $composableBuilder(
      column: $table.dateTimeEventRead, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get urlVersion => $composableBuilder(
      column: $table.urlVersion, builder: (column) => column);
}

class $$PrivacyPolicyTableTableTableManager extends RootTableManager<
    _$CollectorDatabase,
    $PrivacyPolicyTableTable,
    PrivacyPolicyTableData,
    $$PrivacyPolicyTableTableFilterComposer,
    $$PrivacyPolicyTableTableOrderingComposer,
    $$PrivacyPolicyTableTableAnnotationComposer,
    $$PrivacyPolicyTableTableCreateCompanionBuilder,
    $$PrivacyPolicyTableTableUpdateCompanionBuilder,
    (
      PrivacyPolicyTableData,
      BaseReferences<_$CollectorDatabase, $PrivacyPolicyTableTable,
          PrivacyPolicyTableData>
    ),
    PrivacyPolicyTableData,
    PrefetchHooks Function()> {
  $$PrivacyPolicyTableTableTableManager(
      _$CollectorDatabase db, $PrivacyPolicyTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PrivacyPolicyTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PrivacyPolicyTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PrivacyPolicyTableTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<DateTime?> dateTimeCreated = const Value.absent(),
            Value<DateTime?> dateTimeEventRead = const Value.absent(),
            Value<int> version = const Value.absent(),
            Value<String> urlVersion = const Value.absent(),
          }) =>
              PrivacyPolicyTableCompanion(
            dateTimeCreated: dateTimeCreated,
            dateTimeEventRead: dateTimeEventRead,
            version: version,
            urlVersion: urlVersion,
          ),
          createCompanionCallback: ({
            Value<DateTime?> dateTimeCreated = const Value.absent(),
            Value<DateTime?> dateTimeEventRead = const Value.absent(),
            Value<int> version = const Value.absent(),
            required String urlVersion,
          }) =>
              PrivacyPolicyTableCompanion.insert(
            dateTimeCreated: dateTimeCreated,
            dateTimeEventRead: dateTimeEventRead,
            version: version,
            urlVersion: urlVersion,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PrivacyPolicyTableTableProcessedTableManager = ProcessedTableManager<
    _$CollectorDatabase,
    $PrivacyPolicyTableTable,
    PrivacyPolicyTableData,
    $$PrivacyPolicyTableTableFilterComposer,
    $$PrivacyPolicyTableTableOrderingComposer,
    $$PrivacyPolicyTableTableAnnotationComposer,
    $$PrivacyPolicyTableTableCreateCompanionBuilder,
    $$PrivacyPolicyTableTableUpdateCompanionBuilder,
    (
      PrivacyPolicyTableData,
      BaseReferences<_$CollectorDatabase, $PrivacyPolicyTableTable,
          PrivacyPolicyTableData>
    ),
    PrivacyPolicyTableData,
    PrefetchHooks Function()>;

class $CollectorDatabaseManager {
  final _$CollectorDatabase _db;
  $CollectorDatabaseManager(this._db);
  $$CompanyTableTableTableManager get companyTable =>
      $$CompanyTableTableTableManager(_db, _db.companyTable);
  $$EmployeeTableTableTableManager get employeeTable =>
      $$EmployeeTableTableTableManager(_db, _db.employeeTable);
  $$ConfigurationTableTableTableManager get configurationTable =>
      $$ConfigurationTableTableTableManager(_db, _db.configurationTable);
  $$OvernightTableTableTableManager get overnightTable =>
      $$OvernightTableTableTableManager(_db, _db.overnightTable);
  $$JourneyTableTableTableManager get journeyTable =>
      $$JourneyTableTableTableManager(_db, _db.journeyTable);
  $$ClockingEventTableTableTableManager get clockingEventTable =>
      $$ClockingEventTableTableTableManager(_db, _db.clockingEventTable);
  $$FenceTableTableTableManager get fenceTable =>
      $$FenceTableTableTableManager(_db, _db.fenceTable);
  $$PerimeterTableTableTableManager get perimeterTable =>
      $$PerimeterTableTableTableManager(_db, _db.perimeterTable);
  $$EmployeeFenceTableTableTableManager get employeeFenceTable =>
      $$EmployeeFenceTableTableTableManager(_db, _db.employeeFenceTable);
  $$FencePerimeterTableTableTableManager get fencePerimeterTable =>
      $$FencePerimeterTableTableTableManager(_db, _db.fencePerimeterTable);
  $$DeviceTableTableTableManager get deviceTable =>
      $$DeviceTableTableTableManager(_db, _db.deviceTable);
  $$ActivationTableTableTableManager get activationTable =>
      $$ActivationTableTableTableManager(_db, _db.activationTable);
  $$ApplicationTableTableTableManager get applicationTable =>
      $$ApplicationTableTableTableManager(_db, _db.applicationTable);
  $$DeviceConfigurationTableTableTableManager get deviceConfigurationTable =>
      $$DeviceConfigurationTableTableTableManager(
          _db, _db.deviceConfigurationTable);
  $$GlobalConfigurationTableTableTableManager get globalConfigurationTable =>
      $$GlobalConfigurationTableTableTableManager(
          _db, _db.globalConfigurationTable);
  $$ManagerTableTableTableManager get managerTable =>
      $$ManagerTableTableTableManager(_db, _db.managerTable);
  $$PlatformUsersTableTableTableManager get platformUsersTable =>
      $$PlatformUsersTableTableTableManager(_db, _db.platformUsersTable);
  $$EmployeeManagersTableTableTableManager get employeeManagersTable =>
      $$EmployeeManagersTableTableTableManager(_db, _db.employeeManagersTable);
  $$EmployeePlatformUsersTableTableTableManager
      get employeePlatformUsersTable =>
          $$EmployeePlatformUsersTableTableTableManager(
              _db, _db.employeePlatformUsersTable);
  $$ManagersPlatformUsersTableTableTableManager
      get managersPlatformUsersTable =>
          $$ManagersPlatformUsersTableTableTableManager(
              _db, _db.managersPlatformUsersTable);
  $$LogsTableTableTableManager get logsTable =>
      $$LogsTableTableTableManager(_db, _db.logsTable);
  $$ClockingEventUseTableTableTableManager get clockingEventUseTable =>
      $$ClockingEventUseTableTableTableManager(_db, _db.clockingEventUseTable);
  $$ReminderTableTableTableManager get reminderTable =>
      $$ReminderTableTableTableManager(_db, _db.reminderTable);
  $$PrivacyPolicyTableTableTableManager get privacyPolicyTable =>
      $$PrivacyPolicyTableTableTableManager(_db, _db.privacyPolicyTable);
}
