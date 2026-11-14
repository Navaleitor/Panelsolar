// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  @override
  late final GeneratedColumn<String> taxId = GeneratedColumn<String>(
    'tax_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    name,
    phone,
    email,
    taxId,
    logoPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Company> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('tax_id')) {
      context.handle(
        _taxIdMeta,
        taxId.isAcceptableOrUnknown(data['tax_id']!, _taxIdMeta),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      taxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_id'],
      ),
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Nombre comercial (obligatorio).
  final String name;

  /// Teléfono de contacto.
  final String? phone;

  /// Correo de contacto.
  final String? email;

  /// Identificador fiscal (RFC en México). Agregado en v2.
  final String? taxId;

  /// Ruta local del logo para reportes. Agregado en v2.
  final String? logoPath;
  const Company({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.name,
    this.phone,
    this.email,
    this.taxId,
    this.logoPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<String>(taxId);
    }
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      taxId: taxId == null && nullToAbsent
          ? const Value.absent()
          : Value(taxId),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
    );
  }

  factory Company.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      taxId: serializer.fromJson<String?>(json['taxId']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'taxId': serializer.toJson<String?>(taxId),
      'logoPath': serializer.toJson<String?>(logoPath),
    };
  }

  Company copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> taxId = const Value.absent(),
    Value<String?> logoPath = const Value.absent(),
  }) => Company(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    taxId: taxId.present ? taxId.value : this.taxId,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
  );
  Company copyWithCompanion(CompaniesCompanion data) {
    return Company(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      taxId: data.taxId.present ? data.taxId.value : this.taxId,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('taxId: $taxId, ')
          ..write('logoPath: $logoPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    name,
    phone,
    email,
    taxId,
    logoPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.taxId == this.taxId &&
          other.logoPath == this.logoPath);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> taxId;
  final Value<String?> logoPath;
  final Value<int> rowid;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.taxId = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.taxId = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Company> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? taxId,
    Expression<String>? logoPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (taxId != null) 'tax_id': taxId,
      if (logoPath != null) 'logo_path': logoPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CompaniesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? taxId,
    Value<String?>? logoPath,
    Value<int>? rowid,
  }) {
    return CompaniesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      taxId: taxId ?? this.taxId,
      logoPath: logoPath ?? this.logoPath,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<String>(taxId.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('taxId: $taxId, ')
          ..write('logoPath: $logoPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    name,
    phone,
    email,
    address,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Nombre o razón social (obligatorio).
  final String name;

  /// Teléfono de contacto.
  final String? phone;

  /// Correo de contacto.
  final String? email;

  /// Dirección postal (texto libre).
  final String? address;

  /// Notas libres.
  final String? notes;
  const Client({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.name,
    this.phone,
    this.email,
    this.address,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Client copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Client(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    name,
    phone,
    email,
    address,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.address == this.address &&
          other.notes == this.notes);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<int> rowid;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Client> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProjectsTable extends Projects with TableInfo<$ProjectsTable, Project> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProjectStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(ProjectStatus.prospect.name),
      ).withConverter<ProjectStatus>($ProjectsTable.$converterstatus);
  static const VerificationMeta _projectDateMeta = const VerificationMeta(
    'projectDate',
  );
  @override
  late final GeneratedColumn<DateTime> projectDate = GeneratedColumn<DateTime>(
    'project_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    name,
    status,
    projectDate,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'projects';
  @override
  VerificationContext validateIntegrity(
    Insertable<Project> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('project_date')) {
      context.handle(
        _projectDateMeta,
        projectDate.isAcceptableOrUnknown(
          data['project_date']!,
          _projectDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_projectDateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Project map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Project(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      status: $ProjectsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      projectDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}project_date'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ProjectsTable createAlias(String alias) {
    return $ProjectsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProjectStatus, String, String> $converterstatus =
      const EnumNameConverter<ProjectStatus>(ProjectStatus.values);
}

class Project extends DataClass implements Insertable<Project> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Cliente dueño del proyecto.
  final String clientId;

  /// Nombre corto del proyecto (p. ej. "Casa Cumbres").
  final String name;

  /// Estado actual.
  final ProjectStatus status;

  /// Fecha de referencia del proyecto (visita, cotización...), en UTC.
  final DateTime projectDate;

  /// Notas libres.
  final String? notes;
  const Project({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.clientId,
    required this.name,
    required this.status,
    required this.projectDate,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['client_id'] = Variable<String>(clientId);
    map['name'] = Variable<String>(name);
    {
      map['status'] = Variable<String>(
        $ProjectsTable.$converterstatus.toSql(status),
      );
    }
    map['project_date'] = Variable<DateTime>(projectDate);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ProjectsCompanion toCompanion(bool nullToAbsent) {
    return ProjectsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      clientId: Value(clientId),
      name: Value(name),
      status: Value(status),
      projectDate: Value(projectDate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Project.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Project(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      clientId: serializer.fromJson<String>(json['clientId']),
      name: serializer.fromJson<String>(json['name']),
      status: $ProjectsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      projectDate: serializer.fromJson<DateTime>(json['projectDate']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'clientId': serializer.toJson<String>(clientId),
      'name': serializer.toJson<String>(name),
      'status': serializer.toJson<String>(
        $ProjectsTable.$converterstatus.toJson(status),
      ),
      'projectDate': serializer.toJson<DateTime>(projectDate),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Project copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? clientId,
    String? name,
    ProjectStatus? status,
    DateTime? projectDate,
    Value<String?> notes = const Value.absent(),
  }) => Project(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    clientId: clientId ?? this.clientId,
    name: name ?? this.name,
    status: status ?? this.status,
    projectDate: projectDate ?? this.projectDate,
    notes: notes.present ? notes.value : this.notes,
  );
  Project copyWithCompanion(ProjectsCompanion data) {
    return Project(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      name: data.name.present ? data.name.value : this.name,
      status: data.status.present ? data.status.value : this.status,
      projectDate: data.projectDate.present
          ? data.projectDate.value
          : this.projectDate,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Project(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('projectDate: $projectDate, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    name,
    status,
    projectDate,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Project &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.clientId == this.clientId &&
          other.name == this.name &&
          other.status == this.status &&
          other.projectDate == this.projectDate &&
          other.notes == this.notes);
}

class ProjectsCompanion extends UpdateCompanion<Project> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> clientId;
  final Value<String> name;
  final Value<ProjectStatus> status;
  final Value<DateTime> projectDate;
  final Value<String?> notes;
  final Value<int> rowid;
  const ProjectsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.clientId = const Value.absent(),
    this.name = const Value.absent(),
    this.status = const Value.absent(),
    this.projectDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProjectsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String clientId,
    required String name,
    this.status = const Value.absent(),
    required DateTime projectDate,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientId = Value(clientId),
       name = Value(name),
       projectDate = Value(projectDate);
  static Insertable<Project> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? clientId,
    Expression<String>? name,
    Expression<String>? status,
    Expression<DateTime>? projectDate,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (clientId != null) 'client_id': clientId,
      if (name != null) 'name': name,
      if (status != null) 'status': status,
      if (projectDate != null) 'project_date': projectDate,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProjectsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? clientId,
    Value<String>? name,
    Value<ProjectStatus>? status,
    Value<DateTime>? projectDate,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ProjectsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      clientId: clientId ?? this.clientId,
      name: name ?? this.name,
      status: status ?? this.status,
      projectDate: projectDate ?? this.projectDate,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $ProjectsTable.$converterstatus.toSql(status.value),
      );
    }
    if (projectDate.present) {
      map['project_date'] = Variable<DateTime>(projectDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProjectsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('name: $name, ')
          ..write('status: $status, ')
          ..write('projectDate: $projectDate, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SitesTable extends Sites with TableInfo<$SitesTable, Site> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SitesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _altitudeMMeta = const VerificationMeta(
    'altitudeM',
  );
  @override
  late final GeneratedColumn<double> altitudeM = GeneratedColumn<double>(
    'altitude_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeZoneMeta = const VerificationMeta(
    'timeZone',
  );
  @override
  late final GeneratedColumn<String> timeZone = GeneratedColumn<String>(
    'time_zone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LocationSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LocationSource>($SitesTable.$convertersource);
  static const VerificationMeta _sourceTextMeta = const VerificationMeta(
    'sourceText',
  );
  @override
  late final GeneratedColumn<String> sourceText = GeneratedColumn<String>(
    'source_text',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    latitude,
    longitude,
    altitudeM,
    timeZone,
    source,
    sourceText,
    accuracyM,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sites';
  @override
  VerificationContext validateIntegrity(
    Insertable<Site> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('altitude_m')) {
      context.handle(
        _altitudeMMeta,
        altitudeM.isAcceptableOrUnknown(data['altitude_m']!, _altitudeMMeta),
      );
    }
    if (data.containsKey('time_zone')) {
      context.handle(
        _timeZoneMeta,
        timeZone.isAcceptableOrUnknown(data['time_zone']!, _timeZoneMeta),
      );
    }
    if (data.containsKey('source_text')) {
      context.handle(
        _sourceTextMeta,
        sourceText.isAcceptableOrUnknown(data['source_text']!, _sourceTextMeta),
      );
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Site map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Site(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      altitudeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altitude_m'],
      ),
      timeZone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time_zone'],
      ),
      source: $SitesTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_text'],
      ),
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      ),
    );
  }

  @override
  $SitesTable createAlias(String alias) {
    return $SitesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LocationSource, String, String> $convertersource =
      const EnumNameConverter<LocationSource>(LocationSource.values);
}

class Site extends DataClass implements Insertable<Site> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto al que pertenece (único).
  final String projectId;

  /// Latitud WGS84 en grados decimales (−90 a 90).
  final double latitude;

  /// Longitud WGS84 en grados decimales (−180 a 180).
  final double longitude;

  /// Altitud sobre el nivel del mar, en metros (si se conoce).
  final double? altitudeM;

  /// Zona horaria IANA (p. ej. `America/Monterrey`).
  final String? timeZone;

  /// Cómo se obtuvo la ubicación.
  final LocationSource source;

  /// Texto de origen: la dirección buscada o el enlace pegado.
  final String? sourceText;

  /// Precisión horizontal del GPS en metros (solo origen GPS).
  final double? accuracyM;
  const Site({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.latitude,
    required this.longitude,
    this.altitudeM,
    this.timeZone,
    required this.source,
    this.sourceText,
    this.accuracyM,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    map['latitude'] = Variable<double>(latitude);
    map['longitude'] = Variable<double>(longitude);
    if (!nullToAbsent || altitudeM != null) {
      map['altitude_m'] = Variable<double>(altitudeM);
    }
    if (!nullToAbsent || timeZone != null) {
      map['time_zone'] = Variable<String>(timeZone);
    }
    {
      map['source'] = Variable<String>(
        $SitesTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceText != null) {
      map['source_text'] = Variable<String>(sourceText);
    }
    if (!nullToAbsent || accuracyM != null) {
      map['accuracy_m'] = Variable<double>(accuracyM);
    }
    return map;
  }

  SitesCompanion toCompanion(bool nullToAbsent) {
    return SitesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      latitude: Value(latitude),
      longitude: Value(longitude),
      altitudeM: altitudeM == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeM),
      timeZone: timeZone == null && nullToAbsent
          ? const Value.absent()
          : Value(timeZone),
      source: Value(source),
      sourceText: sourceText == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceText),
      accuracyM: accuracyM == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyM),
    );
  }

  factory Site.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Site(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      latitude: serializer.fromJson<double>(json['latitude']),
      longitude: serializer.fromJson<double>(json['longitude']),
      altitudeM: serializer.fromJson<double?>(json['altitudeM']),
      timeZone: serializer.fromJson<String?>(json['timeZone']),
      source: $SitesTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      sourceText: serializer.fromJson<String?>(json['sourceText']),
      accuracyM: serializer.fromJson<double?>(json['accuracyM']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'latitude': serializer.toJson<double>(latitude),
      'longitude': serializer.toJson<double>(longitude),
      'altitudeM': serializer.toJson<double?>(altitudeM),
      'timeZone': serializer.toJson<String?>(timeZone),
      'source': serializer.toJson<String>(
        $SitesTable.$convertersource.toJson(source),
      ),
      'sourceText': serializer.toJson<String?>(sourceText),
      'accuracyM': serializer.toJson<double?>(accuracyM),
    };
  }

  Site copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    double? latitude,
    double? longitude,
    Value<double?> altitudeM = const Value.absent(),
    Value<String?> timeZone = const Value.absent(),
    LocationSource? source,
    Value<String?> sourceText = const Value.absent(),
    Value<double?> accuracyM = const Value.absent(),
  }) => Site(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    latitude: latitude ?? this.latitude,
    longitude: longitude ?? this.longitude,
    altitudeM: altitudeM.present ? altitudeM.value : this.altitudeM,
    timeZone: timeZone.present ? timeZone.value : this.timeZone,
    source: source ?? this.source,
    sourceText: sourceText.present ? sourceText.value : this.sourceText,
    accuracyM: accuracyM.present ? accuracyM.value : this.accuracyM,
  );
  Site copyWithCompanion(SitesCompanion data) {
    return Site(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      altitudeM: data.altitudeM.present ? data.altitudeM.value : this.altitudeM,
      timeZone: data.timeZone.present ? data.timeZone.value : this.timeZone,
      source: data.source.present ? data.source.value : this.source,
      sourceText: data.sourceText.present
          ? data.sourceText.value
          : this.sourceText,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Site(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('timeZone: $timeZone, ')
          ..write('source: $source, ')
          ..write('sourceText: $sourceText, ')
          ..write('accuracyM: $accuracyM')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    latitude,
    longitude,
    altitudeM,
    timeZone,
    source,
    sourceText,
    accuracyM,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Site &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.altitudeM == this.altitudeM &&
          other.timeZone == this.timeZone &&
          other.source == this.source &&
          other.sourceText == this.sourceText &&
          other.accuracyM == this.accuracyM);
}

class SitesCompanion extends UpdateCompanion<Site> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<double> latitude;
  final Value<double> longitude;
  final Value<double?> altitudeM;
  final Value<String?> timeZone;
  final Value<LocationSource> source;
  final Value<String?> sourceText;
  final Value<double?> accuracyM;
  final Value<int> rowid;
  const SitesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.timeZone = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceText = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SitesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required double latitude,
    required double longitude,
    this.altitudeM = const Value.absent(),
    this.timeZone = const Value.absent(),
    required LocationSource source,
    this.sourceText = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       latitude = Value(latitude),
       longitude = Value(longitude),
       source = Value(source);
  static Insertable<Site> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? altitudeM,
    Expression<String>? timeZone,
    Expression<String>? source,
    Expression<String>? sourceText,
    Expression<double>? accuracyM,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (altitudeM != null) 'altitude_m': altitudeM,
      if (timeZone != null) 'time_zone': timeZone,
      if (source != null) 'source': source,
      if (sourceText != null) 'source_text': sourceText,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SitesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<double>? latitude,
    Value<double>? longitude,
    Value<double?>? altitudeM,
    Value<String?>? timeZone,
    Value<LocationSource>? source,
    Value<String?>? sourceText,
    Value<double?>? accuracyM,
    Value<int>? rowid,
  }) {
    return SitesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      altitudeM: altitudeM ?? this.altitudeM,
      timeZone: timeZone ?? this.timeZone,
      source: source ?? this.source,
      sourceText: sourceText ?? this.sourceText,
      accuracyM: accuracyM ?? this.accuracyM,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (altitudeM.present) {
      map['altitude_m'] = Variable<double>(altitudeM.value);
    }
    if (timeZone.present) {
      map['time_zone'] = Variable<String>(timeZone.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $SitesTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceText.present) {
      map['source_text'] = Variable<String>(sourceText.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SitesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('timeZone: $timeZone, ')
          ..write('source: $source, ')
          ..write('sourceText: $sourceText, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UtilityBillsTable extends UtilityBills
    with TableInfo<$UtilityBillsTable, UtilityBill> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UtilityBillsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clients (id)',
    ),
  );
  static const VerificationMeta _periodStartMeta = const VerificationMeta(
    'periodStart',
  );
  @override
  late final GeneratedColumn<DateTime> periodStart = GeneratedColumn<DateTime>(
    'period_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _periodEndMeta = const VerificationMeta(
    'periodEnd',
  );
  @override
  late final GeneratedColumn<DateTime> periodEnd = GeneratedColumn<DateTime>(
    'period_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BillingPeriod, String>
  billingPeriod = GeneratedColumn<String>(
    'billing_period',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<BillingPeriod>($UtilityBillsTable.$converterbillingPeriod);
  static const VerificationMeta _energyKwhMeta = const VerificationMeta(
    'energyKwh',
  );
  @override
  late final GeneratedColumn<double> energyKwh = GeneratedColumn<double>(
    'energy_kwh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountCentsMeta = const VerificationMeta(
    'amountCents',
  );
  @override
  late final GeneratedColumn<int> amountCents = GeneratedColumn<int>(
    'amount_cents',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('MXN'),
  );
  static const VerificationMeta _tariffCodeMeta = const VerificationMeta(
    'tariffCode',
  );
  @override
  late final GeneratedColumn<String> tariffCode = GeneratedColumn<String>(
    'tariff_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    periodStart,
    periodEnd,
    billingPeriod,
    energyKwh,
    amountCents,
    currency,
    tariffCode,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'utility_bills';
  @override
  VerificationContext validateIntegrity(
    Insertable<UtilityBill> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('period_start')) {
      context.handle(
        _periodStartMeta,
        periodStart.isAcceptableOrUnknown(
          data['period_start']!,
          _periodStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_periodStartMeta);
    }
    if (data.containsKey('period_end')) {
      context.handle(
        _periodEndMeta,
        periodEnd.isAcceptableOrUnknown(data['period_end']!, _periodEndMeta),
      );
    } else if (isInserting) {
      context.missing(_periodEndMeta);
    }
    if (data.containsKey('energy_kwh')) {
      context.handle(
        _energyKwhMeta,
        energyKwh.isAcceptableOrUnknown(data['energy_kwh']!, _energyKwhMeta),
      );
    } else if (isInserting) {
      context.missing(_energyKwhMeta);
    }
    if (data.containsKey('amount_cents')) {
      context.handle(
        _amountCentsMeta,
        amountCents.isAcceptableOrUnknown(
          data['amount_cents']!,
          _amountCentsMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('tariff_code')) {
      context.handle(
        _tariffCodeMeta,
        tariffCode.isAcceptableOrUnknown(data['tariff_code']!, _tariffCodeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UtilityBill map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UtilityBill(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      periodStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_start'],
      )!,
      periodEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}period_end'],
      )!,
      billingPeriod: $UtilityBillsTable.$converterbillingPeriod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}billing_period'],
        )!,
      ),
      energyKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}energy_kwh'],
      )!,
      amountCents: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_cents'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      tariffCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tariff_code'],
      ),
    );
  }

  @override
  $UtilityBillsTable createAlias(String alias) {
    return $UtilityBillsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BillingPeriod, String, String>
  $converterbillingPeriod = const EnumNameConverter<BillingPeriod>(
    BillingPeriod.values,
  );
}

class UtilityBill extends DataClass implements Insertable<UtilityBill> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Cliente al que pertenece el recibo.
  final String clientId;

  /// Inicio del periodo facturado (UTC, día completo).
  final DateTime periodStart;

  /// Fin del periodo facturado (UTC, inclusivo).
  final DateTime periodEnd;

  /// Mensual o bimestral.
  final BillingPeriod billingPeriod;

  /// Energía consumida en el periodo, en kWh.
  final double energyKwh;

  /// Importe total en centavos de la moneda (evita errores de redondeo).
  final int? amountCents;

  /// Moneda ISO 4217 (p. ej. `MXN`).
  final String currency;

  /// Código de tarifa del paquete regional (p. ej. `MX-CFE-1C`).
  final String? tariffCode;
  const UtilityBill({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.clientId,
    required this.periodStart,
    required this.periodEnd,
    required this.billingPeriod,
    required this.energyKwh,
    this.amountCents,
    required this.currency,
    this.tariffCode,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['client_id'] = Variable<String>(clientId);
    map['period_start'] = Variable<DateTime>(periodStart);
    map['period_end'] = Variable<DateTime>(periodEnd);
    {
      map['billing_period'] = Variable<String>(
        $UtilityBillsTable.$converterbillingPeriod.toSql(billingPeriod),
      );
    }
    map['energy_kwh'] = Variable<double>(energyKwh);
    if (!nullToAbsent || amountCents != null) {
      map['amount_cents'] = Variable<int>(amountCents);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || tariffCode != null) {
      map['tariff_code'] = Variable<String>(tariffCode);
    }
    return map;
  }

  UtilityBillsCompanion toCompanion(bool nullToAbsent) {
    return UtilityBillsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      clientId: Value(clientId),
      periodStart: Value(periodStart),
      periodEnd: Value(periodEnd),
      billingPeriod: Value(billingPeriod),
      energyKwh: Value(energyKwh),
      amountCents: amountCents == null && nullToAbsent
          ? const Value.absent()
          : Value(amountCents),
      currency: Value(currency),
      tariffCode: tariffCode == null && nullToAbsent
          ? const Value.absent()
          : Value(tariffCode),
    );
  }

  factory UtilityBill.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UtilityBill(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      clientId: serializer.fromJson<String>(json['clientId']),
      periodStart: serializer.fromJson<DateTime>(json['periodStart']),
      periodEnd: serializer.fromJson<DateTime>(json['periodEnd']),
      billingPeriod: $UtilityBillsTable.$converterbillingPeriod.fromJson(
        serializer.fromJson<String>(json['billingPeriod']),
      ),
      energyKwh: serializer.fromJson<double>(json['energyKwh']),
      amountCents: serializer.fromJson<int?>(json['amountCents']),
      currency: serializer.fromJson<String>(json['currency']),
      tariffCode: serializer.fromJson<String?>(json['tariffCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'clientId': serializer.toJson<String>(clientId),
      'periodStart': serializer.toJson<DateTime>(periodStart),
      'periodEnd': serializer.toJson<DateTime>(periodEnd),
      'billingPeriod': serializer.toJson<String>(
        $UtilityBillsTable.$converterbillingPeriod.toJson(billingPeriod),
      ),
      'energyKwh': serializer.toJson<double>(energyKwh),
      'amountCents': serializer.toJson<int?>(amountCents),
      'currency': serializer.toJson<String>(currency),
      'tariffCode': serializer.toJson<String?>(tariffCode),
    };
  }

  UtilityBill copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? clientId,
    DateTime? periodStart,
    DateTime? periodEnd,
    BillingPeriod? billingPeriod,
    double? energyKwh,
    Value<int?> amountCents = const Value.absent(),
    String? currency,
    Value<String?> tariffCode = const Value.absent(),
  }) => UtilityBill(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    clientId: clientId ?? this.clientId,
    periodStart: periodStart ?? this.periodStart,
    periodEnd: periodEnd ?? this.periodEnd,
    billingPeriod: billingPeriod ?? this.billingPeriod,
    energyKwh: energyKwh ?? this.energyKwh,
    amountCents: amountCents.present ? amountCents.value : this.amountCents,
    currency: currency ?? this.currency,
    tariffCode: tariffCode.present ? tariffCode.value : this.tariffCode,
  );
  UtilityBill copyWithCompanion(UtilityBillsCompanion data) {
    return UtilityBill(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      periodStart: data.periodStart.present
          ? data.periodStart.value
          : this.periodStart,
      periodEnd: data.periodEnd.present ? data.periodEnd.value : this.periodEnd,
      billingPeriod: data.billingPeriod.present
          ? data.billingPeriod.value
          : this.billingPeriod,
      energyKwh: data.energyKwh.present ? data.energyKwh.value : this.energyKwh,
      amountCents: data.amountCents.present
          ? data.amountCents.value
          : this.amountCents,
      currency: data.currency.present ? data.currency.value : this.currency,
      tariffCode: data.tariffCode.present
          ? data.tariffCode.value
          : this.tariffCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UtilityBill(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('billingPeriod: $billingPeriod, ')
          ..write('energyKwh: $energyKwh, ')
          ..write('amountCents: $amountCents, ')
          ..write('currency: $currency, ')
          ..write('tariffCode: $tariffCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    clientId,
    periodStart,
    periodEnd,
    billingPeriod,
    energyKwh,
    amountCents,
    currency,
    tariffCode,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UtilityBill &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.clientId == this.clientId &&
          other.periodStart == this.periodStart &&
          other.periodEnd == this.periodEnd &&
          other.billingPeriod == this.billingPeriod &&
          other.energyKwh == this.energyKwh &&
          other.amountCents == this.amountCents &&
          other.currency == this.currency &&
          other.tariffCode == this.tariffCode);
}

class UtilityBillsCompanion extends UpdateCompanion<UtilityBill> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> clientId;
  final Value<DateTime> periodStart;
  final Value<DateTime> periodEnd;
  final Value<BillingPeriod> billingPeriod;
  final Value<double> energyKwh;
  final Value<int?> amountCents;
  final Value<String> currency;
  final Value<String?> tariffCode;
  final Value<int> rowid;
  const UtilityBillsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.clientId = const Value.absent(),
    this.periodStart = const Value.absent(),
    this.periodEnd = const Value.absent(),
    this.billingPeriod = const Value.absent(),
    this.energyKwh = const Value.absent(),
    this.amountCents = const Value.absent(),
    this.currency = const Value.absent(),
    this.tariffCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UtilityBillsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String clientId,
    required DateTime periodStart,
    required DateTime periodEnd,
    required BillingPeriod billingPeriod,
    required double energyKwh,
    this.amountCents = const Value.absent(),
    this.currency = const Value.absent(),
    this.tariffCode = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientId = Value(clientId),
       periodStart = Value(periodStart),
       periodEnd = Value(periodEnd),
       billingPeriod = Value(billingPeriod),
       energyKwh = Value(energyKwh);
  static Insertable<UtilityBill> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? clientId,
    Expression<DateTime>? periodStart,
    Expression<DateTime>? periodEnd,
    Expression<String>? billingPeriod,
    Expression<double>? energyKwh,
    Expression<int>? amountCents,
    Expression<String>? currency,
    Expression<String>? tariffCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (clientId != null) 'client_id': clientId,
      if (periodStart != null) 'period_start': periodStart,
      if (periodEnd != null) 'period_end': periodEnd,
      if (billingPeriod != null) 'billing_period': billingPeriod,
      if (energyKwh != null) 'energy_kwh': energyKwh,
      if (amountCents != null) 'amount_cents': amountCents,
      if (currency != null) 'currency': currency,
      if (tariffCode != null) 'tariff_code': tariffCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UtilityBillsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? clientId,
    Value<DateTime>? periodStart,
    Value<DateTime>? periodEnd,
    Value<BillingPeriod>? billingPeriod,
    Value<double>? energyKwh,
    Value<int?>? amountCents,
    Value<String>? currency,
    Value<String?>? tariffCode,
    Value<int>? rowid,
  }) {
    return UtilityBillsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      clientId: clientId ?? this.clientId,
      periodStart: periodStart ?? this.periodStart,
      periodEnd: periodEnd ?? this.periodEnd,
      billingPeriod: billingPeriod ?? this.billingPeriod,
      energyKwh: energyKwh ?? this.energyKwh,
      amountCents: amountCents ?? this.amountCents,
      currency: currency ?? this.currency,
      tariffCode: tariffCode ?? this.tariffCode,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (periodStart.present) {
      map['period_start'] = Variable<DateTime>(periodStart.value);
    }
    if (periodEnd.present) {
      map['period_end'] = Variable<DateTime>(periodEnd.value);
    }
    if (billingPeriod.present) {
      map['billing_period'] = Variable<String>(
        $UtilityBillsTable.$converterbillingPeriod.toSql(billingPeriod.value),
      );
    }
    if (energyKwh.present) {
      map['energy_kwh'] = Variable<double>(energyKwh.value);
    }
    if (amountCents.present) {
      map['amount_cents'] = Variable<int>(amountCents.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (tariffCode.present) {
      map['tariff_code'] = Variable<String>(tariffCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UtilityBillsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('clientId: $clientId, ')
          ..write('periodStart: $periodStart, ')
          ..write('periodEnd: $periodEnd, ')
          ..write('billingPeriod: $billingPeriod, ')
          ..write('energyKwh: $energyKwh, ')
          ..write('amountCents: $amountCents, ')
          ..write('currency: $currency, ')
          ..write('tariffCode: $tariffCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotosTable extends Photos with TableInfo<$PhotosTable, Photo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PhotoStage, String> stage =
      GeneratedColumn<String>(
        'stage',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PhotoStage>($PhotosTable.$converterstage);
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthPxMeta = const VerificationMeta(
    'widthPx',
  );
  @override
  late final GeneratedColumn<int> widthPx = GeneratedColumn<int>(
    'width_px',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightPxMeta = const VerificationMeta(
    'heightPx',
  );
  @override
  late final GeneratedColumn<int> heightPx = GeneratedColumn<int>(
    'height_px',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _captionMeta = const VerificationMeta(
    'caption',
  );
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
    'caption',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    stage,
    filePath,
    sha256,
    widthPx,
    heightPx,
    latitude,
    longitude,
    takenAt,
    caption,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Photo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('width_px')) {
      context.handle(
        _widthPxMeta,
        widthPx.isAcceptableOrUnknown(data['width_px']!, _widthPxMeta),
      );
    } else if (isInserting) {
      context.missing(_widthPxMeta);
    }
    if (data.containsKey('height_px')) {
      context.handle(
        _heightPxMeta,
        heightPx.isAcceptableOrUnknown(data['height_px']!, _heightPxMeta),
      );
    } else if (isInserting) {
      context.missing(_heightPxMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    }
    if (data.containsKey('caption')) {
      context.handle(
        _captionMeta,
        caption.isAcceptableOrUnknown(data['caption']!, _captionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Photo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Photo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      stage: $PhotosTable.$converterstage.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}stage'],
        )!,
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      widthPx: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width_px'],
      )!,
      heightPx: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height_px'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      ),
      caption: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caption'],
      ),
    );
  }

  @override
  $PhotosTable createAlias(String alias) {
    return $PhotosTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PhotoStage, String, String> $converterstage =
      const EnumNameConverter<PhotoStage>(PhotoStage.values);
}

class Photo extends DataClass implements Insertable<Photo> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto al que pertenece.
  final String projectId;

  /// Etapa: levantamiento, instalación o mantenimiento.
  final PhotoStage stage;

  /// Ruta relativa al directorio de archivos de la app.
  final String filePath;

  /// SHA-256 (hex) del archivo guardado: detecta duplicados y sirve al
  /// respaldo incremental.
  final String sha256;

  /// Ancho en píxeles.
  final int widthPx;

  /// Alto en píxeles.
  final int heightPx;

  /// Latitud donde se tomó (EXIF o GPS del teléfono), si existe.
  final double? latitude;

  /// Longitud donde se tomó, si existe.
  final double? longitude;

  /// Momento de la toma (UTC), si se conoce.
  final DateTime? takenAt;

  /// Descripción opcional.
  final String? caption;
  const Photo({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.stage,
    required this.filePath,
    required this.sha256,
    required this.widthPx,
    required this.heightPx,
    this.latitude,
    this.longitude,
    this.takenAt,
    this.caption,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    {
      map['stage'] = Variable<String>(
        $PhotosTable.$converterstage.toSql(stage),
      );
    }
    map['file_path'] = Variable<String>(filePath);
    map['sha256'] = Variable<String>(sha256);
    map['width_px'] = Variable<int>(widthPx);
    map['height_px'] = Variable<int>(heightPx);
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || takenAt != null) {
      map['taken_at'] = Variable<DateTime>(takenAt);
    }
    if (!nullToAbsent || caption != null) {
      map['caption'] = Variable<String>(caption);
    }
    return map;
  }

  PhotosCompanion toCompanion(bool nullToAbsent) {
    return PhotosCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      stage: Value(stage),
      filePath: Value(filePath),
      sha256: Value(sha256),
      widthPx: Value(widthPx),
      heightPx: Value(heightPx),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      takenAt: takenAt == null && nullToAbsent
          ? const Value.absent()
          : Value(takenAt),
      caption: caption == null && nullToAbsent
          ? const Value.absent()
          : Value(caption),
    );
  }

  factory Photo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Photo(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      stage: $PhotosTable.$converterstage.fromJson(
        serializer.fromJson<String>(json['stage']),
      ),
      filePath: serializer.fromJson<String>(json['filePath']),
      sha256: serializer.fromJson<String>(json['sha256']),
      widthPx: serializer.fromJson<int>(json['widthPx']),
      heightPx: serializer.fromJson<int>(json['heightPx']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      takenAt: serializer.fromJson<DateTime?>(json['takenAt']),
      caption: serializer.fromJson<String?>(json['caption']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'stage': serializer.toJson<String>(
        $PhotosTable.$converterstage.toJson(stage),
      ),
      'filePath': serializer.toJson<String>(filePath),
      'sha256': serializer.toJson<String>(sha256),
      'widthPx': serializer.toJson<int>(widthPx),
      'heightPx': serializer.toJson<int>(heightPx),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'takenAt': serializer.toJson<DateTime?>(takenAt),
      'caption': serializer.toJson<String?>(caption),
    };
  }

  Photo copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    PhotoStage? stage,
    String? filePath,
    String? sha256,
    int? widthPx,
    int? heightPx,
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<DateTime?> takenAt = const Value.absent(),
    Value<String?> caption = const Value.absent(),
  }) => Photo(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    stage: stage ?? this.stage,
    filePath: filePath ?? this.filePath,
    sha256: sha256 ?? this.sha256,
    widthPx: widthPx ?? this.widthPx,
    heightPx: heightPx ?? this.heightPx,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    takenAt: takenAt.present ? takenAt.value : this.takenAt,
    caption: caption.present ? caption.value : this.caption,
  );
  Photo copyWithCompanion(PhotosCompanion data) {
    return Photo(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      stage: data.stage.present ? data.stage.value : this.stage,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      widthPx: data.widthPx.present ? data.widthPx.value : this.widthPx,
      heightPx: data.heightPx.present ? data.heightPx.value : this.heightPx,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
      caption: data.caption.present ? data.caption.value : this.caption,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Photo(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('stage: $stage, ')
          ..write('filePath: $filePath, ')
          ..write('sha256: $sha256, ')
          ..write('widthPx: $widthPx, ')
          ..write('heightPx: $heightPx, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('takenAt: $takenAt, ')
          ..write('caption: $caption')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    stage,
    filePath,
    sha256,
    widthPx,
    heightPx,
    latitude,
    longitude,
    takenAt,
    caption,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Photo &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.stage == this.stage &&
          other.filePath == this.filePath &&
          other.sha256 == this.sha256 &&
          other.widthPx == this.widthPx &&
          other.heightPx == this.heightPx &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.takenAt == this.takenAt &&
          other.caption == this.caption);
}

class PhotosCompanion extends UpdateCompanion<Photo> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<PhotoStage> stage;
  final Value<String> filePath;
  final Value<String> sha256;
  final Value<int> widthPx;
  final Value<int> heightPx;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<DateTime?> takenAt;
  final Value<String?> caption;
  final Value<int> rowid;
  const PhotosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.stage = const Value.absent(),
    this.filePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.widthPx = const Value.absent(),
    this.heightPx = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required PhotoStage stage,
    required String filePath,
    required String sha256,
    required int widthPx,
    required int heightPx,
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.takenAt = const Value.absent(),
    this.caption = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       stage = Value(stage),
       filePath = Value(filePath),
       sha256 = Value(sha256),
       widthPx = Value(widthPx),
       heightPx = Value(heightPx);
  static Insertable<Photo> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? stage,
    Expression<String>? filePath,
    Expression<String>? sha256,
    Expression<int>? widthPx,
    Expression<int>? heightPx,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<DateTime>? takenAt,
    Expression<String>? caption,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (stage != null) 'stage': stage,
      if (filePath != null) 'file_path': filePath,
      if (sha256 != null) 'sha256': sha256,
      if (widthPx != null) 'width_px': widthPx,
      if (heightPx != null) 'height_px': heightPx,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (takenAt != null) 'taken_at': takenAt,
      if (caption != null) 'caption': caption,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotosCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<PhotoStage>? stage,
    Value<String>? filePath,
    Value<String>? sha256,
    Value<int>? widthPx,
    Value<int>? heightPx,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<DateTime?>? takenAt,
    Value<String?>? caption,
    Value<int>? rowid,
  }) {
    return PhotosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      stage: stage ?? this.stage,
      filePath: filePath ?? this.filePath,
      sha256: sha256 ?? this.sha256,
      widthPx: widthPx ?? this.widthPx,
      heightPx: heightPx ?? this.heightPx,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      takenAt: takenAt ?? this.takenAt,
      caption: caption ?? this.caption,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (stage.present) {
      map['stage'] = Variable<String>(
        $PhotosTable.$converterstage.toSql(stage.value),
      );
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (widthPx.present) {
      map['width_px'] = Variable<int>(widthPx.value);
    }
    if (heightPx.present) {
      map['height_px'] = Variable<int>(heightPx.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('stage: $stage, ')
          ..write('filePath: $filePath, ')
          ..write('sha256: $sha256, ')
          ..write('widthPx: $widthPx, ')
          ..write('heightPx: $heightPx, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('takenAt: $takenAt, ')
          ..write('caption: $caption, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumentsTable extends Documents
    with TableInfo<$DocumentsTable, Document> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DocumentKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DocumentKind>($DocumentsTable.$converterkind);
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    title,
    kind,
    filePath,
    mimeType,
    sizeBytes,
    sha256,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documents';
  @override
  VerificationContext validateIntegrity(
    Insertable<Document> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    } else if (isInserting) {
      context.missing(_filePathMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mimeTypeMeta);
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeBytesMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Document map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Document(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: $DocumentsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
    );
  }

  @override
  $DocumentsTable createAlias(String alias) {
    return $DocumentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DocumentKind, String, String> $converterkind =
      const EnumNameConverter<DocumentKind>(DocumentKind.values);
}

class Document extends DataClass implements Insertable<Document> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto al que pertenece.
  final String projectId;

  /// Título visible (por defecto, el nombre del archivo).
  final String title;

  /// PDF o imagen.
  final DocumentKind kind;

  /// Ruta relativa al directorio de archivos de la app.
  final String filePath;

  /// Tipo MIME (p. ej. `application/pdf`).
  final String mimeType;

  /// Tamaño en bytes.
  final int sizeBytes;

  /// SHA-256 (hex) del archivo.
  final String sha256;
  const Document({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.title,
    required this.kind,
    required this.filePath,
    required this.mimeType,
    required this.sizeBytes,
    required this.sha256,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    map['title'] = Variable<String>(title);
    {
      map['kind'] = Variable<String>(
        $DocumentsTable.$converterkind.toSql(kind),
      );
    }
    map['file_path'] = Variable<String>(filePath);
    map['mime_type'] = Variable<String>(mimeType);
    map['size_bytes'] = Variable<int>(sizeBytes);
    map['sha256'] = Variable<String>(sha256);
    return map;
  }

  DocumentsCompanion toCompanion(bool nullToAbsent) {
    return DocumentsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      title: Value(title),
      kind: Value(kind),
      filePath: Value(filePath),
      mimeType: Value(mimeType),
      sizeBytes: Value(sizeBytes),
      sha256: Value(sha256),
    );
  }

  factory Document.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Document(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      title: serializer.fromJson<String>(json['title']),
      kind: $DocumentsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      filePath: serializer.fromJson<String>(json['filePath']),
      mimeType: serializer.fromJson<String>(json['mimeType']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      sha256: serializer.fromJson<String>(json['sha256']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(
        $DocumentsTable.$converterkind.toJson(kind),
      ),
      'filePath': serializer.toJson<String>(filePath),
      'mimeType': serializer.toJson<String>(mimeType),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'sha256': serializer.toJson<String>(sha256),
    };
  }

  Document copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    String? title,
    DocumentKind? kind,
    String? filePath,
    String? mimeType,
    int? sizeBytes,
    String? sha256,
  }) => Document(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    filePath: filePath ?? this.filePath,
    mimeType: mimeType ?? this.mimeType,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    sha256: sha256 ?? this.sha256,
  );
  Document copyWithCompanion(DocumentsCompanion data) {
    return Document(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Document(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('filePath: $filePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('sha256: $sha256')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    title,
    kind,
    filePath,
    mimeType,
    sizeBytes,
    sha256,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.filePath == this.filePath &&
          other.mimeType == this.mimeType &&
          other.sizeBytes == this.sizeBytes &&
          other.sha256 == this.sha256);
}

class DocumentsCompanion extends UpdateCompanion<Document> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<String> title;
  final Value<DocumentKind> kind;
  final Value<String> filePath;
  final Value<String> mimeType;
  final Value<int> sizeBytes;
  final Value<String> sha256;
  final Value<int> rowid;
  const DocumentsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.filePath = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumentsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required String title,
    required DocumentKind kind,
    required String filePath,
    required String mimeType,
    required int sizeBytes,
    required String sha256,
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       title = Value(title),
       kind = Value(kind),
       filePath = Value(filePath),
       mimeType = Value(mimeType),
       sizeBytes = Value(sizeBytes),
       sha256 = Value(sha256);
  static Insertable<Document> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<String>? filePath,
    Expression<String>? mimeType,
    Expression<int>? sizeBytes,
    Expression<String>? sha256,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (filePath != null) 'file_path': filePath,
      if (mimeType != null) 'mime_type': mimeType,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (sha256 != null) 'sha256': sha256,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumentsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<String>? title,
    Value<DocumentKind>? kind,
    Value<String>? filePath,
    Value<String>? mimeType,
    Value<int>? sizeBytes,
    Value<String>? sha256,
    Value<int>? rowid,
  }) {
    return DocumentsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      filePath: filePath ?? this.filePath,
      mimeType: mimeType ?? this.mimeType,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      sha256: sha256 ?? this.sha256,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $DocumentsTable.$converterkind.toSql(kind.value),
      );
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumentsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('filePath: $filePath, ')
          ..write('mimeType: $mimeType, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('sha256: $sha256, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoofImagesTable extends RoofImages
    with TableInfo<$RoofImagesTable, RoofImage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoofImagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES projects (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RoofMode, String> mode =
      GeneratedColumn<String>(
        'mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RoofMode>($RoofImagesTable.$convertermode);
  static const VerificationMeta _filePathMeta = const VerificationMeta(
    'filePath',
  );
  @override
  late final GeneratedColumn<String> filePath = GeneratedColumn<String>(
    'file_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _widthPxMeta = const VerificationMeta(
    'widthPx',
  );
  @override
  late final GeneratedColumn<int> widthPx = GeneratedColumn<int>(
    'width_px',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightPxMeta = const VerificationMeta(
    'heightPx',
  );
  @override
  late final GeneratedColumn<int> heightPx = GeneratedColumn<int>(
    'height_px',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _metersPerPixelMeta = const VerificationMeta(
    'metersPerPixel',
  );
  @override
  late final GeneratedColumn<double> metersPerPixel = GeneratedColumn<double>(
    'meters_per_pixel',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _calibrationLineMeta = const VerificationMeta(
    'calibrationLine',
  );
  @override
  late final GeneratedColumn<String> calibrationLine = GeneratedColumn<String>(
    'calibration_line',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _verificationLineMeta = const VerificationMeta(
    'verificationLine',
  );
  @override
  late final GeneratedColumn<String> verificationLine = GeneratedColumn<String>(
    'verification_line',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _northAngleDegMeta = const VerificationMeta(
    'northAngleDeg',
  );
  @override
  late final GeneratedColumn<double> northAngleDeg = GeneratedColumn<double>(
    'north_angle_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<NorthSource, String> northSource =
      GeneratedColumn<String>(
        'north_source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(NorthSource.imageUp.name),
      ).withConverter<NorthSource>($RoofImagesTable.$converternorthSource);
  static const VerificationMeta _magneticDeclinationDegMeta =
      const VerificationMeta('magneticDeclinationDeg');
  @override
  late final GeneratedColumn<double> magneticDeclinationDeg =
      GeneratedColumn<double>(
        'magnetic_declination_deg',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    mode,
    filePath,
    sha256,
    widthPx,
    heightPx,
    metersPerPixel,
    calibrationLine,
    verificationLine,
    northAngleDeg,
    northSource,
    magneticDeclinationDeg,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roof_images';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoofImage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('file_path')) {
      context.handle(
        _filePathMeta,
        filePath.isAcceptableOrUnknown(data['file_path']!, _filePathMeta),
      );
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    }
    if (data.containsKey('width_px')) {
      context.handle(
        _widthPxMeta,
        widthPx.isAcceptableOrUnknown(data['width_px']!, _widthPxMeta),
      );
    }
    if (data.containsKey('height_px')) {
      context.handle(
        _heightPxMeta,
        heightPx.isAcceptableOrUnknown(data['height_px']!, _heightPxMeta),
      );
    }
    if (data.containsKey('meters_per_pixel')) {
      context.handle(
        _metersPerPixelMeta,
        metersPerPixel.isAcceptableOrUnknown(
          data['meters_per_pixel']!,
          _metersPerPixelMeta,
        ),
      );
    }
    if (data.containsKey('calibration_line')) {
      context.handle(
        _calibrationLineMeta,
        calibrationLine.isAcceptableOrUnknown(
          data['calibration_line']!,
          _calibrationLineMeta,
        ),
      );
    }
    if (data.containsKey('verification_line')) {
      context.handle(
        _verificationLineMeta,
        verificationLine.isAcceptableOrUnknown(
          data['verification_line']!,
          _verificationLineMeta,
        ),
      );
    }
    if (data.containsKey('north_angle_deg')) {
      context.handle(
        _northAngleDegMeta,
        northAngleDeg.isAcceptableOrUnknown(
          data['north_angle_deg']!,
          _northAngleDegMeta,
        ),
      );
    }
    if (data.containsKey('magnetic_declination_deg')) {
      context.handle(
        _magneticDeclinationDegMeta,
        magneticDeclinationDeg.isAcceptableOrUnknown(
          data['magnetic_declination_deg']!,
          _magneticDeclinationDegMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoofImage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoofImage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      mode: $RoofImagesTable.$convertermode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}mode'],
        )!,
      ),
      filePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_path'],
      ),
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      ),
      widthPx: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}width_px'],
      ),
      heightPx: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}height_px'],
      ),
      metersPerPixel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}meters_per_pixel'],
      ),
      calibrationLine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}calibration_line'],
      ),
      verificationLine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_line'],
      ),
      northAngleDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}north_angle_deg'],
      )!,
      northSource: $RoofImagesTable.$converternorthSource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}north_source'],
        )!,
      ),
      magneticDeclinationDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}magnetic_declination_deg'],
      ),
    );
  }

  @override
  $RoofImagesTable createAlias(String alias) {
    return $RoofImagesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RoofMode, String, String> $convertermode =
      const EnumNameConverter<RoofMode>(RoofMode.values);
  static JsonTypeConverter2<NorthSource, String, String> $converternorthSource =
      const EnumNameConverter<NorthSource>(NorthSource.values);
}

class RoofImage extends DataClass implements Insertable<RoofImage> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto al que pertenece (único).
  final String projectId;

  /// Imagen calibrada o croquis con cinta.
  final RoofMode mode;

  /// Ruta relativa de la imagen (vacía en modo croquis).
  final String? filePath;

  /// SHA-256 de la imagen guardada.
  final String? sha256;

  /// Ancho de la imagen en píxeles.
  final int? widthPx;

  /// Alto de la imagen en píxeles.
  final int? heightPx;

  /// Escala: metros por píxel (vacía hasta calibrar).
  final double? metersPerPixel;

  /// Línea de calibración en JSON `{"a":[x,y],"b":[x,y],"m":metros}`
  /// (píxeles de la imagen).
  final String? calibrationLine;

  /// Segunda línea opcional para verificar la escala (mismo formato).
  final String? verificationLine;

  /// Ángulo del norte en la imagen (grados, horario desde arriba).
  final double northAngleDeg;

  /// De dónde salió el norte.
  final NorthSource northSource;

  /// Declinación magnética usada al confirmar con brújula (grados, WMM).
  final double? magneticDeclinationDeg;
  const RoofImage({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.mode,
    this.filePath,
    this.sha256,
    this.widthPx,
    this.heightPx,
    this.metersPerPixel,
    this.calibrationLine,
    this.verificationLine,
    required this.northAngleDeg,
    required this.northSource,
    this.magneticDeclinationDeg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    {
      map['mode'] = Variable<String>(
        $RoofImagesTable.$convertermode.toSql(mode),
      );
    }
    if (!nullToAbsent || filePath != null) {
      map['file_path'] = Variable<String>(filePath);
    }
    if (!nullToAbsent || sha256 != null) {
      map['sha256'] = Variable<String>(sha256);
    }
    if (!nullToAbsent || widthPx != null) {
      map['width_px'] = Variable<int>(widthPx);
    }
    if (!nullToAbsent || heightPx != null) {
      map['height_px'] = Variable<int>(heightPx);
    }
    if (!nullToAbsent || metersPerPixel != null) {
      map['meters_per_pixel'] = Variable<double>(metersPerPixel);
    }
    if (!nullToAbsent || calibrationLine != null) {
      map['calibration_line'] = Variable<String>(calibrationLine);
    }
    if (!nullToAbsent || verificationLine != null) {
      map['verification_line'] = Variable<String>(verificationLine);
    }
    map['north_angle_deg'] = Variable<double>(northAngleDeg);
    {
      map['north_source'] = Variable<String>(
        $RoofImagesTable.$converternorthSource.toSql(northSource),
      );
    }
    if (!nullToAbsent || magneticDeclinationDeg != null) {
      map['magnetic_declination_deg'] = Variable<double>(
        magneticDeclinationDeg,
      );
    }
    return map;
  }

  RoofImagesCompanion toCompanion(bool nullToAbsent) {
    return RoofImagesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      mode: Value(mode),
      filePath: filePath == null && nullToAbsent
          ? const Value.absent()
          : Value(filePath),
      sha256: sha256 == null && nullToAbsent
          ? const Value.absent()
          : Value(sha256),
      widthPx: widthPx == null && nullToAbsent
          ? const Value.absent()
          : Value(widthPx),
      heightPx: heightPx == null && nullToAbsent
          ? const Value.absent()
          : Value(heightPx),
      metersPerPixel: metersPerPixel == null && nullToAbsent
          ? const Value.absent()
          : Value(metersPerPixel),
      calibrationLine: calibrationLine == null && nullToAbsent
          ? const Value.absent()
          : Value(calibrationLine),
      verificationLine: verificationLine == null && nullToAbsent
          ? const Value.absent()
          : Value(verificationLine),
      northAngleDeg: Value(northAngleDeg),
      northSource: Value(northSource),
      magneticDeclinationDeg: magneticDeclinationDeg == null && nullToAbsent
          ? const Value.absent()
          : Value(magneticDeclinationDeg),
    );
  }

  factory RoofImage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoofImage(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      mode: $RoofImagesTable.$convertermode.fromJson(
        serializer.fromJson<String>(json['mode']),
      ),
      filePath: serializer.fromJson<String?>(json['filePath']),
      sha256: serializer.fromJson<String?>(json['sha256']),
      widthPx: serializer.fromJson<int?>(json['widthPx']),
      heightPx: serializer.fromJson<int?>(json['heightPx']),
      metersPerPixel: serializer.fromJson<double?>(json['metersPerPixel']),
      calibrationLine: serializer.fromJson<String?>(json['calibrationLine']),
      verificationLine: serializer.fromJson<String?>(json['verificationLine']),
      northAngleDeg: serializer.fromJson<double>(json['northAngleDeg']),
      northSource: $RoofImagesTable.$converternorthSource.fromJson(
        serializer.fromJson<String>(json['northSource']),
      ),
      magneticDeclinationDeg: serializer.fromJson<double?>(
        json['magneticDeclinationDeg'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'mode': serializer.toJson<String>(
        $RoofImagesTable.$convertermode.toJson(mode),
      ),
      'filePath': serializer.toJson<String?>(filePath),
      'sha256': serializer.toJson<String?>(sha256),
      'widthPx': serializer.toJson<int?>(widthPx),
      'heightPx': serializer.toJson<int?>(heightPx),
      'metersPerPixel': serializer.toJson<double?>(metersPerPixel),
      'calibrationLine': serializer.toJson<String?>(calibrationLine),
      'verificationLine': serializer.toJson<String?>(verificationLine),
      'northAngleDeg': serializer.toJson<double>(northAngleDeg),
      'northSource': serializer.toJson<String>(
        $RoofImagesTable.$converternorthSource.toJson(northSource),
      ),
      'magneticDeclinationDeg': serializer.toJson<double?>(
        magneticDeclinationDeg,
      ),
    };
  }

  RoofImage copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    RoofMode? mode,
    Value<String?> filePath = const Value.absent(),
    Value<String?> sha256 = const Value.absent(),
    Value<int?> widthPx = const Value.absent(),
    Value<int?> heightPx = const Value.absent(),
    Value<double?> metersPerPixel = const Value.absent(),
    Value<String?> calibrationLine = const Value.absent(),
    Value<String?> verificationLine = const Value.absent(),
    double? northAngleDeg,
    NorthSource? northSource,
    Value<double?> magneticDeclinationDeg = const Value.absent(),
  }) => RoofImage(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    mode: mode ?? this.mode,
    filePath: filePath.present ? filePath.value : this.filePath,
    sha256: sha256.present ? sha256.value : this.sha256,
    widthPx: widthPx.present ? widthPx.value : this.widthPx,
    heightPx: heightPx.present ? heightPx.value : this.heightPx,
    metersPerPixel: metersPerPixel.present
        ? metersPerPixel.value
        : this.metersPerPixel,
    calibrationLine: calibrationLine.present
        ? calibrationLine.value
        : this.calibrationLine,
    verificationLine: verificationLine.present
        ? verificationLine.value
        : this.verificationLine,
    northAngleDeg: northAngleDeg ?? this.northAngleDeg,
    northSource: northSource ?? this.northSource,
    magneticDeclinationDeg: magneticDeclinationDeg.present
        ? magneticDeclinationDeg.value
        : this.magneticDeclinationDeg,
  );
  RoofImage copyWithCompanion(RoofImagesCompanion data) {
    return RoofImage(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      mode: data.mode.present ? data.mode.value : this.mode,
      filePath: data.filePath.present ? data.filePath.value : this.filePath,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      widthPx: data.widthPx.present ? data.widthPx.value : this.widthPx,
      heightPx: data.heightPx.present ? data.heightPx.value : this.heightPx,
      metersPerPixel: data.metersPerPixel.present
          ? data.metersPerPixel.value
          : this.metersPerPixel,
      calibrationLine: data.calibrationLine.present
          ? data.calibrationLine.value
          : this.calibrationLine,
      verificationLine: data.verificationLine.present
          ? data.verificationLine.value
          : this.verificationLine,
      northAngleDeg: data.northAngleDeg.present
          ? data.northAngleDeg.value
          : this.northAngleDeg,
      northSource: data.northSource.present
          ? data.northSource.value
          : this.northSource,
      magneticDeclinationDeg: data.magneticDeclinationDeg.present
          ? data.magneticDeclinationDeg.value
          : this.magneticDeclinationDeg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoofImage(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('mode: $mode, ')
          ..write('filePath: $filePath, ')
          ..write('sha256: $sha256, ')
          ..write('widthPx: $widthPx, ')
          ..write('heightPx: $heightPx, ')
          ..write('metersPerPixel: $metersPerPixel, ')
          ..write('calibrationLine: $calibrationLine, ')
          ..write('verificationLine: $verificationLine, ')
          ..write('northAngleDeg: $northAngleDeg, ')
          ..write('northSource: $northSource, ')
          ..write('magneticDeclinationDeg: $magneticDeclinationDeg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    mode,
    filePath,
    sha256,
    widthPx,
    heightPx,
    metersPerPixel,
    calibrationLine,
    verificationLine,
    northAngleDeg,
    northSource,
    magneticDeclinationDeg,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoofImage &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.mode == this.mode &&
          other.filePath == this.filePath &&
          other.sha256 == this.sha256 &&
          other.widthPx == this.widthPx &&
          other.heightPx == this.heightPx &&
          other.metersPerPixel == this.metersPerPixel &&
          other.calibrationLine == this.calibrationLine &&
          other.verificationLine == this.verificationLine &&
          other.northAngleDeg == this.northAngleDeg &&
          other.northSource == this.northSource &&
          other.magneticDeclinationDeg == this.magneticDeclinationDeg);
}

class RoofImagesCompanion extends UpdateCompanion<RoofImage> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<RoofMode> mode;
  final Value<String?> filePath;
  final Value<String?> sha256;
  final Value<int?> widthPx;
  final Value<int?> heightPx;
  final Value<double?> metersPerPixel;
  final Value<String?> calibrationLine;
  final Value<String?> verificationLine;
  final Value<double> northAngleDeg;
  final Value<NorthSource> northSource;
  final Value<double?> magneticDeclinationDeg;
  final Value<int> rowid;
  const RoofImagesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.mode = const Value.absent(),
    this.filePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.widthPx = const Value.absent(),
    this.heightPx = const Value.absent(),
    this.metersPerPixel = const Value.absent(),
    this.calibrationLine = const Value.absent(),
    this.verificationLine = const Value.absent(),
    this.northAngleDeg = const Value.absent(),
    this.northSource = const Value.absent(),
    this.magneticDeclinationDeg = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoofImagesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required RoofMode mode,
    this.filePath = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.widthPx = const Value.absent(),
    this.heightPx = const Value.absent(),
    this.metersPerPixel = const Value.absent(),
    this.calibrationLine = const Value.absent(),
    this.verificationLine = const Value.absent(),
    this.northAngleDeg = const Value.absent(),
    this.northSource = const Value.absent(),
    this.magneticDeclinationDeg = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       mode = Value(mode);
  static Insertable<RoofImage> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? mode,
    Expression<String>? filePath,
    Expression<String>? sha256,
    Expression<int>? widthPx,
    Expression<int>? heightPx,
    Expression<double>? metersPerPixel,
    Expression<String>? calibrationLine,
    Expression<String>? verificationLine,
    Expression<double>? northAngleDeg,
    Expression<String>? northSource,
    Expression<double>? magneticDeclinationDeg,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (mode != null) 'mode': mode,
      if (filePath != null) 'file_path': filePath,
      if (sha256 != null) 'sha256': sha256,
      if (widthPx != null) 'width_px': widthPx,
      if (heightPx != null) 'height_px': heightPx,
      if (metersPerPixel != null) 'meters_per_pixel': metersPerPixel,
      if (calibrationLine != null) 'calibration_line': calibrationLine,
      if (verificationLine != null) 'verification_line': verificationLine,
      if (northAngleDeg != null) 'north_angle_deg': northAngleDeg,
      if (northSource != null) 'north_source': northSource,
      if (magneticDeclinationDeg != null)
        'magnetic_declination_deg': magneticDeclinationDeg,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoofImagesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<RoofMode>? mode,
    Value<String?>? filePath,
    Value<String?>? sha256,
    Value<int?>? widthPx,
    Value<int?>? heightPx,
    Value<double?>? metersPerPixel,
    Value<String?>? calibrationLine,
    Value<String?>? verificationLine,
    Value<double>? northAngleDeg,
    Value<NorthSource>? northSource,
    Value<double?>? magneticDeclinationDeg,
    Value<int>? rowid,
  }) {
    return RoofImagesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      mode: mode ?? this.mode,
      filePath: filePath ?? this.filePath,
      sha256: sha256 ?? this.sha256,
      widthPx: widthPx ?? this.widthPx,
      heightPx: heightPx ?? this.heightPx,
      metersPerPixel: metersPerPixel ?? this.metersPerPixel,
      calibrationLine: calibrationLine ?? this.calibrationLine,
      verificationLine: verificationLine ?? this.verificationLine,
      northAngleDeg: northAngleDeg ?? this.northAngleDeg,
      northSource: northSource ?? this.northSource,
      magneticDeclinationDeg:
          magneticDeclinationDeg ?? this.magneticDeclinationDeg,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (mode.present) {
      map['mode'] = Variable<String>(
        $RoofImagesTable.$convertermode.toSql(mode.value),
      );
    }
    if (filePath.present) {
      map['file_path'] = Variable<String>(filePath.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (widthPx.present) {
      map['width_px'] = Variable<int>(widthPx.value);
    }
    if (heightPx.present) {
      map['height_px'] = Variable<int>(heightPx.value);
    }
    if (metersPerPixel.present) {
      map['meters_per_pixel'] = Variable<double>(metersPerPixel.value);
    }
    if (calibrationLine.present) {
      map['calibration_line'] = Variable<String>(calibrationLine.value);
    }
    if (verificationLine.present) {
      map['verification_line'] = Variable<String>(verificationLine.value);
    }
    if (northAngleDeg.present) {
      map['north_angle_deg'] = Variable<double>(northAngleDeg.value);
    }
    if (northSource.present) {
      map['north_source'] = Variable<String>(
        $RoofImagesTable.$converternorthSource.toSql(northSource.value),
      );
    }
    if (magneticDeclinationDeg.present) {
      map['magnetic_declination_deg'] = Variable<double>(
        magneticDeclinationDeg.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoofImagesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('mode: $mode, ')
          ..write('filePath: $filePath, ')
          ..write('sha256: $sha256, ')
          ..write('widthPx: $widthPx, ')
          ..write('heightPx: $heightPx, ')
          ..write('metersPerPixel: $metersPerPixel, ')
          ..write('calibrationLine: $calibrationLine, ')
          ..write('verificationLine: $verificationLine, ')
          ..write('northAngleDeg: $northAngleDeg, ')
          ..write('northSource: $northSource, ')
          ..write('magneticDeclinationDeg: $magneticDeclinationDeg, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RoofPlanesTable extends RoofPlanes
    with TableInfo<$RoofPlanesTable, RoofPlane> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RoofPlanesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _polygonMeta = const VerificationMeta(
    'polygon',
  );
  @override
  late final GeneratedColumn<String> polygon = GeneratedColumn<String>(
    'polygon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tiltDegMeta = const VerificationMeta(
    'tiltDeg',
  );
  @override
  late final GeneratedColumn<double> tiltDeg = GeneratedColumn<double>(
    'tilt_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TiltSource, String> tiltSource =
      GeneratedColumn<String>(
        'tilt_source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(TiltSource.manual.name),
      ).withConverter<TiltSource>($RoofPlanesTable.$convertertiltSource);
  static const VerificationMeta _azimuthDegMeta = const VerificationMeta(
    'azimuthDeg',
  );
  @override
  late final GeneratedColumn<double> azimuthDeg = GeneratedColumn<double>(
    'azimuth_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(180),
  );
  static const VerificationMeta _azimuthEdgeIndexMeta = const VerificationMeta(
    'azimuthEdgeIndex',
  );
  @override
  late final GeneratedColumn<int> azimuthEdgeIndex = GeneratedColumn<int>(
    'azimuth_edge_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _edgeSetbackMMeta = const VerificationMeta(
    'edgeSetbackM',
  );
  @override
  late final GeneratedColumn<double> edgeSetbackM = GeneratedColumn<double>(
    'edge_setback_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _walkwaysMeta = const VerificationMeta(
    'walkways',
  );
  @override
  late final GeneratedColumn<String> walkways = GeneratedColumn<String>(
    'walkways',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    name,
    polygon,
    tiltDeg,
    tiltSource,
    azimuthDeg,
    azimuthEdgeIndex,
    edgeSetbackM,
    walkways,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'roof_planes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RoofPlane> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('polygon')) {
      context.handle(
        _polygonMeta,
        polygon.isAcceptableOrUnknown(data['polygon']!, _polygonMeta),
      );
    } else if (isInserting) {
      context.missing(_polygonMeta);
    }
    if (data.containsKey('tilt_deg')) {
      context.handle(
        _tiltDegMeta,
        tiltDeg.isAcceptableOrUnknown(data['tilt_deg']!, _tiltDegMeta),
      );
    }
    if (data.containsKey('azimuth_deg')) {
      context.handle(
        _azimuthDegMeta,
        azimuthDeg.isAcceptableOrUnknown(data['azimuth_deg']!, _azimuthDegMeta),
      );
    }
    if (data.containsKey('azimuth_edge_index')) {
      context.handle(
        _azimuthEdgeIndexMeta,
        azimuthEdgeIndex.isAcceptableOrUnknown(
          data['azimuth_edge_index']!,
          _azimuthEdgeIndexMeta,
        ),
      );
    }
    if (data.containsKey('edge_setback_m')) {
      context.handle(
        _edgeSetbackMMeta,
        edgeSetbackM.isAcceptableOrUnknown(
          data['edge_setback_m']!,
          _edgeSetbackMMeta,
        ),
      );
    }
    if (data.containsKey('walkways')) {
      context.handle(
        _walkwaysMeta,
        walkways.isAcceptableOrUnknown(data['walkways']!, _walkwaysMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RoofPlane map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RoofPlane(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      polygon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}polygon'],
      )!,
      tiltDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tilt_deg'],
      )!,
      tiltSource: $RoofPlanesTable.$convertertiltSource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tilt_source'],
        )!,
      ),
      azimuthDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}azimuth_deg'],
      )!,
      azimuthEdgeIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}azimuth_edge_index'],
      ),
      edgeSetbackM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}edge_setback_m'],
      )!,
      walkways: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}walkways'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $RoofPlanesTable createAlias(String alias) {
    return $RoofPlanesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TiltSource, String, String> $convertertiltSource =
      const EnumNameConverter<TiltSource>(TiltSource.values);
}

class RoofPlane extends DataClass implements Insertable<RoofPlane> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Nombre visible ("Plano 1", "Agua sur"...).
  final String name;

  /// Vértices en JSON `[[x,y],...]` (metros).
  final String polygon;

  /// Inclinación (grados, 0 = plano).
  final double tiltDeg;

  /// De dónde salió la inclinación.
  final TiltSource tiltSource;

  /// Azimut hacia donde baja el plano (grados, 180 = sur).
  final double azimuthDeg;

  /// Arista elegida como orilla baja para calcular el azimut, si hay.
  final int? azimuthEdgeIndex;

  /// Retiro de borde (m) en todo el contorno.
  final double edgeSetbackM;

  /// Pasillos de mantenimiento en JSON
  /// `[{"a":[x,y],"b":[x,y],"w":ancho}]` (metros).
  final String walkways;

  /// Orden en la lista.
  final int sortOrder;
  const RoofPlane({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.name,
    required this.polygon,
    required this.tiltDeg,
    required this.tiltSource,
    required this.azimuthDeg,
    this.azimuthEdgeIndex,
    required this.edgeSetbackM,
    required this.walkways,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    map['name'] = Variable<String>(name);
    map['polygon'] = Variable<String>(polygon);
    map['tilt_deg'] = Variable<double>(tiltDeg);
    {
      map['tilt_source'] = Variable<String>(
        $RoofPlanesTable.$convertertiltSource.toSql(tiltSource),
      );
    }
    map['azimuth_deg'] = Variable<double>(azimuthDeg);
    if (!nullToAbsent || azimuthEdgeIndex != null) {
      map['azimuth_edge_index'] = Variable<int>(azimuthEdgeIndex);
    }
    map['edge_setback_m'] = Variable<double>(edgeSetbackM);
    map['walkways'] = Variable<String>(walkways);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  RoofPlanesCompanion toCompanion(bool nullToAbsent) {
    return RoofPlanesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      name: Value(name),
      polygon: Value(polygon),
      tiltDeg: Value(tiltDeg),
      tiltSource: Value(tiltSource),
      azimuthDeg: Value(azimuthDeg),
      azimuthEdgeIndex: azimuthEdgeIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(azimuthEdgeIndex),
      edgeSetbackM: Value(edgeSetbackM),
      walkways: Value(walkways),
      sortOrder: Value(sortOrder),
    );
  }

  factory RoofPlane.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RoofPlane(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      name: serializer.fromJson<String>(json['name']),
      polygon: serializer.fromJson<String>(json['polygon']),
      tiltDeg: serializer.fromJson<double>(json['tiltDeg']),
      tiltSource: $RoofPlanesTable.$convertertiltSource.fromJson(
        serializer.fromJson<String>(json['tiltSource']),
      ),
      azimuthDeg: serializer.fromJson<double>(json['azimuthDeg']),
      azimuthEdgeIndex: serializer.fromJson<int?>(json['azimuthEdgeIndex']),
      edgeSetbackM: serializer.fromJson<double>(json['edgeSetbackM']),
      walkways: serializer.fromJson<String>(json['walkways']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'name': serializer.toJson<String>(name),
      'polygon': serializer.toJson<String>(polygon),
      'tiltDeg': serializer.toJson<double>(tiltDeg),
      'tiltSource': serializer.toJson<String>(
        $RoofPlanesTable.$convertertiltSource.toJson(tiltSource),
      ),
      'azimuthDeg': serializer.toJson<double>(azimuthDeg),
      'azimuthEdgeIndex': serializer.toJson<int?>(azimuthEdgeIndex),
      'edgeSetbackM': serializer.toJson<double>(edgeSetbackM),
      'walkways': serializer.toJson<String>(walkways),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  RoofPlane copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    String? name,
    String? polygon,
    double? tiltDeg,
    TiltSource? tiltSource,
    double? azimuthDeg,
    Value<int?> azimuthEdgeIndex = const Value.absent(),
    double? edgeSetbackM,
    String? walkways,
    int? sortOrder,
  }) => RoofPlane(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    name: name ?? this.name,
    polygon: polygon ?? this.polygon,
    tiltDeg: tiltDeg ?? this.tiltDeg,
    tiltSource: tiltSource ?? this.tiltSource,
    azimuthDeg: azimuthDeg ?? this.azimuthDeg,
    azimuthEdgeIndex: azimuthEdgeIndex.present
        ? azimuthEdgeIndex.value
        : this.azimuthEdgeIndex,
    edgeSetbackM: edgeSetbackM ?? this.edgeSetbackM,
    walkways: walkways ?? this.walkways,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  RoofPlane copyWithCompanion(RoofPlanesCompanion data) {
    return RoofPlane(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      name: data.name.present ? data.name.value : this.name,
      polygon: data.polygon.present ? data.polygon.value : this.polygon,
      tiltDeg: data.tiltDeg.present ? data.tiltDeg.value : this.tiltDeg,
      tiltSource: data.tiltSource.present
          ? data.tiltSource.value
          : this.tiltSource,
      azimuthDeg: data.azimuthDeg.present
          ? data.azimuthDeg.value
          : this.azimuthDeg,
      azimuthEdgeIndex: data.azimuthEdgeIndex.present
          ? data.azimuthEdgeIndex.value
          : this.azimuthEdgeIndex,
      edgeSetbackM: data.edgeSetbackM.present
          ? data.edgeSetbackM.value
          : this.edgeSetbackM,
      walkways: data.walkways.present ? data.walkways.value : this.walkways,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RoofPlane(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('polygon: $polygon, ')
          ..write('tiltDeg: $tiltDeg, ')
          ..write('tiltSource: $tiltSource, ')
          ..write('azimuthDeg: $azimuthDeg, ')
          ..write('azimuthEdgeIndex: $azimuthEdgeIndex, ')
          ..write('edgeSetbackM: $edgeSetbackM, ')
          ..write('walkways: $walkways, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    name,
    polygon,
    tiltDeg,
    tiltSource,
    azimuthDeg,
    azimuthEdgeIndex,
    edgeSetbackM,
    walkways,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RoofPlane &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.name == this.name &&
          other.polygon == this.polygon &&
          other.tiltDeg == this.tiltDeg &&
          other.tiltSource == this.tiltSource &&
          other.azimuthDeg == this.azimuthDeg &&
          other.azimuthEdgeIndex == this.azimuthEdgeIndex &&
          other.edgeSetbackM == this.edgeSetbackM &&
          other.walkways == this.walkways &&
          other.sortOrder == this.sortOrder);
}

class RoofPlanesCompanion extends UpdateCompanion<RoofPlane> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<String> name;
  final Value<String> polygon;
  final Value<double> tiltDeg;
  final Value<TiltSource> tiltSource;
  final Value<double> azimuthDeg;
  final Value<int?> azimuthEdgeIndex;
  final Value<double> edgeSetbackM;
  final Value<String> walkways;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const RoofPlanesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.name = const Value.absent(),
    this.polygon = const Value.absent(),
    this.tiltDeg = const Value.absent(),
    this.tiltSource = const Value.absent(),
    this.azimuthDeg = const Value.absent(),
    this.azimuthEdgeIndex = const Value.absent(),
    this.edgeSetbackM = const Value.absent(),
    this.walkways = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RoofPlanesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required String name,
    required String polygon,
    this.tiltDeg = const Value.absent(),
    this.tiltSource = const Value.absent(),
    this.azimuthDeg = const Value.absent(),
    this.azimuthEdgeIndex = const Value.absent(),
    this.edgeSetbackM = const Value.absent(),
    this.walkways = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       name = Value(name),
       polygon = Value(polygon);
  static Insertable<RoofPlane> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? name,
    Expression<String>? polygon,
    Expression<double>? tiltDeg,
    Expression<String>? tiltSource,
    Expression<double>? azimuthDeg,
    Expression<int>? azimuthEdgeIndex,
    Expression<double>? edgeSetbackM,
    Expression<String>? walkways,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (name != null) 'name': name,
      if (polygon != null) 'polygon': polygon,
      if (tiltDeg != null) 'tilt_deg': tiltDeg,
      if (tiltSource != null) 'tilt_source': tiltSource,
      if (azimuthDeg != null) 'azimuth_deg': azimuthDeg,
      if (azimuthEdgeIndex != null) 'azimuth_edge_index': azimuthEdgeIndex,
      if (edgeSetbackM != null) 'edge_setback_m': edgeSetbackM,
      if (walkways != null) 'walkways': walkways,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RoofPlanesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<String>? name,
    Value<String>? polygon,
    Value<double>? tiltDeg,
    Value<TiltSource>? tiltSource,
    Value<double>? azimuthDeg,
    Value<int?>? azimuthEdgeIndex,
    Value<double>? edgeSetbackM,
    Value<String>? walkways,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return RoofPlanesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      name: name ?? this.name,
      polygon: polygon ?? this.polygon,
      tiltDeg: tiltDeg ?? this.tiltDeg,
      tiltSource: tiltSource ?? this.tiltSource,
      azimuthDeg: azimuthDeg ?? this.azimuthDeg,
      azimuthEdgeIndex: azimuthEdgeIndex ?? this.azimuthEdgeIndex,
      edgeSetbackM: edgeSetbackM ?? this.edgeSetbackM,
      walkways: walkways ?? this.walkways,
      sortOrder: sortOrder ?? this.sortOrder,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (polygon.present) {
      map['polygon'] = Variable<String>(polygon.value);
    }
    if (tiltDeg.present) {
      map['tilt_deg'] = Variable<double>(tiltDeg.value);
    }
    if (tiltSource.present) {
      map['tilt_source'] = Variable<String>(
        $RoofPlanesTable.$convertertiltSource.toSql(tiltSource.value),
      );
    }
    if (azimuthDeg.present) {
      map['azimuth_deg'] = Variable<double>(azimuthDeg.value);
    }
    if (azimuthEdgeIndex.present) {
      map['azimuth_edge_index'] = Variable<int>(azimuthEdgeIndex.value);
    }
    if (edgeSetbackM.present) {
      map['edge_setback_m'] = Variable<double>(edgeSetbackM.value);
    }
    if (walkways.present) {
      map['walkways'] = Variable<String>(walkways.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RoofPlanesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('name: $name, ')
          ..write('polygon: $polygon, ')
          ..write('tiltDeg: $tiltDeg, ')
          ..write('tiltSource: $tiltSource, ')
          ..write('azimuthDeg: $azimuthDeg, ')
          ..write('azimuthEdgeIndex: $azimuthEdgeIndex, ')
          ..write('edgeSetbackM: $edgeSetbackM, ')
          ..write('walkways: $walkways, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ObstaclesTable extends Obstacles
    with TableInfo<$ObstaclesTable, Obstacle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObstaclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ObstacleKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ObstacleKind>($ObstaclesTable.$converterkind);
  @override
  late final GeneratedColumnWithTypeConverter<ObstacleOutline, String> outline =
      GeneratedColumn<String>(
        'outline',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ObstacleOutline>($ObstaclesTable.$converteroutline);
  static const VerificationMeta _centerXMeta = const VerificationMeta(
    'centerX',
  );
  @override
  late final GeneratedColumn<double> centerX = GeneratedColumn<double>(
    'center_x',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _centerYMeta = const VerificationMeta(
    'centerY',
  );
  @override
  late final GeneratedColumn<double> centerY = GeneratedColumn<double>(
    'center_y',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _widthMMeta = const VerificationMeta('widthM');
  @override
  late final GeneratedColumn<double> widthM = GeneratedColumn<double>(
    'width_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depthMMeta = const VerificationMeta('depthM');
  @override
  late final GeneratedColumn<double> depthM = GeneratedColumn<double>(
    'depth_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rotationDegMeta = const VerificationMeta(
    'rotationDeg',
  );
  @override
  late final GeneratedColumn<double> rotationDeg = GeneratedColumn<double>(
    'rotation_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<String> points = GeneratedColumn<String>(
    'points',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMMeta = const VerificationMeta(
    'heightM',
  );
  @override
  late final GeneratedColumn<double> heightM = GeneratedColumn<double>(
    'height_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<HeightSource, String>
  heightSource = GeneratedColumn<String>(
    'height_source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<HeightSource>($ObstaclesTable.$converterheightSource);
  static const VerificationMeta _tankLitersMeta = const VerificationMeta(
    'tankLiters',
  );
  @override
  late final GeneratedColumn<int> tankLiters = GeneratedColumn<int>(
    'tank_liters',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    kind,
    outline,
    centerX,
    centerY,
    widthM,
    depthM,
    rotationDeg,
    points,
    heightM,
    heightSource,
    tankLiters,
    label,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'obstacles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Obstacle> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('center_x')) {
      context.handle(
        _centerXMeta,
        centerX.isAcceptableOrUnknown(data['center_x']!, _centerXMeta),
      );
    }
    if (data.containsKey('center_y')) {
      context.handle(
        _centerYMeta,
        centerY.isAcceptableOrUnknown(data['center_y']!, _centerYMeta),
      );
    }
    if (data.containsKey('width_m')) {
      context.handle(
        _widthMMeta,
        widthM.isAcceptableOrUnknown(data['width_m']!, _widthMMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMMeta);
    }
    if (data.containsKey('depth_m')) {
      context.handle(
        _depthMMeta,
        depthM.isAcceptableOrUnknown(data['depth_m']!, _depthMMeta),
      );
    }
    if (data.containsKey('rotation_deg')) {
      context.handle(
        _rotationDegMeta,
        rotationDeg.isAcceptableOrUnknown(
          data['rotation_deg']!,
          _rotationDegMeta,
        ),
      );
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    }
    if (data.containsKey('height_m')) {
      context.handle(
        _heightMMeta,
        heightM.isAcceptableOrUnknown(data['height_m']!, _heightMMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMMeta);
    }
    if (data.containsKey('tank_liters')) {
      context.handle(
        _tankLitersMeta,
        tankLiters.isAcceptableOrUnknown(data['tank_liters']!, _tankLitersMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Obstacle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Obstacle(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      kind: $ObstaclesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      outline: $ObstaclesTable.$converteroutline.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}outline'],
        )!,
      ),
      centerX: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}center_x'],
      )!,
      centerY: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}center_y'],
      )!,
      widthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width_m'],
      )!,
      depthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}depth_m'],
      ),
      rotationDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rotation_deg'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}points'],
      ),
      heightM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_m'],
      )!,
      heightSource: $ObstaclesTable.$converterheightSource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}height_source'],
        )!,
      ),
      tankLiters: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tank_liters'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
    );
  }

  @override
  $ObstaclesTable createAlias(String alias) {
    return $ObstaclesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ObstacleKind, String, String> $converterkind =
      const EnumNameConverter<ObstacleKind>(ObstacleKind.values);
  static JsonTypeConverter2<ObstacleOutline, String, String> $converteroutline =
      const EnumNameConverter<ObstacleOutline>(ObstacleOutline.values);
  static JsonTypeConverter2<HeightSource, String, String>
  $converterheightSource = const EnumNameConverter<HeightSource>(
    HeightSource.values,
  );
}

class Obstacle extends DataClass implements Insertable<Obstacle> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Tipo (tinaco, antena...).
  final ObstacleKind kind;

  /// Forma de la huella.
  final ObstacleOutline outline;

  /// Centro, este (m). Círculo, rectángulo y punto.
  final double centerX;

  /// Centro, norte (m).
  final double centerY;

  /// Diámetro, ancho o espesor (m).
  final double widthM;

  /// Fondo del rectángulo (m).
  final double? depthM;

  /// Giro del rectángulo (grados, antihorario).
  final double rotationDeg;

  /// Puntos de la línea o del polígono en JSON `[[x,y],...]` (m).
  final String? points;

  /// Altura sobre el techo (m).
  final double heightM;

  /// De dónde salió la altura.
  final HeightSource heightSource;

  /// Capacidad del tinaco (L), si aplica.
  final int? tankLiters;

  /// Nota opcional.
  final String? label;
  const Obstacle({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.kind,
    required this.outline,
    required this.centerX,
    required this.centerY,
    required this.widthM,
    this.depthM,
    required this.rotationDeg,
    this.points,
    required this.heightM,
    required this.heightSource,
    this.tankLiters,
    this.label,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    {
      map['kind'] = Variable<String>(
        $ObstaclesTable.$converterkind.toSql(kind),
      );
    }
    {
      map['outline'] = Variable<String>(
        $ObstaclesTable.$converteroutline.toSql(outline),
      );
    }
    map['center_x'] = Variable<double>(centerX);
    map['center_y'] = Variable<double>(centerY);
    map['width_m'] = Variable<double>(widthM);
    if (!nullToAbsent || depthM != null) {
      map['depth_m'] = Variable<double>(depthM);
    }
    map['rotation_deg'] = Variable<double>(rotationDeg);
    if (!nullToAbsent || points != null) {
      map['points'] = Variable<String>(points);
    }
    map['height_m'] = Variable<double>(heightM);
    {
      map['height_source'] = Variable<String>(
        $ObstaclesTable.$converterheightSource.toSql(heightSource),
      );
    }
    if (!nullToAbsent || tankLiters != null) {
      map['tank_liters'] = Variable<int>(tankLiters);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  ObstaclesCompanion toCompanion(bool nullToAbsent) {
    return ObstaclesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      kind: Value(kind),
      outline: Value(outline),
      centerX: Value(centerX),
      centerY: Value(centerY),
      widthM: Value(widthM),
      depthM: depthM == null && nullToAbsent
          ? const Value.absent()
          : Value(depthM),
      rotationDeg: Value(rotationDeg),
      points: points == null && nullToAbsent
          ? const Value.absent()
          : Value(points),
      heightM: Value(heightM),
      heightSource: Value(heightSource),
      tankLiters: tankLiters == null && nullToAbsent
          ? const Value.absent()
          : Value(tankLiters),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
    );
  }

  factory Obstacle.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Obstacle(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      kind: $ObstaclesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      outline: $ObstaclesTable.$converteroutline.fromJson(
        serializer.fromJson<String>(json['outline']),
      ),
      centerX: serializer.fromJson<double>(json['centerX']),
      centerY: serializer.fromJson<double>(json['centerY']),
      widthM: serializer.fromJson<double>(json['widthM']),
      depthM: serializer.fromJson<double?>(json['depthM']),
      rotationDeg: serializer.fromJson<double>(json['rotationDeg']),
      points: serializer.fromJson<String?>(json['points']),
      heightM: serializer.fromJson<double>(json['heightM']),
      heightSource: $ObstaclesTable.$converterheightSource.fromJson(
        serializer.fromJson<String>(json['heightSource']),
      ),
      tankLiters: serializer.fromJson<int?>(json['tankLiters']),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'kind': serializer.toJson<String>(
        $ObstaclesTable.$converterkind.toJson(kind),
      ),
      'outline': serializer.toJson<String>(
        $ObstaclesTable.$converteroutline.toJson(outline),
      ),
      'centerX': serializer.toJson<double>(centerX),
      'centerY': serializer.toJson<double>(centerY),
      'widthM': serializer.toJson<double>(widthM),
      'depthM': serializer.toJson<double?>(depthM),
      'rotationDeg': serializer.toJson<double>(rotationDeg),
      'points': serializer.toJson<String?>(points),
      'heightM': serializer.toJson<double>(heightM),
      'heightSource': serializer.toJson<String>(
        $ObstaclesTable.$converterheightSource.toJson(heightSource),
      ),
      'tankLiters': serializer.toJson<int?>(tankLiters),
      'label': serializer.toJson<String?>(label),
    };
  }

  Obstacle copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    ObstacleKind? kind,
    ObstacleOutline? outline,
    double? centerX,
    double? centerY,
    double? widthM,
    Value<double?> depthM = const Value.absent(),
    double? rotationDeg,
    Value<String?> points = const Value.absent(),
    double? heightM,
    HeightSource? heightSource,
    Value<int?> tankLiters = const Value.absent(),
    Value<String?> label = const Value.absent(),
  }) => Obstacle(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    kind: kind ?? this.kind,
    outline: outline ?? this.outline,
    centerX: centerX ?? this.centerX,
    centerY: centerY ?? this.centerY,
    widthM: widthM ?? this.widthM,
    depthM: depthM.present ? depthM.value : this.depthM,
    rotationDeg: rotationDeg ?? this.rotationDeg,
    points: points.present ? points.value : this.points,
    heightM: heightM ?? this.heightM,
    heightSource: heightSource ?? this.heightSource,
    tankLiters: tankLiters.present ? tankLiters.value : this.tankLiters,
    label: label.present ? label.value : this.label,
  );
  Obstacle copyWithCompanion(ObstaclesCompanion data) {
    return Obstacle(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      kind: data.kind.present ? data.kind.value : this.kind,
      outline: data.outline.present ? data.outline.value : this.outline,
      centerX: data.centerX.present ? data.centerX.value : this.centerX,
      centerY: data.centerY.present ? data.centerY.value : this.centerY,
      widthM: data.widthM.present ? data.widthM.value : this.widthM,
      depthM: data.depthM.present ? data.depthM.value : this.depthM,
      rotationDeg: data.rotationDeg.present
          ? data.rotationDeg.value
          : this.rotationDeg,
      points: data.points.present ? data.points.value : this.points,
      heightM: data.heightM.present ? data.heightM.value : this.heightM,
      heightSource: data.heightSource.present
          ? data.heightSource.value
          : this.heightSource,
      tankLiters: data.tankLiters.present
          ? data.tankLiters.value
          : this.tankLiters,
      label: data.label.present ? data.label.value : this.label,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Obstacle(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('kind: $kind, ')
          ..write('outline: $outline, ')
          ..write('centerX: $centerX, ')
          ..write('centerY: $centerY, ')
          ..write('widthM: $widthM, ')
          ..write('depthM: $depthM, ')
          ..write('rotationDeg: $rotationDeg, ')
          ..write('points: $points, ')
          ..write('heightM: $heightM, ')
          ..write('heightSource: $heightSource, ')
          ..write('tankLiters: $tankLiters, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    kind,
    outline,
    centerX,
    centerY,
    widthM,
    depthM,
    rotationDeg,
    points,
    heightM,
    heightSource,
    tankLiters,
    label,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Obstacle &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.kind == this.kind &&
          other.outline == this.outline &&
          other.centerX == this.centerX &&
          other.centerY == this.centerY &&
          other.widthM == this.widthM &&
          other.depthM == this.depthM &&
          other.rotationDeg == this.rotationDeg &&
          other.points == this.points &&
          other.heightM == this.heightM &&
          other.heightSource == this.heightSource &&
          other.tankLiters == this.tankLiters &&
          other.label == this.label);
}

class ObstaclesCompanion extends UpdateCompanion<Obstacle> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<ObstacleKind> kind;
  final Value<ObstacleOutline> outline;
  final Value<double> centerX;
  final Value<double> centerY;
  final Value<double> widthM;
  final Value<double?> depthM;
  final Value<double> rotationDeg;
  final Value<String?> points;
  final Value<double> heightM;
  final Value<HeightSource> heightSource;
  final Value<int?> tankLiters;
  final Value<String?> label;
  final Value<int> rowid;
  const ObstaclesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.kind = const Value.absent(),
    this.outline = const Value.absent(),
    this.centerX = const Value.absent(),
    this.centerY = const Value.absent(),
    this.widthM = const Value.absent(),
    this.depthM = const Value.absent(),
    this.rotationDeg = const Value.absent(),
    this.points = const Value.absent(),
    this.heightM = const Value.absent(),
    this.heightSource = const Value.absent(),
    this.tankLiters = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObstaclesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required ObstacleKind kind,
    required ObstacleOutline outline,
    this.centerX = const Value.absent(),
    this.centerY = const Value.absent(),
    required double widthM,
    this.depthM = const Value.absent(),
    this.rotationDeg = const Value.absent(),
    this.points = const Value.absent(),
    required double heightM,
    required HeightSource heightSource,
    this.tankLiters = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       kind = Value(kind),
       outline = Value(outline),
       widthM = Value(widthM),
       heightM = Value(heightM),
       heightSource = Value(heightSource);
  static Insertable<Obstacle> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? kind,
    Expression<String>? outline,
    Expression<double>? centerX,
    Expression<double>? centerY,
    Expression<double>? widthM,
    Expression<double>? depthM,
    Expression<double>? rotationDeg,
    Expression<String>? points,
    Expression<double>? heightM,
    Expression<String>? heightSource,
    Expression<int>? tankLiters,
    Expression<String>? label,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (kind != null) 'kind': kind,
      if (outline != null) 'outline': outline,
      if (centerX != null) 'center_x': centerX,
      if (centerY != null) 'center_y': centerY,
      if (widthM != null) 'width_m': widthM,
      if (depthM != null) 'depth_m': depthM,
      if (rotationDeg != null) 'rotation_deg': rotationDeg,
      if (points != null) 'points': points,
      if (heightM != null) 'height_m': heightM,
      if (heightSource != null) 'height_source': heightSource,
      if (tankLiters != null) 'tank_liters': tankLiters,
      if (label != null) 'label': label,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObstaclesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<ObstacleKind>? kind,
    Value<ObstacleOutline>? outline,
    Value<double>? centerX,
    Value<double>? centerY,
    Value<double>? widthM,
    Value<double?>? depthM,
    Value<double>? rotationDeg,
    Value<String?>? points,
    Value<double>? heightM,
    Value<HeightSource>? heightSource,
    Value<int?>? tankLiters,
    Value<String?>? label,
    Value<int>? rowid,
  }) {
    return ObstaclesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      kind: kind ?? this.kind,
      outline: outline ?? this.outline,
      centerX: centerX ?? this.centerX,
      centerY: centerY ?? this.centerY,
      widthM: widthM ?? this.widthM,
      depthM: depthM ?? this.depthM,
      rotationDeg: rotationDeg ?? this.rotationDeg,
      points: points ?? this.points,
      heightM: heightM ?? this.heightM,
      heightSource: heightSource ?? this.heightSource,
      tankLiters: tankLiters ?? this.tankLiters,
      label: label ?? this.label,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $ObstaclesTable.$converterkind.toSql(kind.value),
      );
    }
    if (outline.present) {
      map['outline'] = Variable<String>(
        $ObstaclesTable.$converteroutline.toSql(outline.value),
      );
    }
    if (centerX.present) {
      map['center_x'] = Variable<double>(centerX.value);
    }
    if (centerY.present) {
      map['center_y'] = Variable<double>(centerY.value);
    }
    if (widthM.present) {
      map['width_m'] = Variable<double>(widthM.value);
    }
    if (depthM.present) {
      map['depth_m'] = Variable<double>(depthM.value);
    }
    if (rotationDeg.present) {
      map['rotation_deg'] = Variable<double>(rotationDeg.value);
    }
    if (points.present) {
      map['points'] = Variable<String>(points.value);
    }
    if (heightM.present) {
      map['height_m'] = Variable<double>(heightM.value);
    }
    if (heightSource.present) {
      map['height_source'] = Variable<String>(
        $ObstaclesTable.$converterheightSource.toSql(heightSource.value),
      );
    }
    if (tankLiters.present) {
      map['tank_liters'] = Variable<int>(tankLiters.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObstaclesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('kind: $kind, ')
          ..write('outline: $outline, ')
          ..write('centerX: $centerX, ')
          ..write('centerY: $centerY, ')
          ..write('widthM: $widthM, ')
          ..write('depthM: $depthM, ')
          ..write('rotationDeg: $rotationDeg, ')
          ..write('points: $points, ')
          ..write('heightM: $heightM, ')
          ..write('heightSource: $heightSource, ')
          ..write('tankLiters: $tankLiters, ')
          ..write('label: $label, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HorizonProfilesTable extends HorizonProfiles
    with TableInfo<$HorizonProfilesTable, HorizonProfileRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HorizonProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<HorizonSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<HorizonSource>($HorizonProfilesTable.$convertersource);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<String> points = GeneratedColumn<String>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    source,
    name,
    points,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'horizon_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<HorizonProfileRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HorizonProfileRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HorizonProfileRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      source: $HorizonProfilesTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}points'],
      )!,
    );
  }

  @override
  $HorizonProfilesTable createAlias(String alias) {
    return $HorizonProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<HorizonSource, String, String> $convertersource =
      const EnumNameConverter<HorizonSource>(HorizonSource.values);
}

class HorizonProfileRecord extends DataClass
    implements Insertable<HorizonProfileRecord> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Origen: terreno, manual o cámara.
  final HorizonSource source;

  /// Nombre visible ("Árbol del vecino").
  final String? name;

  /// Puntos en JSON `[[azimut, elevación], ...]` (grados).
  final String points;
  const HorizonProfileRecord({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.source,
    this.name,
    required this.points,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    {
      map['source'] = Variable<String>(
        $HorizonProfilesTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['points'] = Variable<String>(points);
    return map;
  }

  HorizonProfilesCompanion toCompanion(bool nullToAbsent) {
    return HorizonProfilesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      source: Value(source),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      points: Value(points),
    );
  }

  factory HorizonProfileRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HorizonProfileRecord(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      source: $HorizonProfilesTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      name: serializer.fromJson<String?>(json['name']),
      points: serializer.fromJson<String>(json['points']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'source': serializer.toJson<String>(
        $HorizonProfilesTable.$convertersource.toJson(source),
      ),
      'name': serializer.toJson<String?>(name),
      'points': serializer.toJson<String>(points),
    };
  }

  HorizonProfileRecord copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    HorizonSource? source,
    Value<String?> name = const Value.absent(),
    String? points,
  }) => HorizonProfileRecord(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    source: source ?? this.source,
    name: name.present ? name.value : this.name,
    points: points ?? this.points,
  );
  HorizonProfileRecord copyWithCompanion(HorizonProfilesCompanion data) {
    return HorizonProfileRecord(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      source: data.source.present ? data.source.value : this.source,
      name: data.name.present ? data.name.value : this.name,
      points: data.points.present ? data.points.value : this.points,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HorizonProfileRecord(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('source: $source, ')
          ..write('name: $name, ')
          ..write('points: $points')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    source,
    name,
    points,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HorizonProfileRecord &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.source == this.source &&
          other.name == this.name &&
          other.points == this.points);
}

class HorizonProfilesCompanion extends UpdateCompanion<HorizonProfileRecord> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<HorizonSource> source;
  final Value<String?> name;
  final Value<String> points;
  final Value<int> rowid;
  const HorizonProfilesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.source = const Value.absent(),
    this.name = const Value.absent(),
    this.points = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HorizonProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required HorizonSource source,
    this.name = const Value.absent(),
    required String points,
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       source = Value(source),
       points = Value(points);
  static Insertable<HorizonProfileRecord> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? source,
    Expression<String>? name,
    Expression<String>? points,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (source != null) 'source': source,
      if (name != null) 'name': name,
      if (points != null) 'points': points,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HorizonProfilesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<HorizonSource>? source,
    Value<String?>? name,
    Value<String>? points,
    Value<int>? rowid,
  }) {
    return HorizonProfilesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      source: source ?? this.source,
      name: name ?? this.name,
      points: points ?? this.points,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $HorizonProfilesTable.$convertersource.toSql(source.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (points.present) {
      map['points'] = Variable<String>(points.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HorizonProfilesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('source: $source, ')
          ..write('name: $name, ')
          ..write('points: $points, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PanelModelsTable extends PanelModels
    with TableInfo<$PanelModelsTable, PanelModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PanelModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pmaxWMeta = const VerificationMeta('pmaxW');
  @override
  late final GeneratedColumn<double> pmaxW = GeneratedColumn<double>(
    'pmax_w',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vocVMeta = const VerificationMeta('vocV');
  @override
  late final GeneratedColumn<double> vocV = GeneratedColumn<double>(
    'voc_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iscAMeta = const VerificationMeta('iscA');
  @override
  late final GeneratedColumn<double> iscA = GeneratedColumn<double>(
    'isc_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vmpVMeta = const VerificationMeta('vmpV');
  @override
  late final GeneratedColumn<double> vmpV = GeneratedColumn<double>(
    'vmp_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _impAMeta = const VerificationMeta('impA');
  @override
  late final GeneratedColumn<double> impA = GeneratedColumn<double>(
    'imp_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gammaPmaxPctMeta = const VerificationMeta(
    'gammaPmaxPct',
  );
  @override
  late final GeneratedColumn<double> gammaPmaxPct = GeneratedColumn<double>(
    'gamma_pmax_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(-0.35),
  );
  static const VerificationMeta _betaVocPctMeta = const VerificationMeta(
    'betaVocPct',
  );
  @override
  late final GeneratedColumn<double> betaVocPct = GeneratedColumn<double>(
    'beta_voc_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(-0.28),
  );
  static const VerificationMeta _betaVmpPctMeta = const VerificationMeta(
    'betaVmpPct',
  );
  @override
  late final GeneratedColumn<double> betaVmpPct = GeneratedColumn<double>(
    'beta_vmp_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(-0.37),
  );
  static const VerificationMeta _lengthMMeta = const VerificationMeta(
    'lengthM',
  );
  @override
  late final GeneratedColumn<double> lengthM = GeneratedColumn<double>(
    'length_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _widthMMeta = const VerificationMeta('widthM');
  @override
  late final GeneratedColumn<double> widthM = GeneratedColumn<double>(
    'width_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CellType, String> cellType =
      GeneratedColumn<String>(
        'cell_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(CellType.mono.name),
      ).withConverter<CellType>($PanelModelsTable.$convertercellType);
  static const VerificationMeta _cellCountMeta = const VerificationMeta(
    'cellCount',
  );
  @override
  late final GeneratedColumn<int> cellCount = GeneratedColumn<int>(
    'cell_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bifacialMeta = const VerificationMeta(
    'bifacial',
  );
  @override
  late final GeneratedColumn<bool> bifacial = GeneratedColumn<bool>(
    'bifacial',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bifacial" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _bifacialityPctMeta = const VerificationMeta(
    'bifacialityPct',
  );
  @override
  late final GeneratedColumn<double> bifacialityPct = GeneratedColumn<double>(
    'bifaciality_pct',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxSeriesFuseAMeta = const VerificationMeta(
    'maxSeriesFuseA',
  );
  @override
  late final GeneratedColumn<double> maxSeriesFuseA = GeneratedColumn<double>(
    'max_series_fuse_a',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxSystemVoltageVMeta = const VerificationMeta(
    'maxSystemVoltageV',
  );
  @override
  late final GeneratedColumn<double> maxSystemVoltageV =
      GeneratedColumn<double>(
        'max_system_voltage_v',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<EquipmentSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(EquipmentSource.manual.name),
      ).withConverter<EquipmentSource>($PanelModelsTable.$convertersource);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    pmaxW,
    vocV,
    iscA,
    vmpV,
    impA,
    gammaPmaxPct,
    betaVocPct,
    betaVmpPct,
    lengthM,
    widthM,
    weightKg,
    cellType,
    cellCount,
    bifacial,
    bifacialityPct,
    maxSeriesFuseA,
    maxSystemVoltageV,
    source,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'panel_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<PanelModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manufacturerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('pmax_w')) {
      context.handle(
        _pmaxWMeta,
        pmaxW.isAcceptableOrUnknown(data['pmax_w']!, _pmaxWMeta),
      );
    } else if (isInserting) {
      context.missing(_pmaxWMeta);
    }
    if (data.containsKey('voc_v')) {
      context.handle(
        _vocVMeta,
        vocV.isAcceptableOrUnknown(data['voc_v']!, _vocVMeta),
      );
    } else if (isInserting) {
      context.missing(_vocVMeta);
    }
    if (data.containsKey('isc_a')) {
      context.handle(
        _iscAMeta,
        iscA.isAcceptableOrUnknown(data['isc_a']!, _iscAMeta),
      );
    } else if (isInserting) {
      context.missing(_iscAMeta);
    }
    if (data.containsKey('vmp_v')) {
      context.handle(
        _vmpVMeta,
        vmpV.isAcceptableOrUnknown(data['vmp_v']!, _vmpVMeta),
      );
    } else if (isInserting) {
      context.missing(_vmpVMeta);
    }
    if (data.containsKey('imp_a')) {
      context.handle(
        _impAMeta,
        impA.isAcceptableOrUnknown(data['imp_a']!, _impAMeta),
      );
    } else if (isInserting) {
      context.missing(_impAMeta);
    }
    if (data.containsKey('gamma_pmax_pct')) {
      context.handle(
        _gammaPmaxPctMeta,
        gammaPmaxPct.isAcceptableOrUnknown(
          data['gamma_pmax_pct']!,
          _gammaPmaxPctMeta,
        ),
      );
    }
    if (data.containsKey('beta_voc_pct')) {
      context.handle(
        _betaVocPctMeta,
        betaVocPct.isAcceptableOrUnknown(
          data['beta_voc_pct']!,
          _betaVocPctMeta,
        ),
      );
    }
    if (data.containsKey('beta_vmp_pct')) {
      context.handle(
        _betaVmpPctMeta,
        betaVmpPct.isAcceptableOrUnknown(
          data['beta_vmp_pct']!,
          _betaVmpPctMeta,
        ),
      );
    }
    if (data.containsKey('length_m')) {
      context.handle(
        _lengthMMeta,
        lengthM.isAcceptableOrUnknown(data['length_m']!, _lengthMMeta),
      );
    } else if (isInserting) {
      context.missing(_lengthMMeta);
    }
    if (data.containsKey('width_m')) {
      context.handle(
        _widthMMeta,
        widthM.isAcceptableOrUnknown(data['width_m']!, _widthMMeta),
      );
    } else if (isInserting) {
      context.missing(_widthMMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('cell_count')) {
      context.handle(
        _cellCountMeta,
        cellCount.isAcceptableOrUnknown(data['cell_count']!, _cellCountMeta),
      );
    }
    if (data.containsKey('bifacial')) {
      context.handle(
        _bifacialMeta,
        bifacial.isAcceptableOrUnknown(data['bifacial']!, _bifacialMeta),
      );
    }
    if (data.containsKey('bifaciality_pct')) {
      context.handle(
        _bifacialityPctMeta,
        bifacialityPct.isAcceptableOrUnknown(
          data['bifaciality_pct']!,
          _bifacialityPctMeta,
        ),
      );
    }
    if (data.containsKey('max_series_fuse_a')) {
      context.handle(
        _maxSeriesFuseAMeta,
        maxSeriesFuseA.isAcceptableOrUnknown(
          data['max_series_fuse_a']!,
          _maxSeriesFuseAMeta,
        ),
      );
    }
    if (data.containsKey('max_system_voltage_v')) {
      context.handle(
        _maxSystemVoltageVMeta,
        maxSystemVoltageV.isAcceptableOrUnknown(
          data['max_system_voltage_v']!,
          _maxSystemVoltageVMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PanelModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PanelModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      pmaxW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pmax_w'],
      )!,
      vocV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}voc_v'],
      )!,
      iscA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}isc_a'],
      )!,
      vmpV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vmp_v'],
      )!,
      impA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}imp_a'],
      )!,
      gammaPmaxPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gamma_pmax_pct'],
      )!,
      betaVocPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beta_voc_pct'],
      )!,
      betaVmpPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}beta_vmp_pct'],
      )!,
      lengthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length_m'],
      )!,
      widthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}width_m'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      cellType: $PanelModelsTable.$convertercellType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}cell_type'],
        )!,
      ),
      cellCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cell_count'],
      ),
      bifacial: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bifacial'],
      )!,
      bifacialityPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bifaciality_pct'],
      ),
      maxSeriesFuseA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_series_fuse_a'],
      ),
      maxSystemVoltageV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_system_voltage_v'],
      ),
      source: $PanelModelsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $PanelModelsTable createAlias(String alias) {
    return $PanelModelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CellType, String, String> $convertercellType =
      const EnumNameConverter<CellType>(CellType.values);
  static JsonTypeConverter2<EquipmentSource, String, String> $convertersource =
      const EnumNameConverter<EquipmentSource>(EquipmentSource.values);
}

class PanelModel extends DataClass implements Insertable<PanelModel> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Fabricante.
  final String manufacturer;

  /// Modelo.
  final String model;

  /// Potencia máxima (W).
  final double pmaxW;

  /// Tensión de circuito abierto (V).
  final double vocV;

  /// Corriente de cortocircuito (A).
  final double iscA;

  /// Tensión en máxima potencia (V).
  final double vmpV;

  /// Corriente en máxima potencia (A).
  final double impA;

  /// Coeficiente de Pmax (%/°C).
  final double gammaPmaxPct;

  /// Coeficiente de Voc (%/°C).
  final double betaVocPct;

  /// Coeficiente de Vmp (%/°C).
  final double betaVmpPct;

  /// Largo (m).
  final double lengthM;

  /// Ancho (m).
  final double widthM;

  /// Peso (kg).
  final double? weightKg;

  /// Tipo de celda.
  final CellType cellType;

  /// Número de celdas.
  final int? cellCount;

  /// Bifacial.
  final bool bifacial;

  /// Bifacialidad (%), si es bifacial.
  final double? bifacialityPct;

  /// Fusible máximo en serie (A).
  final double? maxSeriesFuseA;

  /// Tensión máxima del sistema (V).
  final double? maxSystemVoltageV;

  /// Origen.
  final EquipmentSource source;

  /// Notas.
  final String? notes;
  const PanelModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.manufacturer,
    required this.model,
    required this.pmaxW,
    required this.vocV,
    required this.iscA,
    required this.vmpV,
    required this.impA,
    required this.gammaPmaxPct,
    required this.betaVocPct,
    required this.betaVmpPct,
    required this.lengthM,
    required this.widthM,
    this.weightKg,
    required this.cellType,
    this.cellCount,
    required this.bifacial,
    this.bifacialityPct,
    this.maxSeriesFuseA,
    this.maxSystemVoltageV,
    required this.source,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['manufacturer'] = Variable<String>(manufacturer);
    map['model'] = Variable<String>(model);
    map['pmax_w'] = Variable<double>(pmaxW);
    map['voc_v'] = Variable<double>(vocV);
    map['isc_a'] = Variable<double>(iscA);
    map['vmp_v'] = Variable<double>(vmpV);
    map['imp_a'] = Variable<double>(impA);
    map['gamma_pmax_pct'] = Variable<double>(gammaPmaxPct);
    map['beta_voc_pct'] = Variable<double>(betaVocPct);
    map['beta_vmp_pct'] = Variable<double>(betaVmpPct);
    map['length_m'] = Variable<double>(lengthM);
    map['width_m'] = Variable<double>(widthM);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    {
      map['cell_type'] = Variable<String>(
        $PanelModelsTable.$convertercellType.toSql(cellType),
      );
    }
    if (!nullToAbsent || cellCount != null) {
      map['cell_count'] = Variable<int>(cellCount);
    }
    map['bifacial'] = Variable<bool>(bifacial);
    if (!nullToAbsent || bifacialityPct != null) {
      map['bifaciality_pct'] = Variable<double>(bifacialityPct);
    }
    if (!nullToAbsent || maxSeriesFuseA != null) {
      map['max_series_fuse_a'] = Variable<double>(maxSeriesFuseA);
    }
    if (!nullToAbsent || maxSystemVoltageV != null) {
      map['max_system_voltage_v'] = Variable<double>(maxSystemVoltageV);
    }
    {
      map['source'] = Variable<String>(
        $PanelModelsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  PanelModelsCompanion toCompanion(bool nullToAbsent) {
    return PanelModelsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      manufacturer: Value(manufacturer),
      model: Value(model),
      pmaxW: Value(pmaxW),
      vocV: Value(vocV),
      iscA: Value(iscA),
      vmpV: Value(vmpV),
      impA: Value(impA),
      gammaPmaxPct: Value(gammaPmaxPct),
      betaVocPct: Value(betaVocPct),
      betaVmpPct: Value(betaVmpPct),
      lengthM: Value(lengthM),
      widthM: Value(widthM),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      cellType: Value(cellType),
      cellCount: cellCount == null && nullToAbsent
          ? const Value.absent()
          : Value(cellCount),
      bifacial: Value(bifacial),
      bifacialityPct: bifacialityPct == null && nullToAbsent
          ? const Value.absent()
          : Value(bifacialityPct),
      maxSeriesFuseA: maxSeriesFuseA == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSeriesFuseA),
      maxSystemVoltageV: maxSystemVoltageV == null && nullToAbsent
          ? const Value.absent()
          : Value(maxSystemVoltageV),
      source: Value(source),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory PanelModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PanelModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      manufacturer: serializer.fromJson<String>(json['manufacturer']),
      model: serializer.fromJson<String>(json['model']),
      pmaxW: serializer.fromJson<double>(json['pmaxW']),
      vocV: serializer.fromJson<double>(json['vocV']),
      iscA: serializer.fromJson<double>(json['iscA']),
      vmpV: serializer.fromJson<double>(json['vmpV']),
      impA: serializer.fromJson<double>(json['impA']),
      gammaPmaxPct: serializer.fromJson<double>(json['gammaPmaxPct']),
      betaVocPct: serializer.fromJson<double>(json['betaVocPct']),
      betaVmpPct: serializer.fromJson<double>(json['betaVmpPct']),
      lengthM: serializer.fromJson<double>(json['lengthM']),
      widthM: serializer.fromJson<double>(json['widthM']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      cellType: $PanelModelsTable.$convertercellType.fromJson(
        serializer.fromJson<String>(json['cellType']),
      ),
      cellCount: serializer.fromJson<int?>(json['cellCount']),
      bifacial: serializer.fromJson<bool>(json['bifacial']),
      bifacialityPct: serializer.fromJson<double?>(json['bifacialityPct']),
      maxSeriesFuseA: serializer.fromJson<double?>(json['maxSeriesFuseA']),
      maxSystemVoltageV: serializer.fromJson<double?>(
        json['maxSystemVoltageV'],
      ),
      source: $PanelModelsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'manufacturer': serializer.toJson<String>(manufacturer),
      'model': serializer.toJson<String>(model),
      'pmaxW': serializer.toJson<double>(pmaxW),
      'vocV': serializer.toJson<double>(vocV),
      'iscA': serializer.toJson<double>(iscA),
      'vmpV': serializer.toJson<double>(vmpV),
      'impA': serializer.toJson<double>(impA),
      'gammaPmaxPct': serializer.toJson<double>(gammaPmaxPct),
      'betaVocPct': serializer.toJson<double>(betaVocPct),
      'betaVmpPct': serializer.toJson<double>(betaVmpPct),
      'lengthM': serializer.toJson<double>(lengthM),
      'widthM': serializer.toJson<double>(widthM),
      'weightKg': serializer.toJson<double?>(weightKg),
      'cellType': serializer.toJson<String>(
        $PanelModelsTable.$convertercellType.toJson(cellType),
      ),
      'cellCount': serializer.toJson<int?>(cellCount),
      'bifacial': serializer.toJson<bool>(bifacial),
      'bifacialityPct': serializer.toJson<double?>(bifacialityPct),
      'maxSeriesFuseA': serializer.toJson<double?>(maxSeriesFuseA),
      'maxSystemVoltageV': serializer.toJson<double?>(maxSystemVoltageV),
      'source': serializer.toJson<String>(
        $PanelModelsTable.$convertersource.toJson(source),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  PanelModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? manufacturer,
    String? model,
    double? pmaxW,
    double? vocV,
    double? iscA,
    double? vmpV,
    double? impA,
    double? gammaPmaxPct,
    double? betaVocPct,
    double? betaVmpPct,
    double? lengthM,
    double? widthM,
    Value<double?> weightKg = const Value.absent(),
    CellType? cellType,
    Value<int?> cellCount = const Value.absent(),
    bool? bifacial,
    Value<double?> bifacialityPct = const Value.absent(),
    Value<double?> maxSeriesFuseA = const Value.absent(),
    Value<double?> maxSystemVoltageV = const Value.absent(),
    EquipmentSource? source,
    Value<String?> notes = const Value.absent(),
  }) => PanelModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    manufacturer: manufacturer ?? this.manufacturer,
    model: model ?? this.model,
    pmaxW: pmaxW ?? this.pmaxW,
    vocV: vocV ?? this.vocV,
    iscA: iscA ?? this.iscA,
    vmpV: vmpV ?? this.vmpV,
    impA: impA ?? this.impA,
    gammaPmaxPct: gammaPmaxPct ?? this.gammaPmaxPct,
    betaVocPct: betaVocPct ?? this.betaVocPct,
    betaVmpPct: betaVmpPct ?? this.betaVmpPct,
    lengthM: lengthM ?? this.lengthM,
    widthM: widthM ?? this.widthM,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    cellType: cellType ?? this.cellType,
    cellCount: cellCount.present ? cellCount.value : this.cellCount,
    bifacial: bifacial ?? this.bifacial,
    bifacialityPct: bifacialityPct.present
        ? bifacialityPct.value
        : this.bifacialityPct,
    maxSeriesFuseA: maxSeriesFuseA.present
        ? maxSeriesFuseA.value
        : this.maxSeriesFuseA,
    maxSystemVoltageV: maxSystemVoltageV.present
        ? maxSystemVoltageV.value
        : this.maxSystemVoltageV,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
  );
  PanelModel copyWithCompanion(PanelModelsCompanion data) {
    return PanelModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      pmaxW: data.pmaxW.present ? data.pmaxW.value : this.pmaxW,
      vocV: data.vocV.present ? data.vocV.value : this.vocV,
      iscA: data.iscA.present ? data.iscA.value : this.iscA,
      vmpV: data.vmpV.present ? data.vmpV.value : this.vmpV,
      impA: data.impA.present ? data.impA.value : this.impA,
      gammaPmaxPct: data.gammaPmaxPct.present
          ? data.gammaPmaxPct.value
          : this.gammaPmaxPct,
      betaVocPct: data.betaVocPct.present
          ? data.betaVocPct.value
          : this.betaVocPct,
      betaVmpPct: data.betaVmpPct.present
          ? data.betaVmpPct.value
          : this.betaVmpPct,
      lengthM: data.lengthM.present ? data.lengthM.value : this.lengthM,
      widthM: data.widthM.present ? data.widthM.value : this.widthM,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      cellType: data.cellType.present ? data.cellType.value : this.cellType,
      cellCount: data.cellCount.present ? data.cellCount.value : this.cellCount,
      bifacial: data.bifacial.present ? data.bifacial.value : this.bifacial,
      bifacialityPct: data.bifacialityPct.present
          ? data.bifacialityPct.value
          : this.bifacialityPct,
      maxSeriesFuseA: data.maxSeriesFuseA.present
          ? data.maxSeriesFuseA.value
          : this.maxSeriesFuseA,
      maxSystemVoltageV: data.maxSystemVoltageV.present
          ? data.maxSystemVoltageV.value
          : this.maxSystemVoltageV,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PanelModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('pmaxW: $pmaxW, ')
          ..write('vocV: $vocV, ')
          ..write('iscA: $iscA, ')
          ..write('vmpV: $vmpV, ')
          ..write('impA: $impA, ')
          ..write('gammaPmaxPct: $gammaPmaxPct, ')
          ..write('betaVocPct: $betaVocPct, ')
          ..write('betaVmpPct: $betaVmpPct, ')
          ..write('lengthM: $lengthM, ')
          ..write('widthM: $widthM, ')
          ..write('weightKg: $weightKg, ')
          ..write('cellType: $cellType, ')
          ..write('cellCount: $cellCount, ')
          ..write('bifacial: $bifacial, ')
          ..write('bifacialityPct: $bifacialityPct, ')
          ..write('maxSeriesFuseA: $maxSeriesFuseA, ')
          ..write('maxSystemVoltageV: $maxSystemVoltageV, ')
          ..write('source: $source, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    pmaxW,
    vocV,
    iscA,
    vmpV,
    impA,
    gammaPmaxPct,
    betaVocPct,
    betaVmpPct,
    lengthM,
    widthM,
    weightKg,
    cellType,
    cellCount,
    bifacial,
    bifacialityPct,
    maxSeriesFuseA,
    maxSystemVoltageV,
    source,
    notes,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PanelModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.pmaxW == this.pmaxW &&
          other.vocV == this.vocV &&
          other.iscA == this.iscA &&
          other.vmpV == this.vmpV &&
          other.impA == this.impA &&
          other.gammaPmaxPct == this.gammaPmaxPct &&
          other.betaVocPct == this.betaVocPct &&
          other.betaVmpPct == this.betaVmpPct &&
          other.lengthM == this.lengthM &&
          other.widthM == this.widthM &&
          other.weightKg == this.weightKg &&
          other.cellType == this.cellType &&
          other.cellCount == this.cellCount &&
          other.bifacial == this.bifacial &&
          other.bifacialityPct == this.bifacialityPct &&
          other.maxSeriesFuseA == this.maxSeriesFuseA &&
          other.maxSystemVoltageV == this.maxSystemVoltageV &&
          other.source == this.source &&
          other.notes == this.notes);
}

class PanelModelsCompanion extends UpdateCompanion<PanelModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> manufacturer;
  final Value<String> model;
  final Value<double> pmaxW;
  final Value<double> vocV;
  final Value<double> iscA;
  final Value<double> vmpV;
  final Value<double> impA;
  final Value<double> gammaPmaxPct;
  final Value<double> betaVocPct;
  final Value<double> betaVmpPct;
  final Value<double> lengthM;
  final Value<double> widthM;
  final Value<double?> weightKg;
  final Value<CellType> cellType;
  final Value<int?> cellCount;
  final Value<bool> bifacial;
  final Value<double?> bifacialityPct;
  final Value<double?> maxSeriesFuseA;
  final Value<double?> maxSystemVoltageV;
  final Value<EquipmentSource> source;
  final Value<String?> notes;
  final Value<int> rowid;
  const PanelModelsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.pmaxW = const Value.absent(),
    this.vocV = const Value.absent(),
    this.iscA = const Value.absent(),
    this.vmpV = const Value.absent(),
    this.impA = const Value.absent(),
    this.gammaPmaxPct = const Value.absent(),
    this.betaVocPct = const Value.absent(),
    this.betaVmpPct = const Value.absent(),
    this.lengthM = const Value.absent(),
    this.widthM = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.cellType = const Value.absent(),
    this.cellCount = const Value.absent(),
    this.bifacial = const Value.absent(),
    this.bifacialityPct = const Value.absent(),
    this.maxSeriesFuseA = const Value.absent(),
    this.maxSystemVoltageV = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PanelModelsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String manufacturer,
    required String model,
    required double pmaxW,
    required double vocV,
    required double iscA,
    required double vmpV,
    required double impA,
    this.gammaPmaxPct = const Value.absent(),
    this.betaVocPct = const Value.absent(),
    this.betaVmpPct = const Value.absent(),
    required double lengthM,
    required double widthM,
    this.weightKg = const Value.absent(),
    this.cellType = const Value.absent(),
    this.cellCount = const Value.absent(),
    this.bifacial = const Value.absent(),
    this.bifacialityPct = const Value.absent(),
    this.maxSeriesFuseA = const Value.absent(),
    this.maxSystemVoltageV = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : manufacturer = Value(manufacturer),
       model = Value(model),
       pmaxW = Value(pmaxW),
       vocV = Value(vocV),
       iscA = Value(iscA),
       vmpV = Value(vmpV),
       impA = Value(impA),
       lengthM = Value(lengthM),
       widthM = Value(widthM);
  static Insertable<PanelModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<double>? pmaxW,
    Expression<double>? vocV,
    Expression<double>? iscA,
    Expression<double>? vmpV,
    Expression<double>? impA,
    Expression<double>? gammaPmaxPct,
    Expression<double>? betaVocPct,
    Expression<double>? betaVmpPct,
    Expression<double>? lengthM,
    Expression<double>? widthM,
    Expression<double>? weightKg,
    Expression<String>? cellType,
    Expression<int>? cellCount,
    Expression<bool>? bifacial,
    Expression<double>? bifacialityPct,
    Expression<double>? maxSeriesFuseA,
    Expression<double>? maxSystemVoltageV,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (pmaxW != null) 'pmax_w': pmaxW,
      if (vocV != null) 'voc_v': vocV,
      if (iscA != null) 'isc_a': iscA,
      if (vmpV != null) 'vmp_v': vmpV,
      if (impA != null) 'imp_a': impA,
      if (gammaPmaxPct != null) 'gamma_pmax_pct': gammaPmaxPct,
      if (betaVocPct != null) 'beta_voc_pct': betaVocPct,
      if (betaVmpPct != null) 'beta_vmp_pct': betaVmpPct,
      if (lengthM != null) 'length_m': lengthM,
      if (widthM != null) 'width_m': widthM,
      if (weightKg != null) 'weight_kg': weightKg,
      if (cellType != null) 'cell_type': cellType,
      if (cellCount != null) 'cell_count': cellCount,
      if (bifacial != null) 'bifacial': bifacial,
      if (bifacialityPct != null) 'bifaciality_pct': bifacialityPct,
      if (maxSeriesFuseA != null) 'max_series_fuse_a': maxSeriesFuseA,
      if (maxSystemVoltageV != null) 'max_system_voltage_v': maxSystemVoltageV,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PanelModelsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? manufacturer,
    Value<String>? model,
    Value<double>? pmaxW,
    Value<double>? vocV,
    Value<double>? iscA,
    Value<double>? vmpV,
    Value<double>? impA,
    Value<double>? gammaPmaxPct,
    Value<double>? betaVocPct,
    Value<double>? betaVmpPct,
    Value<double>? lengthM,
    Value<double>? widthM,
    Value<double?>? weightKg,
    Value<CellType>? cellType,
    Value<int?>? cellCount,
    Value<bool>? bifacial,
    Value<double?>? bifacialityPct,
    Value<double?>? maxSeriesFuseA,
    Value<double?>? maxSystemVoltageV,
    Value<EquipmentSource>? source,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return PanelModelsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      pmaxW: pmaxW ?? this.pmaxW,
      vocV: vocV ?? this.vocV,
      iscA: iscA ?? this.iscA,
      vmpV: vmpV ?? this.vmpV,
      impA: impA ?? this.impA,
      gammaPmaxPct: gammaPmaxPct ?? this.gammaPmaxPct,
      betaVocPct: betaVocPct ?? this.betaVocPct,
      betaVmpPct: betaVmpPct ?? this.betaVmpPct,
      lengthM: lengthM ?? this.lengthM,
      widthM: widthM ?? this.widthM,
      weightKg: weightKg ?? this.weightKg,
      cellType: cellType ?? this.cellType,
      cellCount: cellCount ?? this.cellCount,
      bifacial: bifacial ?? this.bifacial,
      bifacialityPct: bifacialityPct ?? this.bifacialityPct,
      maxSeriesFuseA: maxSeriesFuseA ?? this.maxSeriesFuseA,
      maxSystemVoltageV: maxSystemVoltageV ?? this.maxSystemVoltageV,
      source: source ?? this.source,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (pmaxW.present) {
      map['pmax_w'] = Variable<double>(pmaxW.value);
    }
    if (vocV.present) {
      map['voc_v'] = Variable<double>(vocV.value);
    }
    if (iscA.present) {
      map['isc_a'] = Variable<double>(iscA.value);
    }
    if (vmpV.present) {
      map['vmp_v'] = Variable<double>(vmpV.value);
    }
    if (impA.present) {
      map['imp_a'] = Variable<double>(impA.value);
    }
    if (gammaPmaxPct.present) {
      map['gamma_pmax_pct'] = Variable<double>(gammaPmaxPct.value);
    }
    if (betaVocPct.present) {
      map['beta_voc_pct'] = Variable<double>(betaVocPct.value);
    }
    if (betaVmpPct.present) {
      map['beta_vmp_pct'] = Variable<double>(betaVmpPct.value);
    }
    if (lengthM.present) {
      map['length_m'] = Variable<double>(lengthM.value);
    }
    if (widthM.present) {
      map['width_m'] = Variable<double>(widthM.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (cellType.present) {
      map['cell_type'] = Variable<String>(
        $PanelModelsTable.$convertercellType.toSql(cellType.value),
      );
    }
    if (cellCount.present) {
      map['cell_count'] = Variable<int>(cellCount.value);
    }
    if (bifacial.present) {
      map['bifacial'] = Variable<bool>(bifacial.value);
    }
    if (bifacialityPct.present) {
      map['bifaciality_pct'] = Variable<double>(bifacialityPct.value);
    }
    if (maxSeriesFuseA.present) {
      map['max_series_fuse_a'] = Variable<double>(maxSeriesFuseA.value);
    }
    if (maxSystemVoltageV.present) {
      map['max_system_voltage_v'] = Variable<double>(maxSystemVoltageV.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $PanelModelsTable.$convertersource.toSql(source.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PanelModelsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('pmaxW: $pmaxW, ')
          ..write('vocV: $vocV, ')
          ..write('iscA: $iscA, ')
          ..write('vmpV: $vmpV, ')
          ..write('impA: $impA, ')
          ..write('gammaPmaxPct: $gammaPmaxPct, ')
          ..write('betaVocPct: $betaVocPct, ')
          ..write('betaVmpPct: $betaVmpPct, ')
          ..write('lengthM: $lengthM, ')
          ..write('widthM: $widthM, ')
          ..write('weightKg: $weightKg, ')
          ..write('cellType: $cellType, ')
          ..write('cellCount: $cellCount, ')
          ..write('bifacial: $bifacial, ')
          ..write('bifacialityPct: $bifacialityPct, ')
          ..write('maxSeriesFuseA: $maxSeriesFuseA, ')
          ..write('maxSystemVoltageV: $maxSystemVoltageV, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InverterModelsTable extends InverterModels
    with TableInfo<$InverterModelsTable, InverterModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InverterModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<InverterKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(InverterKind.string.name),
      ).withConverter<InverterKind>($InverterModelsTable.$converterkind);
  static const VerificationMeta _pacWMeta = const VerificationMeta('pacW');
  @override
  late final GeneratedColumn<double> pacW = GeneratedColumn<double>(
    'pac_w',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vdcMaxVMeta = const VerificationMeta(
    'vdcMaxV',
  );
  @override
  late final GeneratedColumn<double> vdcMaxV = GeneratedColumn<double>(
    'vdc_max_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mpptMinVMeta = const VerificationMeta(
    'mpptMinV',
  );
  @override
  late final GeneratedColumn<double> mpptMinV = GeneratedColumn<double>(
    'mppt_min_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mpptMaxVMeta = const VerificationMeta(
    'mpptMaxV',
  );
  @override
  late final GeneratedColumn<double> mpptMaxV = GeneratedColumn<double>(
    'mppt_max_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mpptCountMeta = const VerificationMeta(
    'mpptCount',
  );
  @override
  late final GeneratedColumn<int> mpptCount = GeneratedColumn<int>(
    'mppt_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _imaxPerMpptAMeta = const VerificationMeta(
    'imaxPerMpptA',
  );
  @override
  late final GeneratedColumn<double> imaxPerMpptA = GeneratedColumn<double>(
    'imax_per_mppt_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iscMaxPerMpptAMeta = const VerificationMeta(
    'iscMaxPerMpptA',
  );
  @override
  late final GeneratedColumn<double> iscMaxPerMpptA = GeneratedColumn<double>(
    'isc_max_per_mppt_a',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _efficiencyPctMeta = const VerificationMeta(
    'efficiencyPct',
  );
  @override
  late final GeneratedColumn<double> efficiencyPct = GeneratedColumn<double>(
    'efficiency_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(96),
  );
  static const VerificationMeta _phasesMeta = const VerificationMeta('phases');
  @override
  late final GeneratedColumn<int> phases = GeneratedColumn<int>(
    'phases',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _acVoltageVMeta = const VerificationMeta(
    'acVoltageV',
  );
  @override
  late final GeneratedColumn<double> acVoltageV = GeneratedColumn<double>(
    'ac_voltage_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(220),
  );
  static const VerificationMeta _iacMaxAMeta = const VerificationMeta(
    'iacMaxA',
  );
  @override
  late final GeneratedColumn<double> iacMaxA = GeneratedColumn<double>(
    'iac_max_a',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<EquipmentSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(EquipmentSource.manual.name),
      ).withConverter<EquipmentSource>($InverterModelsTable.$convertersource);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    kind,
    pacW,
    vdcMaxV,
    mpptMinV,
    mpptMaxV,
    mpptCount,
    imaxPerMpptA,
    iscMaxPerMpptA,
    efficiencyPct,
    phases,
    acVoltageV,
    iacMaxA,
    source,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inverter_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<InverterModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manufacturerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('pac_w')) {
      context.handle(
        _pacWMeta,
        pacW.isAcceptableOrUnknown(data['pac_w']!, _pacWMeta),
      );
    } else if (isInserting) {
      context.missing(_pacWMeta);
    }
    if (data.containsKey('vdc_max_v')) {
      context.handle(
        _vdcMaxVMeta,
        vdcMaxV.isAcceptableOrUnknown(data['vdc_max_v']!, _vdcMaxVMeta),
      );
    } else if (isInserting) {
      context.missing(_vdcMaxVMeta);
    }
    if (data.containsKey('mppt_min_v')) {
      context.handle(
        _mpptMinVMeta,
        mpptMinV.isAcceptableOrUnknown(data['mppt_min_v']!, _mpptMinVMeta),
      );
    } else if (isInserting) {
      context.missing(_mpptMinVMeta);
    }
    if (data.containsKey('mppt_max_v')) {
      context.handle(
        _mpptMaxVMeta,
        mpptMaxV.isAcceptableOrUnknown(data['mppt_max_v']!, _mpptMaxVMeta),
      );
    } else if (isInserting) {
      context.missing(_mpptMaxVMeta);
    }
    if (data.containsKey('mppt_count')) {
      context.handle(
        _mpptCountMeta,
        mpptCount.isAcceptableOrUnknown(data['mppt_count']!, _mpptCountMeta),
      );
    }
    if (data.containsKey('imax_per_mppt_a')) {
      context.handle(
        _imaxPerMpptAMeta,
        imaxPerMpptA.isAcceptableOrUnknown(
          data['imax_per_mppt_a']!,
          _imaxPerMpptAMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_imaxPerMpptAMeta);
    }
    if (data.containsKey('isc_max_per_mppt_a')) {
      context.handle(
        _iscMaxPerMpptAMeta,
        iscMaxPerMpptA.isAcceptableOrUnknown(
          data['isc_max_per_mppt_a']!,
          _iscMaxPerMpptAMeta,
        ),
      );
    }
    if (data.containsKey('efficiency_pct')) {
      context.handle(
        _efficiencyPctMeta,
        efficiencyPct.isAcceptableOrUnknown(
          data['efficiency_pct']!,
          _efficiencyPctMeta,
        ),
      );
    }
    if (data.containsKey('phases')) {
      context.handle(
        _phasesMeta,
        phases.isAcceptableOrUnknown(data['phases']!, _phasesMeta),
      );
    }
    if (data.containsKey('ac_voltage_v')) {
      context.handle(
        _acVoltageVMeta,
        acVoltageV.isAcceptableOrUnknown(
          data['ac_voltage_v']!,
          _acVoltageVMeta,
        ),
      );
    }
    if (data.containsKey('iac_max_a')) {
      context.handle(
        _iacMaxAMeta,
        iacMaxA.isAcceptableOrUnknown(data['iac_max_a']!, _iacMaxAMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InverterModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InverterModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      kind: $InverterModelsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      pacW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pac_w'],
      )!,
      vdcMaxV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vdc_max_v'],
      )!,
      mpptMinV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mppt_min_v'],
      )!,
      mpptMaxV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mppt_max_v'],
      )!,
      mpptCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mppt_count'],
      )!,
      imaxPerMpptA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}imax_per_mppt_a'],
      )!,
      iscMaxPerMpptA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}isc_max_per_mppt_a'],
      ),
      efficiencyPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}efficiency_pct'],
      )!,
      phases: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}phases'],
      )!,
      acVoltageV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ac_voltage_v'],
      )!,
      iacMaxA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}iac_max_a'],
      ),
      source: $InverterModelsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $InverterModelsTable createAlias(String alias) {
    return $InverterModelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InverterKind, String, String> $converterkind =
      const EnumNameConverter<InverterKind>(InverterKind.values);
  static JsonTypeConverter2<EquipmentSource, String, String> $convertersource =
      const EnumNameConverter<EquipmentSource>(EquipmentSource.values);
}

class InverterModel extends DataClass implements Insertable<InverterModel> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Fabricante.
  final String manufacturer;

  /// Modelo.
  final String model;

  /// String, micro o híbrido.
  final InverterKind kind;

  /// Potencia AC nominal (W).
  final double pacW;

  /// Tensión DC máxima (V).
  final double vdcMaxV;

  /// Tensión mínima del MPPT (V).
  final double mpptMinV;

  /// Tensión máxima del MPPT (V).
  final double mpptMaxV;

  /// Número de MPPT (en micros: entradas de panel).
  final int mpptCount;

  /// Corriente máxima de entrada por MPPT (A).
  final double imaxPerMpptA;

  /// Corriente de cortocircuito máxima por MPPT (A).
  final double? iscMaxPerMpptA;

  /// Eficiencia (%; CEC o europea).
  final double efficiencyPct;

  /// Fases de salida (1 o 3).
  final int phases;

  /// Tensión AC nominal (V).
  final double acVoltageV;

  /// Corriente AC máxima de salida (A).
  final double? iacMaxA;

  /// Origen.
  final EquipmentSource source;

  /// Notas.
  final String? notes;
  const InverterModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.manufacturer,
    required this.model,
    required this.kind,
    required this.pacW,
    required this.vdcMaxV,
    required this.mpptMinV,
    required this.mpptMaxV,
    required this.mpptCount,
    required this.imaxPerMpptA,
    this.iscMaxPerMpptA,
    required this.efficiencyPct,
    required this.phases,
    required this.acVoltageV,
    this.iacMaxA,
    required this.source,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['manufacturer'] = Variable<String>(manufacturer);
    map['model'] = Variable<String>(model);
    {
      map['kind'] = Variable<String>(
        $InverterModelsTable.$converterkind.toSql(kind),
      );
    }
    map['pac_w'] = Variable<double>(pacW);
    map['vdc_max_v'] = Variable<double>(vdcMaxV);
    map['mppt_min_v'] = Variable<double>(mpptMinV);
    map['mppt_max_v'] = Variable<double>(mpptMaxV);
    map['mppt_count'] = Variable<int>(mpptCount);
    map['imax_per_mppt_a'] = Variable<double>(imaxPerMpptA);
    if (!nullToAbsent || iscMaxPerMpptA != null) {
      map['isc_max_per_mppt_a'] = Variable<double>(iscMaxPerMpptA);
    }
    map['efficiency_pct'] = Variable<double>(efficiencyPct);
    map['phases'] = Variable<int>(phases);
    map['ac_voltage_v'] = Variable<double>(acVoltageV);
    if (!nullToAbsent || iacMaxA != null) {
      map['iac_max_a'] = Variable<double>(iacMaxA);
    }
    {
      map['source'] = Variable<String>(
        $InverterModelsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  InverterModelsCompanion toCompanion(bool nullToAbsent) {
    return InverterModelsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      manufacturer: Value(manufacturer),
      model: Value(model),
      kind: Value(kind),
      pacW: Value(pacW),
      vdcMaxV: Value(vdcMaxV),
      mpptMinV: Value(mpptMinV),
      mpptMaxV: Value(mpptMaxV),
      mpptCount: Value(mpptCount),
      imaxPerMpptA: Value(imaxPerMpptA),
      iscMaxPerMpptA: iscMaxPerMpptA == null && nullToAbsent
          ? const Value.absent()
          : Value(iscMaxPerMpptA),
      efficiencyPct: Value(efficiencyPct),
      phases: Value(phases),
      acVoltageV: Value(acVoltageV),
      iacMaxA: iacMaxA == null && nullToAbsent
          ? const Value.absent()
          : Value(iacMaxA),
      source: Value(source),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory InverterModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InverterModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      manufacturer: serializer.fromJson<String>(json['manufacturer']),
      model: serializer.fromJson<String>(json['model']),
      kind: $InverterModelsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      pacW: serializer.fromJson<double>(json['pacW']),
      vdcMaxV: serializer.fromJson<double>(json['vdcMaxV']),
      mpptMinV: serializer.fromJson<double>(json['mpptMinV']),
      mpptMaxV: serializer.fromJson<double>(json['mpptMaxV']),
      mpptCount: serializer.fromJson<int>(json['mpptCount']),
      imaxPerMpptA: serializer.fromJson<double>(json['imaxPerMpptA']),
      iscMaxPerMpptA: serializer.fromJson<double?>(json['iscMaxPerMpptA']),
      efficiencyPct: serializer.fromJson<double>(json['efficiencyPct']),
      phases: serializer.fromJson<int>(json['phases']),
      acVoltageV: serializer.fromJson<double>(json['acVoltageV']),
      iacMaxA: serializer.fromJson<double?>(json['iacMaxA']),
      source: $InverterModelsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'manufacturer': serializer.toJson<String>(manufacturer),
      'model': serializer.toJson<String>(model),
      'kind': serializer.toJson<String>(
        $InverterModelsTable.$converterkind.toJson(kind),
      ),
      'pacW': serializer.toJson<double>(pacW),
      'vdcMaxV': serializer.toJson<double>(vdcMaxV),
      'mpptMinV': serializer.toJson<double>(mpptMinV),
      'mpptMaxV': serializer.toJson<double>(mpptMaxV),
      'mpptCount': serializer.toJson<int>(mpptCount),
      'imaxPerMpptA': serializer.toJson<double>(imaxPerMpptA),
      'iscMaxPerMpptA': serializer.toJson<double?>(iscMaxPerMpptA),
      'efficiencyPct': serializer.toJson<double>(efficiencyPct),
      'phases': serializer.toJson<int>(phases),
      'acVoltageV': serializer.toJson<double>(acVoltageV),
      'iacMaxA': serializer.toJson<double?>(iacMaxA),
      'source': serializer.toJson<String>(
        $InverterModelsTable.$convertersource.toJson(source),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  InverterModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? manufacturer,
    String? model,
    InverterKind? kind,
    double? pacW,
    double? vdcMaxV,
    double? mpptMinV,
    double? mpptMaxV,
    int? mpptCount,
    double? imaxPerMpptA,
    Value<double?> iscMaxPerMpptA = const Value.absent(),
    double? efficiencyPct,
    int? phases,
    double? acVoltageV,
    Value<double?> iacMaxA = const Value.absent(),
    EquipmentSource? source,
    Value<String?> notes = const Value.absent(),
  }) => InverterModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    manufacturer: manufacturer ?? this.manufacturer,
    model: model ?? this.model,
    kind: kind ?? this.kind,
    pacW: pacW ?? this.pacW,
    vdcMaxV: vdcMaxV ?? this.vdcMaxV,
    mpptMinV: mpptMinV ?? this.mpptMinV,
    mpptMaxV: mpptMaxV ?? this.mpptMaxV,
    mpptCount: mpptCount ?? this.mpptCount,
    imaxPerMpptA: imaxPerMpptA ?? this.imaxPerMpptA,
    iscMaxPerMpptA: iscMaxPerMpptA.present
        ? iscMaxPerMpptA.value
        : this.iscMaxPerMpptA,
    efficiencyPct: efficiencyPct ?? this.efficiencyPct,
    phases: phases ?? this.phases,
    acVoltageV: acVoltageV ?? this.acVoltageV,
    iacMaxA: iacMaxA.present ? iacMaxA.value : this.iacMaxA,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
  );
  InverterModel copyWithCompanion(InverterModelsCompanion data) {
    return InverterModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      kind: data.kind.present ? data.kind.value : this.kind,
      pacW: data.pacW.present ? data.pacW.value : this.pacW,
      vdcMaxV: data.vdcMaxV.present ? data.vdcMaxV.value : this.vdcMaxV,
      mpptMinV: data.mpptMinV.present ? data.mpptMinV.value : this.mpptMinV,
      mpptMaxV: data.mpptMaxV.present ? data.mpptMaxV.value : this.mpptMaxV,
      mpptCount: data.mpptCount.present ? data.mpptCount.value : this.mpptCount,
      imaxPerMpptA: data.imaxPerMpptA.present
          ? data.imaxPerMpptA.value
          : this.imaxPerMpptA,
      iscMaxPerMpptA: data.iscMaxPerMpptA.present
          ? data.iscMaxPerMpptA.value
          : this.iscMaxPerMpptA,
      efficiencyPct: data.efficiencyPct.present
          ? data.efficiencyPct.value
          : this.efficiencyPct,
      phases: data.phases.present ? data.phases.value : this.phases,
      acVoltageV: data.acVoltageV.present
          ? data.acVoltageV.value
          : this.acVoltageV,
      iacMaxA: data.iacMaxA.present ? data.iacMaxA.value : this.iacMaxA,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InverterModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('kind: $kind, ')
          ..write('pacW: $pacW, ')
          ..write('vdcMaxV: $vdcMaxV, ')
          ..write('mpptMinV: $mpptMinV, ')
          ..write('mpptMaxV: $mpptMaxV, ')
          ..write('mpptCount: $mpptCount, ')
          ..write('imaxPerMpptA: $imaxPerMpptA, ')
          ..write('iscMaxPerMpptA: $iscMaxPerMpptA, ')
          ..write('efficiencyPct: $efficiencyPct, ')
          ..write('phases: $phases, ')
          ..write('acVoltageV: $acVoltageV, ')
          ..write('iacMaxA: $iacMaxA, ')
          ..write('source: $source, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    kind,
    pacW,
    vdcMaxV,
    mpptMinV,
    mpptMaxV,
    mpptCount,
    imaxPerMpptA,
    iscMaxPerMpptA,
    efficiencyPct,
    phases,
    acVoltageV,
    iacMaxA,
    source,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InverterModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.kind == this.kind &&
          other.pacW == this.pacW &&
          other.vdcMaxV == this.vdcMaxV &&
          other.mpptMinV == this.mpptMinV &&
          other.mpptMaxV == this.mpptMaxV &&
          other.mpptCount == this.mpptCount &&
          other.imaxPerMpptA == this.imaxPerMpptA &&
          other.iscMaxPerMpptA == this.iscMaxPerMpptA &&
          other.efficiencyPct == this.efficiencyPct &&
          other.phases == this.phases &&
          other.acVoltageV == this.acVoltageV &&
          other.iacMaxA == this.iacMaxA &&
          other.source == this.source &&
          other.notes == this.notes);
}

class InverterModelsCompanion extends UpdateCompanion<InverterModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> manufacturer;
  final Value<String> model;
  final Value<InverterKind> kind;
  final Value<double> pacW;
  final Value<double> vdcMaxV;
  final Value<double> mpptMinV;
  final Value<double> mpptMaxV;
  final Value<int> mpptCount;
  final Value<double> imaxPerMpptA;
  final Value<double?> iscMaxPerMpptA;
  final Value<double> efficiencyPct;
  final Value<int> phases;
  final Value<double> acVoltageV;
  final Value<double?> iacMaxA;
  final Value<EquipmentSource> source;
  final Value<String?> notes;
  final Value<int> rowid;
  const InverterModelsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.kind = const Value.absent(),
    this.pacW = const Value.absent(),
    this.vdcMaxV = const Value.absent(),
    this.mpptMinV = const Value.absent(),
    this.mpptMaxV = const Value.absent(),
    this.mpptCount = const Value.absent(),
    this.imaxPerMpptA = const Value.absent(),
    this.iscMaxPerMpptA = const Value.absent(),
    this.efficiencyPct = const Value.absent(),
    this.phases = const Value.absent(),
    this.acVoltageV = const Value.absent(),
    this.iacMaxA = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InverterModelsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String manufacturer,
    required String model,
    this.kind = const Value.absent(),
    required double pacW,
    required double vdcMaxV,
    required double mpptMinV,
    required double mpptMaxV,
    this.mpptCount = const Value.absent(),
    required double imaxPerMpptA,
    this.iscMaxPerMpptA = const Value.absent(),
    this.efficiencyPct = const Value.absent(),
    this.phases = const Value.absent(),
    this.acVoltageV = const Value.absent(),
    this.iacMaxA = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : manufacturer = Value(manufacturer),
       model = Value(model),
       pacW = Value(pacW),
       vdcMaxV = Value(vdcMaxV),
       mpptMinV = Value(mpptMinV),
       mpptMaxV = Value(mpptMaxV),
       imaxPerMpptA = Value(imaxPerMpptA);
  static Insertable<InverterModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? kind,
    Expression<double>? pacW,
    Expression<double>? vdcMaxV,
    Expression<double>? mpptMinV,
    Expression<double>? mpptMaxV,
    Expression<int>? mpptCount,
    Expression<double>? imaxPerMpptA,
    Expression<double>? iscMaxPerMpptA,
    Expression<double>? efficiencyPct,
    Expression<int>? phases,
    Expression<double>? acVoltageV,
    Expression<double>? iacMaxA,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (kind != null) 'kind': kind,
      if (pacW != null) 'pac_w': pacW,
      if (vdcMaxV != null) 'vdc_max_v': vdcMaxV,
      if (mpptMinV != null) 'mppt_min_v': mpptMinV,
      if (mpptMaxV != null) 'mppt_max_v': mpptMaxV,
      if (mpptCount != null) 'mppt_count': mpptCount,
      if (imaxPerMpptA != null) 'imax_per_mppt_a': imaxPerMpptA,
      if (iscMaxPerMpptA != null) 'isc_max_per_mppt_a': iscMaxPerMpptA,
      if (efficiencyPct != null) 'efficiency_pct': efficiencyPct,
      if (phases != null) 'phases': phases,
      if (acVoltageV != null) 'ac_voltage_v': acVoltageV,
      if (iacMaxA != null) 'iac_max_a': iacMaxA,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InverterModelsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? manufacturer,
    Value<String>? model,
    Value<InverterKind>? kind,
    Value<double>? pacW,
    Value<double>? vdcMaxV,
    Value<double>? mpptMinV,
    Value<double>? mpptMaxV,
    Value<int>? mpptCount,
    Value<double>? imaxPerMpptA,
    Value<double?>? iscMaxPerMpptA,
    Value<double>? efficiencyPct,
    Value<int>? phases,
    Value<double>? acVoltageV,
    Value<double?>? iacMaxA,
    Value<EquipmentSource>? source,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return InverterModelsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      kind: kind ?? this.kind,
      pacW: pacW ?? this.pacW,
      vdcMaxV: vdcMaxV ?? this.vdcMaxV,
      mpptMinV: mpptMinV ?? this.mpptMinV,
      mpptMaxV: mpptMaxV ?? this.mpptMaxV,
      mpptCount: mpptCount ?? this.mpptCount,
      imaxPerMpptA: imaxPerMpptA ?? this.imaxPerMpptA,
      iscMaxPerMpptA: iscMaxPerMpptA ?? this.iscMaxPerMpptA,
      efficiencyPct: efficiencyPct ?? this.efficiencyPct,
      phases: phases ?? this.phases,
      acVoltageV: acVoltageV ?? this.acVoltageV,
      iacMaxA: iacMaxA ?? this.iacMaxA,
      source: source ?? this.source,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $InverterModelsTable.$converterkind.toSql(kind.value),
      );
    }
    if (pacW.present) {
      map['pac_w'] = Variable<double>(pacW.value);
    }
    if (vdcMaxV.present) {
      map['vdc_max_v'] = Variable<double>(vdcMaxV.value);
    }
    if (mpptMinV.present) {
      map['mppt_min_v'] = Variable<double>(mpptMinV.value);
    }
    if (mpptMaxV.present) {
      map['mppt_max_v'] = Variable<double>(mpptMaxV.value);
    }
    if (mpptCount.present) {
      map['mppt_count'] = Variable<int>(mpptCount.value);
    }
    if (imaxPerMpptA.present) {
      map['imax_per_mppt_a'] = Variable<double>(imaxPerMpptA.value);
    }
    if (iscMaxPerMpptA.present) {
      map['isc_max_per_mppt_a'] = Variable<double>(iscMaxPerMpptA.value);
    }
    if (efficiencyPct.present) {
      map['efficiency_pct'] = Variable<double>(efficiencyPct.value);
    }
    if (phases.present) {
      map['phases'] = Variable<int>(phases.value);
    }
    if (acVoltageV.present) {
      map['ac_voltage_v'] = Variable<double>(acVoltageV.value);
    }
    if (iacMaxA.present) {
      map['iac_max_a'] = Variable<double>(iacMaxA.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $InverterModelsTable.$convertersource.toSql(source.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InverterModelsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('kind: $kind, ')
          ..write('pacW: $pacW, ')
          ..write('vdcMaxV: $vdcMaxV, ')
          ..write('mpptMinV: $mpptMinV, ')
          ..write('mpptMaxV: $mpptMaxV, ')
          ..write('mpptCount: $mpptCount, ')
          ..write('imaxPerMpptA: $imaxPerMpptA, ')
          ..write('iscMaxPerMpptA: $iscMaxPerMpptA, ')
          ..write('efficiencyPct: $efficiencyPct, ')
          ..write('phases: $phases, ')
          ..write('acVoltageV: $acVoltageV, ')
          ..write('iacMaxA: $iacMaxA, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $OptimizerModelsTable extends OptimizerModels
    with TableInfo<$OptimizerModelsTable, OptimizerModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OptimizerModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pmaxInWMeta = const VerificationMeta(
    'pmaxInW',
  );
  @override
  late final GeneratedColumn<double> pmaxInW = GeneratedColumn<double>(
    'pmax_in_w',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vinMaxVMeta = const VerificationMeta(
    'vinMaxV',
  );
  @override
  late final GeneratedColumn<double> vinMaxV = GeneratedColumn<double>(
    'vin_max_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imaxInAMeta = const VerificationMeta(
    'imaxInA',
  );
  @override
  late final GeneratedColumn<double> imaxInA = GeneratedColumn<double>(
    'imax_in_a',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voutMaxVMeta = const VerificationMeta(
    'voutMaxV',
  );
  @override
  late final GeneratedColumn<double> voutMaxV = GeneratedColumn<double>(
    'vout_max_v',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ioutMaxAMeta = const VerificationMeta(
    'ioutMaxA',
  );
  @override
  late final GeneratedColumn<double> ioutMaxA = GeneratedColumn<double>(
    'iout_max_a',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _efficiencyPctMeta = const VerificationMeta(
    'efficiencyPct',
  );
  @override
  late final GeneratedColumn<double> efficiencyPct = GeneratedColumn<double>(
    'efficiency_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(99),
  );
  @override
  late final GeneratedColumnWithTypeConverter<EquipmentSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(EquipmentSource.manual.name),
      ).withConverter<EquipmentSource>($OptimizerModelsTable.$convertersource);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    pmaxInW,
    vinMaxV,
    imaxInA,
    voutMaxV,
    ioutMaxA,
    efficiencyPct,
    source,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'optimizer_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<OptimizerModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manufacturerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('pmax_in_w')) {
      context.handle(
        _pmaxInWMeta,
        pmaxInW.isAcceptableOrUnknown(data['pmax_in_w']!, _pmaxInWMeta),
      );
    } else if (isInserting) {
      context.missing(_pmaxInWMeta);
    }
    if (data.containsKey('vin_max_v')) {
      context.handle(
        _vinMaxVMeta,
        vinMaxV.isAcceptableOrUnknown(data['vin_max_v']!, _vinMaxVMeta),
      );
    } else if (isInserting) {
      context.missing(_vinMaxVMeta);
    }
    if (data.containsKey('imax_in_a')) {
      context.handle(
        _imaxInAMeta,
        imaxInA.isAcceptableOrUnknown(data['imax_in_a']!, _imaxInAMeta),
      );
    } else if (isInserting) {
      context.missing(_imaxInAMeta);
    }
    if (data.containsKey('vout_max_v')) {
      context.handle(
        _voutMaxVMeta,
        voutMaxV.isAcceptableOrUnknown(data['vout_max_v']!, _voutMaxVMeta),
      );
    }
    if (data.containsKey('iout_max_a')) {
      context.handle(
        _ioutMaxAMeta,
        ioutMaxA.isAcceptableOrUnknown(data['iout_max_a']!, _ioutMaxAMeta),
      );
    }
    if (data.containsKey('efficiency_pct')) {
      context.handle(
        _efficiencyPctMeta,
        efficiencyPct.isAcceptableOrUnknown(
          data['efficiency_pct']!,
          _efficiencyPctMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OptimizerModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OptimizerModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      pmaxInW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pmax_in_w'],
      )!,
      vinMaxV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vin_max_v'],
      )!,
      imaxInA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}imax_in_a'],
      )!,
      voutMaxV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vout_max_v'],
      ),
      ioutMaxA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}iout_max_a'],
      ),
      efficiencyPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}efficiency_pct'],
      )!,
      source: $OptimizerModelsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $OptimizerModelsTable createAlias(String alias) {
    return $OptimizerModelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<EquipmentSource, String, String> $convertersource =
      const EnumNameConverter<EquipmentSource>(EquipmentSource.values);
}

class OptimizerModel extends DataClass implements Insertable<OptimizerModel> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Fabricante.
  final String manufacturer;

  /// Modelo.
  final String model;

  /// Potencia de entrada máxima (W).
  final double pmaxInW;

  /// Tensión de entrada máxima (V).
  final double vinMaxV;

  /// Corriente de entrada máxima (A).
  final double imaxInA;

  /// Tensión de salida máxima (V).
  final double? voutMaxV;

  /// Corriente de salida máxima (A).
  final double? ioutMaxA;

  /// Eficiencia (%).
  final double efficiencyPct;

  /// Origen.
  final EquipmentSource source;

  /// Notas.
  final String? notes;
  const OptimizerModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.manufacturer,
    required this.model,
    required this.pmaxInW,
    required this.vinMaxV,
    required this.imaxInA,
    this.voutMaxV,
    this.ioutMaxA,
    required this.efficiencyPct,
    required this.source,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['manufacturer'] = Variable<String>(manufacturer);
    map['model'] = Variable<String>(model);
    map['pmax_in_w'] = Variable<double>(pmaxInW);
    map['vin_max_v'] = Variable<double>(vinMaxV);
    map['imax_in_a'] = Variable<double>(imaxInA);
    if (!nullToAbsent || voutMaxV != null) {
      map['vout_max_v'] = Variable<double>(voutMaxV);
    }
    if (!nullToAbsent || ioutMaxA != null) {
      map['iout_max_a'] = Variable<double>(ioutMaxA);
    }
    map['efficiency_pct'] = Variable<double>(efficiencyPct);
    {
      map['source'] = Variable<String>(
        $OptimizerModelsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  OptimizerModelsCompanion toCompanion(bool nullToAbsent) {
    return OptimizerModelsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      manufacturer: Value(manufacturer),
      model: Value(model),
      pmaxInW: Value(pmaxInW),
      vinMaxV: Value(vinMaxV),
      imaxInA: Value(imaxInA),
      voutMaxV: voutMaxV == null && nullToAbsent
          ? const Value.absent()
          : Value(voutMaxV),
      ioutMaxA: ioutMaxA == null && nullToAbsent
          ? const Value.absent()
          : Value(ioutMaxA),
      efficiencyPct: Value(efficiencyPct),
      source: Value(source),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory OptimizerModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OptimizerModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      manufacturer: serializer.fromJson<String>(json['manufacturer']),
      model: serializer.fromJson<String>(json['model']),
      pmaxInW: serializer.fromJson<double>(json['pmaxInW']),
      vinMaxV: serializer.fromJson<double>(json['vinMaxV']),
      imaxInA: serializer.fromJson<double>(json['imaxInA']),
      voutMaxV: serializer.fromJson<double?>(json['voutMaxV']),
      ioutMaxA: serializer.fromJson<double?>(json['ioutMaxA']),
      efficiencyPct: serializer.fromJson<double>(json['efficiencyPct']),
      source: $OptimizerModelsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'manufacturer': serializer.toJson<String>(manufacturer),
      'model': serializer.toJson<String>(model),
      'pmaxInW': serializer.toJson<double>(pmaxInW),
      'vinMaxV': serializer.toJson<double>(vinMaxV),
      'imaxInA': serializer.toJson<double>(imaxInA),
      'voutMaxV': serializer.toJson<double?>(voutMaxV),
      'ioutMaxA': serializer.toJson<double?>(ioutMaxA),
      'efficiencyPct': serializer.toJson<double>(efficiencyPct),
      'source': serializer.toJson<String>(
        $OptimizerModelsTable.$convertersource.toJson(source),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  OptimizerModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? manufacturer,
    String? model,
    double? pmaxInW,
    double? vinMaxV,
    double? imaxInA,
    Value<double?> voutMaxV = const Value.absent(),
    Value<double?> ioutMaxA = const Value.absent(),
    double? efficiencyPct,
    EquipmentSource? source,
    Value<String?> notes = const Value.absent(),
  }) => OptimizerModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    manufacturer: manufacturer ?? this.manufacturer,
    model: model ?? this.model,
    pmaxInW: pmaxInW ?? this.pmaxInW,
    vinMaxV: vinMaxV ?? this.vinMaxV,
    imaxInA: imaxInA ?? this.imaxInA,
    voutMaxV: voutMaxV.present ? voutMaxV.value : this.voutMaxV,
    ioutMaxA: ioutMaxA.present ? ioutMaxA.value : this.ioutMaxA,
    efficiencyPct: efficiencyPct ?? this.efficiencyPct,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
  );
  OptimizerModel copyWithCompanion(OptimizerModelsCompanion data) {
    return OptimizerModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      pmaxInW: data.pmaxInW.present ? data.pmaxInW.value : this.pmaxInW,
      vinMaxV: data.vinMaxV.present ? data.vinMaxV.value : this.vinMaxV,
      imaxInA: data.imaxInA.present ? data.imaxInA.value : this.imaxInA,
      voutMaxV: data.voutMaxV.present ? data.voutMaxV.value : this.voutMaxV,
      ioutMaxA: data.ioutMaxA.present ? data.ioutMaxA.value : this.ioutMaxA,
      efficiencyPct: data.efficiencyPct.present
          ? data.efficiencyPct.value
          : this.efficiencyPct,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OptimizerModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('pmaxInW: $pmaxInW, ')
          ..write('vinMaxV: $vinMaxV, ')
          ..write('imaxInA: $imaxInA, ')
          ..write('voutMaxV: $voutMaxV, ')
          ..write('ioutMaxA: $ioutMaxA, ')
          ..write('efficiencyPct: $efficiencyPct, ')
          ..write('source: $source, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    pmaxInW,
    vinMaxV,
    imaxInA,
    voutMaxV,
    ioutMaxA,
    efficiencyPct,
    source,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OptimizerModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.pmaxInW == this.pmaxInW &&
          other.vinMaxV == this.vinMaxV &&
          other.imaxInA == this.imaxInA &&
          other.voutMaxV == this.voutMaxV &&
          other.ioutMaxA == this.ioutMaxA &&
          other.efficiencyPct == this.efficiencyPct &&
          other.source == this.source &&
          other.notes == this.notes);
}

class OptimizerModelsCompanion extends UpdateCompanion<OptimizerModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> manufacturer;
  final Value<String> model;
  final Value<double> pmaxInW;
  final Value<double> vinMaxV;
  final Value<double> imaxInA;
  final Value<double?> voutMaxV;
  final Value<double?> ioutMaxA;
  final Value<double> efficiencyPct;
  final Value<EquipmentSource> source;
  final Value<String?> notes;
  final Value<int> rowid;
  const OptimizerModelsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.pmaxInW = const Value.absent(),
    this.vinMaxV = const Value.absent(),
    this.imaxInA = const Value.absent(),
    this.voutMaxV = const Value.absent(),
    this.ioutMaxA = const Value.absent(),
    this.efficiencyPct = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  OptimizerModelsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String manufacturer,
    required String model,
    required double pmaxInW,
    required double vinMaxV,
    required double imaxInA,
    this.voutMaxV = const Value.absent(),
    this.ioutMaxA = const Value.absent(),
    this.efficiencyPct = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : manufacturer = Value(manufacturer),
       model = Value(model),
       pmaxInW = Value(pmaxInW),
       vinMaxV = Value(vinMaxV),
       imaxInA = Value(imaxInA);
  static Insertable<OptimizerModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<double>? pmaxInW,
    Expression<double>? vinMaxV,
    Expression<double>? imaxInA,
    Expression<double>? voutMaxV,
    Expression<double>? ioutMaxA,
    Expression<double>? efficiencyPct,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (pmaxInW != null) 'pmax_in_w': pmaxInW,
      if (vinMaxV != null) 'vin_max_v': vinMaxV,
      if (imaxInA != null) 'imax_in_a': imaxInA,
      if (voutMaxV != null) 'vout_max_v': voutMaxV,
      if (ioutMaxA != null) 'iout_max_a': ioutMaxA,
      if (efficiencyPct != null) 'efficiency_pct': efficiencyPct,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  OptimizerModelsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? manufacturer,
    Value<String>? model,
    Value<double>? pmaxInW,
    Value<double>? vinMaxV,
    Value<double>? imaxInA,
    Value<double?>? voutMaxV,
    Value<double?>? ioutMaxA,
    Value<double>? efficiencyPct,
    Value<EquipmentSource>? source,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return OptimizerModelsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      pmaxInW: pmaxInW ?? this.pmaxInW,
      vinMaxV: vinMaxV ?? this.vinMaxV,
      imaxInA: imaxInA ?? this.imaxInA,
      voutMaxV: voutMaxV ?? this.voutMaxV,
      ioutMaxA: ioutMaxA ?? this.ioutMaxA,
      efficiencyPct: efficiencyPct ?? this.efficiencyPct,
      source: source ?? this.source,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (pmaxInW.present) {
      map['pmax_in_w'] = Variable<double>(pmaxInW.value);
    }
    if (vinMaxV.present) {
      map['vin_max_v'] = Variable<double>(vinMaxV.value);
    }
    if (imaxInA.present) {
      map['imax_in_a'] = Variable<double>(imaxInA.value);
    }
    if (voutMaxV.present) {
      map['vout_max_v'] = Variable<double>(voutMaxV.value);
    }
    if (ioutMaxA.present) {
      map['iout_max_a'] = Variable<double>(ioutMaxA.value);
    }
    if (efficiencyPct.present) {
      map['efficiency_pct'] = Variable<double>(efficiencyPct.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $OptimizerModelsTable.$convertersource.toSql(source.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OptimizerModelsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('pmaxInW: $pmaxInW, ')
          ..write('vinMaxV: $vinMaxV, ')
          ..write('imaxInA: $imaxInA, ')
          ..write('voutMaxV: $voutMaxV, ')
          ..write('ioutMaxA: $ioutMaxA, ')
          ..write('efficiencyPct: $efficiencyPct, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BatteryModelsTable extends BatteryModels
    with TableInfo<$BatteryModelsTable, BatteryModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatteryModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta(
    'manufacturer',
  );
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BatteryChemistry, String>
  chemistry = GeneratedColumn<String>(
    'chemistry',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(BatteryChemistry.lfp.name),
  ).withConverter<BatteryChemistry>($BatteryModelsTable.$converterchemistry);
  static const VerificationMeta _capacityKwhMeta = const VerificationMeta(
    'capacityKwh',
  );
  @override
  late final GeneratedColumn<double> capacityKwh = GeneratedColumn<double>(
    'capacity_kwh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usableKwhMeta = const VerificationMeta(
    'usableKwh',
  );
  @override
  late final GeneratedColumn<double> usableKwh = GeneratedColumn<double>(
    'usable_kwh',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nominalVoltageVMeta = const VerificationMeta(
    'nominalVoltageV',
  );
  @override
  late final GeneratedColumn<double> nominalVoltageV = GeneratedColumn<double>(
    'nominal_voltage_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxChargeKwMeta = const VerificationMeta(
    'maxChargeKw',
  );
  @override
  late final GeneratedColumn<double> maxChargeKw = GeneratedColumn<double>(
    'max_charge_kw',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _maxDischargeKwMeta = const VerificationMeta(
    'maxDischargeKw',
  );
  @override
  late final GeneratedColumn<double> maxDischargeKw = GeneratedColumn<double>(
    'max_discharge_kw',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cyclesMeta = const VerificationMeta('cycles');
  @override
  late final GeneratedColumn<int> cycles = GeneratedColumn<int>(
    'cycles',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<EquipmentSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(EquipmentSource.manual.name),
      ).withConverter<EquipmentSource>($BatteryModelsTable.$convertersource);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    chemistry,
    capacityKwh,
    usableKwh,
    nominalVoltageV,
    maxChargeKw,
    maxDischargeKw,
    cycles,
    source,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'battery_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<BatteryModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(
        _manufacturerMeta,
        manufacturer.isAcceptableOrUnknown(
          data['manufacturer']!,
          _manufacturerMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_manufacturerMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('capacity_kwh')) {
      context.handle(
        _capacityKwhMeta,
        capacityKwh.isAcceptableOrUnknown(
          data['capacity_kwh']!,
          _capacityKwhMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_capacityKwhMeta);
    }
    if (data.containsKey('usable_kwh')) {
      context.handle(
        _usableKwhMeta,
        usableKwh.isAcceptableOrUnknown(data['usable_kwh']!, _usableKwhMeta),
      );
    }
    if (data.containsKey('nominal_voltage_v')) {
      context.handle(
        _nominalVoltageVMeta,
        nominalVoltageV.isAcceptableOrUnknown(
          data['nominal_voltage_v']!,
          _nominalVoltageVMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nominalVoltageVMeta);
    }
    if (data.containsKey('max_charge_kw')) {
      context.handle(
        _maxChargeKwMeta,
        maxChargeKw.isAcceptableOrUnknown(
          data['max_charge_kw']!,
          _maxChargeKwMeta,
        ),
      );
    }
    if (data.containsKey('max_discharge_kw')) {
      context.handle(
        _maxDischargeKwMeta,
        maxDischargeKw.isAcceptableOrUnknown(
          data['max_discharge_kw']!,
          _maxDischargeKwMeta,
        ),
      );
    }
    if (data.containsKey('cycles')) {
      context.handle(
        _cyclesMeta,
        cycles.isAcceptableOrUnknown(data['cycles']!, _cyclesMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BatteryModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BatteryModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      manufacturer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manufacturer'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      chemistry: $BatteryModelsTable.$converterchemistry.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}chemistry'],
        )!,
      ),
      capacityKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}capacity_kwh'],
      )!,
      usableKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}usable_kwh'],
      ),
      nominalVoltageV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}nominal_voltage_v'],
      )!,
      maxChargeKw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_charge_kw'],
      ),
      maxDischargeKw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}max_discharge_kw'],
      ),
      cycles: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cycles'],
      ),
      source: $BatteryModelsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $BatteryModelsTable createAlias(String alias) {
    return $BatteryModelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BatteryChemistry, String, String>
  $converterchemistry = const EnumNameConverter<BatteryChemistry>(
    BatteryChemistry.values,
  );
  static JsonTypeConverter2<EquipmentSource, String, String> $convertersource =
      const EnumNameConverter<EquipmentSource>(EquipmentSource.values);
}

class BatteryModel extends DataClass implements Insertable<BatteryModel> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Fabricante.
  final String manufacturer;

  /// Modelo.
  final String model;

  /// Química.
  final BatteryChemistry chemistry;

  /// Capacidad nominal (kWh).
  final double capacityKwh;

  /// Capacidad útil (kWh).
  final double? usableKwh;

  /// Tensión nominal (V).
  final double nominalVoltageV;

  /// Potencia máxima de carga (kW).
  final double? maxChargeKw;

  /// Potencia máxima de descarga (kW).
  final double? maxDischargeKw;

  /// Ciclos de vida.
  final int? cycles;

  /// Origen.
  final EquipmentSource source;

  /// Notas.
  final String? notes;
  const BatteryModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.manufacturer,
    required this.model,
    required this.chemistry,
    required this.capacityKwh,
    this.usableKwh,
    required this.nominalVoltageV,
    this.maxChargeKw,
    this.maxDischargeKw,
    this.cycles,
    required this.source,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['manufacturer'] = Variable<String>(manufacturer);
    map['model'] = Variable<String>(model);
    {
      map['chemistry'] = Variable<String>(
        $BatteryModelsTable.$converterchemistry.toSql(chemistry),
      );
    }
    map['capacity_kwh'] = Variable<double>(capacityKwh);
    if (!nullToAbsent || usableKwh != null) {
      map['usable_kwh'] = Variable<double>(usableKwh);
    }
    map['nominal_voltage_v'] = Variable<double>(nominalVoltageV);
    if (!nullToAbsent || maxChargeKw != null) {
      map['max_charge_kw'] = Variable<double>(maxChargeKw);
    }
    if (!nullToAbsent || maxDischargeKw != null) {
      map['max_discharge_kw'] = Variable<double>(maxDischargeKw);
    }
    if (!nullToAbsent || cycles != null) {
      map['cycles'] = Variable<int>(cycles);
    }
    {
      map['source'] = Variable<String>(
        $BatteryModelsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  BatteryModelsCompanion toCompanion(bool nullToAbsent) {
    return BatteryModelsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      manufacturer: Value(manufacturer),
      model: Value(model),
      chemistry: Value(chemistry),
      capacityKwh: Value(capacityKwh),
      usableKwh: usableKwh == null && nullToAbsent
          ? const Value.absent()
          : Value(usableKwh),
      nominalVoltageV: Value(nominalVoltageV),
      maxChargeKw: maxChargeKw == null && nullToAbsent
          ? const Value.absent()
          : Value(maxChargeKw),
      maxDischargeKw: maxDischargeKw == null && nullToAbsent
          ? const Value.absent()
          : Value(maxDischargeKw),
      cycles: cycles == null && nullToAbsent
          ? const Value.absent()
          : Value(cycles),
      source: Value(source),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory BatteryModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BatteryModel(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      manufacturer: serializer.fromJson<String>(json['manufacturer']),
      model: serializer.fromJson<String>(json['model']),
      chemistry: $BatteryModelsTable.$converterchemistry.fromJson(
        serializer.fromJson<String>(json['chemistry']),
      ),
      capacityKwh: serializer.fromJson<double>(json['capacityKwh']),
      usableKwh: serializer.fromJson<double?>(json['usableKwh']),
      nominalVoltageV: serializer.fromJson<double>(json['nominalVoltageV']),
      maxChargeKw: serializer.fromJson<double?>(json['maxChargeKw']),
      maxDischargeKw: serializer.fromJson<double?>(json['maxDischargeKw']),
      cycles: serializer.fromJson<int?>(json['cycles']),
      source: $BatteryModelsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'manufacturer': serializer.toJson<String>(manufacturer),
      'model': serializer.toJson<String>(model),
      'chemistry': serializer.toJson<String>(
        $BatteryModelsTable.$converterchemistry.toJson(chemistry),
      ),
      'capacityKwh': serializer.toJson<double>(capacityKwh),
      'usableKwh': serializer.toJson<double?>(usableKwh),
      'nominalVoltageV': serializer.toJson<double>(nominalVoltageV),
      'maxChargeKw': serializer.toJson<double?>(maxChargeKw),
      'maxDischargeKw': serializer.toJson<double?>(maxDischargeKw),
      'cycles': serializer.toJson<int?>(cycles),
      'source': serializer.toJson<String>(
        $BatteryModelsTable.$convertersource.toJson(source),
      ),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  BatteryModel copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? manufacturer,
    String? model,
    BatteryChemistry? chemistry,
    double? capacityKwh,
    Value<double?> usableKwh = const Value.absent(),
    double? nominalVoltageV,
    Value<double?> maxChargeKw = const Value.absent(),
    Value<double?> maxDischargeKw = const Value.absent(),
    Value<int?> cycles = const Value.absent(),
    EquipmentSource? source,
    Value<String?> notes = const Value.absent(),
  }) => BatteryModel(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    manufacturer: manufacturer ?? this.manufacturer,
    model: model ?? this.model,
    chemistry: chemistry ?? this.chemistry,
    capacityKwh: capacityKwh ?? this.capacityKwh,
    usableKwh: usableKwh.present ? usableKwh.value : this.usableKwh,
    nominalVoltageV: nominalVoltageV ?? this.nominalVoltageV,
    maxChargeKw: maxChargeKw.present ? maxChargeKw.value : this.maxChargeKw,
    maxDischargeKw: maxDischargeKw.present
        ? maxDischargeKw.value
        : this.maxDischargeKw,
    cycles: cycles.present ? cycles.value : this.cycles,
    source: source ?? this.source,
    notes: notes.present ? notes.value : this.notes,
  );
  BatteryModel copyWithCompanion(BatteryModelsCompanion data) {
    return BatteryModel(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      manufacturer: data.manufacturer.present
          ? data.manufacturer.value
          : this.manufacturer,
      model: data.model.present ? data.model.value : this.model,
      chemistry: data.chemistry.present ? data.chemistry.value : this.chemistry,
      capacityKwh: data.capacityKwh.present
          ? data.capacityKwh.value
          : this.capacityKwh,
      usableKwh: data.usableKwh.present ? data.usableKwh.value : this.usableKwh,
      nominalVoltageV: data.nominalVoltageV.present
          ? data.nominalVoltageV.value
          : this.nominalVoltageV,
      maxChargeKw: data.maxChargeKw.present
          ? data.maxChargeKw.value
          : this.maxChargeKw,
      maxDischargeKw: data.maxDischargeKw.present
          ? data.maxDischargeKw.value
          : this.maxDischargeKw,
      cycles: data.cycles.present ? data.cycles.value : this.cycles,
      source: data.source.present ? data.source.value : this.source,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BatteryModel(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('chemistry: $chemistry, ')
          ..write('capacityKwh: $capacityKwh, ')
          ..write('usableKwh: $usableKwh, ')
          ..write('nominalVoltageV: $nominalVoltageV, ')
          ..write('maxChargeKw: $maxChargeKw, ')
          ..write('maxDischargeKw: $maxDischargeKw, ')
          ..write('cycles: $cycles, ')
          ..write('source: $source, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    manufacturer,
    model,
    chemistry,
    capacityKwh,
    usableKwh,
    nominalVoltageV,
    maxChargeKw,
    maxDischargeKw,
    cycles,
    source,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BatteryModel &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.manufacturer == this.manufacturer &&
          other.model == this.model &&
          other.chemistry == this.chemistry &&
          other.capacityKwh == this.capacityKwh &&
          other.usableKwh == this.usableKwh &&
          other.nominalVoltageV == this.nominalVoltageV &&
          other.maxChargeKw == this.maxChargeKw &&
          other.maxDischargeKw == this.maxDischargeKw &&
          other.cycles == this.cycles &&
          other.source == this.source &&
          other.notes == this.notes);
}

class BatteryModelsCompanion extends UpdateCompanion<BatteryModel> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> manufacturer;
  final Value<String> model;
  final Value<BatteryChemistry> chemistry;
  final Value<double> capacityKwh;
  final Value<double?> usableKwh;
  final Value<double> nominalVoltageV;
  final Value<double?> maxChargeKw;
  final Value<double?> maxDischargeKw;
  final Value<int?> cycles;
  final Value<EquipmentSource> source;
  final Value<String?> notes;
  final Value<int> rowid;
  const BatteryModelsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.model = const Value.absent(),
    this.chemistry = const Value.absent(),
    this.capacityKwh = const Value.absent(),
    this.usableKwh = const Value.absent(),
    this.nominalVoltageV = const Value.absent(),
    this.maxChargeKw = const Value.absent(),
    this.maxDischargeKw = const Value.absent(),
    this.cycles = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BatteryModelsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String manufacturer,
    required String model,
    this.chemistry = const Value.absent(),
    required double capacityKwh,
    this.usableKwh = const Value.absent(),
    required double nominalVoltageV,
    this.maxChargeKw = const Value.absent(),
    this.maxDischargeKw = const Value.absent(),
    this.cycles = const Value.absent(),
    this.source = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : manufacturer = Value(manufacturer),
       model = Value(model),
       capacityKwh = Value(capacityKwh),
       nominalVoltageV = Value(nominalVoltageV);
  static Insertable<BatteryModel> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? manufacturer,
    Expression<String>? model,
    Expression<String>? chemistry,
    Expression<double>? capacityKwh,
    Expression<double>? usableKwh,
    Expression<double>? nominalVoltageV,
    Expression<double>? maxChargeKw,
    Expression<double>? maxDischargeKw,
    Expression<int>? cycles,
    Expression<String>? source,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (model != null) 'model': model,
      if (chemistry != null) 'chemistry': chemistry,
      if (capacityKwh != null) 'capacity_kwh': capacityKwh,
      if (usableKwh != null) 'usable_kwh': usableKwh,
      if (nominalVoltageV != null) 'nominal_voltage_v': nominalVoltageV,
      if (maxChargeKw != null) 'max_charge_kw': maxChargeKw,
      if (maxDischargeKw != null) 'max_discharge_kw': maxDischargeKw,
      if (cycles != null) 'cycles': cycles,
      if (source != null) 'source': source,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BatteryModelsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? manufacturer,
    Value<String>? model,
    Value<BatteryChemistry>? chemistry,
    Value<double>? capacityKwh,
    Value<double?>? usableKwh,
    Value<double>? nominalVoltageV,
    Value<double?>? maxChargeKw,
    Value<double?>? maxDischargeKw,
    Value<int?>? cycles,
    Value<EquipmentSource>? source,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return BatteryModelsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      manufacturer: manufacturer ?? this.manufacturer,
      model: model ?? this.model,
      chemistry: chemistry ?? this.chemistry,
      capacityKwh: capacityKwh ?? this.capacityKwh,
      usableKwh: usableKwh ?? this.usableKwh,
      nominalVoltageV: nominalVoltageV ?? this.nominalVoltageV,
      maxChargeKw: maxChargeKw ?? this.maxChargeKw,
      maxDischargeKw: maxDischargeKw ?? this.maxDischargeKw,
      cycles: cycles ?? this.cycles,
      source: source ?? this.source,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (chemistry.present) {
      map['chemistry'] = Variable<String>(
        $BatteryModelsTable.$converterchemistry.toSql(chemistry.value),
      );
    }
    if (capacityKwh.present) {
      map['capacity_kwh'] = Variable<double>(capacityKwh.value);
    }
    if (usableKwh.present) {
      map['usable_kwh'] = Variable<double>(usableKwh.value);
    }
    if (nominalVoltageV.present) {
      map['nominal_voltage_v'] = Variable<double>(nominalVoltageV.value);
    }
    if (maxChargeKw.present) {
      map['max_charge_kw'] = Variable<double>(maxChargeKw.value);
    }
    if (maxDischargeKw.present) {
      map['max_discharge_kw'] = Variable<double>(maxDischargeKw.value);
    }
    if (cycles.present) {
      map['cycles'] = Variable<int>(cycles.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $BatteryModelsTable.$convertersource.toSql(source.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatteryModelsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('model: $model, ')
          ..write('chemistry: $chemistry, ')
          ..write('capacityKwh: $capacityKwh, ')
          ..write('usableKwh: $usableKwh, ')
          ..write('nominalVoltageV: $nominalVoltageV, ')
          ..write('maxChargeKw: $maxChargeKw, ')
          ..write('maxDischargeKw: $maxDischargeKw, ')
          ..write('cycles: $cycles, ')
          ..write('source: $source, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PvDesignsTable extends PvDesigns
    with TableInfo<$PvDesignsTable, PvDesign> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PvDesignsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _panelModelIdMeta = const VerificationMeta(
    'panelModelId',
  );
  @override
  late final GeneratedColumn<String> panelModelId = GeneratedColumn<String>(
    'panel_model_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inverterModelIdMeta = const VerificationMeta(
    'inverterModelId',
  );
  @override
  late final GeneratedColumn<String> inverterModelId = GeneratedColumn<String>(
    'inverter_model_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _inverterCountMeta = const VerificationMeta(
    'inverterCount',
  );
  @override
  late final GeneratedColumn<int> inverterCount = GeneratedColumn<int>(
    'inverter_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _optimizerModelIdMeta = const VerificationMeta(
    'optimizerModelId',
  );
  @override
  late final GeneratedColumn<String> optimizerModelId = GeneratedColumn<String>(
    'optimizer_model_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _batteryModelIdMeta = const VerificationMeta(
    'batteryModelId',
  );
  @override
  late final GeneratedColumn<String> batteryModelId = GeneratedColumn<String>(
    'battery_model_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _systemVoltageLimitVMeta =
      const VerificationMeta('systemVoltageLimitV');
  @override
  late final GeneratedColumn<double> systemVoltageLimitV =
      GeneratedColumn<double>(
        'system_voltage_limit_v',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(600),
      );
  static const VerificationMeta _lossesMeta = const VerificationMeta('losses');
  @override
  late final GeneratedColumn<String> losses = GeneratedColumn<String>(
    'losses',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _shadeThresholdPctMeta = const VerificationMeta(
    'shadeThresholdPct',
  );
  @override
  late final GeneratedColumn<double> shadeThresholdPct =
      GeneratedColumn<double>(
        'shade_threshold_pct',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(10),
      );
  static const VerificationMeta _gridVoltageVMeta = const VerificationMeta(
    'gridVoltageV',
  );
  @override
  late final GeneratedColumn<double> gridVoltageV = GeneratedColumn<double>(
    'grid_voltage_v',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(220),
  );
  static const VerificationMeta _windMeta = const VerificationMeta('wind');
  @override
  late final GeneratedColumn<String> wind = GeneratedColumn<String>(
    'wind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    panelModelId,
    inverterModelId,
    inverterCount,
    optimizerModelId,
    batteryModelId,
    systemVoltageLimitV,
    losses,
    shadeThresholdPct,
    gridVoltageV,
    wind,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pv_designs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PvDesign> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('panel_model_id')) {
      context.handle(
        _panelModelIdMeta,
        panelModelId.isAcceptableOrUnknown(
          data['panel_model_id']!,
          _panelModelIdMeta,
        ),
      );
    }
    if (data.containsKey('inverter_model_id')) {
      context.handle(
        _inverterModelIdMeta,
        inverterModelId.isAcceptableOrUnknown(
          data['inverter_model_id']!,
          _inverterModelIdMeta,
        ),
      );
    }
    if (data.containsKey('inverter_count')) {
      context.handle(
        _inverterCountMeta,
        inverterCount.isAcceptableOrUnknown(
          data['inverter_count']!,
          _inverterCountMeta,
        ),
      );
    }
    if (data.containsKey('optimizer_model_id')) {
      context.handle(
        _optimizerModelIdMeta,
        optimizerModelId.isAcceptableOrUnknown(
          data['optimizer_model_id']!,
          _optimizerModelIdMeta,
        ),
      );
    }
    if (data.containsKey('battery_model_id')) {
      context.handle(
        _batteryModelIdMeta,
        batteryModelId.isAcceptableOrUnknown(
          data['battery_model_id']!,
          _batteryModelIdMeta,
        ),
      );
    }
    if (data.containsKey('system_voltage_limit_v')) {
      context.handle(
        _systemVoltageLimitVMeta,
        systemVoltageLimitV.isAcceptableOrUnknown(
          data['system_voltage_limit_v']!,
          _systemVoltageLimitVMeta,
        ),
      );
    }
    if (data.containsKey('losses')) {
      context.handle(
        _lossesMeta,
        losses.isAcceptableOrUnknown(data['losses']!, _lossesMeta),
      );
    }
    if (data.containsKey('shade_threshold_pct')) {
      context.handle(
        _shadeThresholdPctMeta,
        shadeThresholdPct.isAcceptableOrUnknown(
          data['shade_threshold_pct']!,
          _shadeThresholdPctMeta,
        ),
      );
    }
    if (data.containsKey('grid_voltage_v')) {
      context.handle(
        _gridVoltageVMeta,
        gridVoltageV.isAcceptableOrUnknown(
          data['grid_voltage_v']!,
          _gridVoltageVMeta,
        ),
      );
    }
    if (data.containsKey('wind')) {
      context.handle(
        _windMeta,
        wind.isAcceptableOrUnknown(data['wind']!, _windMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PvDesign map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PvDesign(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      panelModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}panel_model_id'],
      ),
      inverterModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}inverter_model_id'],
      ),
      inverterCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inverter_count'],
      )!,
      optimizerModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}optimizer_model_id'],
      ),
      batteryModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}battery_model_id'],
      ),
      systemVoltageLimitV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}system_voltage_limit_v'],
      )!,
      losses: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}losses'],
      )!,
      shadeThresholdPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shade_threshold_pct'],
      )!,
      gridVoltageV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grid_voltage_v'],
      )!,
      wind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wind'],
      )!,
    );
  }

  @override
  $PvDesignsTable createAlias(String alias) {
    return $PvDesignsTable(attachedDatabase, alias);
  }
}

class PvDesign extends DataClass implements Insertable<PvDesign> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto (único).
  final String projectId;

  /// Panel elegido (`panel_models.id`).
  final String? panelModelId;

  /// Inversor elegido (`inverter_models.id`).
  final String? inverterModelId;

  /// Número de inversores (o de microinversores).
  final int inverterCount;

  /// Optimizador elegido (`optimizer_models.id`), si hay.
  final String? optimizerModelId;

  /// Batería elegida (`battery_models.id`), si hay.
  final String? batteryModelId;

  /// Tensión máxima del sistema por norma (V).
  final double systemVoltageLimitV;

  /// Pérdidas editables en JSON (`{"soiling":2,...}`, %).
  final String losses;

  /// Umbral de sombra para excluir paneles (%).
  final double shadeThresholdPct;

  /// Tensión de la red (V).
  final double gridVoltageV;

  /// Ajustes de viento en JSON (velocidad, exposición, GCrn...).
  final String wind;
  const PvDesign({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    this.panelModelId,
    this.inverterModelId,
    required this.inverterCount,
    this.optimizerModelId,
    this.batteryModelId,
    required this.systemVoltageLimitV,
    required this.losses,
    required this.shadeThresholdPct,
    required this.gridVoltageV,
    required this.wind,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    if (!nullToAbsent || panelModelId != null) {
      map['panel_model_id'] = Variable<String>(panelModelId);
    }
    if (!nullToAbsent || inverterModelId != null) {
      map['inverter_model_id'] = Variable<String>(inverterModelId);
    }
    map['inverter_count'] = Variable<int>(inverterCount);
    if (!nullToAbsent || optimizerModelId != null) {
      map['optimizer_model_id'] = Variable<String>(optimizerModelId);
    }
    if (!nullToAbsent || batteryModelId != null) {
      map['battery_model_id'] = Variable<String>(batteryModelId);
    }
    map['system_voltage_limit_v'] = Variable<double>(systemVoltageLimitV);
    map['losses'] = Variable<String>(losses);
    map['shade_threshold_pct'] = Variable<double>(shadeThresholdPct);
    map['grid_voltage_v'] = Variable<double>(gridVoltageV);
    map['wind'] = Variable<String>(wind);
    return map;
  }

  PvDesignsCompanion toCompanion(bool nullToAbsent) {
    return PvDesignsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      panelModelId: panelModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(panelModelId),
      inverterModelId: inverterModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(inverterModelId),
      inverterCount: Value(inverterCount),
      optimizerModelId: optimizerModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(optimizerModelId),
      batteryModelId: batteryModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryModelId),
      systemVoltageLimitV: Value(systemVoltageLimitV),
      losses: Value(losses),
      shadeThresholdPct: Value(shadeThresholdPct),
      gridVoltageV: Value(gridVoltageV),
      wind: Value(wind),
    );
  }

  factory PvDesign.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PvDesign(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      panelModelId: serializer.fromJson<String?>(json['panelModelId']),
      inverterModelId: serializer.fromJson<String?>(json['inverterModelId']),
      inverterCount: serializer.fromJson<int>(json['inverterCount']),
      optimizerModelId: serializer.fromJson<String?>(json['optimizerModelId']),
      batteryModelId: serializer.fromJson<String?>(json['batteryModelId']),
      systemVoltageLimitV: serializer.fromJson<double>(
        json['systemVoltageLimitV'],
      ),
      losses: serializer.fromJson<String>(json['losses']),
      shadeThresholdPct: serializer.fromJson<double>(json['shadeThresholdPct']),
      gridVoltageV: serializer.fromJson<double>(json['gridVoltageV']),
      wind: serializer.fromJson<String>(json['wind']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'panelModelId': serializer.toJson<String?>(panelModelId),
      'inverterModelId': serializer.toJson<String?>(inverterModelId),
      'inverterCount': serializer.toJson<int>(inverterCount),
      'optimizerModelId': serializer.toJson<String?>(optimizerModelId),
      'batteryModelId': serializer.toJson<String?>(batteryModelId),
      'systemVoltageLimitV': serializer.toJson<double>(systemVoltageLimitV),
      'losses': serializer.toJson<String>(losses),
      'shadeThresholdPct': serializer.toJson<double>(shadeThresholdPct),
      'gridVoltageV': serializer.toJson<double>(gridVoltageV),
      'wind': serializer.toJson<String>(wind),
    };
  }

  PvDesign copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    Value<String?> panelModelId = const Value.absent(),
    Value<String?> inverterModelId = const Value.absent(),
    int? inverterCount,
    Value<String?> optimizerModelId = const Value.absent(),
    Value<String?> batteryModelId = const Value.absent(),
    double? systemVoltageLimitV,
    String? losses,
    double? shadeThresholdPct,
    double? gridVoltageV,
    String? wind,
  }) => PvDesign(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    panelModelId: panelModelId.present ? panelModelId.value : this.panelModelId,
    inverterModelId: inverterModelId.present
        ? inverterModelId.value
        : this.inverterModelId,
    inverterCount: inverterCount ?? this.inverterCount,
    optimizerModelId: optimizerModelId.present
        ? optimizerModelId.value
        : this.optimizerModelId,
    batteryModelId: batteryModelId.present
        ? batteryModelId.value
        : this.batteryModelId,
    systemVoltageLimitV: systemVoltageLimitV ?? this.systemVoltageLimitV,
    losses: losses ?? this.losses,
    shadeThresholdPct: shadeThresholdPct ?? this.shadeThresholdPct,
    gridVoltageV: gridVoltageV ?? this.gridVoltageV,
    wind: wind ?? this.wind,
  );
  PvDesign copyWithCompanion(PvDesignsCompanion data) {
    return PvDesign(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      panelModelId: data.panelModelId.present
          ? data.panelModelId.value
          : this.panelModelId,
      inverterModelId: data.inverterModelId.present
          ? data.inverterModelId.value
          : this.inverterModelId,
      inverterCount: data.inverterCount.present
          ? data.inverterCount.value
          : this.inverterCount,
      optimizerModelId: data.optimizerModelId.present
          ? data.optimizerModelId.value
          : this.optimizerModelId,
      batteryModelId: data.batteryModelId.present
          ? data.batteryModelId.value
          : this.batteryModelId,
      systemVoltageLimitV: data.systemVoltageLimitV.present
          ? data.systemVoltageLimitV.value
          : this.systemVoltageLimitV,
      losses: data.losses.present ? data.losses.value : this.losses,
      shadeThresholdPct: data.shadeThresholdPct.present
          ? data.shadeThresholdPct.value
          : this.shadeThresholdPct,
      gridVoltageV: data.gridVoltageV.present
          ? data.gridVoltageV.value
          : this.gridVoltageV,
      wind: data.wind.present ? data.wind.value : this.wind,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PvDesign(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('panelModelId: $panelModelId, ')
          ..write('inverterModelId: $inverterModelId, ')
          ..write('inverterCount: $inverterCount, ')
          ..write('optimizerModelId: $optimizerModelId, ')
          ..write('batteryModelId: $batteryModelId, ')
          ..write('systemVoltageLimitV: $systemVoltageLimitV, ')
          ..write('losses: $losses, ')
          ..write('shadeThresholdPct: $shadeThresholdPct, ')
          ..write('gridVoltageV: $gridVoltageV, ')
          ..write('wind: $wind')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    panelModelId,
    inverterModelId,
    inverterCount,
    optimizerModelId,
    batteryModelId,
    systemVoltageLimitV,
    losses,
    shadeThresholdPct,
    gridVoltageV,
    wind,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PvDesign &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.panelModelId == this.panelModelId &&
          other.inverterModelId == this.inverterModelId &&
          other.inverterCount == this.inverterCount &&
          other.optimizerModelId == this.optimizerModelId &&
          other.batteryModelId == this.batteryModelId &&
          other.systemVoltageLimitV == this.systemVoltageLimitV &&
          other.losses == this.losses &&
          other.shadeThresholdPct == this.shadeThresholdPct &&
          other.gridVoltageV == this.gridVoltageV &&
          other.wind == this.wind);
}

class PvDesignsCompanion extends UpdateCompanion<PvDesign> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<String?> panelModelId;
  final Value<String?> inverterModelId;
  final Value<int> inverterCount;
  final Value<String?> optimizerModelId;
  final Value<String?> batteryModelId;
  final Value<double> systemVoltageLimitV;
  final Value<String> losses;
  final Value<double> shadeThresholdPct;
  final Value<double> gridVoltageV;
  final Value<String> wind;
  final Value<int> rowid;
  const PvDesignsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.panelModelId = const Value.absent(),
    this.inverterModelId = const Value.absent(),
    this.inverterCount = const Value.absent(),
    this.optimizerModelId = const Value.absent(),
    this.batteryModelId = const Value.absent(),
    this.systemVoltageLimitV = const Value.absent(),
    this.losses = const Value.absent(),
    this.shadeThresholdPct = const Value.absent(),
    this.gridVoltageV = const Value.absent(),
    this.wind = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PvDesignsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    this.panelModelId = const Value.absent(),
    this.inverterModelId = const Value.absent(),
    this.inverterCount = const Value.absent(),
    this.optimizerModelId = const Value.absent(),
    this.batteryModelId = const Value.absent(),
    this.systemVoltageLimitV = const Value.absent(),
    this.losses = const Value.absent(),
    this.shadeThresholdPct = const Value.absent(),
    this.gridVoltageV = const Value.absent(),
    this.wind = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId);
  static Insertable<PvDesign> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? panelModelId,
    Expression<String>? inverterModelId,
    Expression<int>? inverterCount,
    Expression<String>? optimizerModelId,
    Expression<String>? batteryModelId,
    Expression<double>? systemVoltageLimitV,
    Expression<String>? losses,
    Expression<double>? shadeThresholdPct,
    Expression<double>? gridVoltageV,
    Expression<String>? wind,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (panelModelId != null) 'panel_model_id': panelModelId,
      if (inverterModelId != null) 'inverter_model_id': inverterModelId,
      if (inverterCount != null) 'inverter_count': inverterCount,
      if (optimizerModelId != null) 'optimizer_model_id': optimizerModelId,
      if (batteryModelId != null) 'battery_model_id': batteryModelId,
      if (systemVoltageLimitV != null)
        'system_voltage_limit_v': systemVoltageLimitV,
      if (losses != null) 'losses': losses,
      if (shadeThresholdPct != null) 'shade_threshold_pct': shadeThresholdPct,
      if (gridVoltageV != null) 'grid_voltage_v': gridVoltageV,
      if (wind != null) 'wind': wind,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PvDesignsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<String?>? panelModelId,
    Value<String?>? inverterModelId,
    Value<int>? inverterCount,
    Value<String?>? optimizerModelId,
    Value<String?>? batteryModelId,
    Value<double>? systemVoltageLimitV,
    Value<String>? losses,
    Value<double>? shadeThresholdPct,
    Value<double>? gridVoltageV,
    Value<String>? wind,
    Value<int>? rowid,
  }) {
    return PvDesignsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      panelModelId: panelModelId ?? this.panelModelId,
      inverterModelId: inverterModelId ?? this.inverterModelId,
      inverterCount: inverterCount ?? this.inverterCount,
      optimizerModelId: optimizerModelId ?? this.optimizerModelId,
      batteryModelId: batteryModelId ?? this.batteryModelId,
      systemVoltageLimitV: systemVoltageLimitV ?? this.systemVoltageLimitV,
      losses: losses ?? this.losses,
      shadeThresholdPct: shadeThresholdPct ?? this.shadeThresholdPct,
      gridVoltageV: gridVoltageV ?? this.gridVoltageV,
      wind: wind ?? this.wind,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (panelModelId.present) {
      map['panel_model_id'] = Variable<String>(panelModelId.value);
    }
    if (inverterModelId.present) {
      map['inverter_model_id'] = Variable<String>(inverterModelId.value);
    }
    if (inverterCount.present) {
      map['inverter_count'] = Variable<int>(inverterCount.value);
    }
    if (optimizerModelId.present) {
      map['optimizer_model_id'] = Variable<String>(optimizerModelId.value);
    }
    if (batteryModelId.present) {
      map['battery_model_id'] = Variable<String>(batteryModelId.value);
    }
    if (systemVoltageLimitV.present) {
      map['system_voltage_limit_v'] = Variable<double>(
        systemVoltageLimitV.value,
      );
    }
    if (losses.present) {
      map['losses'] = Variable<String>(losses.value);
    }
    if (shadeThresholdPct.present) {
      map['shade_threshold_pct'] = Variable<double>(shadeThresholdPct.value);
    }
    if (gridVoltageV.present) {
      map['grid_voltage_v'] = Variable<double>(gridVoltageV.value);
    }
    if (wind.present) {
      map['wind'] = Variable<String>(wind.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PvDesignsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('panelModelId: $panelModelId, ')
          ..write('inverterModelId: $inverterModelId, ')
          ..write('inverterCount: $inverterCount, ')
          ..write('optimizerModelId: $optimizerModelId, ')
          ..write('batteryModelId: $batteryModelId, ')
          ..write('systemVoltageLimitV: $systemVoltageLimitV, ')
          ..write('losses: $losses, ')
          ..write('shadeThresholdPct: $shadeThresholdPct, ')
          ..write('gridVoltageV: $gridVoltageV, ')
          ..write('wind: $wind, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArrayLayoutsTable extends ArrayLayouts
    with TableInfo<$ArrayLayoutsTable, ArrayLayout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArrayLayoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _roofPlaneIdMeta = const VerificationMeta(
    'roofPlaneId',
  );
  @override
  late final GeneratedColumn<String> roofPlaneId = GeneratedColumn<String>(
    'roof_plane_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES roof_planes (id)',
    ),
  );
  static const VerificationMeta _panelModelIdMeta = const VerificationMeta(
    'panelModelId',
  );
  @override
  late final GeneratedColumn<String> panelModelId = GeneratedColumn<String>(
    'panel_model_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LayoutOrientation, String>
  orientation = GeneratedColumn<String>(
    'orientation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(LayoutOrientation.portrait.name),
  ).withConverter<LayoutOrientation>($ArrayLayoutsTable.$converterorientation);
  @override
  late final GeneratedColumnWithTypeConverter<MountType, String> mount =
      GeneratedColumn<String>(
        'mount',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(MountType.flush.name),
      ).withConverter<MountType>($ArrayLayoutsTable.$convertermount);
  static const VerificationMeta _rackTiltDegMeta = const VerificationMeta(
    'rackTiltDeg',
  );
  @override
  late final GeneratedColumn<double> rackTiltDeg = GeneratedColumn<double>(
    'rack_tilt_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _rackAzimuthDegMeta = const VerificationMeta(
    'rackAzimuthDeg',
  );
  @override
  late final GeneratedColumn<double> rackAzimuthDeg = GeneratedColumn<double>(
    'rack_azimuth_deg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(180),
  );
  static const VerificationMeta _gapMMeta = const VerificationMeta('gapM');
  @override
  late final GeneratedColumn<double> gapM = GeneratedColumn<double>(
    'gap_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.02),
  );
  static const VerificationMeta _rowGapMMeta = const VerificationMeta(
    'rowGapM',
  );
  @override
  late final GeneratedColumn<double> rowGapM = GeneratedColumn<double>(
    'row_gap_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.02),
  );
  static const VerificationMeta _clearanceMMeta = const VerificationMeta(
    'clearanceM',
  );
  @override
  late final GeneratedColumn<double> clearanceM = GeneratedColumn<double>(
    'clearance_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.3),
  );
  static const VerificationMeta _rowSpacingMMeta = const VerificationMeta(
    'rowSpacingM',
  );
  @override
  late final GeneratedColumn<double> rowSpacingM = GeneratedColumn<double>(
    'row_spacing_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _panelsMeta = const VerificationMeta('panels');
  @override
  late final GeneratedColumn<String> panels = GeneratedColumn<String>(
    'panels',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    roofPlaneId,
    panelModelId,
    orientation,
    mount,
    rackTiltDeg,
    rackAzimuthDeg,
    gapM,
    rowGapM,
    clearanceM,
    rowSpacingM,
    panels,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'array_layouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArrayLayout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('roof_plane_id')) {
      context.handle(
        _roofPlaneIdMeta,
        roofPlaneId.isAcceptableOrUnknown(
          data['roof_plane_id']!,
          _roofPlaneIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roofPlaneIdMeta);
    }
    if (data.containsKey('panel_model_id')) {
      context.handle(
        _panelModelIdMeta,
        panelModelId.isAcceptableOrUnknown(
          data['panel_model_id']!,
          _panelModelIdMeta,
        ),
      );
    }
    if (data.containsKey('rack_tilt_deg')) {
      context.handle(
        _rackTiltDegMeta,
        rackTiltDeg.isAcceptableOrUnknown(
          data['rack_tilt_deg']!,
          _rackTiltDegMeta,
        ),
      );
    }
    if (data.containsKey('rack_azimuth_deg')) {
      context.handle(
        _rackAzimuthDegMeta,
        rackAzimuthDeg.isAcceptableOrUnknown(
          data['rack_azimuth_deg']!,
          _rackAzimuthDegMeta,
        ),
      );
    }
    if (data.containsKey('gap_m')) {
      context.handle(
        _gapMMeta,
        gapM.isAcceptableOrUnknown(data['gap_m']!, _gapMMeta),
      );
    }
    if (data.containsKey('row_gap_m')) {
      context.handle(
        _rowGapMMeta,
        rowGapM.isAcceptableOrUnknown(data['row_gap_m']!, _rowGapMMeta),
      );
    }
    if (data.containsKey('clearance_m')) {
      context.handle(
        _clearanceMMeta,
        clearanceM.isAcceptableOrUnknown(data['clearance_m']!, _clearanceMMeta),
      );
    }
    if (data.containsKey('row_spacing_m')) {
      context.handle(
        _rowSpacingMMeta,
        rowSpacingM.isAcceptableOrUnknown(
          data['row_spacing_m']!,
          _rowSpacingMMeta,
        ),
      );
    }
    if (data.containsKey('panels')) {
      context.handle(
        _panelsMeta,
        panels.isAcceptableOrUnknown(data['panels']!, _panelsMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArrayLayout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArrayLayout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      roofPlaneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roof_plane_id'],
      )!,
      panelModelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}panel_model_id'],
      ),
      orientation: $ArrayLayoutsTable.$converterorientation.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}orientation'],
        )!,
      ),
      mount: $ArrayLayoutsTable.$convertermount.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}mount'],
        )!,
      ),
      rackTiltDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rack_tilt_deg'],
      )!,
      rackAzimuthDeg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rack_azimuth_deg'],
      )!,
      gapM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}gap_m'],
      )!,
      rowGapM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}row_gap_m'],
      )!,
      clearanceM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}clearance_m'],
      )!,
      rowSpacingM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}row_spacing_m'],
      ),
      panels: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}panels'],
      )!,
    );
  }

  @override
  $ArrayLayoutsTable createAlias(String alias) {
    return $ArrayLayoutsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LayoutOrientation, String, String>
  $converterorientation = const EnumNameConverter<LayoutOrientation>(
    LayoutOrientation.values,
  );
  static JsonTypeConverter2<MountType, String, String> $convertermount =
      const EnumNameConverter<MountType>(MountType.values);
}

class ArrayLayout extends DataClass implements Insertable<ArrayLayout> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Plano del techo.
  final String roofPlaneId;

  /// Panel usado (`panel_models.id`).
  final String? panelModelId;

  /// Vertical u horizontal.
  final LayoutOrientation orientation;

  /// Pegado al techo o en estructura inclinada.
  final MountType mount;

  /// Inclinación de la estructura (grados), solo en techo plano.
  final double rackTiltDeg;

  /// Azimut de la estructura (grados).
  final double rackAzimuthDeg;

  /// Separación entre paneles de una fila (m).
  final double gapM;

  /// Separación entre filas pegadas al techo (m).
  final double rowGapM;

  /// Holgura alrededor de obstáculos (m).
  final double clearanceM;

  /// Separación libre entre filas de estructura calculada (m).
  final double? rowSpacingM;

  /// Paneles en JSON `[{"c":[[x,y],...4],"r":fila,"k":col,"on":true}]`
  /// (metros locales; `on` = falso si el usuario lo quitó).
  final String panels;
  const ArrayLayout({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.roofPlaneId,
    this.panelModelId,
    required this.orientation,
    required this.mount,
    required this.rackTiltDeg,
    required this.rackAzimuthDeg,
    required this.gapM,
    required this.rowGapM,
    required this.clearanceM,
    this.rowSpacingM,
    required this.panels,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    map['roof_plane_id'] = Variable<String>(roofPlaneId);
    if (!nullToAbsent || panelModelId != null) {
      map['panel_model_id'] = Variable<String>(panelModelId);
    }
    {
      map['orientation'] = Variable<String>(
        $ArrayLayoutsTable.$converterorientation.toSql(orientation),
      );
    }
    {
      map['mount'] = Variable<String>(
        $ArrayLayoutsTable.$convertermount.toSql(mount),
      );
    }
    map['rack_tilt_deg'] = Variable<double>(rackTiltDeg);
    map['rack_azimuth_deg'] = Variable<double>(rackAzimuthDeg);
    map['gap_m'] = Variable<double>(gapM);
    map['row_gap_m'] = Variable<double>(rowGapM);
    map['clearance_m'] = Variable<double>(clearanceM);
    if (!nullToAbsent || rowSpacingM != null) {
      map['row_spacing_m'] = Variable<double>(rowSpacingM);
    }
    map['panels'] = Variable<String>(panels);
    return map;
  }

  ArrayLayoutsCompanion toCompanion(bool nullToAbsent) {
    return ArrayLayoutsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      roofPlaneId: Value(roofPlaneId),
      panelModelId: panelModelId == null && nullToAbsent
          ? const Value.absent()
          : Value(panelModelId),
      orientation: Value(orientation),
      mount: Value(mount),
      rackTiltDeg: Value(rackTiltDeg),
      rackAzimuthDeg: Value(rackAzimuthDeg),
      gapM: Value(gapM),
      rowGapM: Value(rowGapM),
      clearanceM: Value(clearanceM),
      rowSpacingM: rowSpacingM == null && nullToAbsent
          ? const Value.absent()
          : Value(rowSpacingM),
      panels: Value(panels),
    );
  }

  factory ArrayLayout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArrayLayout(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      roofPlaneId: serializer.fromJson<String>(json['roofPlaneId']),
      panelModelId: serializer.fromJson<String?>(json['panelModelId']),
      orientation: $ArrayLayoutsTable.$converterorientation.fromJson(
        serializer.fromJson<String>(json['orientation']),
      ),
      mount: $ArrayLayoutsTable.$convertermount.fromJson(
        serializer.fromJson<String>(json['mount']),
      ),
      rackTiltDeg: serializer.fromJson<double>(json['rackTiltDeg']),
      rackAzimuthDeg: serializer.fromJson<double>(json['rackAzimuthDeg']),
      gapM: serializer.fromJson<double>(json['gapM']),
      rowGapM: serializer.fromJson<double>(json['rowGapM']),
      clearanceM: serializer.fromJson<double>(json['clearanceM']),
      rowSpacingM: serializer.fromJson<double?>(json['rowSpacingM']),
      panels: serializer.fromJson<String>(json['panels']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'roofPlaneId': serializer.toJson<String>(roofPlaneId),
      'panelModelId': serializer.toJson<String?>(panelModelId),
      'orientation': serializer.toJson<String>(
        $ArrayLayoutsTable.$converterorientation.toJson(orientation),
      ),
      'mount': serializer.toJson<String>(
        $ArrayLayoutsTable.$convertermount.toJson(mount),
      ),
      'rackTiltDeg': serializer.toJson<double>(rackTiltDeg),
      'rackAzimuthDeg': serializer.toJson<double>(rackAzimuthDeg),
      'gapM': serializer.toJson<double>(gapM),
      'rowGapM': serializer.toJson<double>(rowGapM),
      'clearanceM': serializer.toJson<double>(clearanceM),
      'rowSpacingM': serializer.toJson<double?>(rowSpacingM),
      'panels': serializer.toJson<String>(panels),
    };
  }

  ArrayLayout copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    String? roofPlaneId,
    Value<String?> panelModelId = const Value.absent(),
    LayoutOrientation? orientation,
    MountType? mount,
    double? rackTiltDeg,
    double? rackAzimuthDeg,
    double? gapM,
    double? rowGapM,
    double? clearanceM,
    Value<double?> rowSpacingM = const Value.absent(),
    String? panels,
  }) => ArrayLayout(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    roofPlaneId: roofPlaneId ?? this.roofPlaneId,
    panelModelId: panelModelId.present ? panelModelId.value : this.panelModelId,
    orientation: orientation ?? this.orientation,
    mount: mount ?? this.mount,
    rackTiltDeg: rackTiltDeg ?? this.rackTiltDeg,
    rackAzimuthDeg: rackAzimuthDeg ?? this.rackAzimuthDeg,
    gapM: gapM ?? this.gapM,
    rowGapM: rowGapM ?? this.rowGapM,
    clearanceM: clearanceM ?? this.clearanceM,
    rowSpacingM: rowSpacingM.present ? rowSpacingM.value : this.rowSpacingM,
    panels: panels ?? this.panels,
  );
  ArrayLayout copyWithCompanion(ArrayLayoutsCompanion data) {
    return ArrayLayout(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      roofPlaneId: data.roofPlaneId.present
          ? data.roofPlaneId.value
          : this.roofPlaneId,
      panelModelId: data.panelModelId.present
          ? data.panelModelId.value
          : this.panelModelId,
      orientation: data.orientation.present
          ? data.orientation.value
          : this.orientation,
      mount: data.mount.present ? data.mount.value : this.mount,
      rackTiltDeg: data.rackTiltDeg.present
          ? data.rackTiltDeg.value
          : this.rackTiltDeg,
      rackAzimuthDeg: data.rackAzimuthDeg.present
          ? data.rackAzimuthDeg.value
          : this.rackAzimuthDeg,
      gapM: data.gapM.present ? data.gapM.value : this.gapM,
      rowGapM: data.rowGapM.present ? data.rowGapM.value : this.rowGapM,
      clearanceM: data.clearanceM.present
          ? data.clearanceM.value
          : this.clearanceM,
      rowSpacingM: data.rowSpacingM.present
          ? data.rowSpacingM.value
          : this.rowSpacingM,
      panels: data.panels.present ? data.panels.value : this.panels,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArrayLayout(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('roofPlaneId: $roofPlaneId, ')
          ..write('panelModelId: $panelModelId, ')
          ..write('orientation: $orientation, ')
          ..write('mount: $mount, ')
          ..write('rackTiltDeg: $rackTiltDeg, ')
          ..write('rackAzimuthDeg: $rackAzimuthDeg, ')
          ..write('gapM: $gapM, ')
          ..write('rowGapM: $rowGapM, ')
          ..write('clearanceM: $clearanceM, ')
          ..write('rowSpacingM: $rowSpacingM, ')
          ..write('panels: $panels')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    roofPlaneId,
    panelModelId,
    orientation,
    mount,
    rackTiltDeg,
    rackAzimuthDeg,
    gapM,
    rowGapM,
    clearanceM,
    rowSpacingM,
    panels,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArrayLayout &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.roofPlaneId == this.roofPlaneId &&
          other.panelModelId == this.panelModelId &&
          other.orientation == this.orientation &&
          other.mount == this.mount &&
          other.rackTiltDeg == this.rackTiltDeg &&
          other.rackAzimuthDeg == this.rackAzimuthDeg &&
          other.gapM == this.gapM &&
          other.rowGapM == this.rowGapM &&
          other.clearanceM == this.clearanceM &&
          other.rowSpacingM == this.rowSpacingM &&
          other.panels == this.panels);
}

class ArrayLayoutsCompanion extends UpdateCompanion<ArrayLayout> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<String> roofPlaneId;
  final Value<String?> panelModelId;
  final Value<LayoutOrientation> orientation;
  final Value<MountType> mount;
  final Value<double> rackTiltDeg;
  final Value<double> rackAzimuthDeg;
  final Value<double> gapM;
  final Value<double> rowGapM;
  final Value<double> clearanceM;
  final Value<double?> rowSpacingM;
  final Value<String> panels;
  final Value<int> rowid;
  const ArrayLayoutsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.roofPlaneId = const Value.absent(),
    this.panelModelId = const Value.absent(),
    this.orientation = const Value.absent(),
    this.mount = const Value.absent(),
    this.rackTiltDeg = const Value.absent(),
    this.rackAzimuthDeg = const Value.absent(),
    this.gapM = const Value.absent(),
    this.rowGapM = const Value.absent(),
    this.clearanceM = const Value.absent(),
    this.rowSpacingM = const Value.absent(),
    this.panels = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArrayLayoutsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required String roofPlaneId,
    this.panelModelId = const Value.absent(),
    this.orientation = const Value.absent(),
    this.mount = const Value.absent(),
    this.rackTiltDeg = const Value.absent(),
    this.rackAzimuthDeg = const Value.absent(),
    this.gapM = const Value.absent(),
    this.rowGapM = const Value.absent(),
    this.clearanceM = const Value.absent(),
    this.rowSpacingM = const Value.absent(),
    this.panels = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       roofPlaneId = Value(roofPlaneId);
  static Insertable<ArrayLayout> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? roofPlaneId,
    Expression<String>? panelModelId,
    Expression<String>? orientation,
    Expression<String>? mount,
    Expression<double>? rackTiltDeg,
    Expression<double>? rackAzimuthDeg,
    Expression<double>? gapM,
    Expression<double>? rowGapM,
    Expression<double>? clearanceM,
    Expression<double>? rowSpacingM,
    Expression<String>? panels,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (roofPlaneId != null) 'roof_plane_id': roofPlaneId,
      if (panelModelId != null) 'panel_model_id': panelModelId,
      if (orientation != null) 'orientation': orientation,
      if (mount != null) 'mount': mount,
      if (rackTiltDeg != null) 'rack_tilt_deg': rackTiltDeg,
      if (rackAzimuthDeg != null) 'rack_azimuth_deg': rackAzimuthDeg,
      if (gapM != null) 'gap_m': gapM,
      if (rowGapM != null) 'row_gap_m': rowGapM,
      if (clearanceM != null) 'clearance_m': clearanceM,
      if (rowSpacingM != null) 'row_spacing_m': rowSpacingM,
      if (panels != null) 'panels': panels,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArrayLayoutsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<String>? roofPlaneId,
    Value<String?>? panelModelId,
    Value<LayoutOrientation>? orientation,
    Value<MountType>? mount,
    Value<double>? rackTiltDeg,
    Value<double>? rackAzimuthDeg,
    Value<double>? gapM,
    Value<double>? rowGapM,
    Value<double>? clearanceM,
    Value<double?>? rowSpacingM,
    Value<String>? panels,
    Value<int>? rowid,
  }) {
    return ArrayLayoutsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      roofPlaneId: roofPlaneId ?? this.roofPlaneId,
      panelModelId: panelModelId ?? this.panelModelId,
      orientation: orientation ?? this.orientation,
      mount: mount ?? this.mount,
      rackTiltDeg: rackTiltDeg ?? this.rackTiltDeg,
      rackAzimuthDeg: rackAzimuthDeg ?? this.rackAzimuthDeg,
      gapM: gapM ?? this.gapM,
      rowGapM: rowGapM ?? this.rowGapM,
      clearanceM: clearanceM ?? this.clearanceM,
      rowSpacingM: rowSpacingM ?? this.rowSpacingM,
      panels: panels ?? this.panels,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (roofPlaneId.present) {
      map['roof_plane_id'] = Variable<String>(roofPlaneId.value);
    }
    if (panelModelId.present) {
      map['panel_model_id'] = Variable<String>(panelModelId.value);
    }
    if (orientation.present) {
      map['orientation'] = Variable<String>(
        $ArrayLayoutsTable.$converterorientation.toSql(orientation.value),
      );
    }
    if (mount.present) {
      map['mount'] = Variable<String>(
        $ArrayLayoutsTable.$convertermount.toSql(mount.value),
      );
    }
    if (rackTiltDeg.present) {
      map['rack_tilt_deg'] = Variable<double>(rackTiltDeg.value);
    }
    if (rackAzimuthDeg.present) {
      map['rack_azimuth_deg'] = Variable<double>(rackAzimuthDeg.value);
    }
    if (gapM.present) {
      map['gap_m'] = Variable<double>(gapM.value);
    }
    if (rowGapM.present) {
      map['row_gap_m'] = Variable<double>(rowGapM.value);
    }
    if (clearanceM.present) {
      map['clearance_m'] = Variable<double>(clearanceM.value);
    }
    if (rowSpacingM.present) {
      map['row_spacing_m'] = Variable<double>(rowSpacingM.value);
    }
    if (panels.present) {
      map['panels'] = Variable<String>(panels.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArrayLayoutsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('roofPlaneId: $roofPlaneId, ')
          ..write('panelModelId: $panelModelId, ')
          ..write('orientation: $orientation, ')
          ..write('mount: $mount, ')
          ..write('rackTiltDeg: $rackTiltDeg, ')
          ..write('rackAzimuthDeg: $rackAzimuthDeg, ')
          ..write('gapM: $gapM, ')
          ..write('rowGapM: $rowGapM, ')
          ..write('clearanceM: $clearanceM, ')
          ..write('rowSpacingM: $rowSpacingM, ')
          ..write('panels: $panels, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StringConfigsTable extends StringConfigs
    with TableInfo<$StringConfigsTable, StringConfig> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StringConfigsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _inverterIndexMeta = const VerificationMeta(
    'inverterIndex',
  );
  @override
  late final GeneratedColumn<int> inverterIndex = GeneratedColumn<int>(
    'inverter_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mpptIndexMeta = const VerificationMeta(
    'mpptIndex',
  );
  @override
  late final GeneratedColumn<int> mpptIndex = GeneratedColumn<int>(
    'mppt_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _seriesMeta = const VerificationMeta('series');
  @override
  late final GeneratedColumn<int> series = GeneratedColumn<int>(
    'series',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parallelMeta = const VerificationMeta(
    'parallel',
  );
  @override
  late final GeneratedColumn<int> parallel = GeneratedColumn<int>(
    'parallel',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _editedMeta = const VerificationMeta('edited');
  @override
  late final GeneratedColumn<bool> edited = GeneratedColumn<bool>(
    'edited',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("edited" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    inverterIndex,
    mpptIndex,
    series,
    parallel,
    edited,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'string_configs';
  @override
  VerificationContext validateIntegrity(
    Insertable<StringConfig> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('inverter_index')) {
      context.handle(
        _inverterIndexMeta,
        inverterIndex.isAcceptableOrUnknown(
          data['inverter_index']!,
          _inverterIndexMeta,
        ),
      );
    }
    if (data.containsKey('mppt_index')) {
      context.handle(
        _mpptIndexMeta,
        mpptIndex.isAcceptableOrUnknown(data['mppt_index']!, _mpptIndexMeta),
      );
    }
    if (data.containsKey('series')) {
      context.handle(
        _seriesMeta,
        series.isAcceptableOrUnknown(data['series']!, _seriesMeta),
      );
    } else if (isInserting) {
      context.missing(_seriesMeta);
    }
    if (data.containsKey('parallel')) {
      context.handle(
        _parallelMeta,
        parallel.isAcceptableOrUnknown(data['parallel']!, _parallelMeta),
      );
    }
    if (data.containsKey('edited')) {
      context.handle(
        _editedMeta,
        edited.isAcceptableOrUnknown(data['edited']!, _editedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StringConfig map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StringConfig(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      inverterIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}inverter_index'],
      )!,
      mpptIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mppt_index'],
      )!,
      series: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}series'],
      )!,
      parallel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}parallel'],
      )!,
      edited: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}edited'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $StringConfigsTable createAlias(String alias) {
    return $StringConfigsTable(attachedDatabase, alias);
  }
}

class StringConfig extends DataClass implements Insertable<StringConfig> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Inversor (0 = el primero).
  final int inverterIndex;

  /// Entrada MPPT (0 = la primera).
  final int mpptIndex;

  /// Paneles en serie.
  final int series;

  /// Strings en paralelo.
  final int parallel;

  /// `true` si el usuario lo cambió a mano.
  final bool edited;

  /// Orden.
  final int sortOrder;
  const StringConfig({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.inverterIndex,
    required this.mpptIndex,
    required this.series,
    required this.parallel,
    required this.edited,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    map['inverter_index'] = Variable<int>(inverterIndex);
    map['mppt_index'] = Variable<int>(mpptIndex);
    map['series'] = Variable<int>(series);
    map['parallel'] = Variable<int>(parallel);
    map['edited'] = Variable<bool>(edited);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  StringConfigsCompanion toCompanion(bool nullToAbsent) {
    return StringConfigsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      inverterIndex: Value(inverterIndex),
      mpptIndex: Value(mpptIndex),
      series: Value(series),
      parallel: Value(parallel),
      edited: Value(edited),
      sortOrder: Value(sortOrder),
    );
  }

  factory StringConfig.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StringConfig(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      inverterIndex: serializer.fromJson<int>(json['inverterIndex']),
      mpptIndex: serializer.fromJson<int>(json['mpptIndex']),
      series: serializer.fromJson<int>(json['series']),
      parallel: serializer.fromJson<int>(json['parallel']),
      edited: serializer.fromJson<bool>(json['edited']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'inverterIndex': serializer.toJson<int>(inverterIndex),
      'mpptIndex': serializer.toJson<int>(mpptIndex),
      'series': serializer.toJson<int>(series),
      'parallel': serializer.toJson<int>(parallel),
      'edited': serializer.toJson<bool>(edited),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  StringConfig copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    int? inverterIndex,
    int? mpptIndex,
    int? series,
    int? parallel,
    bool? edited,
    int? sortOrder,
  }) => StringConfig(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    inverterIndex: inverterIndex ?? this.inverterIndex,
    mpptIndex: mpptIndex ?? this.mpptIndex,
    series: series ?? this.series,
    parallel: parallel ?? this.parallel,
    edited: edited ?? this.edited,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  StringConfig copyWithCompanion(StringConfigsCompanion data) {
    return StringConfig(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      inverterIndex: data.inverterIndex.present
          ? data.inverterIndex.value
          : this.inverterIndex,
      mpptIndex: data.mpptIndex.present ? data.mpptIndex.value : this.mpptIndex,
      series: data.series.present ? data.series.value : this.series,
      parallel: data.parallel.present ? data.parallel.value : this.parallel,
      edited: data.edited.present ? data.edited.value : this.edited,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StringConfig(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('inverterIndex: $inverterIndex, ')
          ..write('mpptIndex: $mpptIndex, ')
          ..write('series: $series, ')
          ..write('parallel: $parallel, ')
          ..write('edited: $edited, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    inverterIndex,
    mpptIndex,
    series,
    parallel,
    edited,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StringConfig &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.inverterIndex == this.inverterIndex &&
          other.mpptIndex == this.mpptIndex &&
          other.series == this.series &&
          other.parallel == this.parallel &&
          other.edited == this.edited &&
          other.sortOrder == this.sortOrder);
}

class StringConfigsCompanion extends UpdateCompanion<StringConfig> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<int> inverterIndex;
  final Value<int> mpptIndex;
  final Value<int> series;
  final Value<int> parallel;
  final Value<bool> edited;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const StringConfigsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.inverterIndex = const Value.absent(),
    this.mpptIndex = const Value.absent(),
    this.series = const Value.absent(),
    this.parallel = const Value.absent(),
    this.edited = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StringConfigsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    this.inverterIndex = const Value.absent(),
    this.mpptIndex = const Value.absent(),
    required int series,
    this.parallel = const Value.absent(),
    this.edited = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       series = Value(series);
  static Insertable<StringConfig> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<int>? inverterIndex,
    Expression<int>? mpptIndex,
    Expression<int>? series,
    Expression<int>? parallel,
    Expression<bool>? edited,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (inverterIndex != null) 'inverter_index': inverterIndex,
      if (mpptIndex != null) 'mppt_index': mpptIndex,
      if (series != null) 'series': series,
      if (parallel != null) 'parallel': parallel,
      if (edited != null) 'edited': edited,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StringConfigsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<int>? inverterIndex,
    Value<int>? mpptIndex,
    Value<int>? series,
    Value<int>? parallel,
    Value<bool>? edited,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return StringConfigsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      inverterIndex: inverterIndex ?? this.inverterIndex,
      mpptIndex: mpptIndex ?? this.mpptIndex,
      series: series ?? this.series,
      parallel: parallel ?? this.parallel,
      edited: edited ?? this.edited,
      sortOrder: sortOrder ?? this.sortOrder,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (inverterIndex.present) {
      map['inverter_index'] = Variable<int>(inverterIndex.value);
    }
    if (mpptIndex.present) {
      map['mppt_index'] = Variable<int>(mpptIndex.value);
    }
    if (series.present) {
      map['series'] = Variable<int>(series.value);
    }
    if (parallel.present) {
      map['parallel'] = Variable<int>(parallel.value);
    }
    if (edited.present) {
      map['edited'] = Variable<bool>(edited.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StringConfigsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('inverterIndex: $inverterIndex, ')
          ..write('mpptIndex: $mpptIndex, ')
          ..write('series: $series, ')
          ..write('parallel: $parallel, ')
          ..write('edited: $edited, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ElectricalRunsTable extends ElectricalRuns
    with TableInfo<$ElectricalRunsTable, ElectricalRun> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ElectricalRunsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RunKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RunKind>($ElectricalRunsTable.$converterkind);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lengthMMeta = const VerificationMeta(
    'lengthM',
  );
  @override
  late final GeneratedColumn<double> lengthM = GeneratedColumn<double>(
    'length_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CableMaterial, String> material =
      GeneratedColumn<String>(
        'material',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(CableMaterial.copper.name),
      ).withConverter<CableMaterial>($ElectricalRunsTable.$convertermaterial);
  @override
  late final GeneratedColumnWithTypeConverter<RacewayKind, String> raceway =
      GeneratedColumn<String>(
        'raceway',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: Constant(RacewayKind.rooftop13to90mm.name),
      ).withConverter<RacewayKind>($ElectricalRunsTable.$converterraceway);
  static const VerificationMeta _ambientCMeta = const VerificationMeta(
    'ambientC',
  );
  @override
  late final GeneratedColumn<double> ambientC = GeneratedColumn<double>(
    'ambient_c',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(40),
  );
  static const VerificationMeta _conductorsMeta = const VerificationMeta(
    'conductors',
  );
  @override
  late final GeneratedColumn<int> conductors = GeneratedColumn<int>(
    'conductors',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _chosenSizeMeta = const VerificationMeta(
    'chosenSize',
  );
  @override
  late final GeneratedColumn<String> chosenSize = GeneratedColumn<String>(
    'chosen_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultSizeMeta = const VerificationMeta(
    'resultSize',
  );
  @override
  late final GeneratedColumn<String> resultSize = GeneratedColumn<String>(
    'result_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dropPercentMeta = const VerificationMeta(
    'dropPercent',
  );
  @override
  late final GeneratedColumn<double> dropPercent = GeneratedColumn<double>(
    'drop_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    kind,
    name,
    lengthM,
    material,
    raceway,
    ambientC,
    conductors,
    chosenSize,
    resultSize,
    dropPercent,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'electrical_runs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ElectricalRun> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('length_m')) {
      context.handle(
        _lengthMMeta,
        lengthM.isAcceptableOrUnknown(data['length_m']!, _lengthMMeta),
      );
    } else if (isInserting) {
      context.missing(_lengthMMeta);
    }
    if (data.containsKey('ambient_c')) {
      context.handle(
        _ambientCMeta,
        ambientC.isAcceptableOrUnknown(data['ambient_c']!, _ambientCMeta),
      );
    }
    if (data.containsKey('conductors')) {
      context.handle(
        _conductorsMeta,
        conductors.isAcceptableOrUnknown(data['conductors']!, _conductorsMeta),
      );
    }
    if (data.containsKey('chosen_size')) {
      context.handle(
        _chosenSizeMeta,
        chosenSize.isAcceptableOrUnknown(data['chosen_size']!, _chosenSizeMeta),
      );
    }
    if (data.containsKey('result_size')) {
      context.handle(
        _resultSizeMeta,
        resultSize.isAcceptableOrUnknown(data['result_size']!, _resultSizeMeta),
      );
    }
    if (data.containsKey('drop_percent')) {
      context.handle(
        _dropPercentMeta,
        dropPercent.isAcceptableOrUnknown(
          data['drop_percent']!,
          _dropPercentMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ElectricalRun map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ElectricalRun(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      kind: $ElectricalRunsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      lengthM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}length_m'],
      )!,
      material: $ElectricalRunsTable.$convertermaterial.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}material'],
        )!,
      ),
      raceway: $ElectricalRunsTable.$converterraceway.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}raceway'],
        )!,
      ),
      ambientC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ambient_c'],
      )!,
      conductors: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conductors'],
      )!,
      chosenSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chosen_size'],
      ),
      resultSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result_size'],
      ),
      dropPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}drop_percent'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $ElectricalRunsTable createAlias(String alias) {
    return $ElectricalRunsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RunKind, String, String> $converterkind =
      const EnumNameConverter<RunKind>(RunKind.values);
  static JsonTypeConverter2<CableMaterial, String, String> $convertermaterial =
      const EnumNameConverter<CableMaterial>(CableMaterial.values);
  static JsonTypeConverter2<RacewayKind, String, String> $converterraceway =
      const EnumNameConverter<RacewayKind>(RacewayKind.values);
}

class ElectricalRun extends DataClass implements Insertable<ElectricalRun> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// String → inversor o inversor → tablero.
  final RunKind kind;

  /// Nombre visible.
  final String name;

  /// Longitud en un sentido (m).
  final double lengthM;

  /// Material.
  final CableMaterial material;

  /// Canalización.
  final RacewayKind raceway;

  /// Temperatura ambiente de diseño (°C).
  final double ambientC;

  /// Conductores portadores de corriente en la canalización.
  final int conductors;

  /// Calibre elegido a mano (nulo = el mínimo calculado).
  final String? chosenSize;

  /// Calibre resultante.
  final String? resultSize;

  /// Caída de tensión resultante (%).
  final double? dropPercent;

  /// Orden.
  final int sortOrder;
  const ElectricalRun({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.kind,
    required this.name,
    required this.lengthM,
    required this.material,
    required this.raceway,
    required this.ambientC,
    required this.conductors,
    this.chosenSize,
    this.resultSize,
    this.dropPercent,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    {
      map['kind'] = Variable<String>(
        $ElectricalRunsTable.$converterkind.toSql(kind),
      );
    }
    map['name'] = Variable<String>(name);
    map['length_m'] = Variable<double>(lengthM);
    {
      map['material'] = Variable<String>(
        $ElectricalRunsTable.$convertermaterial.toSql(material),
      );
    }
    {
      map['raceway'] = Variable<String>(
        $ElectricalRunsTable.$converterraceway.toSql(raceway),
      );
    }
    map['ambient_c'] = Variable<double>(ambientC);
    map['conductors'] = Variable<int>(conductors);
    if (!nullToAbsent || chosenSize != null) {
      map['chosen_size'] = Variable<String>(chosenSize);
    }
    if (!nullToAbsent || resultSize != null) {
      map['result_size'] = Variable<String>(resultSize);
    }
    if (!nullToAbsent || dropPercent != null) {
      map['drop_percent'] = Variable<double>(dropPercent);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  ElectricalRunsCompanion toCompanion(bool nullToAbsent) {
    return ElectricalRunsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      kind: Value(kind),
      name: Value(name),
      lengthM: Value(lengthM),
      material: Value(material),
      raceway: Value(raceway),
      ambientC: Value(ambientC),
      conductors: Value(conductors),
      chosenSize: chosenSize == null && nullToAbsent
          ? const Value.absent()
          : Value(chosenSize),
      resultSize: resultSize == null && nullToAbsent
          ? const Value.absent()
          : Value(resultSize),
      dropPercent: dropPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(dropPercent),
      sortOrder: Value(sortOrder),
    );
  }

  factory ElectricalRun.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ElectricalRun(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      kind: $ElectricalRunsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      name: serializer.fromJson<String>(json['name']),
      lengthM: serializer.fromJson<double>(json['lengthM']),
      material: $ElectricalRunsTable.$convertermaterial.fromJson(
        serializer.fromJson<String>(json['material']),
      ),
      raceway: $ElectricalRunsTable.$converterraceway.fromJson(
        serializer.fromJson<String>(json['raceway']),
      ),
      ambientC: serializer.fromJson<double>(json['ambientC']),
      conductors: serializer.fromJson<int>(json['conductors']),
      chosenSize: serializer.fromJson<String?>(json['chosenSize']),
      resultSize: serializer.fromJson<String?>(json['resultSize']),
      dropPercent: serializer.fromJson<double?>(json['dropPercent']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'kind': serializer.toJson<String>(
        $ElectricalRunsTable.$converterkind.toJson(kind),
      ),
      'name': serializer.toJson<String>(name),
      'lengthM': serializer.toJson<double>(lengthM),
      'material': serializer.toJson<String>(
        $ElectricalRunsTable.$convertermaterial.toJson(material),
      ),
      'raceway': serializer.toJson<String>(
        $ElectricalRunsTable.$converterraceway.toJson(raceway),
      ),
      'ambientC': serializer.toJson<double>(ambientC),
      'conductors': serializer.toJson<int>(conductors),
      'chosenSize': serializer.toJson<String?>(chosenSize),
      'resultSize': serializer.toJson<String?>(resultSize),
      'dropPercent': serializer.toJson<double?>(dropPercent),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  ElectricalRun copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    RunKind? kind,
    String? name,
    double? lengthM,
    CableMaterial? material,
    RacewayKind? raceway,
    double? ambientC,
    int? conductors,
    Value<String?> chosenSize = const Value.absent(),
    Value<String?> resultSize = const Value.absent(),
    Value<double?> dropPercent = const Value.absent(),
    int? sortOrder,
  }) => ElectricalRun(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    kind: kind ?? this.kind,
    name: name ?? this.name,
    lengthM: lengthM ?? this.lengthM,
    material: material ?? this.material,
    raceway: raceway ?? this.raceway,
    ambientC: ambientC ?? this.ambientC,
    conductors: conductors ?? this.conductors,
    chosenSize: chosenSize.present ? chosenSize.value : this.chosenSize,
    resultSize: resultSize.present ? resultSize.value : this.resultSize,
    dropPercent: dropPercent.present ? dropPercent.value : this.dropPercent,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  ElectricalRun copyWithCompanion(ElectricalRunsCompanion data) {
    return ElectricalRun(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      kind: data.kind.present ? data.kind.value : this.kind,
      name: data.name.present ? data.name.value : this.name,
      lengthM: data.lengthM.present ? data.lengthM.value : this.lengthM,
      material: data.material.present ? data.material.value : this.material,
      raceway: data.raceway.present ? data.raceway.value : this.raceway,
      ambientC: data.ambientC.present ? data.ambientC.value : this.ambientC,
      conductors: data.conductors.present
          ? data.conductors.value
          : this.conductors,
      chosenSize: data.chosenSize.present
          ? data.chosenSize.value
          : this.chosenSize,
      resultSize: data.resultSize.present
          ? data.resultSize.value
          : this.resultSize,
      dropPercent: data.dropPercent.present
          ? data.dropPercent.value
          : this.dropPercent,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ElectricalRun(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('kind: $kind, ')
          ..write('name: $name, ')
          ..write('lengthM: $lengthM, ')
          ..write('material: $material, ')
          ..write('raceway: $raceway, ')
          ..write('ambientC: $ambientC, ')
          ..write('conductors: $conductors, ')
          ..write('chosenSize: $chosenSize, ')
          ..write('resultSize: $resultSize, ')
          ..write('dropPercent: $dropPercent, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    kind,
    name,
    lengthM,
    material,
    raceway,
    ambientC,
    conductors,
    chosenSize,
    resultSize,
    dropPercent,
    sortOrder,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ElectricalRun &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.kind == this.kind &&
          other.name == this.name &&
          other.lengthM == this.lengthM &&
          other.material == this.material &&
          other.raceway == this.raceway &&
          other.ambientC == this.ambientC &&
          other.conductors == this.conductors &&
          other.chosenSize == this.chosenSize &&
          other.resultSize == this.resultSize &&
          other.dropPercent == this.dropPercent &&
          other.sortOrder == this.sortOrder);
}

class ElectricalRunsCompanion extends UpdateCompanion<ElectricalRun> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<RunKind> kind;
  final Value<String> name;
  final Value<double> lengthM;
  final Value<CableMaterial> material;
  final Value<RacewayKind> raceway;
  final Value<double> ambientC;
  final Value<int> conductors;
  final Value<String?> chosenSize;
  final Value<String?> resultSize;
  final Value<double?> dropPercent;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const ElectricalRunsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.kind = const Value.absent(),
    this.name = const Value.absent(),
    this.lengthM = const Value.absent(),
    this.material = const Value.absent(),
    this.raceway = const Value.absent(),
    this.ambientC = const Value.absent(),
    this.conductors = const Value.absent(),
    this.chosenSize = const Value.absent(),
    this.resultSize = const Value.absent(),
    this.dropPercent = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ElectricalRunsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required RunKind kind,
    required String name,
    required double lengthM,
    this.material = const Value.absent(),
    this.raceway = const Value.absent(),
    this.ambientC = const Value.absent(),
    this.conductors = const Value.absent(),
    this.chosenSize = const Value.absent(),
    this.resultSize = const Value.absent(),
    this.dropPercent = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       kind = Value(kind),
       name = Value(name),
       lengthM = Value(lengthM);
  static Insertable<ElectricalRun> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? kind,
    Expression<String>? name,
    Expression<double>? lengthM,
    Expression<String>? material,
    Expression<String>? raceway,
    Expression<double>? ambientC,
    Expression<int>? conductors,
    Expression<String>? chosenSize,
    Expression<String>? resultSize,
    Expression<double>? dropPercent,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (kind != null) 'kind': kind,
      if (name != null) 'name': name,
      if (lengthM != null) 'length_m': lengthM,
      if (material != null) 'material': material,
      if (raceway != null) 'raceway': raceway,
      if (ambientC != null) 'ambient_c': ambientC,
      if (conductors != null) 'conductors': conductors,
      if (chosenSize != null) 'chosen_size': chosenSize,
      if (resultSize != null) 'result_size': resultSize,
      if (dropPercent != null) 'drop_percent': dropPercent,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ElectricalRunsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<RunKind>? kind,
    Value<String>? name,
    Value<double>? lengthM,
    Value<CableMaterial>? material,
    Value<RacewayKind>? raceway,
    Value<double>? ambientC,
    Value<int>? conductors,
    Value<String?>? chosenSize,
    Value<String?>? resultSize,
    Value<double?>? dropPercent,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return ElectricalRunsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      kind: kind ?? this.kind,
      name: name ?? this.name,
      lengthM: lengthM ?? this.lengthM,
      material: material ?? this.material,
      raceway: raceway ?? this.raceway,
      ambientC: ambientC ?? this.ambientC,
      conductors: conductors ?? this.conductors,
      chosenSize: chosenSize ?? this.chosenSize,
      resultSize: resultSize ?? this.resultSize,
      dropPercent: dropPercent ?? this.dropPercent,
      sortOrder: sortOrder ?? this.sortOrder,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $ElectricalRunsTable.$converterkind.toSql(kind.value),
      );
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (lengthM.present) {
      map['length_m'] = Variable<double>(lengthM.value);
    }
    if (material.present) {
      map['material'] = Variable<String>(
        $ElectricalRunsTable.$convertermaterial.toSql(material.value),
      );
    }
    if (raceway.present) {
      map['raceway'] = Variable<String>(
        $ElectricalRunsTable.$converterraceway.toSql(raceway.value),
      );
    }
    if (ambientC.present) {
      map['ambient_c'] = Variable<double>(ambientC.value);
    }
    if (conductors.present) {
      map['conductors'] = Variable<int>(conductors.value);
    }
    if (chosenSize.present) {
      map['chosen_size'] = Variable<String>(chosenSize.value);
    }
    if (resultSize.present) {
      map['result_size'] = Variable<String>(resultSize.value);
    }
    if (dropPercent.present) {
      map['drop_percent'] = Variable<double>(dropPercent.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ElectricalRunsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('kind: $kind, ')
          ..write('name: $name, ')
          ..write('lengthM: $lengthM, ')
          ..write('material: $material, ')
          ..write('raceway: $raceway, ')
          ..write('ambientC: $ambientC, ')
          ..write('conductors: $conductors, ')
          ..write('chosenSize: $chosenSize, ')
          ..write('resultSize: $resultSize, ')
          ..write('dropPercent: $dropPercent, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProtectionDevicesTable extends ProtectionDevices
    with TableInfo<$ProtectionDevicesTable, ProtectionDevice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProtectionDevicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProtectionDeviceKind, String>
  kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<ProtectionDeviceKind>($ProtectionDevicesTable.$converterkind);
  static const VerificationMeta _ratingAMeta = const VerificationMeta(
    'ratingA',
  );
  @override
  late final GeneratedColumn<double> ratingA = GeneratedColumn<double>(
    'rating_a',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voltageVMeta = const VerificationMeta(
    'voltageV',
  );
  @override
  late final GeneratedColumn<double> voltageV = GeneratedColumn<double>(
    'voltage_v',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _conductorSizeMeta = const VerificationMeta(
    'conductorSize',
  );
  @override
  late final GeneratedColumn<String> conductorSize = GeneratedColumn<String>(
    'conductor_size',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    kind,
    ratingA,
    voltageV,
    quantity,
    conductorSize,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'protection_devices';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProtectionDevice> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('rating_a')) {
      context.handle(
        _ratingAMeta,
        ratingA.isAcceptableOrUnknown(data['rating_a']!, _ratingAMeta),
      );
    }
    if (data.containsKey('voltage_v')) {
      context.handle(
        _voltageVMeta,
        voltageV.isAcceptableOrUnknown(data['voltage_v']!, _voltageVMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('conductor_size')) {
      context.handle(
        _conductorSizeMeta,
        conductorSize.isAcceptableOrUnknown(
          data['conductor_size']!,
          _conductorSizeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProtectionDevice map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProtectionDevice(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      kind: $ProtectionDevicesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      ratingA: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating_a'],
      ),
      voltageV: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}voltage_v'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      conductorSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conductor_size'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ProtectionDevicesTable createAlias(String alias) {
    return $ProtectionDevicesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProtectionDeviceKind, String, String>
  $converterkind = const EnumNameConverter<ProtectionDeviceKind>(
    ProtectionDeviceKind.values,
  );
}

class ProtectionDevice extends DataClass
    implements Insertable<ProtectionDevice> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Tipo.
  final ProtectionDeviceKind kind;

  /// Corriente nominal (A).
  final double? ratingA;

  /// Tensión (V).
  final double? voltageV;

  /// Cantidad.
  final int quantity;

  /// Calibre (solo conductor de tierra).
  final String? conductorSize;

  /// Notas.
  final String? notes;
  const ProtectionDevice({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.kind,
    this.ratingA,
    this.voltageV,
    required this.quantity,
    this.conductorSize,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    {
      map['kind'] = Variable<String>(
        $ProtectionDevicesTable.$converterkind.toSql(kind),
      );
    }
    if (!nullToAbsent || ratingA != null) {
      map['rating_a'] = Variable<double>(ratingA);
    }
    if (!nullToAbsent || voltageV != null) {
      map['voltage_v'] = Variable<double>(voltageV);
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || conductorSize != null) {
      map['conductor_size'] = Variable<String>(conductorSize);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ProtectionDevicesCompanion toCompanion(bool nullToAbsent) {
    return ProtectionDevicesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      kind: Value(kind),
      ratingA: ratingA == null && nullToAbsent
          ? const Value.absent()
          : Value(ratingA),
      voltageV: voltageV == null && nullToAbsent
          ? const Value.absent()
          : Value(voltageV),
      quantity: Value(quantity),
      conductorSize: conductorSize == null && nullToAbsent
          ? const Value.absent()
          : Value(conductorSize),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory ProtectionDevice.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProtectionDevice(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      kind: $ProtectionDevicesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      ratingA: serializer.fromJson<double?>(json['ratingA']),
      voltageV: serializer.fromJson<double?>(json['voltageV']),
      quantity: serializer.fromJson<int>(json['quantity']),
      conductorSize: serializer.fromJson<String?>(json['conductorSize']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'kind': serializer.toJson<String>(
        $ProtectionDevicesTable.$converterkind.toJson(kind),
      ),
      'ratingA': serializer.toJson<double?>(ratingA),
      'voltageV': serializer.toJson<double?>(voltageV),
      'quantity': serializer.toJson<int>(quantity),
      'conductorSize': serializer.toJson<String?>(conductorSize),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ProtectionDevice copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    ProtectionDeviceKind? kind,
    Value<double?> ratingA = const Value.absent(),
    Value<double?> voltageV = const Value.absent(),
    int? quantity,
    Value<String?> conductorSize = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => ProtectionDevice(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    kind: kind ?? this.kind,
    ratingA: ratingA.present ? ratingA.value : this.ratingA,
    voltageV: voltageV.present ? voltageV.value : this.voltageV,
    quantity: quantity ?? this.quantity,
    conductorSize: conductorSize.present
        ? conductorSize.value
        : this.conductorSize,
    notes: notes.present ? notes.value : this.notes,
  );
  ProtectionDevice copyWithCompanion(ProtectionDevicesCompanion data) {
    return ProtectionDevice(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      kind: data.kind.present ? data.kind.value : this.kind,
      ratingA: data.ratingA.present ? data.ratingA.value : this.ratingA,
      voltageV: data.voltageV.present ? data.voltageV.value : this.voltageV,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      conductorSize: data.conductorSize.present
          ? data.conductorSize.value
          : this.conductorSize,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProtectionDevice(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('kind: $kind, ')
          ..write('ratingA: $ratingA, ')
          ..write('voltageV: $voltageV, ')
          ..write('quantity: $quantity, ')
          ..write('conductorSize: $conductorSize, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    kind,
    ratingA,
    voltageV,
    quantity,
    conductorSize,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProtectionDevice &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.kind == this.kind &&
          other.ratingA == this.ratingA &&
          other.voltageV == this.voltageV &&
          other.quantity == this.quantity &&
          other.conductorSize == this.conductorSize &&
          other.notes == this.notes);
}

class ProtectionDevicesCompanion extends UpdateCompanion<ProtectionDevice> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<ProtectionDeviceKind> kind;
  final Value<double?> ratingA;
  final Value<double?> voltageV;
  final Value<int> quantity;
  final Value<String?> conductorSize;
  final Value<String?> notes;
  final Value<int> rowid;
  const ProtectionDevicesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.kind = const Value.absent(),
    this.ratingA = const Value.absent(),
    this.voltageV = const Value.absent(),
    this.quantity = const Value.absent(),
    this.conductorSize = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProtectionDevicesCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required ProtectionDeviceKind kind,
    this.ratingA = const Value.absent(),
    this.voltageV = const Value.absent(),
    this.quantity = const Value.absent(),
    this.conductorSize = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       kind = Value(kind);
  static Insertable<ProtectionDevice> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<String>? kind,
    Expression<double>? ratingA,
    Expression<double>? voltageV,
    Expression<int>? quantity,
    Expression<String>? conductorSize,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (kind != null) 'kind': kind,
      if (ratingA != null) 'rating_a': ratingA,
      if (voltageV != null) 'voltage_v': voltageV,
      if (quantity != null) 'quantity': quantity,
      if (conductorSize != null) 'conductor_size': conductorSize,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProtectionDevicesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<ProtectionDeviceKind>? kind,
    Value<double?>? ratingA,
    Value<double?>? voltageV,
    Value<int>? quantity,
    Value<String?>? conductorSize,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ProtectionDevicesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      kind: kind ?? this.kind,
      ratingA: ratingA ?? this.ratingA,
      voltageV: voltageV ?? this.voltageV,
      quantity: quantity ?? this.quantity,
      conductorSize: conductorSize ?? this.conductorSize,
      notes: notes ?? this.notes,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $ProtectionDevicesTable.$converterkind.toSql(kind.value),
      );
    }
    if (ratingA.present) {
      map['rating_a'] = Variable<double>(ratingA.value);
    }
    if (voltageV.present) {
      map['voltage_v'] = Variable<double>(voltageV.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (conductorSize.present) {
      map['conductor_size'] = Variable<String>(conductorSize.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProtectionDevicesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('kind: $kind, ')
          ..write('ratingA: $ratingA, ')
          ..write('voltageV: $voltageV, ')
          ..write('quantity: $quantity, ')
          ..write('conductorSize: $conductorSize, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SimulationResultsTable extends SimulationResults
    with TableInfo<$SimulationResultsTable, SimulationResultRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SimulationResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: newUuid,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now().toUtc(),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _projectIdMeta = const VerificationMeta(
    'projectId',
  );
  @override
  late final GeneratedColumn<String> projectId = GeneratedColumn<String>(
    'project_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES projects (id)',
    ),
  );
  static const VerificationMeta _pdcWMeta = const VerificationMeta('pdcW');
  @override
  late final GeneratedColumn<double> pdcW = GeneratedColumn<double>(
    'pdc_w',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pacWMeta = const VerificationMeta('pacW');
  @override
  late final GeneratedColumn<double> pacW = GeneratedColumn<double>(
    'pac_w',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstYearKwhMeta = const VerificationMeta(
    'firstYearKwh',
  );
  @override
  late final GeneratedColumn<double> firstYearKwh = GeneratedColumn<double>(
    'first_year_kwh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lifetimeKwhMeta = const VerificationMeta(
    'lifetimeKwh',
  );
  @override
  late final GeneratedColumn<double> lifetimeKwh = GeneratedColumn<double>(
    'lifetime_kwh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearsMeta = const VerificationMeta('years');
  @override
  late final GeneratedColumn<int> years = GeneratedColumn<int>(
    'years',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _monthlyKwhMeta = const VerificationMeta(
    'monthlyKwh',
  );
  @override
  late final GeneratedColumn<String> monthlyKwh = GeneratedColumn<String>(
    'monthly_kwh',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yearlyKwhMeta = const VerificationMeta(
    'yearlyKwh',
  );
  @override
  late final GeneratedColumn<String> yearlyKwh = GeneratedColumn<String>(
    'yearly_kwh',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clippedKwhMeta = const VerificationMeta(
    'clippedKwh',
  );
  @override
  late final GeneratedColumn<double> clippedKwh = GeneratedColumn<double>(
    'clipped_kwh',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _shadingLossPctMeta = const VerificationMeta(
    'shadingLossPct',
  );
  @override
  late final GeneratedColumn<double> shadingLossPct = GeneratedColumn<double>(
    'shading_loss_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _specificYieldMeta = const VerificationMeta(
    'specificYield',
  );
  @override
  late final GeneratedColumn<double> specificYield = GeneratedColumn<double>(
    'specific_yield',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _performanceRatioMeta = const VerificationMeta(
    'performanceRatio',
  );
  @override
  late final GeneratedColumn<double> performanceRatio = GeneratedColumn<double>(
    'performance_ratio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lossesMeta = const VerificationMeta('losses');
  @override
  late final GeneratedColumn<String> losses = GeneratedColumn<String>(
    'losses',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _weatherLabelMeta = const VerificationMeta(
    'weatherLabel',
  );
  @override
  late final GeneratedColumn<String> weatherLabel = GeneratedColumn<String>(
    'weather_label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    pdcW,
    pacW,
    firstYearKwh,
    lifetimeKwh,
    years,
    monthlyKwh,
    yearlyKwh,
    clippedKwh,
    shadingLossPct,
    specificYield,
    performanceRatio,
    losses,
    weatherLabel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'simulation_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<SimulationResultRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('project_id')) {
      context.handle(
        _projectIdMeta,
        projectId.isAcceptableOrUnknown(data['project_id']!, _projectIdMeta),
      );
    } else if (isInserting) {
      context.missing(_projectIdMeta);
    }
    if (data.containsKey('pdc_w')) {
      context.handle(
        _pdcWMeta,
        pdcW.isAcceptableOrUnknown(data['pdc_w']!, _pdcWMeta),
      );
    } else if (isInserting) {
      context.missing(_pdcWMeta);
    }
    if (data.containsKey('pac_w')) {
      context.handle(
        _pacWMeta,
        pacW.isAcceptableOrUnknown(data['pac_w']!, _pacWMeta),
      );
    } else if (isInserting) {
      context.missing(_pacWMeta);
    }
    if (data.containsKey('first_year_kwh')) {
      context.handle(
        _firstYearKwhMeta,
        firstYearKwh.isAcceptableOrUnknown(
          data['first_year_kwh']!,
          _firstYearKwhMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstYearKwhMeta);
    }
    if (data.containsKey('lifetime_kwh')) {
      context.handle(
        _lifetimeKwhMeta,
        lifetimeKwh.isAcceptableOrUnknown(
          data['lifetime_kwh']!,
          _lifetimeKwhMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lifetimeKwhMeta);
    }
    if (data.containsKey('years')) {
      context.handle(
        _yearsMeta,
        years.isAcceptableOrUnknown(data['years']!, _yearsMeta),
      );
    }
    if (data.containsKey('monthly_kwh')) {
      context.handle(
        _monthlyKwhMeta,
        monthlyKwh.isAcceptableOrUnknown(data['monthly_kwh']!, _monthlyKwhMeta),
      );
    } else if (isInserting) {
      context.missing(_monthlyKwhMeta);
    }
    if (data.containsKey('yearly_kwh')) {
      context.handle(
        _yearlyKwhMeta,
        yearlyKwh.isAcceptableOrUnknown(data['yearly_kwh']!, _yearlyKwhMeta),
      );
    } else if (isInserting) {
      context.missing(_yearlyKwhMeta);
    }
    if (data.containsKey('clipped_kwh')) {
      context.handle(
        _clippedKwhMeta,
        clippedKwh.isAcceptableOrUnknown(data['clipped_kwh']!, _clippedKwhMeta),
      );
    }
    if (data.containsKey('shading_loss_pct')) {
      context.handle(
        _shadingLossPctMeta,
        shadingLossPct.isAcceptableOrUnknown(
          data['shading_loss_pct']!,
          _shadingLossPctMeta,
        ),
      );
    }
    if (data.containsKey('specific_yield')) {
      context.handle(
        _specificYieldMeta,
        specificYield.isAcceptableOrUnknown(
          data['specific_yield']!,
          _specificYieldMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_specificYieldMeta);
    }
    if (data.containsKey('performance_ratio')) {
      context.handle(
        _performanceRatioMeta,
        performanceRatio.isAcceptableOrUnknown(
          data['performance_ratio']!,
          _performanceRatioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_performanceRatioMeta);
    }
    if (data.containsKey('losses')) {
      context.handle(
        _lossesMeta,
        losses.isAcceptableOrUnknown(data['losses']!, _lossesMeta),
      );
    }
    if (data.containsKey('weather_label')) {
      context.handle(
        _weatherLabelMeta,
        weatherLabel.isAcceptableOrUnknown(
          data['weather_label']!,
          _weatherLabelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SimulationResultRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SimulationResultRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      projectId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}project_id'],
      )!,
      pdcW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pdc_w'],
      )!,
      pacW: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pac_w'],
      )!,
      firstYearKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}first_year_kwh'],
      )!,
      lifetimeKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lifetime_kwh'],
      )!,
      years: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}years'],
      )!,
      monthlyKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}monthly_kwh'],
      )!,
      yearlyKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}yearly_kwh'],
      )!,
      clippedKwh: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}clipped_kwh'],
      )!,
      shadingLossPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}shading_loss_pct'],
      )!,
      specificYield: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}specific_yield'],
      )!,
      performanceRatio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}performance_ratio'],
      )!,
      losses: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}losses'],
      )!,
      weatherLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}weather_label'],
      ),
    );
  }

  @override
  $SimulationResultsTable createAlias(String alias) {
    return $SimulationResultsTable(attachedDatabase, alias);
  }
}

class SimulationResultRecord extends DataClass
    implements Insertable<SimulationResultRecord> {
  /// Identificador UUID v4.
  final String id;

  /// Momento de creación (UTC).
  final DateTime createdAt;

  /// Momento de la última modificación (UTC).
  final DateTime updatedAt;

  /// Momento del borrado lógico (UTC) o `null` si está activo.
  final DateTime? deletedAt;

  /// Proyecto.
  final String projectId;

  /// Potencia DC (W).
  final double pdcW;

  /// Potencia AC (W).
  final double pacW;

  /// Energía del primer año (kWh).
  final double firstYearKwh;

  /// Energía de toda la vida útil (kWh).
  final double lifetimeKwh;

  /// Años de vida útil simulados.
  final int years;

  /// Energía mensual del primer año en JSON (12 valores, kWh).
  final String monthlyKwh;

  /// Energía por año en JSON (kWh).
  final String yearlyKwh;

  /// Recorte anual (kWh).
  final double clippedKwh;

  /// Pérdida por sombra (%).
  final double shadingLossPct;

  /// Rendimiento específico (kWh/kWp).
  final double specificYield;

  /// Performance ratio.
  final double performanceRatio;

  /// Pérdidas usadas en JSON (%).
  final String losses;

  /// Fuente del clima ("NASA POWER 2021–2025").
  final String? weatherLabel;
  const SimulationResultRecord({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.pdcW,
    required this.pacW,
    required this.firstYearKwh,
    required this.lifetimeKwh,
    required this.years,
    required this.monthlyKwh,
    required this.yearlyKwh,
    required this.clippedKwh,
    required this.shadingLossPct,
    required this.specificYield,
    required this.performanceRatio,
    required this.losses,
    this.weatherLabel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['project_id'] = Variable<String>(projectId);
    map['pdc_w'] = Variable<double>(pdcW);
    map['pac_w'] = Variable<double>(pacW);
    map['first_year_kwh'] = Variable<double>(firstYearKwh);
    map['lifetime_kwh'] = Variable<double>(lifetimeKwh);
    map['years'] = Variable<int>(years);
    map['monthly_kwh'] = Variable<String>(monthlyKwh);
    map['yearly_kwh'] = Variable<String>(yearlyKwh);
    map['clipped_kwh'] = Variable<double>(clippedKwh);
    map['shading_loss_pct'] = Variable<double>(shadingLossPct);
    map['specific_yield'] = Variable<double>(specificYield);
    map['performance_ratio'] = Variable<double>(performanceRatio);
    map['losses'] = Variable<String>(losses);
    if (!nullToAbsent || weatherLabel != null) {
      map['weather_label'] = Variable<String>(weatherLabel);
    }
    return map;
  }

  SimulationResultsCompanion toCompanion(bool nullToAbsent) {
    return SimulationResultsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      projectId: Value(projectId),
      pdcW: Value(pdcW),
      pacW: Value(pacW),
      firstYearKwh: Value(firstYearKwh),
      lifetimeKwh: Value(lifetimeKwh),
      years: Value(years),
      monthlyKwh: Value(monthlyKwh),
      yearlyKwh: Value(yearlyKwh),
      clippedKwh: Value(clippedKwh),
      shadingLossPct: Value(shadingLossPct),
      specificYield: Value(specificYield),
      performanceRatio: Value(performanceRatio),
      losses: Value(losses),
      weatherLabel: weatherLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(weatherLabel),
    );
  }

  factory SimulationResultRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SimulationResultRecord(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      projectId: serializer.fromJson<String>(json['projectId']),
      pdcW: serializer.fromJson<double>(json['pdcW']),
      pacW: serializer.fromJson<double>(json['pacW']),
      firstYearKwh: serializer.fromJson<double>(json['firstYearKwh']),
      lifetimeKwh: serializer.fromJson<double>(json['lifetimeKwh']),
      years: serializer.fromJson<int>(json['years']),
      monthlyKwh: serializer.fromJson<String>(json['monthlyKwh']),
      yearlyKwh: serializer.fromJson<String>(json['yearlyKwh']),
      clippedKwh: serializer.fromJson<double>(json['clippedKwh']),
      shadingLossPct: serializer.fromJson<double>(json['shadingLossPct']),
      specificYield: serializer.fromJson<double>(json['specificYield']),
      performanceRatio: serializer.fromJson<double>(json['performanceRatio']),
      losses: serializer.fromJson<String>(json['losses']),
      weatherLabel: serializer.fromJson<String?>(json['weatherLabel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'projectId': serializer.toJson<String>(projectId),
      'pdcW': serializer.toJson<double>(pdcW),
      'pacW': serializer.toJson<double>(pacW),
      'firstYearKwh': serializer.toJson<double>(firstYearKwh),
      'lifetimeKwh': serializer.toJson<double>(lifetimeKwh),
      'years': serializer.toJson<int>(years),
      'monthlyKwh': serializer.toJson<String>(monthlyKwh),
      'yearlyKwh': serializer.toJson<String>(yearlyKwh),
      'clippedKwh': serializer.toJson<double>(clippedKwh),
      'shadingLossPct': serializer.toJson<double>(shadingLossPct),
      'specificYield': serializer.toJson<double>(specificYield),
      'performanceRatio': serializer.toJson<double>(performanceRatio),
      'losses': serializer.toJson<String>(losses),
      'weatherLabel': serializer.toJson<String?>(weatherLabel),
    };
  }

  SimulationResultRecord copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    String? projectId,
    double? pdcW,
    double? pacW,
    double? firstYearKwh,
    double? lifetimeKwh,
    int? years,
    String? monthlyKwh,
    String? yearlyKwh,
    double? clippedKwh,
    double? shadingLossPct,
    double? specificYield,
    double? performanceRatio,
    String? losses,
    Value<String?> weatherLabel = const Value.absent(),
  }) => SimulationResultRecord(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    projectId: projectId ?? this.projectId,
    pdcW: pdcW ?? this.pdcW,
    pacW: pacW ?? this.pacW,
    firstYearKwh: firstYearKwh ?? this.firstYearKwh,
    lifetimeKwh: lifetimeKwh ?? this.lifetimeKwh,
    years: years ?? this.years,
    monthlyKwh: monthlyKwh ?? this.monthlyKwh,
    yearlyKwh: yearlyKwh ?? this.yearlyKwh,
    clippedKwh: clippedKwh ?? this.clippedKwh,
    shadingLossPct: shadingLossPct ?? this.shadingLossPct,
    specificYield: specificYield ?? this.specificYield,
    performanceRatio: performanceRatio ?? this.performanceRatio,
    losses: losses ?? this.losses,
    weatherLabel: weatherLabel.present ? weatherLabel.value : this.weatherLabel,
  );
  SimulationResultRecord copyWithCompanion(SimulationResultsCompanion data) {
    return SimulationResultRecord(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      projectId: data.projectId.present ? data.projectId.value : this.projectId,
      pdcW: data.pdcW.present ? data.pdcW.value : this.pdcW,
      pacW: data.pacW.present ? data.pacW.value : this.pacW,
      firstYearKwh: data.firstYearKwh.present
          ? data.firstYearKwh.value
          : this.firstYearKwh,
      lifetimeKwh: data.lifetimeKwh.present
          ? data.lifetimeKwh.value
          : this.lifetimeKwh,
      years: data.years.present ? data.years.value : this.years,
      monthlyKwh: data.monthlyKwh.present
          ? data.monthlyKwh.value
          : this.monthlyKwh,
      yearlyKwh: data.yearlyKwh.present ? data.yearlyKwh.value : this.yearlyKwh,
      clippedKwh: data.clippedKwh.present
          ? data.clippedKwh.value
          : this.clippedKwh,
      shadingLossPct: data.shadingLossPct.present
          ? data.shadingLossPct.value
          : this.shadingLossPct,
      specificYield: data.specificYield.present
          ? data.specificYield.value
          : this.specificYield,
      performanceRatio: data.performanceRatio.present
          ? data.performanceRatio.value
          : this.performanceRatio,
      losses: data.losses.present ? data.losses.value : this.losses,
      weatherLabel: data.weatherLabel.present
          ? data.weatherLabel.value
          : this.weatherLabel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SimulationResultRecord(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('pdcW: $pdcW, ')
          ..write('pacW: $pacW, ')
          ..write('firstYearKwh: $firstYearKwh, ')
          ..write('lifetimeKwh: $lifetimeKwh, ')
          ..write('years: $years, ')
          ..write('monthlyKwh: $monthlyKwh, ')
          ..write('yearlyKwh: $yearlyKwh, ')
          ..write('clippedKwh: $clippedKwh, ')
          ..write('shadingLossPct: $shadingLossPct, ')
          ..write('specificYield: $specificYield, ')
          ..write('performanceRatio: $performanceRatio, ')
          ..write('losses: $losses, ')
          ..write('weatherLabel: $weatherLabel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    projectId,
    pdcW,
    pacW,
    firstYearKwh,
    lifetimeKwh,
    years,
    monthlyKwh,
    yearlyKwh,
    clippedKwh,
    shadingLossPct,
    specificYield,
    performanceRatio,
    losses,
    weatherLabel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SimulationResultRecord &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.projectId == this.projectId &&
          other.pdcW == this.pdcW &&
          other.pacW == this.pacW &&
          other.firstYearKwh == this.firstYearKwh &&
          other.lifetimeKwh == this.lifetimeKwh &&
          other.years == this.years &&
          other.monthlyKwh == this.monthlyKwh &&
          other.yearlyKwh == this.yearlyKwh &&
          other.clippedKwh == this.clippedKwh &&
          other.shadingLossPct == this.shadingLossPct &&
          other.specificYield == this.specificYield &&
          other.performanceRatio == this.performanceRatio &&
          other.losses == this.losses &&
          other.weatherLabel == this.weatherLabel);
}

class SimulationResultsCompanion
    extends UpdateCompanion<SimulationResultRecord> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<String> projectId;
  final Value<double> pdcW;
  final Value<double> pacW;
  final Value<double> firstYearKwh;
  final Value<double> lifetimeKwh;
  final Value<int> years;
  final Value<String> monthlyKwh;
  final Value<String> yearlyKwh;
  final Value<double> clippedKwh;
  final Value<double> shadingLossPct;
  final Value<double> specificYield;
  final Value<double> performanceRatio;
  final Value<String> losses;
  final Value<String?> weatherLabel;
  final Value<int> rowid;
  const SimulationResultsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.projectId = const Value.absent(),
    this.pdcW = const Value.absent(),
    this.pacW = const Value.absent(),
    this.firstYearKwh = const Value.absent(),
    this.lifetimeKwh = const Value.absent(),
    this.years = const Value.absent(),
    this.monthlyKwh = const Value.absent(),
    this.yearlyKwh = const Value.absent(),
    this.clippedKwh = const Value.absent(),
    this.shadingLossPct = const Value.absent(),
    this.specificYield = const Value.absent(),
    this.performanceRatio = const Value.absent(),
    this.losses = const Value.absent(),
    this.weatherLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SimulationResultsCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    required String projectId,
    required double pdcW,
    required double pacW,
    required double firstYearKwh,
    required double lifetimeKwh,
    this.years = const Value.absent(),
    required String monthlyKwh,
    required String yearlyKwh,
    this.clippedKwh = const Value.absent(),
    this.shadingLossPct = const Value.absent(),
    required double specificYield,
    required double performanceRatio,
    this.losses = const Value.absent(),
    this.weatherLabel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : projectId = Value(projectId),
       pdcW = Value(pdcW),
       pacW = Value(pacW),
       firstYearKwh = Value(firstYearKwh),
       lifetimeKwh = Value(lifetimeKwh),
       monthlyKwh = Value(monthlyKwh),
       yearlyKwh = Value(yearlyKwh),
       specificYield = Value(specificYield),
       performanceRatio = Value(performanceRatio);
  static Insertable<SimulationResultRecord> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<String>? projectId,
    Expression<double>? pdcW,
    Expression<double>? pacW,
    Expression<double>? firstYearKwh,
    Expression<double>? lifetimeKwh,
    Expression<int>? years,
    Expression<String>? monthlyKwh,
    Expression<String>? yearlyKwh,
    Expression<double>? clippedKwh,
    Expression<double>? shadingLossPct,
    Expression<double>? specificYield,
    Expression<double>? performanceRatio,
    Expression<String>? losses,
    Expression<String>? weatherLabel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (projectId != null) 'project_id': projectId,
      if (pdcW != null) 'pdc_w': pdcW,
      if (pacW != null) 'pac_w': pacW,
      if (firstYearKwh != null) 'first_year_kwh': firstYearKwh,
      if (lifetimeKwh != null) 'lifetime_kwh': lifetimeKwh,
      if (years != null) 'years': years,
      if (monthlyKwh != null) 'monthly_kwh': monthlyKwh,
      if (yearlyKwh != null) 'yearly_kwh': yearlyKwh,
      if (clippedKwh != null) 'clipped_kwh': clippedKwh,
      if (shadingLossPct != null) 'shading_loss_pct': shadingLossPct,
      if (specificYield != null) 'specific_yield': specificYield,
      if (performanceRatio != null) 'performance_ratio': performanceRatio,
      if (losses != null) 'losses': losses,
      if (weatherLabel != null) 'weather_label': weatherLabel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SimulationResultsCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<String>? projectId,
    Value<double>? pdcW,
    Value<double>? pacW,
    Value<double>? firstYearKwh,
    Value<double>? lifetimeKwh,
    Value<int>? years,
    Value<String>? monthlyKwh,
    Value<String>? yearlyKwh,
    Value<double>? clippedKwh,
    Value<double>? shadingLossPct,
    Value<double>? specificYield,
    Value<double>? performanceRatio,
    Value<String>? losses,
    Value<String?>? weatherLabel,
    Value<int>? rowid,
  }) {
    return SimulationResultsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      projectId: projectId ?? this.projectId,
      pdcW: pdcW ?? this.pdcW,
      pacW: pacW ?? this.pacW,
      firstYearKwh: firstYearKwh ?? this.firstYearKwh,
      lifetimeKwh: lifetimeKwh ?? this.lifetimeKwh,
      years: years ?? this.years,
      monthlyKwh: monthlyKwh ?? this.monthlyKwh,
      yearlyKwh: yearlyKwh ?? this.yearlyKwh,
      clippedKwh: clippedKwh ?? this.clippedKwh,
      shadingLossPct: shadingLossPct ?? this.shadingLossPct,
      specificYield: specificYield ?? this.specificYield,
      performanceRatio: performanceRatio ?? this.performanceRatio,
      losses: losses ?? this.losses,
      weatherLabel: weatherLabel ?? this.weatherLabel,
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
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (projectId.present) {
      map['project_id'] = Variable<String>(projectId.value);
    }
    if (pdcW.present) {
      map['pdc_w'] = Variable<double>(pdcW.value);
    }
    if (pacW.present) {
      map['pac_w'] = Variable<double>(pacW.value);
    }
    if (firstYearKwh.present) {
      map['first_year_kwh'] = Variable<double>(firstYearKwh.value);
    }
    if (lifetimeKwh.present) {
      map['lifetime_kwh'] = Variable<double>(lifetimeKwh.value);
    }
    if (years.present) {
      map['years'] = Variable<int>(years.value);
    }
    if (monthlyKwh.present) {
      map['monthly_kwh'] = Variable<String>(monthlyKwh.value);
    }
    if (yearlyKwh.present) {
      map['yearly_kwh'] = Variable<String>(yearlyKwh.value);
    }
    if (clippedKwh.present) {
      map['clipped_kwh'] = Variable<double>(clippedKwh.value);
    }
    if (shadingLossPct.present) {
      map['shading_loss_pct'] = Variable<double>(shadingLossPct.value);
    }
    if (specificYield.present) {
      map['specific_yield'] = Variable<double>(specificYield.value);
    }
    if (performanceRatio.present) {
      map['performance_ratio'] = Variable<double>(performanceRatio.value);
    }
    if (losses.present) {
      map['losses'] = Variable<String>(losses.value);
    }
    if (weatherLabel.present) {
      map['weather_label'] = Variable<String>(weatherLabel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SimulationResultsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('projectId: $projectId, ')
          ..write('pdcW: $pdcW, ')
          ..write('pacW: $pacW, ')
          ..write('firstYearKwh: $firstYearKwh, ')
          ..write('lifetimeKwh: $lifetimeKwh, ')
          ..write('years: $years, ')
          ..write('monthlyKwh: $monthlyKwh, ')
          ..write('yearlyKwh: $yearlyKwh, ')
          ..write('clippedKwh: $clippedKwh, ')
          ..write('shadingLossPct: $shadingLossPct, ')
          ..write('specificYield: $specificYield, ')
          ..write('performanceRatio: $performanceRatio, ')
          ..write('losses: $losses, ')
          ..write('weatherLabel: $weatherLabel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $ProjectsTable projects = $ProjectsTable(this);
  late final $SitesTable sites = $SitesTable(this);
  late final $UtilityBillsTable utilityBills = $UtilityBillsTable(this);
  late final $PhotosTable photos = $PhotosTable(this);
  late final $DocumentsTable documents = $DocumentsTable(this);
  late final $RoofImagesTable roofImages = $RoofImagesTable(this);
  late final $RoofPlanesTable roofPlanes = $RoofPlanesTable(this);
  late final $ObstaclesTable obstacles = $ObstaclesTable(this);
  late final $HorizonProfilesTable horizonProfiles = $HorizonProfilesTable(
    this,
  );
  late final $PanelModelsTable panelModels = $PanelModelsTable(this);
  late final $InverterModelsTable inverterModels = $InverterModelsTable(this);
  late final $OptimizerModelsTable optimizerModels = $OptimizerModelsTable(
    this,
  );
  late final $BatteryModelsTable batteryModels = $BatteryModelsTable(this);
  late final $PvDesignsTable pvDesigns = $PvDesignsTable(this);
  late final $ArrayLayoutsTable arrayLayouts = $ArrayLayoutsTable(this);
  late final $StringConfigsTable stringConfigs = $StringConfigsTable(this);
  late final $ElectricalRunsTable electricalRuns = $ElectricalRunsTable(this);
  late final $ProtectionDevicesTable protectionDevices =
      $ProtectionDevicesTable(this);
  late final $SimulationResultsTable simulationResults =
      $SimulationResultsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    companies,
    clients,
    projects,
    sites,
    utilityBills,
    photos,
    documents,
    roofImages,
    roofPlanes,
    obstacles,
    horizonProfiles,
    panelModels,
    inverterModels,
    optimizerModels,
    batteryModels,
    pvDesigns,
    arrayLayouts,
    stringConfigs,
    electricalRuns,
    protectionDevices,
    simulationResults,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CompaniesTableCreateCompanionBuilder = CompaniesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> taxId,
  Value<String?> logoPath,
  Value<int> rowid,
});
typedef $$CompaniesTableUpdateCompanionBuilder = CompaniesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> taxId,
  Value<String?> logoPath,
  Value<int> rowid,
});

class $$CompaniesTableFilterComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CompaniesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompaniesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get taxId =>
      $composableBuilder(column: $table.taxId, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);
}

class $$CompaniesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompaniesTable,
          Company,
          $$CompaniesTableFilterComposer,
          $$CompaniesTableOrderingComposer,
          $$CompaniesTableAnnotationComposer,
          $$CompaniesTableCreateCompanionBuilder,
          $$CompaniesTableUpdateCompanionBuilder,
          (Company, BaseReferences<_$AppDatabase, $CompaniesTable, Company>),
          Company,
          PrefetchHooks Function()
        > {
  $$CompaniesTableTableManager(_$AppDatabase db, $CompaniesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompaniesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                name: name,
                phone: phone,
                email: email,
                taxId: taxId,
                logoPath: logoPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CompaniesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                name: name,
                phone: phone,
                email: email,
                taxId: taxId,
                logoPath: logoPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CompaniesTable, Company>(table),
                  BaseReferences<_$AppDatabase, $CompaniesTable, Company>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CompaniesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompaniesTable,
      Company,
      $$CompaniesTableFilterComposer,
      $$CompaniesTableOrderingComposer,
      $$CompaniesTableAnnotationComposer,
      $$CompaniesTableCreateCompanionBuilder,
      $$CompaniesTableUpdateCompanionBuilder,
      (Company, BaseReferences<_$AppDatabase, $CompaniesTable, Company>),
      Company,
      PrefetchHooks Function()
    >;
typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> name,
  Value<String?> phone,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$ClientsTableReferences
    extends BaseReferences<_$AppDatabase, $ClientsTable, Client> {
  $$ClientsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProjectsTable, List<Project>> _projectsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.projects,
    aliasName: 'clients__id__projects__client_id',
  );

  $$ProjectsTableProcessedTableManager get projectsRefs {
    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_projectsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UtilityBillsTable, List<UtilityBill>>
  _utilityBillsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.utilityBills,
    aliasName: 'clients__id__utility_bills__client_id',
  );

  $$UtilityBillsTableProcessedTableManager get utilityBillsRefs {
    final manager = $$UtilityBillsTableTableManager(
      $_db,
      $_db.utilityBills,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_utilityBillsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> projectsRefs(
    Expression<bool> Function($$ProjectsTableFilterComposer f) f,
  ) {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> utilityBillsRefs(
    Expression<bool> Function($$UtilityBillsTableFilterComposer f) f,
  ) {
    final $$UtilityBillsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utilityBills,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilityBillsTableFilterComposer(
            $db: $db,
            $table: $db.utilityBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> projectsRefs<T extends Object>(
    Expression<T> Function($$ProjectsTableAnnotationComposer a) f,
  ) {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> utilityBillsRefs<T extends Object>(
    Expression<T> Function($$UtilityBillsTableAnnotationComposer a) f,
  ) {
    final $$UtilityBillsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.utilityBills,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UtilityBillsTableAnnotationComposer(
            $db: $db,
            $table: $db.utilityBills,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientsTable,
          Client,
          $$ClientsTableFilterComposer,
          $$ClientsTableOrderingComposer,
          $$ClientsTableAnnotationComposer,
          $$ClientsTableCreateCompanionBuilder,
          $$ClientsTableUpdateCompanionBuilder,
          (Client, $$ClientsTableReferences),
          Client,
          PrefetchHooks Function({bool projectsRefs, bool utilityBillsRefs})
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                name: name,
                phone: phone,
                email: email,
                address: address,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                name: name,
                phone: phone,
                email: email,
                address: address,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClientsTable, Client>(table),
                  $$ClientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectsRefs = false, utilityBillsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (projectsRefs) db.projects,
                    if (utilityBillsRefs) db.utilityBills,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (projectsRefs)
                        await $_getPrefetchedDataByColumns<
                          Client,
                          $ClientsTable,
                          Project,
                          $ProjectsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._projectsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).projectsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'client_id',
                          typedResults: items,
                        ),
                      if (utilityBillsRefs)
                        await $_getPrefetchedDataByColumns<
                          Client,
                          $ClientsTable,
                          UtilityBill,
                          $UtilityBillsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ClientsTableReferences
                              ._utilityBillsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ClientsTableReferences(
                                db,
                                table,
                                p0,
                              ).utilityBillsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'client_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientsTable,
      Client,
      $$ClientsTableFilterComposer,
      $$ClientsTableOrderingComposer,
      $$ClientsTableAnnotationComposer,
      $$ClientsTableCreateCompanionBuilder,
      $$ClientsTableUpdateCompanionBuilder,
      (Client, $$ClientsTableReferences),
      Client,
      PrefetchHooks Function({bool projectsRefs, bool utilityBillsRefs})
    >;
typedef $$ProjectsTableCreateCompanionBuilder = ProjectsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String clientId,
  required String name,
  Value<ProjectStatus> status,
  required DateTime projectDate,
  Value<String?> notes,
  Value<int> rowid,
});
typedef $$ProjectsTableUpdateCompanionBuilder = ProjectsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> clientId,
  Value<String> name,
  Value<ProjectStatus> status,
  Value<DateTime> projectDate,
  Value<String?> notes,
  Value<int> rowid,
});

final class $$ProjectsTableReferences
    extends BaseReferences<_$AppDatabase, $ProjectsTable, Project> {
  $$ProjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('projects__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$SitesTable, List<Site>> _sitesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.sites,
    aliasName: 'projects__id__sites__project_id',
  );

  $$SitesTableProcessedTableManager get sitesRefs {
    final manager = $$SitesTableTableManager(
      $_db,
      $_db.sites,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sitesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhotosTable, List<Photo>> _photosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.photos,
    aliasName: 'projects__id__photos__project_id',
  );

  $$PhotosTableProcessedTableManager get photosRefs {
    final manager = $$PhotosTableTableManager(
      $_db,
      $_db.photos,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_photosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumentsTable, List<Document>>
  _documentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documents,
    aliasName: 'projects__id__documents__project_id',
  );

  $$DocumentsTableProcessedTableManager get documentsRefs {
    final manager = $$DocumentsTableTableManager(
      $_db,
      $_db.documents,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoofImagesTable, List<RoofImage>>
  _roofImagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roofImages,
    aliasName: 'projects__id__roof_images__project_id',
  );

  $$RoofImagesTableProcessedTableManager get roofImagesRefs {
    final manager = $$RoofImagesTableTableManager(
      $_db,
      $_db.roofImages,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_roofImagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RoofPlanesTable, List<RoofPlane>>
  _roofPlanesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.roofPlanes,
    aliasName: 'projects__id__roof_planes__project_id',
  );

  $$RoofPlanesTableProcessedTableManager get roofPlanesRefs {
    final manager = $$RoofPlanesTableTableManager(
      $_db,
      $_db.roofPlanes,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_roofPlanesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ObstaclesTable, List<Obstacle>>
  _obstaclesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.obstacles,
    aliasName: 'projects__id__obstacles__project_id',
  );

  $$ObstaclesTableProcessedTableManager get obstaclesRefs {
    final manager = $$ObstaclesTableTableManager(
      $_db,
      $_db.obstacles,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_obstaclesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$HorizonProfilesTable, List<HorizonProfileRecord>>
  _horizonProfilesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.horizonProfiles,
    aliasName: 'projects__id__horizon_profiles__project_id',
  );

  $$HorizonProfilesTableProcessedTableManager get horizonProfilesRefs {
    final manager = $$HorizonProfilesTableTableManager(
      $_db,
      $_db.horizonProfiles,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _horizonProfilesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PvDesignsTable, List<PvDesign>>
  _pvDesignsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.pvDesigns,
    aliasName: 'projects__id__pv_designs__project_id',
  );

  $$PvDesignsTableProcessedTableManager get pvDesignsRefs {
    final manager = $$PvDesignsTableTableManager(
      $_db,
      $_db.pvDesigns,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pvDesignsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ArrayLayoutsTable, List<ArrayLayout>>
  _arrayLayoutsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.arrayLayouts,
    aliasName: 'projects__id__array_layouts__project_id',
  );

  $$ArrayLayoutsTableProcessedTableManager get arrayLayoutsRefs {
    final manager = $$ArrayLayoutsTableTableManager(
      $_db,
      $_db.arrayLayouts,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_arrayLayoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StringConfigsTable, List<StringConfig>>
  _stringConfigsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.stringConfigs,
    aliasName: 'projects__id__string_configs__project_id',
  );

  $$StringConfigsTableProcessedTableManager get stringConfigsRefs {
    final manager = $$StringConfigsTableTableManager(
      $_db,
      $_db.stringConfigs,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_stringConfigsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ElectricalRunsTable, List<ElectricalRun>>
  _electricalRunsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.electricalRuns,
    aliasName: 'projects__id__electrical_runs__project_id',
  );

  $$ElectricalRunsTableProcessedTableManager get electricalRunsRefs {
    final manager = $$ElectricalRunsTableTableManager(
      $_db,
      $_db.electricalRuns,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_electricalRunsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ProtectionDevicesTable, List<ProtectionDevice>>
  _protectionDevicesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.protectionDevices,
        aliasName: 'projects__id__protection_devices__project_id',
      );

  $$ProtectionDevicesTableProcessedTableManager get protectionDevicesRefs {
    final manager = $$ProtectionDevicesTableTableManager(
      $_db,
      $_db.protectionDevices,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _protectionDevicesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $SimulationResultsTable,
    List<SimulationResultRecord>
  >
  _simulationResultsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.simulationResults,
        aliasName: 'projects__id__simulation_results__project_id',
      );

  $$SimulationResultsTableProcessedTableManager get simulationResultsRefs {
    final manager = $$SimulationResultsTableTableManager(
      $_db,
      $_db.simulationResults,
    ).filter((f) => f.projectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _simulationResultsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProjectsTableFilterComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProjectStatus, ProjectStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get projectDate => $composableBuilder(
    column: $table.projectDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> sitesRefs(
    Expression<bool> Function($$SitesTableFilterComposer f) f,
  ) {
    final $$SitesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sites,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SitesTableFilterComposer(
            $db: $db,
            $table: $db.sites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> photosRefs(
    Expression<bool> Function($$PhotosTableFilterComposer f) f,
  ) {
    final $$PhotosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableFilterComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documentsRefs(
    Expression<bool> Function($$DocumentsTableFilterComposer f) f,
  ) {
    final $$DocumentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableFilterComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roofImagesRefs(
    Expression<bool> Function($$RoofImagesTableFilterComposer f) f,
  ) {
    final $$RoofImagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roofImages,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofImagesTableFilterComposer(
            $db: $db,
            $table: $db.roofImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> roofPlanesRefs(
    Expression<bool> Function($$RoofPlanesTableFilterComposer f) f,
  ) {
    final $$RoofPlanesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roofPlanes,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofPlanesTableFilterComposer(
            $db: $db,
            $table: $db.roofPlanes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> obstaclesRefs(
    Expression<bool> Function($$ObstaclesTableFilterComposer f) f,
  ) {
    final $$ObstaclesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.obstacles,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObstaclesTableFilterComposer(
            $db: $db,
            $table: $db.obstacles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> horizonProfilesRefs(
    Expression<bool> Function($$HorizonProfilesTableFilterComposer f) f,
  ) {
    final $$HorizonProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horizonProfiles,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorizonProfilesTableFilterComposer(
            $db: $db,
            $table: $db.horizonProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pvDesignsRefs(
    Expression<bool> Function($$PvDesignsTableFilterComposer f) f,
  ) {
    final $$PvDesignsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pvDesigns,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PvDesignsTableFilterComposer(
            $db: $db,
            $table: $db.pvDesigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> arrayLayoutsRefs(
    Expression<bool> Function($$ArrayLayoutsTableFilterComposer f) f,
  ) {
    final $$ArrayLayoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.arrayLayouts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArrayLayoutsTableFilterComposer(
            $db: $db,
            $table: $db.arrayLayouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stringConfigsRefs(
    Expression<bool> Function($$StringConfigsTableFilterComposer f) f,
  ) {
    final $$StringConfigsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stringConfigs,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StringConfigsTableFilterComposer(
            $db: $db,
            $table: $db.stringConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> electricalRunsRefs(
    Expression<bool> Function($$ElectricalRunsTableFilterComposer f) f,
  ) {
    final $$ElectricalRunsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.electricalRuns,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElectricalRunsTableFilterComposer(
            $db: $db,
            $table: $db.electricalRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> protectionDevicesRefs(
    Expression<bool> Function($$ProtectionDevicesTableFilterComposer f) f,
  ) {
    final $$ProtectionDevicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.protectionDevices,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProtectionDevicesTableFilterComposer(
            $db: $db,
            $table: $db.protectionDevices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> simulationResultsRefs(
    Expression<bool> Function($$SimulationResultsTableFilterComposer f) f,
  ) {
    final $$SimulationResultsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.simulationResults,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SimulationResultsTableFilterComposer(
            $db: $db,
            $table: $db.simulationResults,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get projectDate => $composableBuilder(
    column: $table.projectDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProjectsTable> {
  $$ProjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProjectStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get projectDate => $composableBuilder(
    column: $table.projectDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> sitesRefs<T extends Object>(
    Expression<T> Function($$SitesTableAnnotationComposer a) f,
  ) {
    final $$SitesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sites,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SitesTableAnnotationComposer(
            $db: $db,
            $table: $db.sites,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> photosRefs<T extends Object>(
    Expression<T> Function($$PhotosTableAnnotationComposer a) f,
  ) {
    final $$PhotosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.photos,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhotosTableAnnotationComposer(
            $db: $db,
            $table: $db.photos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documentsRefs<T extends Object>(
    Expression<T> Function($$DocumentsTableAnnotationComposer a) f,
  ) {
    final $$DocumentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documents,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumentsTableAnnotationComposer(
            $db: $db,
            $table: $db.documents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roofImagesRefs<T extends Object>(
    Expression<T> Function($$RoofImagesTableAnnotationComposer a) f,
  ) {
    final $$RoofImagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roofImages,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofImagesTableAnnotationComposer(
            $db: $db,
            $table: $db.roofImages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> roofPlanesRefs<T extends Object>(
    Expression<T> Function($$RoofPlanesTableAnnotationComposer a) f,
  ) {
    final $$RoofPlanesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.roofPlanes,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofPlanesTableAnnotationComposer(
            $db: $db,
            $table: $db.roofPlanes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> obstaclesRefs<T extends Object>(
    Expression<T> Function($$ObstaclesTableAnnotationComposer a) f,
  ) {
    final $$ObstaclesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.obstacles,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObstaclesTableAnnotationComposer(
            $db: $db,
            $table: $db.obstacles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> horizonProfilesRefs<T extends Object>(
    Expression<T> Function($$HorizonProfilesTableAnnotationComposer a) f,
  ) {
    final $$HorizonProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.horizonProfiles,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HorizonProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.horizonProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pvDesignsRefs<T extends Object>(
    Expression<T> Function($$PvDesignsTableAnnotationComposer a) f,
  ) {
    final $$PvDesignsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pvDesigns,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PvDesignsTableAnnotationComposer(
            $db: $db,
            $table: $db.pvDesigns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> arrayLayoutsRefs<T extends Object>(
    Expression<T> Function($$ArrayLayoutsTableAnnotationComposer a) f,
  ) {
    final $$ArrayLayoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.arrayLayouts,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArrayLayoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.arrayLayouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stringConfigsRefs<T extends Object>(
    Expression<T> Function($$StringConfigsTableAnnotationComposer a) f,
  ) {
    final $$StringConfigsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stringConfigs,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StringConfigsTableAnnotationComposer(
            $db: $db,
            $table: $db.stringConfigs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> electricalRunsRefs<T extends Object>(
    Expression<T> Function($$ElectricalRunsTableAnnotationComposer a) f,
  ) {
    final $$ElectricalRunsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.electricalRuns,
      getReferencedColumn: (t) => t.projectId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ElectricalRunsTableAnnotationComposer(
            $db: $db,
            $table: $db.electricalRuns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> protectionDevicesRefs<T extends Object>(
    Expression<T> Function($$ProtectionDevicesTableAnnotationComposer a) f,
  ) {
    final $$ProtectionDevicesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.protectionDevices,
          getReferencedColumn: (t) => t.projectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ProtectionDevicesTableAnnotationComposer(
                $db: $db,
                $table: $db.protectionDevices,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> simulationResultsRefs<T extends Object>(
    Expression<T> Function($$SimulationResultsTableAnnotationComposer a) f,
  ) {
    final $$SimulationResultsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.simulationResults,
          getReferencedColumn: (t) => t.projectId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SimulationResultsTableAnnotationComposer(
                $db: $db,
                $table: $db.simulationResults,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ProjectsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProjectsTable,
          Project,
          $$ProjectsTableFilterComposer,
          $$ProjectsTableOrderingComposer,
          $$ProjectsTableAnnotationComposer,
          $$ProjectsTableCreateCompanionBuilder,
          $$ProjectsTableUpdateCompanionBuilder,
          (Project, $$ProjectsTableReferences),
          Project,
          PrefetchHooks Function({
            bool clientId,
            bool sitesRefs,
            bool photosRefs,
            bool documentsRefs,
            bool roofImagesRefs,
            bool roofPlanesRefs,
            bool obstaclesRefs,
            bool horizonProfilesRefs,
            bool pvDesignsRefs,
            bool arrayLayoutsRefs,
            bool stringConfigsRefs,
            bool electricalRunsRefs,
            bool protectionDevicesRefs,
            bool simulationResultsRefs,
          })
        > {
  $$ProjectsTableTableManager(_$AppDatabase db, $ProjectsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<ProjectStatus> status = const Value.absent(),
                Value<DateTime> projectDate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                name: name,
                status: status,
                projectDate: projectDate,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String clientId,
                required String name,
                Value<ProjectStatus> status = const Value.absent(),
                required DateTime projectDate,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProjectsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                name: name,
                status: status,
                projectDate: projectDate,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProjectsTable, Project>(table),
                  $$ProjectsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                sitesRefs = false,
                photosRefs = false,
                documentsRefs = false,
                roofImagesRefs = false,
                roofPlanesRefs = false,
                obstaclesRefs = false,
                horizonProfilesRefs = false,
                pvDesignsRefs = false,
                arrayLayoutsRefs = false,
                stringConfigsRefs = false,
                electricalRunsRefs = false,
                protectionDevicesRefs = false,
                simulationResultsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (sitesRefs) db.sites,
                    if (photosRefs) db.photos,
                    if (documentsRefs) db.documents,
                    if (roofImagesRefs) db.roofImages,
                    if (roofPlanesRefs) db.roofPlanes,
                    if (obstaclesRefs) db.obstacles,
                    if (horizonProfilesRefs) db.horizonProfiles,
                    if (pvDesignsRefs) db.pvDesigns,
                    if (arrayLayoutsRefs) db.arrayLayouts,
                    if (stringConfigsRefs) db.stringConfigs,
                    if (electricalRunsRefs) db.electricalRuns,
                    if (protectionDevicesRefs) db.protectionDevices,
                    if (simulationResultsRefs) db.simulationResults,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.clientId,
                            referencedTable: $$ProjectsTableReferences
                                ._clientIdTable(db),
                            referencedColumn: $$ProjectsTableReferences
                                ._clientIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (sitesRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          Site,
                          $SitesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._sitesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).sitesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (photosRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          Photo,
                          $PhotosTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._photosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).photosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (documentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          Document,
                          $DocumentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._documentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).documentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (roofImagesRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          RoofImage,
                          $RoofImagesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._roofImagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).roofImagesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (roofPlanesRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          RoofPlane,
                          $RoofPlanesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._roofPlanesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).roofPlanesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (obstaclesRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          Obstacle,
                          $ObstaclesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._obstaclesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).obstaclesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (horizonProfilesRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          HorizonProfileRecord,
                          $HorizonProfilesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._horizonProfilesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).horizonProfilesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (pvDesignsRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          PvDesign,
                          $PvDesignsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._pvDesignsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).pvDesignsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (arrayLayoutsRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          ArrayLayout,
                          $ArrayLayoutsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._arrayLayoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).arrayLayoutsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (stringConfigsRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          StringConfig,
                          $StringConfigsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._stringConfigsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).stringConfigsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (electricalRunsRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          ElectricalRun,
                          $ElectricalRunsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._electricalRunsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).electricalRunsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (protectionDevicesRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          ProtectionDevice,
                          $ProtectionDevicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._protectionDevicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).protectionDevicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                      if (simulationResultsRefs)
                        await $_getPrefetchedDataByColumns<
                          Project,
                          $ProjectsTable,
                          SimulationResultRecord,
                          $SimulationResultsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProjectsTableReferences
                              ._simulationResultsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProjectsTableReferences(
                                db,
                                table,
                                p0,
                              ).simulationResultsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'project_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProjectsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProjectsTable,
      Project,
      $$ProjectsTableFilterComposer,
      $$ProjectsTableOrderingComposer,
      $$ProjectsTableAnnotationComposer,
      $$ProjectsTableCreateCompanionBuilder,
      $$ProjectsTableUpdateCompanionBuilder,
      (Project, $$ProjectsTableReferences),
      Project,
      PrefetchHooks Function({
        bool clientId,
        bool sitesRefs,
        bool photosRefs,
        bool documentsRefs,
        bool roofImagesRefs,
        bool roofPlanesRefs,
        bool obstaclesRefs,
        bool horizonProfilesRefs,
        bool pvDesignsRefs,
        bool arrayLayoutsRefs,
        bool stringConfigsRefs,
        bool electricalRunsRefs,
        bool protectionDevicesRefs,
        bool simulationResultsRefs,
      })
    >;
typedef $$SitesTableCreateCompanionBuilder = SitesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  required double latitude,
  required double longitude,
  Value<double?> altitudeM,
  Value<String?> timeZone,
  required LocationSource source,
  Value<String?> sourceText,
  Value<double?> accuracyM,
  Value<int> rowid,
});
typedef $$SitesTableUpdateCompanionBuilder = SitesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<double> latitude,
  Value<double> longitude,
  Value<double?> altitudeM,
  Value<String?> timeZone,
  Value<LocationSource> source,
  Value<String?> sourceText,
  Value<double?> accuracyM,
  Value<int> rowid,
});

final class $$SitesTableReferences
    extends BaseReferences<_$AppDatabase, $SitesTable, Site> {
  $$SitesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('sites__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SitesTableFilterComposer extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LocationSource, LocationSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SitesTableOrderingComposer
    extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeZone => $composableBuilder(
    column: $table.timeZone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SitesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SitesTable> {
  $$SitesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get altitudeM =>
      $composableBuilder(column: $table.altitudeM, builder: (column) => column);

  GeneratedColumn<String> get timeZone =>
      $composableBuilder(column: $table.timeZone, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocationSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceText => $composableBuilder(
    column: $table.sourceText,
    builder: (column) => column,
  );

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SitesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SitesTable,
          Site,
          $$SitesTableFilterComposer,
          $$SitesTableOrderingComposer,
          $$SitesTableAnnotationComposer,
          $$SitesTableCreateCompanionBuilder,
          $$SitesTableUpdateCompanionBuilder,
          (Site, $$SitesTableReferences),
          Site,
          PrefetchHooks Function({bool projectId})
        > {
  $$SitesTableTableManager(_$AppDatabase db, $SitesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SitesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SitesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SitesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<double> latitude = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double?> altitudeM = const Value.absent(),
                Value<String?> timeZone = const Value.absent(),
                Value<LocationSource> source = const Value.absent(),
                Value<String?> sourceText = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SitesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                latitude: latitude,
                longitude: longitude,
                altitudeM: altitudeM,
                timeZone: timeZone,
                source: source,
                sourceText: sourceText,
                accuracyM: accuracyM,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required double latitude,
                required double longitude,
                Value<double?> altitudeM = const Value.absent(),
                Value<String?> timeZone = const Value.absent(),
                required LocationSource source,
                Value<String?> sourceText = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SitesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                latitude: latitude,
                longitude: longitude,
                altitudeM: altitudeM,
                timeZone: timeZone,
                source: source,
                sourceText: sourceText,
                accuracyM: accuracyM,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SitesTable, Site>(table),
                  $$SitesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$SitesTableReferences._projectIdTable(
                          db,
                        ),
                        referencedColumn: $$SitesTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$SitesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SitesTable,
      Site,
      $$SitesTableFilterComposer,
      $$SitesTableOrderingComposer,
      $$SitesTableAnnotationComposer,
      $$SitesTableCreateCompanionBuilder,
      $$SitesTableUpdateCompanionBuilder,
      (Site, $$SitesTableReferences),
      Site,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$UtilityBillsTableCreateCompanionBuilder =
    UtilityBillsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String clientId,
      required DateTime periodStart,
      required DateTime periodEnd,
      required BillingPeriod billingPeriod,
      required double energyKwh,
      Value<int?> amountCents,
      Value<String> currency,
      Value<String?> tariffCode,
      Value<int> rowid,
    });
typedef $$UtilityBillsTableUpdateCompanionBuilder =
    UtilityBillsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> clientId,
      Value<DateTime> periodStart,
      Value<DateTime> periodEnd,
      Value<BillingPeriod> billingPeriod,
      Value<double> energyKwh,
      Value<int?> amountCents,
      Value<String> currency,
      Value<String?> tariffCode,
      Value<int> rowid,
    });

final class $$UtilityBillsTableReferences
    extends BaseReferences<_$AppDatabase, $UtilityBillsTable, UtilityBill> {
  $$UtilityBillsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientsTable _clientIdTable(_$AppDatabase db) =>
      db.clients.createAlias('utility_bills__client_id__clients__id');

  $$ClientsTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientsTableTableManager(
      $_db,
      $_db.clients,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UtilityBillsTableFilterComposer
    extends Composer<_$AppDatabase, $UtilityBillsTable> {
  $$UtilityBillsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BillingPeriod, BillingPeriod, String>
  get billingPeriod => $composableBuilder(
    column: $table.billingPeriod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get energyKwh => $composableBuilder(
    column: $table.energyKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tariffCode => $composableBuilder(
    column: $table.tariffCode,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientsTableFilterComposer get clientId {
    final $$ClientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableFilterComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilityBillsTableOrderingComposer
    extends Composer<_$AppDatabase, $UtilityBillsTable> {
  $$UtilityBillsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get periodEnd => $composableBuilder(
    column: $table.periodEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get billingPeriod => $composableBuilder(
    column: $table.billingPeriod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get energyKwh => $composableBuilder(
    column: $table.energyKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tariffCode => $composableBuilder(
    column: $table.tariffCode,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientsTableOrderingComposer get clientId {
    final $$ClientsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableOrderingComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilityBillsTableAnnotationComposer
    extends Composer<_$AppDatabase, $UtilityBillsTable> {
  $$UtilityBillsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get periodStart => $composableBuilder(
    column: $table.periodStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get periodEnd =>
      $composableBuilder(column: $table.periodEnd, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BillingPeriod, String> get billingPeriod =>
      $composableBuilder(
        column: $table.billingPeriod,
        builder: (column) => column,
      );

  GeneratedColumn<double> get energyKwh =>
      $composableBuilder(column: $table.energyKwh, builder: (column) => column);

  GeneratedColumn<int> get amountCents => $composableBuilder(
    column: $table.amountCents,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get tariffCode => $composableBuilder(
    column: $table.tariffCode,
    builder: (column) => column,
  );

  $$ClientsTableAnnotationComposer get clientId {
    final $$ClientsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clients,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientsTableAnnotationComposer(
            $db: $db,
            $table: $db.clients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UtilityBillsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UtilityBillsTable,
          UtilityBill,
          $$UtilityBillsTableFilterComposer,
          $$UtilityBillsTableOrderingComposer,
          $$UtilityBillsTableAnnotationComposer,
          $$UtilityBillsTableCreateCompanionBuilder,
          $$UtilityBillsTableUpdateCompanionBuilder,
          (UtilityBill, $$UtilityBillsTableReferences),
          UtilityBill,
          PrefetchHooks Function({bool clientId})
        > {
  $$UtilityBillsTableTableManager(_$AppDatabase db, $UtilityBillsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UtilityBillsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UtilityBillsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UtilityBillsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<DateTime> periodStart = const Value.absent(),
                Value<DateTime> periodEnd = const Value.absent(),
                Value<BillingPeriod> billingPeriod = const Value.absent(),
                Value<double> energyKwh = const Value.absent(),
                Value<int?> amountCents = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> tariffCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilityBillsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                periodStart: periodStart,
                periodEnd: periodEnd,
                billingPeriod: billingPeriod,
                energyKwh: energyKwh,
                amountCents: amountCents,
                currency: currency,
                tariffCode: tariffCode,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String clientId,
                required DateTime periodStart,
                required DateTime periodEnd,
                required BillingPeriod billingPeriod,
                required double energyKwh,
                Value<int?> amountCents = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> tariffCode = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UtilityBillsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                clientId: clientId,
                periodStart: periodStart,
                periodEnd: periodEnd,
                billingPeriod: billingPeriod,
                energyKwh: energyKwh,
                amountCents: amountCents,
                currency: currency,
                tariffCode: tariffCode,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UtilityBillsTable, UtilityBill>(table),
                  $$UtilityBillsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clientId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (clientId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.clientId,
                        referencedTable: $$UtilityBillsTableReferences
                            ._clientIdTable(db),
                        referencedColumn: $$UtilityBillsTableReferences
                            ._clientIdTable(db)
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
        ),
      );
}

typedef $$UtilityBillsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UtilityBillsTable,
      UtilityBill,
      $$UtilityBillsTableFilterComposer,
      $$UtilityBillsTableOrderingComposer,
      $$UtilityBillsTableAnnotationComposer,
      $$UtilityBillsTableCreateCompanionBuilder,
      $$UtilityBillsTableUpdateCompanionBuilder,
      (UtilityBill, $$UtilityBillsTableReferences),
      UtilityBill,
      PrefetchHooks Function({bool clientId})
    >;
typedef $$PhotosTableCreateCompanionBuilder = PhotosCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  required PhotoStage stage,
  required String filePath,
  required String sha256,
  required int widthPx,
  required int heightPx,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<DateTime?> takenAt,
  Value<String?> caption,
  Value<int> rowid,
});
typedef $$PhotosTableUpdateCompanionBuilder = PhotosCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<PhotoStage> stage,
  Value<String> filePath,
  Value<String> sha256,
  Value<int> widthPx,
  Value<int> heightPx,
  Value<double?> latitude,
  Value<double?> longitude,
  Value<DateTime?> takenAt,
  Value<String?> caption,
  Value<int> rowid,
});

final class $$PhotosTableReferences
    extends BaseReferences<_$AppDatabase, $PhotosTable, Photo> {
  $$PhotosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('photos__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhotosTableFilterComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PhotoStage, PhotoStage, String> get stage =>
      $composableBuilder(
        column: $table.stage,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get widthPx => $composableBuilder(
    column: $table.widthPx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heightPx => $composableBuilder(
    column: $table.heightPx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stage => $composableBuilder(
    column: $table.stage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get widthPx => $composableBuilder(
    column: $table.widthPx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heightPx => $composableBuilder(
    column: $table.heightPx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get caption => $composableBuilder(
    column: $table.caption,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotosTable> {
  $$PhotosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PhotoStage, String> get stage =>
      $composableBuilder(column: $table.stage, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get widthPx =>
      $composableBuilder(column: $table.widthPx, builder: (column) => column);

  GeneratedColumn<int> get heightPx =>
      $composableBuilder(column: $table.heightPx, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  GeneratedColumn<String> get caption =>
      $composableBuilder(column: $table.caption, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhotosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhotosTable,
          Photo,
          $$PhotosTableFilterComposer,
          $$PhotosTableOrderingComposer,
          $$PhotosTableAnnotationComposer,
          $$PhotosTableCreateCompanionBuilder,
          $$PhotosTableUpdateCompanionBuilder,
          (Photo, $$PhotosTableReferences),
          Photo,
          PrefetchHooks Function({bool projectId})
        > {
  $$PhotosTableTableManager(_$AppDatabase db, $PhotosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<PhotoStage> stage = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> widthPx = const Value.absent(),
                Value<int> heightPx = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> takenAt = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                stage: stage,
                filePath: filePath,
                sha256: sha256,
                widthPx: widthPx,
                heightPx: heightPx,
                latitude: latitude,
                longitude: longitude,
                takenAt: takenAt,
                caption: caption,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required PhotoStage stage,
                required String filePath,
                required String sha256,
                required int widthPx,
                required int heightPx,
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<DateTime?> takenAt = const Value.absent(),
                Value<String?> caption = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PhotosCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                stage: stage,
                filePath: filePath,
                sha256: sha256,
                widthPx: widthPx,
                heightPx: heightPx,
                latitude: latitude,
                longitude: longitude,
                takenAt: takenAt,
                caption: caption,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhotosTable, Photo>(table),
                  $$PhotosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$PhotosTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$PhotosTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$PhotosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhotosTable,
      Photo,
      $$PhotosTableFilterComposer,
      $$PhotosTableOrderingComposer,
      $$PhotosTableAnnotationComposer,
      $$PhotosTableCreateCompanionBuilder,
      $$PhotosTableUpdateCompanionBuilder,
      (Photo, $$PhotosTableReferences),
      Photo,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$DocumentsTableCreateCompanionBuilder = DocumentsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  required String title,
  required DocumentKind kind,
  required String filePath,
  required String mimeType,
  required int sizeBytes,
  required String sha256,
  Value<int> rowid,
});
typedef $$DocumentsTableUpdateCompanionBuilder = DocumentsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<String> title,
  Value<DocumentKind> kind,
  Value<String> filePath,
  Value<String> mimeType,
  Value<int> sizeBytes,
  Value<String> sha256,
  Value<int> rowid,
});

final class $$DocumentsTableReferences
    extends BaseReferences<_$AppDatabase, $DocumentsTable, Document> {
  $$DocumentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('documents__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumentsTableFilterComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DocumentKind, DocumentKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumentsTable> {
  $$DocumentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DocumentKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumentsTable,
          Document,
          $$DocumentsTableFilterComposer,
          $$DocumentsTableOrderingComposer,
          $$DocumentsTableAnnotationComposer,
          $$DocumentsTableCreateCompanionBuilder,
          $$DocumentsTableUpdateCompanionBuilder,
          (Document, $$DocumentsTableReferences),
          Document,
          PrefetchHooks Function({bool projectId})
        > {
  $$DocumentsTableTableManager(_$AppDatabase db, $DocumentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DocumentKind> kind = const Value.absent(),
                Value<String> filePath = const Value.absent(),
                Value<String> mimeType = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                title: title,
                kind: kind,
                filePath: filePath,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                sha256: sha256,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required String title,
                required DocumentKind kind,
                required String filePath,
                required String mimeType,
                required int sizeBytes,
                required String sha256,
                Value<int> rowid = const Value.absent(),
              }) => DocumentsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                title: title,
                kind: kind,
                filePath: filePath,
                mimeType: mimeType,
                sizeBytes: sizeBytes,
                sha256: sha256,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DocumentsTable, Document>(table),
                  $$DocumentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$DocumentsTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$DocumentsTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$DocumentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumentsTable,
      Document,
      $$DocumentsTableFilterComposer,
      $$DocumentsTableOrderingComposer,
      $$DocumentsTableAnnotationComposer,
      $$DocumentsTableCreateCompanionBuilder,
      $$DocumentsTableUpdateCompanionBuilder,
      (Document, $$DocumentsTableReferences),
      Document,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$RoofImagesTableCreateCompanionBuilder = RoofImagesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  required RoofMode mode,
  Value<String?> filePath,
  Value<String?> sha256,
  Value<int?> widthPx,
  Value<int?> heightPx,
  Value<double?> metersPerPixel,
  Value<String?> calibrationLine,
  Value<String?> verificationLine,
  Value<double> northAngleDeg,
  Value<NorthSource> northSource,
  Value<double?> magneticDeclinationDeg,
  Value<int> rowid,
});
typedef $$RoofImagesTableUpdateCompanionBuilder = RoofImagesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<RoofMode> mode,
  Value<String?> filePath,
  Value<String?> sha256,
  Value<int?> widthPx,
  Value<int?> heightPx,
  Value<double?> metersPerPixel,
  Value<String?> calibrationLine,
  Value<String?> verificationLine,
  Value<double> northAngleDeg,
  Value<NorthSource> northSource,
  Value<double?> magneticDeclinationDeg,
  Value<int> rowid,
});

final class $$RoofImagesTableReferences
    extends BaseReferences<_$AppDatabase, $RoofImagesTable, RoofImage> {
  $$RoofImagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('roof_images__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RoofImagesTableFilterComposer
    extends Composer<_$AppDatabase, $RoofImagesTable> {
  $$RoofImagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RoofMode, RoofMode, String> get mode =>
      $composableBuilder(
        column: $table.mode,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get widthPx => $composableBuilder(
    column: $table.widthPx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heightPx => $composableBuilder(
    column: $table.heightPx,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get metersPerPixel => $composableBuilder(
    column: $table.metersPerPixel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get calibrationLine => $composableBuilder(
    column: $table.calibrationLine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationLine => $composableBuilder(
    column: $table.verificationLine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get northAngleDeg => $composableBuilder(
    column: $table.northAngleDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NorthSource, NorthSource, String>
  get northSource => $composableBuilder(
    column: $table.northSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get magneticDeclinationDeg => $composableBuilder(
    column: $table.magneticDeclinationDeg,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoofImagesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoofImagesTable> {
  $$RoofImagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mode => $composableBuilder(
    column: $table.mode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get filePath => $composableBuilder(
    column: $table.filePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get widthPx => $composableBuilder(
    column: $table.widthPx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heightPx => $composableBuilder(
    column: $table.heightPx,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get metersPerPixel => $composableBuilder(
    column: $table.metersPerPixel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get calibrationLine => $composableBuilder(
    column: $table.calibrationLine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationLine => $composableBuilder(
    column: $table.verificationLine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get northAngleDeg => $composableBuilder(
    column: $table.northAngleDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get northSource => $composableBuilder(
    column: $table.northSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get magneticDeclinationDeg => $composableBuilder(
    column: $table.magneticDeclinationDeg,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoofImagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoofImagesTable> {
  $$RoofImagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RoofMode, String> get mode =>
      $composableBuilder(column: $table.mode, builder: (column) => column);

  GeneratedColumn<String> get filePath =>
      $composableBuilder(column: $table.filePath, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get widthPx =>
      $composableBuilder(column: $table.widthPx, builder: (column) => column);

  GeneratedColumn<int> get heightPx =>
      $composableBuilder(column: $table.heightPx, builder: (column) => column);

  GeneratedColumn<double> get metersPerPixel => $composableBuilder(
    column: $table.metersPerPixel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get calibrationLine => $composableBuilder(
    column: $table.calibrationLine,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verificationLine => $composableBuilder(
    column: $table.verificationLine,
    builder: (column) => column,
  );

  GeneratedColumn<double> get northAngleDeg => $composableBuilder(
    column: $table.northAngleDeg,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<NorthSource, String> get northSource =>
      $composableBuilder(
        column: $table.northSource,
        builder: (column) => column,
      );

  GeneratedColumn<double> get magneticDeclinationDeg => $composableBuilder(
    column: $table.magneticDeclinationDeg,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoofImagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoofImagesTable,
          RoofImage,
          $$RoofImagesTableFilterComposer,
          $$RoofImagesTableOrderingComposer,
          $$RoofImagesTableAnnotationComposer,
          $$RoofImagesTableCreateCompanionBuilder,
          $$RoofImagesTableUpdateCompanionBuilder,
          (RoofImage, $$RoofImagesTableReferences),
          RoofImage,
          PrefetchHooks Function({bool projectId})
        > {
  $$RoofImagesTableTableManager(_$AppDatabase db, $RoofImagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoofImagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoofImagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoofImagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<RoofMode> mode = const Value.absent(),
                Value<String?> filePath = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<int?> widthPx = const Value.absent(),
                Value<int?> heightPx = const Value.absent(),
                Value<double?> metersPerPixel = const Value.absent(),
                Value<String?> calibrationLine = const Value.absent(),
                Value<String?> verificationLine = const Value.absent(),
                Value<double> northAngleDeg = const Value.absent(),
                Value<NorthSource> northSource = const Value.absent(),
                Value<double?> magneticDeclinationDeg = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoofImagesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                mode: mode,
                filePath: filePath,
                sha256: sha256,
                widthPx: widthPx,
                heightPx: heightPx,
                metersPerPixel: metersPerPixel,
                calibrationLine: calibrationLine,
                verificationLine: verificationLine,
                northAngleDeg: northAngleDeg,
                northSource: northSource,
                magneticDeclinationDeg: magneticDeclinationDeg,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required RoofMode mode,
                Value<String?> filePath = const Value.absent(),
                Value<String?> sha256 = const Value.absent(),
                Value<int?> widthPx = const Value.absent(),
                Value<int?> heightPx = const Value.absent(),
                Value<double?> metersPerPixel = const Value.absent(),
                Value<String?> calibrationLine = const Value.absent(),
                Value<String?> verificationLine = const Value.absent(),
                Value<double> northAngleDeg = const Value.absent(),
                Value<NorthSource> northSource = const Value.absent(),
                Value<double?> magneticDeclinationDeg = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoofImagesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                mode: mode,
                filePath: filePath,
                sha256: sha256,
                widthPx: widthPx,
                heightPx: heightPx,
                metersPerPixel: metersPerPixel,
                calibrationLine: calibrationLine,
                verificationLine: verificationLine,
                northAngleDeg: northAngleDeg,
                northSource: northSource,
                magneticDeclinationDeg: magneticDeclinationDeg,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoofImagesTable, RoofImage>(table),
                  $$RoofImagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$RoofImagesTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$RoofImagesTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$RoofImagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoofImagesTable,
      RoofImage,
      $$RoofImagesTableFilterComposer,
      $$RoofImagesTableOrderingComposer,
      $$RoofImagesTableAnnotationComposer,
      $$RoofImagesTableCreateCompanionBuilder,
      $$RoofImagesTableUpdateCompanionBuilder,
      (RoofImage, $$RoofImagesTableReferences),
      RoofImage,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$RoofPlanesTableCreateCompanionBuilder = RoofPlanesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  required String name,
  required String polygon,
  Value<double> tiltDeg,
  Value<TiltSource> tiltSource,
  Value<double> azimuthDeg,
  Value<int?> azimuthEdgeIndex,
  Value<double> edgeSetbackM,
  Value<String> walkways,
  Value<int> sortOrder,
  Value<int> rowid,
});
typedef $$RoofPlanesTableUpdateCompanionBuilder = RoofPlanesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<String> name,
  Value<String> polygon,
  Value<double> tiltDeg,
  Value<TiltSource> tiltSource,
  Value<double> azimuthDeg,
  Value<int?> azimuthEdgeIndex,
  Value<double> edgeSetbackM,
  Value<String> walkways,
  Value<int> sortOrder,
  Value<int> rowid,
});

final class $$RoofPlanesTableReferences
    extends BaseReferences<_$AppDatabase, $RoofPlanesTable, RoofPlane> {
  $$RoofPlanesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('roof_planes__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ArrayLayoutsTable, List<ArrayLayout>>
  _arrayLayoutsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.arrayLayouts,
    aliasName: 'roof_planes__id__array_layouts__roof_plane_id',
  );

  $$ArrayLayoutsTableProcessedTableManager get arrayLayoutsRefs {
    final manager = $$ArrayLayoutsTableTableManager(
      $_db,
      $_db.arrayLayouts,
    ).filter((f) => f.roofPlaneId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_arrayLayoutsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RoofPlanesTableFilterComposer
    extends Composer<_$AppDatabase, $RoofPlanesTable> {
  $$RoofPlanesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get polygon => $composableBuilder(
    column: $table.polygon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tiltDeg => $composableBuilder(
    column: $table.tiltDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TiltSource, TiltSource, String>
  get tiltSource => $composableBuilder(
    column: $table.tiltSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get azimuthDeg => $composableBuilder(
    column: $table.azimuthDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get azimuthEdgeIndex => $composableBuilder(
    column: $table.azimuthEdgeIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get edgeSetbackM => $composableBuilder(
    column: $table.edgeSetbackM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get walkways => $composableBuilder(
    column: $table.walkways,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> arrayLayoutsRefs(
    Expression<bool> Function($$ArrayLayoutsTableFilterComposer f) f,
  ) {
    final $$ArrayLayoutsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.arrayLayouts,
      getReferencedColumn: (t) => t.roofPlaneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArrayLayoutsTableFilterComposer(
            $db: $db,
            $table: $db.arrayLayouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoofPlanesTableOrderingComposer
    extends Composer<_$AppDatabase, $RoofPlanesTable> {
  $$RoofPlanesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get polygon => $composableBuilder(
    column: $table.polygon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tiltDeg => $composableBuilder(
    column: $table.tiltDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tiltSource => $composableBuilder(
    column: $table.tiltSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get azimuthDeg => $composableBuilder(
    column: $table.azimuthDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get azimuthEdgeIndex => $composableBuilder(
    column: $table.azimuthEdgeIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get edgeSetbackM => $composableBuilder(
    column: $table.edgeSetbackM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get walkways => $composableBuilder(
    column: $table.walkways,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RoofPlanesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RoofPlanesTable> {
  $$RoofPlanesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get polygon =>
      $composableBuilder(column: $table.polygon, builder: (column) => column);

  GeneratedColumn<double> get tiltDeg =>
      $composableBuilder(column: $table.tiltDeg, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TiltSource, String> get tiltSource =>
      $composableBuilder(
        column: $table.tiltSource,
        builder: (column) => column,
      );

  GeneratedColumn<double> get azimuthDeg => $composableBuilder(
    column: $table.azimuthDeg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get azimuthEdgeIndex => $composableBuilder(
    column: $table.azimuthEdgeIndex,
    builder: (column) => column,
  );

  GeneratedColumn<double> get edgeSetbackM => $composableBuilder(
    column: $table.edgeSetbackM,
    builder: (column) => column,
  );

  GeneratedColumn<String> get walkways =>
      $composableBuilder(column: $table.walkways, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> arrayLayoutsRefs<T extends Object>(
    Expression<T> Function($$ArrayLayoutsTableAnnotationComposer a) f,
  ) {
    final $$ArrayLayoutsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.arrayLayouts,
      getReferencedColumn: (t) => t.roofPlaneId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArrayLayoutsTableAnnotationComposer(
            $db: $db,
            $table: $db.arrayLayouts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RoofPlanesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RoofPlanesTable,
          RoofPlane,
          $$RoofPlanesTableFilterComposer,
          $$RoofPlanesTableOrderingComposer,
          $$RoofPlanesTableAnnotationComposer,
          $$RoofPlanesTableCreateCompanionBuilder,
          $$RoofPlanesTableUpdateCompanionBuilder,
          (RoofPlane, $$RoofPlanesTableReferences),
          RoofPlane,
          PrefetchHooks Function({bool projectId, bool arrayLayoutsRefs})
        > {
  $$RoofPlanesTableTableManager(_$AppDatabase db, $RoofPlanesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RoofPlanesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RoofPlanesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RoofPlanesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> polygon = const Value.absent(),
                Value<double> tiltDeg = const Value.absent(),
                Value<TiltSource> tiltSource = const Value.absent(),
                Value<double> azimuthDeg = const Value.absent(),
                Value<int?> azimuthEdgeIndex = const Value.absent(),
                Value<double> edgeSetbackM = const Value.absent(),
                Value<String> walkways = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoofPlanesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                name: name,
                polygon: polygon,
                tiltDeg: tiltDeg,
                tiltSource: tiltSource,
                azimuthDeg: azimuthDeg,
                azimuthEdgeIndex: azimuthEdgeIndex,
                edgeSetbackM: edgeSetbackM,
                walkways: walkways,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required String name,
                required String polygon,
                Value<double> tiltDeg = const Value.absent(),
                Value<TiltSource> tiltSource = const Value.absent(),
                Value<double> azimuthDeg = const Value.absent(),
                Value<int?> azimuthEdgeIndex = const Value.absent(),
                Value<double> edgeSetbackM = const Value.absent(),
                Value<String> walkways = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RoofPlanesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                name: name,
                polygon: polygon,
                tiltDeg: tiltDeg,
                tiltSource: tiltSource,
                azimuthDeg: azimuthDeg,
                azimuthEdgeIndex: azimuthEdgeIndex,
                edgeSetbackM: edgeSetbackM,
                walkways: walkways,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RoofPlanesTable, RoofPlane>(table),
                  $$RoofPlanesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({projectId = false, arrayLayoutsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (arrayLayoutsRefs) db.arrayLayouts,
                  ],
                  addJoins:
                      <
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
                          dynamic
                        >
                      >(state) {
                        if (projectId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.projectId,
                            referencedTable: $$RoofPlanesTableReferences
                                ._projectIdTable(db),
                            referencedColumn: $$RoofPlanesTableReferences
                                ._projectIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (arrayLayoutsRefs)
                        await $_getPrefetchedDataByColumns<
                          RoofPlane,
                          $RoofPlanesTable,
                          ArrayLayout,
                          $ArrayLayoutsTable
                        >(
                          currentTable: table,
                          referencedTable: $$RoofPlanesTableReferences
                              ._arrayLayoutsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RoofPlanesTableReferences(
                                db,
                                table,
                                p0,
                              ).arrayLayoutsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'roof_plane_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RoofPlanesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RoofPlanesTable,
      RoofPlane,
      $$RoofPlanesTableFilterComposer,
      $$RoofPlanesTableOrderingComposer,
      $$RoofPlanesTableAnnotationComposer,
      $$RoofPlanesTableCreateCompanionBuilder,
      $$RoofPlanesTableUpdateCompanionBuilder,
      (RoofPlane, $$RoofPlanesTableReferences),
      RoofPlane,
      PrefetchHooks Function({bool projectId, bool arrayLayoutsRefs})
    >;
typedef $$ObstaclesTableCreateCompanionBuilder = ObstaclesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  required ObstacleKind kind,
  required ObstacleOutline outline,
  Value<double> centerX,
  Value<double> centerY,
  required double widthM,
  Value<double?> depthM,
  Value<double> rotationDeg,
  Value<String?> points,
  required double heightM,
  required HeightSource heightSource,
  Value<int?> tankLiters,
  Value<String?> label,
  Value<int> rowid,
});
typedef $$ObstaclesTableUpdateCompanionBuilder = ObstaclesCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<ObstacleKind> kind,
  Value<ObstacleOutline> outline,
  Value<double> centerX,
  Value<double> centerY,
  Value<double> widthM,
  Value<double?> depthM,
  Value<double> rotationDeg,
  Value<String?> points,
  Value<double> heightM,
  Value<HeightSource> heightSource,
  Value<int?> tankLiters,
  Value<String?> label,
  Value<int> rowid,
});

final class $$ObstaclesTableReferences
    extends BaseReferences<_$AppDatabase, $ObstaclesTable, Obstacle> {
  $$ObstaclesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('obstacles__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ObstaclesTableFilterComposer
    extends Composer<_$AppDatabase, $ObstaclesTable> {
  $$ObstaclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ObstacleKind, ObstacleKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ObstacleOutline, ObstacleOutline, String>
  get outline => $composableBuilder(
    column: $table.outline,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get centerX => $composableBuilder(
    column: $table.centerX,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get centerY => $composableBuilder(
    column: $table.centerY,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get widthM => $composableBuilder(
    column: $table.widthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get depthM => $composableBuilder(
    column: $table.depthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rotationDeg => $composableBuilder(
    column: $table.rotationDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightM => $composableBuilder(
    column: $table.heightM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HeightSource, HeightSource, String>
  get heightSource => $composableBuilder(
    column: $table.heightSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get tankLiters => $composableBuilder(
    column: $table.tankLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObstaclesTableOrderingComposer
    extends Composer<_$AppDatabase, $ObstaclesTable> {
  $$ObstaclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get outline => $composableBuilder(
    column: $table.outline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centerX => $composableBuilder(
    column: $table.centerX,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get centerY => $composableBuilder(
    column: $table.centerY,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get widthM => $composableBuilder(
    column: $table.widthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get depthM => $composableBuilder(
    column: $table.depthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rotationDeg => $composableBuilder(
    column: $table.rotationDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightM => $composableBuilder(
    column: $table.heightM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heightSource => $composableBuilder(
    column: $table.heightSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tankLiters => $composableBuilder(
    column: $table.tankLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObstaclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObstaclesTable> {
  $$ObstaclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ObstacleKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ObstacleOutline, String> get outline =>
      $composableBuilder(column: $table.outline, builder: (column) => column);

  GeneratedColumn<double> get centerX =>
      $composableBuilder(column: $table.centerX, builder: (column) => column);

  GeneratedColumn<double> get centerY =>
      $composableBuilder(column: $table.centerY, builder: (column) => column);

  GeneratedColumn<double> get widthM =>
      $composableBuilder(column: $table.widthM, builder: (column) => column);

  GeneratedColumn<double> get depthM =>
      $composableBuilder(column: $table.depthM, builder: (column) => column);

  GeneratedColumn<double> get rotationDeg => $composableBuilder(
    column: $table.rotationDeg,
    builder: (column) => column,
  );

  GeneratedColumn<String> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<double> get heightM =>
      $composableBuilder(column: $table.heightM, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HeightSource, String> get heightSource =>
      $composableBuilder(
        column: $table.heightSource,
        builder: (column) => column,
      );

  GeneratedColumn<int> get tankLiters => $composableBuilder(
    column: $table.tankLiters,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObstaclesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObstaclesTable,
          Obstacle,
          $$ObstaclesTableFilterComposer,
          $$ObstaclesTableOrderingComposer,
          $$ObstaclesTableAnnotationComposer,
          $$ObstaclesTableCreateCompanionBuilder,
          $$ObstaclesTableUpdateCompanionBuilder,
          (Obstacle, $$ObstaclesTableReferences),
          Obstacle,
          PrefetchHooks Function({bool projectId})
        > {
  $$ObstaclesTableTableManager(_$AppDatabase db, $ObstaclesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObstaclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObstaclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ObstaclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<ObstacleKind> kind = const Value.absent(),
                Value<ObstacleOutline> outline = const Value.absent(),
                Value<double> centerX = const Value.absent(),
                Value<double> centerY = const Value.absent(),
                Value<double> widthM = const Value.absent(),
                Value<double?> depthM = const Value.absent(),
                Value<double> rotationDeg = const Value.absent(),
                Value<String?> points = const Value.absent(),
                Value<double> heightM = const Value.absent(),
                Value<HeightSource> heightSource = const Value.absent(),
                Value<int?> tankLiters = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObstaclesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                kind: kind,
                outline: outline,
                centerX: centerX,
                centerY: centerY,
                widthM: widthM,
                depthM: depthM,
                rotationDeg: rotationDeg,
                points: points,
                heightM: heightM,
                heightSource: heightSource,
                tankLiters: tankLiters,
                label: label,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required ObstacleKind kind,
                required ObstacleOutline outline,
                Value<double> centerX = const Value.absent(),
                Value<double> centerY = const Value.absent(),
                required double widthM,
                Value<double?> depthM = const Value.absent(),
                Value<double> rotationDeg = const Value.absent(),
                Value<String?> points = const Value.absent(),
                required double heightM,
                required HeightSource heightSource,
                Value<int?> tankLiters = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObstaclesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                kind: kind,
                outline: outline,
                centerX: centerX,
                centerY: centerY,
                widthM: widthM,
                depthM: depthM,
                rotationDeg: rotationDeg,
                points: points,
                heightM: heightM,
                heightSource: heightSource,
                tankLiters: tankLiters,
                label: label,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ObstaclesTable, Obstacle>(table),
                  $$ObstaclesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$ObstaclesTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$ObstaclesTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$ObstaclesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObstaclesTable,
      Obstacle,
      $$ObstaclesTableFilterComposer,
      $$ObstaclesTableOrderingComposer,
      $$ObstaclesTableAnnotationComposer,
      $$ObstaclesTableCreateCompanionBuilder,
      $$ObstaclesTableUpdateCompanionBuilder,
      (Obstacle, $$ObstaclesTableReferences),
      Obstacle,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$HorizonProfilesTableCreateCompanionBuilder =
    HorizonProfilesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String projectId,
      required HorizonSource source,
      Value<String?> name,
      required String points,
      Value<int> rowid,
    });
typedef $$HorizonProfilesTableUpdateCompanionBuilder =
    HorizonProfilesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> projectId,
      Value<HorizonSource> source,
      Value<String?> name,
      Value<String> points,
      Value<int> rowid,
    });

final class $$HorizonProfilesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $HorizonProfilesTable,
          HorizonProfileRecord
        > {
  $$HorizonProfilesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('horizon_profiles__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HorizonProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $HorizonProfilesTable> {
  $$HorizonProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<HorizonSource, HorizonSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorizonProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $HorizonProfilesTable> {
  $$HorizonProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorizonProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $HorizonProfilesTable> {
  $$HorizonProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<HorizonSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HorizonProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HorizonProfilesTable,
          HorizonProfileRecord,
          $$HorizonProfilesTableFilterComposer,
          $$HorizonProfilesTableOrderingComposer,
          $$HorizonProfilesTableAnnotationComposer,
          $$HorizonProfilesTableCreateCompanionBuilder,
          $$HorizonProfilesTableUpdateCompanionBuilder,
          (HorizonProfileRecord, $$HorizonProfilesTableReferences),
          HorizonProfileRecord,
          PrefetchHooks Function({bool projectId})
        > {
  $$HorizonProfilesTableTableManager(
    _$AppDatabase db,
    $HorizonProfilesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HorizonProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HorizonProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HorizonProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<HorizonSource> source = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> points = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HorizonProfilesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                source: source,
                name: name,
                points: points,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required HorizonSource source,
                Value<String?> name = const Value.absent(),
                required String points,
                Value<int> rowid = const Value.absent(),
              }) => HorizonProfilesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                source: source,
                name: name,
                points: points,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HorizonProfilesTable, HorizonProfileRecord>(
                    table,
                  ),
                  $$HorizonProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$HorizonProfilesTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$HorizonProfilesTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$HorizonProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HorizonProfilesTable,
      HorizonProfileRecord,
      $$HorizonProfilesTableFilterComposer,
      $$HorizonProfilesTableOrderingComposer,
      $$HorizonProfilesTableAnnotationComposer,
      $$HorizonProfilesTableCreateCompanionBuilder,
      $$HorizonProfilesTableUpdateCompanionBuilder,
      (HorizonProfileRecord, $$HorizonProfilesTableReferences),
      HorizonProfileRecord,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$PanelModelsTableCreateCompanionBuilder =
    PanelModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String manufacturer,
      required String model,
      required double pmaxW,
      required double vocV,
      required double iscA,
      required double vmpV,
      required double impA,
      Value<double> gammaPmaxPct,
      Value<double> betaVocPct,
      Value<double> betaVmpPct,
      required double lengthM,
      required double widthM,
      Value<double?> weightKg,
      Value<CellType> cellType,
      Value<int?> cellCount,
      Value<bool> bifacial,
      Value<double?> bifacialityPct,
      Value<double?> maxSeriesFuseA,
      Value<double?> maxSystemVoltageV,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$PanelModelsTableUpdateCompanionBuilder =
    PanelModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> manufacturer,
      Value<String> model,
      Value<double> pmaxW,
      Value<double> vocV,
      Value<double> iscA,
      Value<double> vmpV,
      Value<double> impA,
      Value<double> gammaPmaxPct,
      Value<double> betaVocPct,
      Value<double> betaVmpPct,
      Value<double> lengthM,
      Value<double> widthM,
      Value<double?> weightKg,
      Value<CellType> cellType,
      Value<int?> cellCount,
      Value<bool> bifacial,
      Value<double?> bifacialityPct,
      Value<double?> maxSeriesFuseA,
      Value<double?> maxSystemVoltageV,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$PanelModelsTableFilterComposer
    extends Composer<_$AppDatabase, $PanelModelsTable> {
  $$PanelModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pmaxW => $composableBuilder(
    column: $table.pmaxW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vocV => $composableBuilder(
    column: $table.vocV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get iscA => $composableBuilder(
    column: $table.iscA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vmpV => $composableBuilder(
    column: $table.vmpV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get impA => $composableBuilder(
    column: $table.impA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gammaPmaxPct => $composableBuilder(
    column: $table.gammaPmaxPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get betaVocPct => $composableBuilder(
    column: $table.betaVocPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get betaVmpPct => $composableBuilder(
    column: $table.betaVmpPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lengthM => $composableBuilder(
    column: $table.lengthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get widthM => $composableBuilder(
    column: $table.widthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CellType, CellType, String> get cellType =>
      $composableBuilder(
        column: $table.cellType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get cellCount => $composableBuilder(
    column: $table.cellCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get bifacial => $composableBuilder(
    column: $table.bifacial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bifacialityPct => $composableBuilder(
    column: $table.bifacialityPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSeriesFuseA => $composableBuilder(
    column: $table.maxSeriesFuseA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxSystemVoltageV => $composableBuilder(
    column: $table.maxSystemVoltageV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EquipmentSource, EquipmentSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PanelModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $PanelModelsTable> {
  $$PanelModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pmaxW => $composableBuilder(
    column: $table.pmaxW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vocV => $composableBuilder(
    column: $table.vocV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get iscA => $composableBuilder(
    column: $table.iscA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vmpV => $composableBuilder(
    column: $table.vmpV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get impA => $composableBuilder(
    column: $table.impA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gammaPmaxPct => $composableBuilder(
    column: $table.gammaPmaxPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get betaVocPct => $composableBuilder(
    column: $table.betaVocPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get betaVmpPct => $composableBuilder(
    column: $table.betaVmpPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lengthM => $composableBuilder(
    column: $table.lengthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get widthM => $composableBuilder(
    column: $table.widthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cellType => $composableBuilder(
    column: $table.cellType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cellCount => $composableBuilder(
    column: $table.cellCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get bifacial => $composableBuilder(
    column: $table.bifacial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bifacialityPct => $composableBuilder(
    column: $table.bifacialityPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSeriesFuseA => $composableBuilder(
    column: $table.maxSeriesFuseA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxSystemVoltageV => $composableBuilder(
    column: $table.maxSystemVoltageV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PanelModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PanelModelsTable> {
  $$PanelModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<double> get pmaxW =>
      $composableBuilder(column: $table.pmaxW, builder: (column) => column);

  GeneratedColumn<double> get vocV =>
      $composableBuilder(column: $table.vocV, builder: (column) => column);

  GeneratedColumn<double> get iscA =>
      $composableBuilder(column: $table.iscA, builder: (column) => column);

  GeneratedColumn<double> get vmpV =>
      $composableBuilder(column: $table.vmpV, builder: (column) => column);

  GeneratedColumn<double> get impA =>
      $composableBuilder(column: $table.impA, builder: (column) => column);

  GeneratedColumn<double> get gammaPmaxPct => $composableBuilder(
    column: $table.gammaPmaxPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get betaVocPct => $composableBuilder(
    column: $table.betaVocPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get betaVmpPct => $composableBuilder(
    column: $table.betaVmpPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lengthM =>
      $composableBuilder(column: $table.lengthM, builder: (column) => column);

  GeneratedColumn<double> get widthM =>
      $composableBuilder(column: $table.widthM, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CellType, String> get cellType =>
      $composableBuilder(column: $table.cellType, builder: (column) => column);

  GeneratedColumn<int> get cellCount =>
      $composableBuilder(column: $table.cellCount, builder: (column) => column);

  GeneratedColumn<bool> get bifacial =>
      $composableBuilder(column: $table.bifacial, builder: (column) => column);

  GeneratedColumn<double> get bifacialityPct => $composableBuilder(
    column: $table.bifacialityPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSeriesFuseA => $composableBuilder(
    column: $table.maxSeriesFuseA,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxSystemVoltageV => $composableBuilder(
    column: $table.maxSystemVoltageV,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<EquipmentSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$PanelModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PanelModelsTable,
          PanelModel,
          $$PanelModelsTableFilterComposer,
          $$PanelModelsTableOrderingComposer,
          $$PanelModelsTableAnnotationComposer,
          $$PanelModelsTableCreateCompanionBuilder,
          $$PanelModelsTableUpdateCompanionBuilder,
          (
            PanelModel,
            BaseReferences<_$AppDatabase, $PanelModelsTable, PanelModel>,
          ),
          PanelModel,
          PrefetchHooks Function()
        > {
  $$PanelModelsTableTableManager(_$AppDatabase db, $PanelModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PanelModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PanelModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PanelModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> manufacturer = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<double> pmaxW = const Value.absent(),
                Value<double> vocV = const Value.absent(),
                Value<double> iscA = const Value.absent(),
                Value<double> vmpV = const Value.absent(),
                Value<double> impA = const Value.absent(),
                Value<double> gammaPmaxPct = const Value.absent(),
                Value<double> betaVocPct = const Value.absent(),
                Value<double> betaVmpPct = const Value.absent(),
                Value<double> lengthM = const Value.absent(),
                Value<double> widthM = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<CellType> cellType = const Value.absent(),
                Value<int?> cellCount = const Value.absent(),
                Value<bool> bifacial = const Value.absent(),
                Value<double?> bifacialityPct = const Value.absent(),
                Value<double?> maxSeriesFuseA = const Value.absent(),
                Value<double?> maxSystemVoltageV = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PanelModelsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                pmaxW: pmaxW,
                vocV: vocV,
                iscA: iscA,
                vmpV: vmpV,
                impA: impA,
                gammaPmaxPct: gammaPmaxPct,
                betaVocPct: betaVocPct,
                betaVmpPct: betaVmpPct,
                lengthM: lengthM,
                widthM: widthM,
                weightKg: weightKg,
                cellType: cellType,
                cellCount: cellCount,
                bifacial: bifacial,
                bifacialityPct: bifacialityPct,
                maxSeriesFuseA: maxSeriesFuseA,
                maxSystemVoltageV: maxSystemVoltageV,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String manufacturer,
                required String model,
                required double pmaxW,
                required double vocV,
                required double iscA,
                required double vmpV,
                required double impA,
                Value<double> gammaPmaxPct = const Value.absent(),
                Value<double> betaVocPct = const Value.absent(),
                Value<double> betaVmpPct = const Value.absent(),
                required double lengthM,
                required double widthM,
                Value<double?> weightKg = const Value.absent(),
                Value<CellType> cellType = const Value.absent(),
                Value<int?> cellCount = const Value.absent(),
                Value<bool> bifacial = const Value.absent(),
                Value<double?> bifacialityPct = const Value.absent(),
                Value<double?> maxSeriesFuseA = const Value.absent(),
                Value<double?> maxSystemVoltageV = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PanelModelsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                pmaxW: pmaxW,
                vocV: vocV,
                iscA: iscA,
                vmpV: vmpV,
                impA: impA,
                gammaPmaxPct: gammaPmaxPct,
                betaVocPct: betaVocPct,
                betaVmpPct: betaVmpPct,
                lengthM: lengthM,
                widthM: widthM,
                weightKg: weightKg,
                cellType: cellType,
                cellCount: cellCount,
                bifacial: bifacial,
                bifacialityPct: bifacialityPct,
                maxSeriesFuseA: maxSeriesFuseA,
                maxSystemVoltageV: maxSystemVoltageV,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PanelModelsTable, PanelModel>(table),
                  BaseReferences<_$AppDatabase, $PanelModelsTable, PanelModel>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PanelModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PanelModelsTable,
      PanelModel,
      $$PanelModelsTableFilterComposer,
      $$PanelModelsTableOrderingComposer,
      $$PanelModelsTableAnnotationComposer,
      $$PanelModelsTableCreateCompanionBuilder,
      $$PanelModelsTableUpdateCompanionBuilder,
      (
        PanelModel,
        BaseReferences<_$AppDatabase, $PanelModelsTable, PanelModel>,
      ),
      PanelModel,
      PrefetchHooks Function()
    >;
typedef $$InverterModelsTableCreateCompanionBuilder =
    InverterModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String manufacturer,
      required String model,
      Value<InverterKind> kind,
      required double pacW,
      required double vdcMaxV,
      required double mpptMinV,
      required double mpptMaxV,
      Value<int> mpptCount,
      required double imaxPerMpptA,
      Value<double?> iscMaxPerMpptA,
      Value<double> efficiencyPct,
      Value<int> phases,
      Value<double> acVoltageV,
      Value<double?> iacMaxA,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$InverterModelsTableUpdateCompanionBuilder =
    InverterModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> manufacturer,
      Value<String> model,
      Value<InverterKind> kind,
      Value<double> pacW,
      Value<double> vdcMaxV,
      Value<double> mpptMinV,
      Value<double> mpptMaxV,
      Value<int> mpptCount,
      Value<double> imaxPerMpptA,
      Value<double?> iscMaxPerMpptA,
      Value<double> efficiencyPct,
      Value<int> phases,
      Value<double> acVoltageV,
      Value<double?> iacMaxA,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$InverterModelsTableFilterComposer
    extends Composer<_$AppDatabase, $InverterModelsTable> {
  $$InverterModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InverterKind, InverterKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get pacW => $composableBuilder(
    column: $table.pacW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vdcMaxV => $composableBuilder(
    column: $table.vdcMaxV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mpptMinV => $composableBuilder(
    column: $table.mpptMinV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mpptMaxV => $composableBuilder(
    column: $table.mpptMaxV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mpptCount => $composableBuilder(
    column: $table.mpptCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get imaxPerMpptA => $composableBuilder(
    column: $table.imaxPerMpptA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get iscMaxPerMpptA => $composableBuilder(
    column: $table.iscMaxPerMpptA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get efficiencyPct => $composableBuilder(
    column: $table.efficiencyPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get phases => $composableBuilder(
    column: $table.phases,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get acVoltageV => $composableBuilder(
    column: $table.acVoltageV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get iacMaxA => $composableBuilder(
    column: $table.iacMaxA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EquipmentSource, EquipmentSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InverterModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $InverterModelsTable> {
  $$InverterModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pacW => $composableBuilder(
    column: $table.pacW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vdcMaxV => $composableBuilder(
    column: $table.vdcMaxV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mpptMinV => $composableBuilder(
    column: $table.mpptMinV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mpptMaxV => $composableBuilder(
    column: $table.mpptMaxV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mpptCount => $composableBuilder(
    column: $table.mpptCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get imaxPerMpptA => $composableBuilder(
    column: $table.imaxPerMpptA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get iscMaxPerMpptA => $composableBuilder(
    column: $table.iscMaxPerMpptA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get efficiencyPct => $composableBuilder(
    column: $table.efficiencyPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get phases => $composableBuilder(
    column: $table.phases,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get acVoltageV => $composableBuilder(
    column: $table.acVoltageV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get iacMaxA => $composableBuilder(
    column: $table.iacMaxA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InverterModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InverterModelsTable> {
  $$InverterModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InverterKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get pacW =>
      $composableBuilder(column: $table.pacW, builder: (column) => column);

  GeneratedColumn<double> get vdcMaxV =>
      $composableBuilder(column: $table.vdcMaxV, builder: (column) => column);

  GeneratedColumn<double> get mpptMinV =>
      $composableBuilder(column: $table.mpptMinV, builder: (column) => column);

  GeneratedColumn<double> get mpptMaxV =>
      $composableBuilder(column: $table.mpptMaxV, builder: (column) => column);

  GeneratedColumn<int> get mpptCount =>
      $composableBuilder(column: $table.mpptCount, builder: (column) => column);

  GeneratedColumn<double> get imaxPerMpptA => $composableBuilder(
    column: $table.imaxPerMpptA,
    builder: (column) => column,
  );

  GeneratedColumn<double> get iscMaxPerMpptA => $composableBuilder(
    column: $table.iscMaxPerMpptA,
    builder: (column) => column,
  );

  GeneratedColumn<double> get efficiencyPct => $composableBuilder(
    column: $table.efficiencyPct,
    builder: (column) => column,
  );

  GeneratedColumn<int> get phases =>
      $composableBuilder(column: $table.phases, builder: (column) => column);

  GeneratedColumn<double> get acVoltageV => $composableBuilder(
    column: $table.acVoltageV,
    builder: (column) => column,
  );

  GeneratedColumn<double> get iacMaxA =>
      $composableBuilder(column: $table.iacMaxA, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EquipmentSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$InverterModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InverterModelsTable,
          InverterModel,
          $$InverterModelsTableFilterComposer,
          $$InverterModelsTableOrderingComposer,
          $$InverterModelsTableAnnotationComposer,
          $$InverterModelsTableCreateCompanionBuilder,
          $$InverterModelsTableUpdateCompanionBuilder,
          (
            InverterModel,
            BaseReferences<_$AppDatabase, $InverterModelsTable, InverterModel>,
          ),
          InverterModel,
          PrefetchHooks Function()
        > {
  $$InverterModelsTableTableManager(
    _$AppDatabase db,
    $InverterModelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InverterModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InverterModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InverterModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> manufacturer = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<InverterKind> kind = const Value.absent(),
                Value<double> pacW = const Value.absent(),
                Value<double> vdcMaxV = const Value.absent(),
                Value<double> mpptMinV = const Value.absent(),
                Value<double> mpptMaxV = const Value.absent(),
                Value<int> mpptCount = const Value.absent(),
                Value<double> imaxPerMpptA = const Value.absent(),
                Value<double?> iscMaxPerMpptA = const Value.absent(),
                Value<double> efficiencyPct = const Value.absent(),
                Value<int> phases = const Value.absent(),
                Value<double> acVoltageV = const Value.absent(),
                Value<double?> iacMaxA = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InverterModelsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                kind: kind,
                pacW: pacW,
                vdcMaxV: vdcMaxV,
                mpptMinV: mpptMinV,
                mpptMaxV: mpptMaxV,
                mpptCount: mpptCount,
                imaxPerMpptA: imaxPerMpptA,
                iscMaxPerMpptA: iscMaxPerMpptA,
                efficiencyPct: efficiencyPct,
                phases: phases,
                acVoltageV: acVoltageV,
                iacMaxA: iacMaxA,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String manufacturer,
                required String model,
                Value<InverterKind> kind = const Value.absent(),
                required double pacW,
                required double vdcMaxV,
                required double mpptMinV,
                required double mpptMaxV,
                Value<int> mpptCount = const Value.absent(),
                required double imaxPerMpptA,
                Value<double?> iscMaxPerMpptA = const Value.absent(),
                Value<double> efficiencyPct = const Value.absent(),
                Value<int> phases = const Value.absent(),
                Value<double> acVoltageV = const Value.absent(),
                Value<double?> iacMaxA = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InverterModelsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                kind: kind,
                pacW: pacW,
                vdcMaxV: vdcMaxV,
                mpptMinV: mpptMinV,
                mpptMaxV: mpptMaxV,
                mpptCount: mpptCount,
                imaxPerMpptA: imaxPerMpptA,
                iscMaxPerMpptA: iscMaxPerMpptA,
                efficiencyPct: efficiencyPct,
                phases: phases,
                acVoltageV: acVoltageV,
                iacMaxA: iacMaxA,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InverterModelsTable, InverterModel>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $InverterModelsTable,
                    InverterModel
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InverterModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InverterModelsTable,
      InverterModel,
      $$InverterModelsTableFilterComposer,
      $$InverterModelsTableOrderingComposer,
      $$InverterModelsTableAnnotationComposer,
      $$InverterModelsTableCreateCompanionBuilder,
      $$InverterModelsTableUpdateCompanionBuilder,
      (
        InverterModel,
        BaseReferences<_$AppDatabase, $InverterModelsTable, InverterModel>,
      ),
      InverterModel,
      PrefetchHooks Function()
    >;
typedef $$OptimizerModelsTableCreateCompanionBuilder =
    OptimizerModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String manufacturer,
      required String model,
      required double pmaxInW,
      required double vinMaxV,
      required double imaxInA,
      Value<double?> voutMaxV,
      Value<double?> ioutMaxA,
      Value<double> efficiencyPct,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$OptimizerModelsTableUpdateCompanionBuilder =
    OptimizerModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> manufacturer,
      Value<String> model,
      Value<double> pmaxInW,
      Value<double> vinMaxV,
      Value<double> imaxInA,
      Value<double?> voutMaxV,
      Value<double?> ioutMaxA,
      Value<double> efficiencyPct,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$OptimizerModelsTableFilterComposer
    extends Composer<_$AppDatabase, $OptimizerModelsTable> {
  $$OptimizerModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pmaxInW => $composableBuilder(
    column: $table.pmaxInW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vinMaxV => $composableBuilder(
    column: $table.vinMaxV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get imaxInA => $composableBuilder(
    column: $table.imaxInA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voutMaxV => $composableBuilder(
    column: $table.voutMaxV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ioutMaxA => $composableBuilder(
    column: $table.ioutMaxA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get efficiencyPct => $composableBuilder(
    column: $table.efficiencyPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EquipmentSource, EquipmentSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$OptimizerModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $OptimizerModelsTable> {
  $$OptimizerModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pmaxInW => $composableBuilder(
    column: $table.pmaxInW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vinMaxV => $composableBuilder(
    column: $table.vinMaxV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get imaxInA => $composableBuilder(
    column: $table.imaxInA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voutMaxV => $composableBuilder(
    column: $table.voutMaxV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ioutMaxA => $composableBuilder(
    column: $table.ioutMaxA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get efficiencyPct => $composableBuilder(
    column: $table.efficiencyPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OptimizerModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OptimizerModelsTable> {
  $$OptimizerModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<double> get pmaxInW =>
      $composableBuilder(column: $table.pmaxInW, builder: (column) => column);

  GeneratedColumn<double> get vinMaxV =>
      $composableBuilder(column: $table.vinMaxV, builder: (column) => column);

  GeneratedColumn<double> get imaxInA =>
      $composableBuilder(column: $table.imaxInA, builder: (column) => column);

  GeneratedColumn<double> get voutMaxV =>
      $composableBuilder(column: $table.voutMaxV, builder: (column) => column);

  GeneratedColumn<double> get ioutMaxA =>
      $composableBuilder(column: $table.ioutMaxA, builder: (column) => column);

  GeneratedColumn<double> get efficiencyPct => $composableBuilder(
    column: $table.efficiencyPct,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<EquipmentSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$OptimizerModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OptimizerModelsTable,
          OptimizerModel,
          $$OptimizerModelsTableFilterComposer,
          $$OptimizerModelsTableOrderingComposer,
          $$OptimizerModelsTableAnnotationComposer,
          $$OptimizerModelsTableCreateCompanionBuilder,
          $$OptimizerModelsTableUpdateCompanionBuilder,
          (
            OptimizerModel,
            BaseReferences<
              _$AppDatabase,
              $OptimizerModelsTable,
              OptimizerModel
            >,
          ),
          OptimizerModel,
          PrefetchHooks Function()
        > {
  $$OptimizerModelsTableTableManager(
    _$AppDatabase db,
    $OptimizerModelsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OptimizerModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OptimizerModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OptimizerModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> manufacturer = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<double> pmaxInW = const Value.absent(),
                Value<double> vinMaxV = const Value.absent(),
                Value<double> imaxInA = const Value.absent(),
                Value<double?> voutMaxV = const Value.absent(),
                Value<double?> ioutMaxA = const Value.absent(),
                Value<double> efficiencyPct = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OptimizerModelsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                pmaxInW: pmaxInW,
                vinMaxV: vinMaxV,
                imaxInA: imaxInA,
                voutMaxV: voutMaxV,
                ioutMaxA: ioutMaxA,
                efficiencyPct: efficiencyPct,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String manufacturer,
                required String model,
                required double pmaxInW,
                required double vinMaxV,
                required double imaxInA,
                Value<double?> voutMaxV = const Value.absent(),
                Value<double?> ioutMaxA = const Value.absent(),
                Value<double> efficiencyPct = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => OptimizerModelsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                pmaxInW: pmaxInW,
                vinMaxV: vinMaxV,
                imaxInA: imaxInA,
                voutMaxV: voutMaxV,
                ioutMaxA: ioutMaxA,
                efficiencyPct: efficiencyPct,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OptimizerModelsTable, OptimizerModel>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $OptimizerModelsTable,
                    OptimizerModel
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OptimizerModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OptimizerModelsTable,
      OptimizerModel,
      $$OptimizerModelsTableFilterComposer,
      $$OptimizerModelsTableOrderingComposer,
      $$OptimizerModelsTableAnnotationComposer,
      $$OptimizerModelsTableCreateCompanionBuilder,
      $$OptimizerModelsTableUpdateCompanionBuilder,
      (
        OptimizerModel,
        BaseReferences<_$AppDatabase, $OptimizerModelsTable, OptimizerModel>,
      ),
      OptimizerModel,
      PrefetchHooks Function()
    >;
typedef $$BatteryModelsTableCreateCompanionBuilder =
    BatteryModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String manufacturer,
      required String model,
      Value<BatteryChemistry> chemistry,
      required double capacityKwh,
      Value<double?> usableKwh,
      required double nominalVoltageV,
      Value<double?> maxChargeKw,
      Value<double?> maxDischargeKw,
      Value<int?> cycles,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$BatteryModelsTableUpdateCompanionBuilder =
    BatteryModelsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> manufacturer,
      Value<String> model,
      Value<BatteryChemistry> chemistry,
      Value<double> capacityKwh,
      Value<double?> usableKwh,
      Value<double> nominalVoltageV,
      Value<double?> maxChargeKw,
      Value<double?> maxDischargeKw,
      Value<int?> cycles,
      Value<EquipmentSource> source,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$BatteryModelsTableFilterComposer
    extends Composer<_$AppDatabase, $BatteryModelsTable> {
  $$BatteryModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BatteryChemistry, BatteryChemistry, String>
  get chemistry => $composableBuilder(
    column: $table.chemistry,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get capacityKwh => $composableBuilder(
    column: $table.capacityKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get usableKwh => $composableBuilder(
    column: $table.usableKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get nominalVoltageV => $composableBuilder(
    column: $table.nominalVoltageV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxChargeKw => $composableBuilder(
    column: $table.maxChargeKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get maxDischargeKw => $composableBuilder(
    column: $table.maxDischargeKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cycles => $composableBuilder(
    column: $table.cycles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EquipmentSource, EquipmentSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BatteryModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $BatteryModelsTable> {
  $$BatteryModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chemistry => $composableBuilder(
    column: $table.chemistry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get capacityKwh => $composableBuilder(
    column: $table.capacityKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get usableKwh => $composableBuilder(
    column: $table.usableKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get nominalVoltageV => $composableBuilder(
    column: $table.nominalVoltageV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxChargeKw => $composableBuilder(
    column: $table.maxChargeKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get maxDischargeKw => $composableBuilder(
    column: $table.maxDischargeKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cycles => $composableBuilder(
    column: $table.cycles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BatteryModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BatteryModelsTable> {
  $$BatteryModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get manufacturer => $composableBuilder(
    column: $table.manufacturer,
    builder: (column) => column,
  );

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BatteryChemistry, String> get chemistry =>
      $composableBuilder(column: $table.chemistry, builder: (column) => column);

  GeneratedColumn<double> get capacityKwh => $composableBuilder(
    column: $table.capacityKwh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get usableKwh =>
      $composableBuilder(column: $table.usableKwh, builder: (column) => column);

  GeneratedColumn<double> get nominalVoltageV => $composableBuilder(
    column: $table.nominalVoltageV,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxChargeKw => $composableBuilder(
    column: $table.maxChargeKw,
    builder: (column) => column,
  );

  GeneratedColumn<double> get maxDischargeKw => $composableBuilder(
    column: $table.maxDischargeKw,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cycles =>
      $composableBuilder(column: $table.cycles, builder: (column) => column);

  GeneratedColumnWithTypeConverter<EquipmentSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$BatteryModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatteryModelsTable,
          BatteryModel,
          $$BatteryModelsTableFilterComposer,
          $$BatteryModelsTableOrderingComposer,
          $$BatteryModelsTableAnnotationComposer,
          $$BatteryModelsTableCreateCompanionBuilder,
          $$BatteryModelsTableUpdateCompanionBuilder,
          (
            BatteryModel,
            BaseReferences<_$AppDatabase, $BatteryModelsTable, BatteryModel>,
          ),
          BatteryModel,
          PrefetchHooks Function()
        > {
  $$BatteryModelsTableTableManager(_$AppDatabase db, $BatteryModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BatteryModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BatteryModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BatteryModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> manufacturer = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<BatteryChemistry> chemistry = const Value.absent(),
                Value<double> capacityKwh = const Value.absent(),
                Value<double?> usableKwh = const Value.absent(),
                Value<double> nominalVoltageV = const Value.absent(),
                Value<double?> maxChargeKw = const Value.absent(),
                Value<double?> maxDischargeKw = const Value.absent(),
                Value<int?> cycles = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatteryModelsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                chemistry: chemistry,
                capacityKwh: capacityKwh,
                usableKwh: usableKwh,
                nominalVoltageV: nominalVoltageV,
                maxChargeKw: maxChargeKw,
                maxDischargeKw: maxDischargeKw,
                cycles: cycles,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String manufacturer,
                required String model,
                Value<BatteryChemistry> chemistry = const Value.absent(),
                required double capacityKwh,
                Value<double?> usableKwh = const Value.absent(),
                required double nominalVoltageV,
                Value<double?> maxChargeKw = const Value.absent(),
                Value<double?> maxDischargeKw = const Value.absent(),
                Value<int?> cycles = const Value.absent(),
                Value<EquipmentSource> source = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BatteryModelsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                manufacturer: manufacturer,
                model: model,
                chemistry: chemistry,
                capacityKwh: capacityKwh,
                usableKwh: usableKwh,
                nominalVoltageV: nominalVoltageV,
                maxChargeKw: maxChargeKw,
                maxDischargeKw: maxDischargeKw,
                cycles: cycles,
                source: source,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BatteryModelsTable, BatteryModel>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BatteryModelsTable,
                    BatteryModel
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BatteryModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatteryModelsTable,
      BatteryModel,
      $$BatteryModelsTableFilterComposer,
      $$BatteryModelsTableOrderingComposer,
      $$BatteryModelsTableAnnotationComposer,
      $$BatteryModelsTableCreateCompanionBuilder,
      $$BatteryModelsTableUpdateCompanionBuilder,
      (
        BatteryModel,
        BaseReferences<_$AppDatabase, $BatteryModelsTable, BatteryModel>,
      ),
      BatteryModel,
      PrefetchHooks Function()
    >;
typedef $$PvDesignsTableCreateCompanionBuilder = PvDesignsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  required String projectId,
  Value<String?> panelModelId,
  Value<String?> inverterModelId,
  Value<int> inverterCount,
  Value<String?> optimizerModelId,
  Value<String?> batteryModelId,
  Value<double> systemVoltageLimitV,
  Value<String> losses,
  Value<double> shadeThresholdPct,
  Value<double> gridVoltageV,
  Value<String> wind,
  Value<int> rowid,
});
typedef $$PvDesignsTableUpdateCompanionBuilder = PvDesignsCompanion Function({
  Value<String> id,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<String> projectId,
  Value<String?> panelModelId,
  Value<String?> inverterModelId,
  Value<int> inverterCount,
  Value<String?> optimizerModelId,
  Value<String?> batteryModelId,
  Value<double> systemVoltageLimitV,
  Value<String> losses,
  Value<double> shadeThresholdPct,
  Value<double> gridVoltageV,
  Value<String> wind,
  Value<int> rowid,
});

final class $$PvDesignsTableReferences
    extends BaseReferences<_$AppDatabase, $PvDesignsTable, PvDesign> {
  $$PvDesignsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('pv_designs__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PvDesignsTableFilterComposer
    extends Composer<_$AppDatabase, $PvDesignsTable> {
  $$PvDesignsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get panelModelId => $composableBuilder(
    column: $table.panelModelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get inverterModelId => $composableBuilder(
    column: $table.inverterModelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inverterCount => $composableBuilder(
    column: $table.inverterCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get optimizerModelId => $composableBuilder(
    column: $table.optimizerModelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get batteryModelId => $composableBuilder(
    column: $table.batteryModelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get systemVoltageLimitV => $composableBuilder(
    column: $table.systemVoltageLimitV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get losses => $composableBuilder(
    column: $table.losses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shadeThresholdPct => $composableBuilder(
    column: $table.shadeThresholdPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gridVoltageV => $composableBuilder(
    column: $table.gridVoltageV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wind => $composableBuilder(
    column: $table.wind,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PvDesignsTableOrderingComposer
    extends Composer<_$AppDatabase, $PvDesignsTable> {
  $$PvDesignsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get panelModelId => $composableBuilder(
    column: $table.panelModelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get inverterModelId => $composableBuilder(
    column: $table.inverterModelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inverterCount => $composableBuilder(
    column: $table.inverterCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get optimizerModelId => $composableBuilder(
    column: $table.optimizerModelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get batteryModelId => $composableBuilder(
    column: $table.batteryModelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get systemVoltageLimitV => $composableBuilder(
    column: $table.systemVoltageLimitV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get losses => $composableBuilder(
    column: $table.losses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shadeThresholdPct => $composableBuilder(
    column: $table.shadeThresholdPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gridVoltageV => $composableBuilder(
    column: $table.gridVoltageV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wind => $composableBuilder(
    column: $table.wind,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PvDesignsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PvDesignsTable> {
  $$PvDesignsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get panelModelId => $composableBuilder(
    column: $table.panelModelId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get inverterModelId => $composableBuilder(
    column: $table.inverterModelId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get inverterCount => $composableBuilder(
    column: $table.inverterCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get optimizerModelId => $composableBuilder(
    column: $table.optimizerModelId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get batteryModelId => $composableBuilder(
    column: $table.batteryModelId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get systemVoltageLimitV => $composableBuilder(
    column: $table.systemVoltageLimitV,
    builder: (column) => column,
  );

  GeneratedColumn<String> get losses =>
      $composableBuilder(column: $table.losses, builder: (column) => column);

  GeneratedColumn<double> get shadeThresholdPct => $composableBuilder(
    column: $table.shadeThresholdPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gridVoltageV => $composableBuilder(
    column: $table.gridVoltageV,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wind =>
      $composableBuilder(column: $table.wind, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PvDesignsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PvDesignsTable,
          PvDesign,
          $$PvDesignsTableFilterComposer,
          $$PvDesignsTableOrderingComposer,
          $$PvDesignsTableAnnotationComposer,
          $$PvDesignsTableCreateCompanionBuilder,
          $$PvDesignsTableUpdateCompanionBuilder,
          (PvDesign, $$PvDesignsTableReferences),
          PvDesign,
          PrefetchHooks Function({bool projectId})
        > {
  $$PvDesignsTableTableManager(_$AppDatabase db, $PvDesignsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PvDesignsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PvDesignsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PvDesignsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String?> panelModelId = const Value.absent(),
                Value<String?> inverterModelId = const Value.absent(),
                Value<int> inverterCount = const Value.absent(),
                Value<String?> optimizerModelId = const Value.absent(),
                Value<String?> batteryModelId = const Value.absent(),
                Value<double> systemVoltageLimitV = const Value.absent(),
                Value<String> losses = const Value.absent(),
                Value<double> shadeThresholdPct = const Value.absent(),
                Value<double> gridVoltageV = const Value.absent(),
                Value<String> wind = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PvDesignsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                panelModelId: panelModelId,
                inverterModelId: inverterModelId,
                inverterCount: inverterCount,
                optimizerModelId: optimizerModelId,
                batteryModelId: batteryModelId,
                systemVoltageLimitV: systemVoltageLimitV,
                losses: losses,
                shadeThresholdPct: shadeThresholdPct,
                gridVoltageV: gridVoltageV,
                wind: wind,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                Value<String?> panelModelId = const Value.absent(),
                Value<String?> inverterModelId = const Value.absent(),
                Value<int> inverterCount = const Value.absent(),
                Value<String?> optimizerModelId = const Value.absent(),
                Value<String?> batteryModelId = const Value.absent(),
                Value<double> systemVoltageLimitV = const Value.absent(),
                Value<String> losses = const Value.absent(),
                Value<double> shadeThresholdPct = const Value.absent(),
                Value<double> gridVoltageV = const Value.absent(),
                Value<String> wind = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PvDesignsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                panelModelId: panelModelId,
                inverterModelId: inverterModelId,
                inverterCount: inverterCount,
                optimizerModelId: optimizerModelId,
                batteryModelId: batteryModelId,
                systemVoltageLimitV: systemVoltageLimitV,
                losses: losses,
                shadeThresholdPct: shadeThresholdPct,
                gridVoltageV: gridVoltageV,
                wind: wind,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PvDesignsTable, PvDesign>(table),
                  $$PvDesignsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$PvDesignsTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$PvDesignsTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$PvDesignsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PvDesignsTable,
      PvDesign,
      $$PvDesignsTableFilterComposer,
      $$PvDesignsTableOrderingComposer,
      $$PvDesignsTableAnnotationComposer,
      $$PvDesignsTableCreateCompanionBuilder,
      $$PvDesignsTableUpdateCompanionBuilder,
      (PvDesign, $$PvDesignsTableReferences),
      PvDesign,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$ArrayLayoutsTableCreateCompanionBuilder =
    ArrayLayoutsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String projectId,
      required String roofPlaneId,
      Value<String?> panelModelId,
      Value<LayoutOrientation> orientation,
      Value<MountType> mount,
      Value<double> rackTiltDeg,
      Value<double> rackAzimuthDeg,
      Value<double> gapM,
      Value<double> rowGapM,
      Value<double> clearanceM,
      Value<double?> rowSpacingM,
      Value<String> panels,
      Value<int> rowid,
    });
typedef $$ArrayLayoutsTableUpdateCompanionBuilder =
    ArrayLayoutsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> projectId,
      Value<String> roofPlaneId,
      Value<String?> panelModelId,
      Value<LayoutOrientation> orientation,
      Value<MountType> mount,
      Value<double> rackTiltDeg,
      Value<double> rackAzimuthDeg,
      Value<double> gapM,
      Value<double> rowGapM,
      Value<double> clearanceM,
      Value<double?> rowSpacingM,
      Value<String> panels,
      Value<int> rowid,
    });

final class $$ArrayLayoutsTableReferences
    extends BaseReferences<_$AppDatabase, $ArrayLayoutsTable, ArrayLayout> {
  $$ArrayLayoutsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('array_layouts__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RoofPlanesTable _roofPlaneIdTable(_$AppDatabase db) => db.roofPlanes
      .createAlias('array_layouts__roof_plane_id__roof_planes__id');

  $$RoofPlanesTableProcessedTableManager get roofPlaneId {
    final $_column = $_itemColumn<String>('roof_plane_id')!;

    final manager = $$RoofPlanesTableTableManager(
      $_db,
      $_db.roofPlanes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_roofPlaneIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ArrayLayoutsTableFilterComposer
    extends Composer<_$AppDatabase, $ArrayLayoutsTable> {
  $$ArrayLayoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get panelModelId => $composableBuilder(
    column: $table.panelModelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LayoutOrientation, LayoutOrientation, String>
  get orientation => $composableBuilder(
    column: $table.orientation,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<MountType, MountType, String> get mount =>
      $composableBuilder(
        column: $table.mount,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get rackTiltDeg => $composableBuilder(
    column: $table.rackTiltDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rackAzimuthDeg => $composableBuilder(
    column: $table.rackAzimuthDeg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get gapM => $composableBuilder(
    column: $table.gapM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rowGapM => $composableBuilder(
    column: $table.rowGapM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get clearanceM => $composableBuilder(
    column: $table.clearanceM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rowSpacingM => $composableBuilder(
    column: $table.rowSpacingM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get panels => $composableBuilder(
    column: $table.panels,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoofPlanesTableFilterComposer get roofPlaneId {
    final $$RoofPlanesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roofPlaneId,
      referencedTable: $db.roofPlanes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofPlanesTableFilterComposer(
            $db: $db,
            $table: $db.roofPlanes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArrayLayoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArrayLayoutsTable> {
  $$ArrayLayoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get panelModelId => $composableBuilder(
    column: $table.panelModelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get orientation => $composableBuilder(
    column: $table.orientation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mount => $composableBuilder(
    column: $table.mount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rackTiltDeg => $composableBuilder(
    column: $table.rackTiltDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rackAzimuthDeg => $composableBuilder(
    column: $table.rackAzimuthDeg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get gapM => $composableBuilder(
    column: $table.gapM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rowGapM => $composableBuilder(
    column: $table.rowGapM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get clearanceM => $composableBuilder(
    column: $table.clearanceM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rowSpacingM => $composableBuilder(
    column: $table.rowSpacingM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get panels => $composableBuilder(
    column: $table.panels,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoofPlanesTableOrderingComposer get roofPlaneId {
    final $$RoofPlanesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roofPlaneId,
      referencedTable: $db.roofPlanes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofPlanesTableOrderingComposer(
            $db: $db,
            $table: $db.roofPlanes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArrayLayoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArrayLayoutsTable> {
  $$ArrayLayoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<String> get panelModelId => $composableBuilder(
    column: $table.panelModelId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LayoutOrientation, String> get orientation =>
      $composableBuilder(
        column: $table.orientation,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<MountType, String> get mount =>
      $composableBuilder(column: $table.mount, builder: (column) => column);

  GeneratedColumn<double> get rackTiltDeg => $composableBuilder(
    column: $table.rackTiltDeg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rackAzimuthDeg => $composableBuilder(
    column: $table.rackAzimuthDeg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get gapM =>
      $composableBuilder(column: $table.gapM, builder: (column) => column);

  GeneratedColumn<double> get rowGapM =>
      $composableBuilder(column: $table.rowGapM, builder: (column) => column);

  GeneratedColumn<double> get clearanceM => $composableBuilder(
    column: $table.clearanceM,
    builder: (column) => column,
  );

  GeneratedColumn<double> get rowSpacingM => $composableBuilder(
    column: $table.rowSpacingM,
    builder: (column) => column,
  );

  GeneratedColumn<String> get panels =>
      $composableBuilder(column: $table.panels, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RoofPlanesTableAnnotationComposer get roofPlaneId {
    final $$RoofPlanesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.roofPlaneId,
      referencedTable: $db.roofPlanes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RoofPlanesTableAnnotationComposer(
            $db: $db,
            $table: $db.roofPlanes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArrayLayoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArrayLayoutsTable,
          ArrayLayout,
          $$ArrayLayoutsTableFilterComposer,
          $$ArrayLayoutsTableOrderingComposer,
          $$ArrayLayoutsTableAnnotationComposer,
          $$ArrayLayoutsTableCreateCompanionBuilder,
          $$ArrayLayoutsTableUpdateCompanionBuilder,
          (ArrayLayout, $$ArrayLayoutsTableReferences),
          ArrayLayout,
          PrefetchHooks Function({bool projectId, bool roofPlaneId})
        > {
  $$ArrayLayoutsTableTableManager(_$AppDatabase db, $ArrayLayoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArrayLayoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArrayLayoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArrayLayoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<String> roofPlaneId = const Value.absent(),
                Value<String?> panelModelId = const Value.absent(),
                Value<LayoutOrientation> orientation = const Value.absent(),
                Value<MountType> mount = const Value.absent(),
                Value<double> rackTiltDeg = const Value.absent(),
                Value<double> rackAzimuthDeg = const Value.absent(),
                Value<double> gapM = const Value.absent(),
                Value<double> rowGapM = const Value.absent(),
                Value<double> clearanceM = const Value.absent(),
                Value<double?> rowSpacingM = const Value.absent(),
                Value<String> panels = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArrayLayoutsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                roofPlaneId: roofPlaneId,
                panelModelId: panelModelId,
                orientation: orientation,
                mount: mount,
                rackTiltDeg: rackTiltDeg,
                rackAzimuthDeg: rackAzimuthDeg,
                gapM: gapM,
                rowGapM: rowGapM,
                clearanceM: clearanceM,
                rowSpacingM: rowSpacingM,
                panels: panels,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required String roofPlaneId,
                Value<String?> panelModelId = const Value.absent(),
                Value<LayoutOrientation> orientation = const Value.absent(),
                Value<MountType> mount = const Value.absent(),
                Value<double> rackTiltDeg = const Value.absent(),
                Value<double> rackAzimuthDeg = const Value.absent(),
                Value<double> gapM = const Value.absent(),
                Value<double> rowGapM = const Value.absent(),
                Value<double> clearanceM = const Value.absent(),
                Value<double?> rowSpacingM = const Value.absent(),
                Value<String> panels = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArrayLayoutsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                roofPlaneId: roofPlaneId,
                panelModelId: panelModelId,
                orientation: orientation,
                mount: mount,
                rackTiltDeg: rackTiltDeg,
                rackAzimuthDeg: rackAzimuthDeg,
                gapM: gapM,
                rowGapM: rowGapM,
                clearanceM: clearanceM,
                rowSpacingM: rowSpacingM,
                panels: panels,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ArrayLayoutsTable, ArrayLayout>(table),
                  $$ArrayLayoutsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false, roofPlaneId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$ArrayLayoutsTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$ArrayLayoutsTableReferences
                            ._projectIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (roofPlaneId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.roofPlaneId,
                        referencedTable: $$ArrayLayoutsTableReferences
                            ._roofPlaneIdTable(db),
                        referencedColumn: $$ArrayLayoutsTableReferences
                            ._roofPlaneIdTable(db)
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
        ),
      );
}

typedef $$ArrayLayoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArrayLayoutsTable,
      ArrayLayout,
      $$ArrayLayoutsTableFilterComposer,
      $$ArrayLayoutsTableOrderingComposer,
      $$ArrayLayoutsTableAnnotationComposer,
      $$ArrayLayoutsTableCreateCompanionBuilder,
      $$ArrayLayoutsTableUpdateCompanionBuilder,
      (ArrayLayout, $$ArrayLayoutsTableReferences),
      ArrayLayout,
      PrefetchHooks Function({bool projectId, bool roofPlaneId})
    >;
typedef $$StringConfigsTableCreateCompanionBuilder =
    StringConfigsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String projectId,
      Value<int> inverterIndex,
      Value<int> mpptIndex,
      required int series,
      Value<int> parallel,
      Value<bool> edited,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$StringConfigsTableUpdateCompanionBuilder =
    StringConfigsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> projectId,
      Value<int> inverterIndex,
      Value<int> mpptIndex,
      Value<int> series,
      Value<int> parallel,
      Value<bool> edited,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$StringConfigsTableReferences
    extends BaseReferences<_$AppDatabase, $StringConfigsTable, StringConfig> {
  $$StringConfigsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('string_configs__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$StringConfigsTableFilterComposer
    extends Composer<_$AppDatabase, $StringConfigsTable> {
  $$StringConfigsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get inverterIndex => $composableBuilder(
    column: $table.inverterIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mpptIndex => $composableBuilder(
    column: $table.mpptIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get parallel => $composableBuilder(
    column: $table.parallel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get edited => $composableBuilder(
    column: $table.edited,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StringConfigsTableOrderingComposer
    extends Composer<_$AppDatabase, $StringConfigsTable> {
  $$StringConfigsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get inverterIndex => $composableBuilder(
    column: $table.inverterIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mpptIndex => $composableBuilder(
    column: $table.mpptIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get series => $composableBuilder(
    column: $table.series,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get parallel => $composableBuilder(
    column: $table.parallel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get edited => $composableBuilder(
    column: $table.edited,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StringConfigsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StringConfigsTable> {
  $$StringConfigsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get inverterIndex => $composableBuilder(
    column: $table.inverterIndex,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mpptIndex =>
      $composableBuilder(column: $table.mpptIndex, builder: (column) => column);

  GeneratedColumn<int> get series =>
      $composableBuilder(column: $table.series, builder: (column) => column);

  GeneratedColumn<int> get parallel =>
      $composableBuilder(column: $table.parallel, builder: (column) => column);

  GeneratedColumn<bool> get edited =>
      $composableBuilder(column: $table.edited, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StringConfigsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StringConfigsTable,
          StringConfig,
          $$StringConfigsTableFilterComposer,
          $$StringConfigsTableOrderingComposer,
          $$StringConfigsTableAnnotationComposer,
          $$StringConfigsTableCreateCompanionBuilder,
          $$StringConfigsTableUpdateCompanionBuilder,
          (StringConfig, $$StringConfigsTableReferences),
          StringConfig,
          PrefetchHooks Function({bool projectId})
        > {
  $$StringConfigsTableTableManager(_$AppDatabase db, $StringConfigsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StringConfigsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StringConfigsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StringConfigsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<int> inverterIndex = const Value.absent(),
                Value<int> mpptIndex = const Value.absent(),
                Value<int> series = const Value.absent(),
                Value<int> parallel = const Value.absent(),
                Value<bool> edited = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StringConfigsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                inverterIndex: inverterIndex,
                mpptIndex: mpptIndex,
                series: series,
                parallel: parallel,
                edited: edited,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                Value<int> inverterIndex = const Value.absent(),
                Value<int> mpptIndex = const Value.absent(),
                required int series,
                Value<int> parallel = const Value.absent(),
                Value<bool> edited = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StringConfigsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                inverterIndex: inverterIndex,
                mpptIndex: mpptIndex,
                series: series,
                parallel: parallel,
                edited: edited,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StringConfigsTable, StringConfig>(table),
                  $$StringConfigsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$StringConfigsTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$StringConfigsTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$StringConfigsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StringConfigsTable,
      StringConfig,
      $$StringConfigsTableFilterComposer,
      $$StringConfigsTableOrderingComposer,
      $$StringConfigsTableAnnotationComposer,
      $$StringConfigsTableCreateCompanionBuilder,
      $$StringConfigsTableUpdateCompanionBuilder,
      (StringConfig, $$StringConfigsTableReferences),
      StringConfig,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$ElectricalRunsTableCreateCompanionBuilder =
    ElectricalRunsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String projectId,
      required RunKind kind,
      required String name,
      required double lengthM,
      Value<CableMaterial> material,
      Value<RacewayKind> raceway,
      Value<double> ambientC,
      Value<int> conductors,
      Value<String?> chosenSize,
      Value<String?> resultSize,
      Value<double?> dropPercent,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$ElectricalRunsTableUpdateCompanionBuilder =
    ElectricalRunsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> projectId,
      Value<RunKind> kind,
      Value<String> name,
      Value<double> lengthM,
      Value<CableMaterial> material,
      Value<RacewayKind> raceway,
      Value<double> ambientC,
      Value<int> conductors,
      Value<String?> chosenSize,
      Value<String?> resultSize,
      Value<double?> dropPercent,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$ElectricalRunsTableReferences
    extends BaseReferences<_$AppDatabase, $ElectricalRunsTable, ElectricalRun> {
  $$ElectricalRunsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('electrical_runs__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ElectricalRunsTableFilterComposer
    extends Composer<_$AppDatabase, $ElectricalRunsTable> {
  $$ElectricalRunsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RunKind, RunKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lengthM => $composableBuilder(
    column: $table.lengthM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CableMaterial, CableMaterial, String>
  get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<RacewayKind, RacewayKind, String>
  get raceway => $composableBuilder(
    column: $table.raceway,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get ambientC => $composableBuilder(
    column: $table.ambientC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get conductors => $composableBuilder(
    column: $table.conductors,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chosenSize => $composableBuilder(
    column: $table.chosenSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resultSize => $composableBuilder(
    column: $table.resultSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dropPercent => $composableBuilder(
    column: $table.dropPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElectricalRunsTableOrderingComposer
    extends Composer<_$AppDatabase, $ElectricalRunsTable> {
  $$ElectricalRunsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lengthM => $composableBuilder(
    column: $table.lengthM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get material => $composableBuilder(
    column: $table.material,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get raceway => $composableBuilder(
    column: $table.raceway,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ambientC => $composableBuilder(
    column: $table.ambientC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get conductors => $composableBuilder(
    column: $table.conductors,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chosenSize => $composableBuilder(
    column: $table.chosenSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resultSize => $composableBuilder(
    column: $table.resultSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dropPercent => $composableBuilder(
    column: $table.dropPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElectricalRunsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ElectricalRunsTable> {
  $$ElectricalRunsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RunKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get lengthM =>
      $composableBuilder(column: $table.lengthM, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CableMaterial, String> get material =>
      $composableBuilder(column: $table.material, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RacewayKind, String> get raceway =>
      $composableBuilder(column: $table.raceway, builder: (column) => column);

  GeneratedColumn<double> get ambientC =>
      $composableBuilder(column: $table.ambientC, builder: (column) => column);

  GeneratedColumn<int> get conductors => $composableBuilder(
    column: $table.conductors,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chosenSize => $composableBuilder(
    column: $table.chosenSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resultSize => $composableBuilder(
    column: $table.resultSize,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dropPercent => $composableBuilder(
    column: $table.dropPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ElectricalRunsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ElectricalRunsTable,
          ElectricalRun,
          $$ElectricalRunsTableFilterComposer,
          $$ElectricalRunsTableOrderingComposer,
          $$ElectricalRunsTableAnnotationComposer,
          $$ElectricalRunsTableCreateCompanionBuilder,
          $$ElectricalRunsTableUpdateCompanionBuilder,
          (ElectricalRun, $$ElectricalRunsTableReferences),
          ElectricalRun,
          PrefetchHooks Function({bool projectId})
        > {
  $$ElectricalRunsTableTableManager(
    _$AppDatabase db,
    $ElectricalRunsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ElectricalRunsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ElectricalRunsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ElectricalRunsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<RunKind> kind = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> lengthM = const Value.absent(),
                Value<CableMaterial> material = const Value.absent(),
                Value<RacewayKind> raceway = const Value.absent(),
                Value<double> ambientC = const Value.absent(),
                Value<int> conductors = const Value.absent(),
                Value<String?> chosenSize = const Value.absent(),
                Value<String?> resultSize = const Value.absent(),
                Value<double?> dropPercent = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ElectricalRunsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                kind: kind,
                name: name,
                lengthM: lengthM,
                material: material,
                raceway: raceway,
                ambientC: ambientC,
                conductors: conductors,
                chosenSize: chosenSize,
                resultSize: resultSize,
                dropPercent: dropPercent,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required RunKind kind,
                required String name,
                required double lengthM,
                Value<CableMaterial> material = const Value.absent(),
                Value<RacewayKind> raceway = const Value.absent(),
                Value<double> ambientC = const Value.absent(),
                Value<int> conductors = const Value.absent(),
                Value<String?> chosenSize = const Value.absent(),
                Value<String?> resultSize = const Value.absent(),
                Value<double?> dropPercent = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ElectricalRunsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                kind: kind,
                name: name,
                lengthM: lengthM,
                material: material,
                raceway: raceway,
                ambientC: ambientC,
                conductors: conductors,
                chosenSize: chosenSize,
                resultSize: resultSize,
                dropPercent: dropPercent,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ElectricalRunsTable, ElectricalRun>(table),
                  $$ElectricalRunsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$ElectricalRunsTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$ElectricalRunsTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$ElectricalRunsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ElectricalRunsTable,
      ElectricalRun,
      $$ElectricalRunsTableFilterComposer,
      $$ElectricalRunsTableOrderingComposer,
      $$ElectricalRunsTableAnnotationComposer,
      $$ElectricalRunsTableCreateCompanionBuilder,
      $$ElectricalRunsTableUpdateCompanionBuilder,
      (ElectricalRun, $$ElectricalRunsTableReferences),
      ElectricalRun,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$ProtectionDevicesTableCreateCompanionBuilder =
    ProtectionDevicesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String projectId,
      required ProtectionDeviceKind kind,
      Value<double?> ratingA,
      Value<double?> voltageV,
      Value<int> quantity,
      Value<String?> conductorSize,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$ProtectionDevicesTableUpdateCompanionBuilder =
    ProtectionDevicesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> projectId,
      Value<ProtectionDeviceKind> kind,
      Value<double?> ratingA,
      Value<double?> voltageV,
      Value<int> quantity,
      Value<String?> conductorSize,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$ProtectionDevicesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ProtectionDevicesTable,
          ProtectionDevice
        > {
  $$ProtectionDevicesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('protection_devices__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ProtectionDevicesTableFilterComposer
    extends Composer<_$AppDatabase, $ProtectionDevicesTable> {
  $$ProtectionDevicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    ProtectionDeviceKind,
    ProtectionDeviceKind,
    String
  >
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get ratingA => $composableBuilder(
    column: $table.ratingA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get voltageV => $composableBuilder(
    column: $table.voltageV,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conductorSize => $composableBuilder(
    column: $table.conductorSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProtectionDevicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProtectionDevicesTable> {
  $$ProtectionDevicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratingA => $composableBuilder(
    column: $table.ratingA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get voltageV => $composableBuilder(
    column: $table.voltageV,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conductorSize => $composableBuilder(
    column: $table.conductorSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProtectionDevicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProtectionDevicesTable> {
  $$ProtectionDevicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProtectionDeviceKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get ratingA =>
      $composableBuilder(column: $table.ratingA, builder: (column) => column);

  GeneratedColumn<double> get voltageV =>
      $composableBuilder(column: $table.voltageV, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get conductorSize => $composableBuilder(
    column: $table.conductorSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProtectionDevicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProtectionDevicesTable,
          ProtectionDevice,
          $$ProtectionDevicesTableFilterComposer,
          $$ProtectionDevicesTableOrderingComposer,
          $$ProtectionDevicesTableAnnotationComposer,
          $$ProtectionDevicesTableCreateCompanionBuilder,
          $$ProtectionDevicesTableUpdateCompanionBuilder,
          (ProtectionDevice, $$ProtectionDevicesTableReferences),
          ProtectionDevice,
          PrefetchHooks Function({bool projectId})
        > {
  $$ProtectionDevicesTableTableManager(
    _$AppDatabase db,
    $ProtectionDevicesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProtectionDevicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProtectionDevicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProtectionDevicesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<ProtectionDeviceKind> kind = const Value.absent(),
                Value<double?> ratingA = const Value.absent(),
                Value<double?> voltageV = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> conductorSize = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProtectionDevicesCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                kind: kind,
                ratingA: ratingA,
                voltageV: voltageV,
                quantity: quantity,
                conductorSize: conductorSize,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required ProtectionDeviceKind kind,
                Value<double?> ratingA = const Value.absent(),
                Value<double?> voltageV = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<String?> conductorSize = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProtectionDevicesCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                kind: kind,
                ratingA: ratingA,
                voltageV: voltageV,
                quantity: quantity,
                conductorSize: conductorSize,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProtectionDevicesTable, ProtectionDevice>(table),
                  $$ProtectionDevicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$ProtectionDevicesTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$ProtectionDevicesTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$ProtectionDevicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProtectionDevicesTable,
      ProtectionDevice,
      $$ProtectionDevicesTableFilterComposer,
      $$ProtectionDevicesTableOrderingComposer,
      $$ProtectionDevicesTableAnnotationComposer,
      $$ProtectionDevicesTableCreateCompanionBuilder,
      $$ProtectionDevicesTableUpdateCompanionBuilder,
      (ProtectionDevice, $$ProtectionDevicesTableReferences),
      ProtectionDevice,
      PrefetchHooks Function({bool projectId})
    >;
typedef $$SimulationResultsTableCreateCompanionBuilder =
    SimulationResultsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      required String projectId,
      required double pdcW,
      required double pacW,
      required double firstYearKwh,
      required double lifetimeKwh,
      Value<int> years,
      required String monthlyKwh,
      required String yearlyKwh,
      Value<double> clippedKwh,
      Value<double> shadingLossPct,
      required double specificYield,
      required double performanceRatio,
      Value<String> losses,
      Value<String?> weatherLabel,
      Value<int> rowid,
    });
typedef $$SimulationResultsTableUpdateCompanionBuilder =
    SimulationResultsCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<String> projectId,
      Value<double> pdcW,
      Value<double> pacW,
      Value<double> firstYearKwh,
      Value<double> lifetimeKwh,
      Value<int> years,
      Value<String> monthlyKwh,
      Value<String> yearlyKwh,
      Value<double> clippedKwh,
      Value<double> shadingLossPct,
      Value<double> specificYield,
      Value<double> performanceRatio,
      Value<String> losses,
      Value<String?> weatherLabel,
      Value<int> rowid,
    });

final class $$SimulationResultsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SimulationResultsTable,
          SimulationResultRecord
        > {
  $$SimulationResultsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ProjectsTable _projectIdTable(_$AppDatabase db) =>
      db.projects.createAlias('simulation_results__project_id__projects__id');

  $$ProjectsTableProcessedTableManager get projectId {
    final $_column = $_itemColumn<String>('project_id')!;

    final manager = $$ProjectsTableTableManager(
      $_db,
      $_db.projects,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_projectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SimulationResultsTableFilterComposer
    extends Composer<_$AppDatabase, $SimulationResultsTable> {
  $$SimulationResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pdcW => $composableBuilder(
    column: $table.pdcW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pacW => $composableBuilder(
    column: $table.pacW,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get firstYearKwh => $composableBuilder(
    column: $table.firstYearKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lifetimeKwh => $composableBuilder(
    column: $table.lifetimeKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get years => $composableBuilder(
    column: $table.years,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get monthlyKwh => $composableBuilder(
    column: $table.monthlyKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get yearlyKwh => $composableBuilder(
    column: $table.yearlyKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get clippedKwh => $composableBuilder(
    column: $table.clippedKwh,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get shadingLossPct => $composableBuilder(
    column: $table.shadingLossPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get specificYield => $composableBuilder(
    column: $table.specificYield,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get performanceRatio => $composableBuilder(
    column: $table.performanceRatio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get losses => $composableBuilder(
    column: $table.losses,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get weatherLabel => $composableBuilder(
    column: $table.weatherLabel,
    builder: (column) => ColumnFilters(column),
  );

  $$ProjectsTableFilterComposer get projectId {
    final $$ProjectsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableFilterComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SimulationResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $SimulationResultsTable> {
  $$SimulationResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pdcW => $composableBuilder(
    column: $table.pdcW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pacW => $composableBuilder(
    column: $table.pacW,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get firstYearKwh => $composableBuilder(
    column: $table.firstYearKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lifetimeKwh => $composableBuilder(
    column: $table.lifetimeKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get years => $composableBuilder(
    column: $table.years,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get monthlyKwh => $composableBuilder(
    column: $table.monthlyKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get yearlyKwh => $composableBuilder(
    column: $table.yearlyKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get clippedKwh => $composableBuilder(
    column: $table.clippedKwh,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get shadingLossPct => $composableBuilder(
    column: $table.shadingLossPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get specificYield => $composableBuilder(
    column: $table.specificYield,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get performanceRatio => $composableBuilder(
    column: $table.performanceRatio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get losses => $composableBuilder(
    column: $table.losses,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get weatherLabel => $composableBuilder(
    column: $table.weatherLabel,
    builder: (column) => ColumnOrderings(column),
  );

  $$ProjectsTableOrderingComposer get projectId {
    final $$ProjectsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableOrderingComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SimulationResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SimulationResultsTable> {
  $$SimulationResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<double> get pdcW =>
      $composableBuilder(column: $table.pdcW, builder: (column) => column);

  GeneratedColumn<double> get pacW =>
      $composableBuilder(column: $table.pacW, builder: (column) => column);

  GeneratedColumn<double> get firstYearKwh => $composableBuilder(
    column: $table.firstYearKwh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lifetimeKwh => $composableBuilder(
    column: $table.lifetimeKwh,
    builder: (column) => column,
  );

  GeneratedColumn<int> get years =>
      $composableBuilder(column: $table.years, builder: (column) => column);

  GeneratedColumn<String> get monthlyKwh => $composableBuilder(
    column: $table.monthlyKwh,
    builder: (column) => column,
  );

  GeneratedColumn<String> get yearlyKwh =>
      $composableBuilder(column: $table.yearlyKwh, builder: (column) => column);

  GeneratedColumn<double> get clippedKwh => $composableBuilder(
    column: $table.clippedKwh,
    builder: (column) => column,
  );

  GeneratedColumn<double> get shadingLossPct => $composableBuilder(
    column: $table.shadingLossPct,
    builder: (column) => column,
  );

  GeneratedColumn<double> get specificYield => $composableBuilder(
    column: $table.specificYield,
    builder: (column) => column,
  );

  GeneratedColumn<double> get performanceRatio => $composableBuilder(
    column: $table.performanceRatio,
    builder: (column) => column,
  );

  GeneratedColumn<String> get losses =>
      $composableBuilder(column: $table.losses, builder: (column) => column);

  GeneratedColumn<String> get weatherLabel => $composableBuilder(
    column: $table.weatherLabel,
    builder: (column) => column,
  );

  $$ProjectsTableAnnotationComposer get projectId {
    final $$ProjectsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.projectId,
      referencedTable: $db.projects,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProjectsTableAnnotationComposer(
            $db: $db,
            $table: $db.projects,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SimulationResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SimulationResultsTable,
          SimulationResultRecord,
          $$SimulationResultsTableFilterComposer,
          $$SimulationResultsTableOrderingComposer,
          $$SimulationResultsTableAnnotationComposer,
          $$SimulationResultsTableCreateCompanionBuilder,
          $$SimulationResultsTableUpdateCompanionBuilder,
          (SimulationResultRecord, $$SimulationResultsTableReferences),
          SimulationResultRecord,
          PrefetchHooks Function({bool projectId})
        > {
  $$SimulationResultsTableTableManager(
    _$AppDatabase db,
    $SimulationResultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SimulationResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SimulationResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SimulationResultsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<String> projectId = const Value.absent(),
                Value<double> pdcW = const Value.absent(),
                Value<double> pacW = const Value.absent(),
                Value<double> firstYearKwh = const Value.absent(),
                Value<double> lifetimeKwh = const Value.absent(),
                Value<int> years = const Value.absent(),
                Value<String> monthlyKwh = const Value.absent(),
                Value<String> yearlyKwh = const Value.absent(),
                Value<double> clippedKwh = const Value.absent(),
                Value<double> shadingLossPct = const Value.absent(),
                Value<double> specificYield = const Value.absent(),
                Value<double> performanceRatio = const Value.absent(),
                Value<String> losses = const Value.absent(),
                Value<String?> weatherLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SimulationResultsCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                pdcW: pdcW,
                pacW: pacW,
                firstYearKwh: firstYearKwh,
                lifetimeKwh: lifetimeKwh,
                years: years,
                monthlyKwh: monthlyKwh,
                yearlyKwh: yearlyKwh,
                clippedKwh: clippedKwh,
                shadingLossPct: shadingLossPct,
                specificYield: specificYield,
                performanceRatio: performanceRatio,
                losses: losses,
                weatherLabel: weatherLabel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                required String projectId,
                required double pdcW,
                required double pacW,
                required double firstYearKwh,
                required double lifetimeKwh,
                Value<int> years = const Value.absent(),
                required String monthlyKwh,
                required String yearlyKwh,
                Value<double> clippedKwh = const Value.absent(),
                Value<double> shadingLossPct = const Value.absent(),
                required double specificYield,
                required double performanceRatio,
                Value<String> losses = const Value.absent(),
                Value<String?> weatherLabel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SimulationResultsCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                projectId: projectId,
                pdcW: pdcW,
                pacW: pacW,
                firstYearKwh: firstYearKwh,
                lifetimeKwh: lifetimeKwh,
                years: years,
                monthlyKwh: monthlyKwh,
                yearlyKwh: yearlyKwh,
                clippedKwh: clippedKwh,
                shadingLossPct: shadingLossPct,
                specificYield: specificYield,
                performanceRatio: performanceRatio,
                losses: losses,
                weatherLabel: weatherLabel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SimulationResultsTable, SimulationResultRecord>(
                    table,
                  ),
                  $$SimulationResultsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({projectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (projectId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.projectId,
                        referencedTable: $$SimulationResultsTableReferences
                            ._projectIdTable(db),
                        referencedColumn: $$SimulationResultsTableReferences
                            ._projectIdTable(db)
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
        ),
      );
}

typedef $$SimulationResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SimulationResultsTable,
      SimulationResultRecord,
      $$SimulationResultsTableFilterComposer,
      $$SimulationResultsTableOrderingComposer,
      $$SimulationResultsTableAnnotationComposer,
      $$SimulationResultsTableCreateCompanionBuilder,
      $$SimulationResultsTableUpdateCompanionBuilder,
      (SimulationResultRecord, $$SimulationResultsTableReferences),
      SimulationResultRecord,
      PrefetchHooks Function({bool projectId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompaniesTableTableManager get companies =>
      $$CompaniesTableTableManager(_db, _db.companies);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$ProjectsTableTableManager get projects =>
      $$ProjectsTableTableManager(_db, _db.projects);
  $$SitesTableTableManager get sites =>
      $$SitesTableTableManager(_db, _db.sites);
  $$UtilityBillsTableTableManager get utilityBills =>
      $$UtilityBillsTableTableManager(_db, _db.utilityBills);
  $$PhotosTableTableManager get photos =>
      $$PhotosTableTableManager(_db, _db.photos);
  $$DocumentsTableTableManager get documents =>
      $$DocumentsTableTableManager(_db, _db.documents);
  $$RoofImagesTableTableManager get roofImages =>
      $$RoofImagesTableTableManager(_db, _db.roofImages);
  $$RoofPlanesTableTableManager get roofPlanes =>
      $$RoofPlanesTableTableManager(_db, _db.roofPlanes);
  $$ObstaclesTableTableManager get obstacles =>
      $$ObstaclesTableTableManager(_db, _db.obstacles);
  $$HorizonProfilesTableTableManager get horizonProfiles =>
      $$HorizonProfilesTableTableManager(_db, _db.horizonProfiles);
  $$PanelModelsTableTableManager get panelModels =>
      $$PanelModelsTableTableManager(_db, _db.panelModels);
  $$InverterModelsTableTableManager get inverterModels =>
      $$InverterModelsTableTableManager(_db, _db.inverterModels);
  $$OptimizerModelsTableTableManager get optimizerModels =>
      $$OptimizerModelsTableTableManager(_db, _db.optimizerModels);
  $$BatteryModelsTableTableManager get batteryModels =>
      $$BatteryModelsTableTableManager(_db, _db.batteryModels);
  $$PvDesignsTableTableManager get pvDesigns =>
      $$PvDesignsTableTableManager(_db, _db.pvDesigns);
  $$ArrayLayoutsTableTableManager get arrayLayouts =>
      $$ArrayLayoutsTableTableManager(_db, _db.arrayLayouts);
  $$StringConfigsTableTableManager get stringConfigs =>
      $$StringConfigsTableTableManager(_db, _db.stringConfigs);
  $$ElectricalRunsTableTableManager get electricalRuns =>
      $$ElectricalRunsTableTableManager(_db, _db.electricalRuns);
  $$ProtectionDevicesTableTableManager get protectionDevices =>
      $$ProtectionDevicesTableTableManager(_db, _db.protectionDevices);
  $$SimulationResultsTableTableManager get simulationResults =>
      $$SimulationResultsTableTableManager(_db, _db.simulationResults);
}
