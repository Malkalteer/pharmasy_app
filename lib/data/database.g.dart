// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta('passwordHash');
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saltMeta = const VerificationMeta('salt');
  @override
  late final GeneratedColumn<String> salt = GeneratedColumn<String>(
    'salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _permissionsMeta = const VerificationMeta('permissions');
  @override
  late final GeneratedColumn<String> permissions = GeneratedColumn<String>(
    'permissions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    fullName,
    passwordHash,
    salt,
    role,
    permissions,
    active,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta, username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta, fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('password_hash')) {
      context.handle(_passwordHashMeta, passwordHash.isAcceptableOrUnknown(data['password_hash']!, _passwordHashMeta));
    } else if (isInserting) {
      context.missing(_passwordHashMeta);
    }
    if (data.containsKey('salt')) {
      context.handle(_saltMeta, salt.isAcceptableOrUnknown(data['salt']!, _saltMeta));
    } else if (isInserting) {
      context.missing(_saltMeta);
    }
    if (data.containsKey('role')) {
      context.handle(_roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('permissions')) {
      context.handle(_permissionsMeta, permissions.isAcceptableOrUnknown(data['permissions']!, _permissionsMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      username: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}username'])!,
      fullName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      passwordHash: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}password_hash'])!,
      salt: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}salt'])!,
      role: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      permissions: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}permissions'])!,
      active: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String username;
  final String fullName;
  final String passwordHash;
  final String salt;

  /// owner = مالك (كل الصلاحيات)، pharmacist = صيدلي
  final String role;

  /// قائمة صلاحيات مفصولة بفواصل (انظر Permission)
  final String permissions;
  final bool active;
  final DateTime createdAt;
  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.passwordHash,
    required this.salt,
    required this.role,
    required this.permissions,
    required this.active,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['full_name'] = Variable<String>(fullName);
    map['password_hash'] = Variable<String>(passwordHash);
    map['salt'] = Variable<String>(salt);
    map['role'] = Variable<String>(role);
    map['permissions'] = Variable<String>(permissions);
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      username: Value(username),
      fullName: Value(fullName),
      passwordHash: Value(passwordHash),
      salt: Value(salt),
      role: Value(role),
      permissions: Value(permissions),
      active: Value(active),
      createdAt: Value(createdAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      fullName: serializer.fromJson<String>(json['fullName']),
      passwordHash: serializer.fromJson<String>(json['passwordHash']),
      salt: serializer.fromJson<String>(json['salt']),
      role: serializer.fromJson<String>(json['role']),
      permissions: serializer.fromJson<String>(json['permissions']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'fullName': serializer.toJson<String>(fullName),
      'passwordHash': serializer.toJson<String>(passwordHash),
      'salt': serializer.toJson<String>(salt),
      'role': serializer.toJson<String>(role),
      'permissions': serializer.toJson<String>(permissions),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  User copyWith({
    int? id,
    String? username,
    String? fullName,
    String? passwordHash,
    String? salt,
    String? role,
    String? permissions,
    bool? active,
    DateTime? createdAt,
  }) => User(
    id: id ?? this.id,
    username: username ?? this.username,
    fullName: fullName ?? this.fullName,
    passwordHash: passwordHash ?? this.passwordHash,
    salt: salt ?? this.salt,
    role: role ?? this.role,
    permissions: permissions ?? this.permissions,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      passwordHash: data.passwordHash.present ? data.passwordHash.value : this.passwordHash,
      salt: data.salt.present ? data.salt.value : this.salt,
      role: data.role.present ? data.role.value : this.role,
      permissions: data.permissions.present ? data.permissions.value : this.permissions,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('role: $role, ')
          ..write('permissions: $permissions, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, fullName, passwordHash, salt, role, permissions, active, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.username == this.username &&
          other.fullName == this.fullName &&
          other.passwordHash == this.passwordHash &&
          other.salt == this.salt &&
          other.role == this.role &&
          other.permissions == this.permissions &&
          other.active == this.active &&
          other.createdAt == this.createdAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> fullName;
  final Value<String> passwordHash;
  final Value<String> salt;
  final Value<String> role;
  final Value<String> permissions;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.fullName = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.salt = const Value.absent(),
    this.role = const Value.absent(),
    this.permissions = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String fullName,
    required String passwordHash,
    required String salt,
    required String role,
    this.permissions = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : username = Value(username),
       fullName = Value(fullName),
       passwordHash = Value(passwordHash),
       salt = Value(salt),
       role = Value(role);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? fullName,
    Expression<String>? passwordHash,
    Expression<String>? salt,
    Expression<String>? role,
    Expression<String>? permissions,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (fullName != null) 'full_name': fullName,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (salt != null) 'salt': salt,
      if (role != null) 'role': role,
      if (permissions != null) 'permissions': permissions,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<String>? fullName,
    Value<String>? passwordHash,
    Value<String>? salt,
    Value<String>? role,
    Value<String>? permissions,
    Value<bool>? active,
    Value<DateTime>? createdAt,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      passwordHash: passwordHash ?? this.passwordHash,
      salt: salt ?? this.salt,
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (salt.present) {
      map['salt'] = Variable<String>(salt.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (permissions.present) {
      map['permissions'] = Variable<String>(permissions.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('fullName: $fullName, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('salt: $salt, ')
          ..write('role: $role, ')
          ..write('permissions: $permissions, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<Setting> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(_keyMeta, key.isAcceptableOrUnknown(data['key']!, _keyMeta));
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(_valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}key'])!,
      value: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}value'])!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory Setting.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(key: serializer.fromJson<String>(json['key']), value: serializer.fromJson<String>(json['value']));
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{'key': serializer.toJson<String>(key), 'value': serializer.toJson<String>(value)};
  }

  Setting copyWith({String? key, String? value}) => Setting(key: key ?? this.key, value: value ?? this.value);
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({required String key, required String value, this.rowid = const Value.absent()})
    : key = Value(key),
      value = Value(value);
  static Insertable<Setting> custom({Expression<String>? key, Expression<String>? value, Expression<int>? rowid}) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({Value<String>? key, Value<String>? value, Value<int>? rowid}) {
    return SettingsCompanion(key: key ?? this.key, value: value ?? this.value, rowid: rowid ?? this.rowid);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExchangeRatesTable extends ExchangeRates with TableInfo<$ExchangeRatesTable, ExchangeRate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExchangeRatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES users (id)'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, rate, userId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exchange_rates';
  @override
  VerificationContext validateIntegrity(Insertable<ExchangeRate> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('rate')) {
      context.handle(_rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExchangeRate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExchangeRate(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      rate: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExchangeRatesTable createAlias(String alias) {
    return $ExchangeRatesTable(attachedDatabase, alias);
  }
}

class ExchangeRate extends DataClass implements Insertable<ExchangeRate> {
  final int id;
  final double rate;
  final int? userId;
  final DateTime createdAt;
  const ExchangeRate({required this.id, required this.rate, this.userId, required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['rate'] = Variable<double>(rate);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExchangeRatesCompanion toCompanion(bool nullToAbsent) {
    return ExchangeRatesCompanion(
      id: Value(id),
      rate: Value(rate),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory ExchangeRate.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExchangeRate(
      id: serializer.fromJson<int>(json['id']),
      rate: serializer.fromJson<double>(json['rate']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'rate': serializer.toJson<double>(rate),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExchangeRate copyWith({int? id, double? rate, Value<int?> userId = const Value.absent(), DateTime? createdAt}) =>
      ExchangeRate(
        id: id ?? this.id,
        rate: rate ?? this.rate,
        userId: userId.present ? userId.value : this.userId,
        createdAt: createdAt ?? this.createdAt,
      );
  ExchangeRate copyWithCompanion(ExchangeRatesCompanion data) {
    return ExchangeRate(
      id: data.id.present ? data.id.value : this.id,
      rate: data.rate.present ? data.rate.value : this.rate,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRate(')
          ..write('id: $id, ')
          ..write('rate: $rate, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, rate, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExchangeRate &&
          other.id == this.id &&
          other.rate == this.rate &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class ExchangeRatesCompanion extends UpdateCompanion<ExchangeRate> {
  final Value<int> id;
  final Value<double> rate;
  final Value<int?> userId;
  final Value<DateTime> createdAt;
  const ExchangeRatesCompanion({
    this.id = const Value.absent(),
    this.rate = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ExchangeRatesCompanion.insert({
    this.id = const Value.absent(),
    required double rate,
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : rate = Value(rate);
  static Insertable<ExchangeRate> custom({
    Expression<int>? id,
    Expression<double>? rate,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (rate != null) 'rate': rate,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ExchangeRatesCompanion copyWith({
    Value<int>? id,
    Value<double>? rate,
    Value<int?>? userId,
    Value<DateTime>? createdAt,
  }) {
    return ExchangeRatesCompanion(
      id: id ?? this.id,
      rate: rate ?? this.rate,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExchangeRatesCompanion(')
          ..write('id: $id, ')
          ..write('rate: $rate, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $MedicinesTable extends Medicines with TableInfo<$MedicinesTable, Medicine> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
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
  static const VerificationMeta _scientificNameMeta = const VerificationMeta('scientificName');
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _manufacturerMeta = const VerificationMeta('manufacturer');
  @override
  late final GeneratedColumn<String> manufacturer = GeneratedColumn<String>(
    'manufacturer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _formMeta = const VerificationMeta('form');
  @override
  late final GeneratedColumn<String> form = GeneratedColumn<String>(
    'form',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _stripsPerBoxMeta = const VerificationMeta('stripsPerBox');
  @override
  late final GeneratedColumn<int> stripsPerBox = GeneratedColumn<int>(
    'strips_per_box',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitsPerStripMeta = const VerificationMeta('unitsPerStrip');
  @override
  late final GeneratedColumn<int> unitsPerStrip = GeneratedColumn<int>(
    'units_per_strip',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _boxNameMeta = const VerificationMeta('boxName');
  @override
  late final GeneratedColumn<String> boxName = GeneratedColumn<String>(
    'box_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('علبة'),
  );
  static const VerificationMeta _stripNameMeta = const VerificationMeta('stripName');
  @override
  late final GeneratedColumn<String> stripName = GeneratedColumn<String>(
    'strip_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('ظرف'),
  );
  static const VerificationMeta _unitNameMeta = const VerificationMeta('unitName');
  @override
  late final GeneratedColumn<String> unitName = GeneratedColumn<String>(
    'unit_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('حبة'),
  );
  static const VerificationMeta _allowStripSaleMeta = const VerificationMeta('allowStripSale');
  @override
  late final GeneratedColumn<bool> allowStripSale = GeneratedColumn<bool>(
    'allow_strip_sale',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("allow_strip_sale" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _allowUnitSaleMeta = const VerificationMeta('allowUnitSale');
  @override
  late final GeneratedColumn<bool> allowUnitSale = GeneratedColumn<bool>(
    'allow_unit_sale',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("allow_unit_sale" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _priceUsdMeta = const VerificationMeta('priceUsd');
  @override
  late final GeneratedColumn<double> priceUsd = GeneratedColumn<double>(
    'price_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _stripPriceUsdMeta = const VerificationMeta('stripPriceUsd');
  @override
  late final GeneratedColumn<double> stripPriceUsd = GeneratedColumn<double>(
    'strip_price_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitPriceUsdMeta = const VerificationMeta('unitPriceUsd');
  @override
  late final GeneratedColumn<double> unitPriceUsd = GeneratedColumn<double>(
    'unit_price_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minStockBoxesMeta = const VerificationMeta('minStockBoxes');
  @override
  late final GeneratedColumn<double> minStockBoxes = GeneratedColumn<double>(
    'min_stock_boxes',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _requiresPrescriptionMeta = const VerificationMeta('requiresPrescription');
  @override
  late final GeneratedColumn<bool> requiresPrescription = GeneratedColumn<bool>(
    'requires_prescription',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("requires_prescription" IN (0, 1))'),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    scientificName,
    manufacturer,
    form,
    category,
    barcode,
    stripsPerBox,
    unitsPerStrip,
    boxName,
    stripName,
    unitName,
    allowStripSale,
    allowUnitSale,
    priceUsd,
    stripPriceUsd,
    unitPriceUsd,
    minStockBoxes,
    requiresPrescription,
    active,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicines';
  @override
  VerificationContext validateIntegrity(Insertable<Medicine> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(data['scientific_name']!, _scientificNameMeta),
      );
    }
    if (data.containsKey('manufacturer')) {
      context.handle(_manufacturerMeta, manufacturer.isAcceptableOrUnknown(data['manufacturer']!, _manufacturerMeta));
    }
    if (data.containsKey('form')) {
      context.handle(_formMeta, form.isAcceptableOrUnknown(data['form']!, _formMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta, category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta, barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('strips_per_box')) {
      context.handle(_stripsPerBoxMeta, stripsPerBox.isAcceptableOrUnknown(data['strips_per_box']!, _stripsPerBoxMeta));
    }
    if (data.containsKey('units_per_strip')) {
      context.handle(
        _unitsPerStripMeta,
        unitsPerStrip.isAcceptableOrUnknown(data['units_per_strip']!, _unitsPerStripMeta),
      );
    }
    if (data.containsKey('box_name')) {
      context.handle(_boxNameMeta, boxName.isAcceptableOrUnknown(data['box_name']!, _boxNameMeta));
    }
    if (data.containsKey('strip_name')) {
      context.handle(_stripNameMeta, stripName.isAcceptableOrUnknown(data['strip_name']!, _stripNameMeta));
    }
    if (data.containsKey('unit_name')) {
      context.handle(_unitNameMeta, unitName.isAcceptableOrUnknown(data['unit_name']!, _unitNameMeta));
    }
    if (data.containsKey('allow_strip_sale')) {
      context.handle(
        _allowStripSaleMeta,
        allowStripSale.isAcceptableOrUnknown(data['allow_strip_sale']!, _allowStripSaleMeta),
      );
    }
    if (data.containsKey('allow_unit_sale')) {
      context.handle(
        _allowUnitSaleMeta,
        allowUnitSale.isAcceptableOrUnknown(data['allow_unit_sale']!, _allowUnitSaleMeta),
      );
    }
    if (data.containsKey('price_usd')) {
      context.handle(_priceUsdMeta, priceUsd.isAcceptableOrUnknown(data['price_usd']!, _priceUsdMeta));
    }
    if (data.containsKey('strip_price_usd')) {
      context.handle(
        _stripPriceUsdMeta,
        stripPriceUsd.isAcceptableOrUnknown(data['strip_price_usd']!, _stripPriceUsdMeta),
      );
    }
    if (data.containsKey('unit_price_usd')) {
      context.handle(_unitPriceUsdMeta, unitPriceUsd.isAcceptableOrUnknown(data['unit_price_usd']!, _unitPriceUsdMeta));
    }
    if (data.containsKey('min_stock_boxes')) {
      context.handle(
        _minStockBoxesMeta,
        minStockBoxes.isAcceptableOrUnknown(data['min_stock_boxes']!, _minStockBoxesMeta),
      );
    }
    if (data.containsKey('requires_prescription')) {
      context.handle(
        _requiresPrescriptionMeta,
        requiresPrescription.isAcceptableOrUnknown(data['requires_prescription']!, _requiresPrescriptionMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medicine map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medicine(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      scientificName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}scientific_name']),
      manufacturer: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}manufacturer']),
      form: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}form']),
      category: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}category']),
      barcode: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      stripsPerBox: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}strips_per_box'])!,
      unitsPerStrip: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}units_per_strip'])!,
      boxName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}box_name'])!,
      stripName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}strip_name'])!,
      unitName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}unit_name'])!,
      allowStripSale: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}allow_strip_sale'])!,
      allowUnitSale: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}allow_unit_sale'])!,
      priceUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}price_usd'])!,
      stripPriceUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}strip_price_usd']),
      unitPriceUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}unit_price_usd']),
      minStockBoxes: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}min_stock_boxes'])!,
      requiresPrescription: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_prescription'],
      )!,
      active: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $MedicinesTable createAlias(String alias) {
    return $MedicinesTable(attachedDatabase, alias);
  }
}

class Medicine extends DataClass implements Insertable<Medicine> {
  final int id;
  final String name;

  /// المادة الفعالة (تُستخدم لاقتراح البدائل)
  final String? scientificName;
  final String? manufacturer;

  /// الشكل الصيدلاني: حب، شراب، حقن...
  final String? form;
  final String? category;
  final String? barcode;

  /// عدد الأشرطة (الظروف) في العلبة
  final int stripsPerBox;

  /// عدد الحبات في الشريط
  final int unitsPerStrip;
  final String boxName;
  final String stripName;
  final String unitName;
  final bool allowStripSale;
  final bool allowUnitSale;

  /// سعر بيع العلبة بالدولار
  final double priceUsd;

  /// سعر خاص للشريط/الحبة (اختياري، وإلا يُحسب تناسبياً)
  final double? stripPriceUsd;
  final double? unitPriceUsd;

  /// الحد الأدنى للمخزون بالعلب
  final double minStockBoxes;
  final bool requiresPrescription;
  final bool active;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Medicine({
    required this.id,
    required this.name,
    this.scientificName,
    this.manufacturer,
    this.form,
    this.category,
    this.barcode,
    required this.stripsPerBox,
    required this.unitsPerStrip,
    required this.boxName,
    required this.stripName,
    required this.unitName,
    required this.allowStripSale,
    required this.allowUnitSale,
    required this.priceUsd,
    this.stripPriceUsd,
    this.unitPriceUsd,
    required this.minStockBoxes,
    required this.requiresPrescription,
    required this.active,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || scientificName != null) {
      map['scientific_name'] = Variable<String>(scientificName);
    }
    if (!nullToAbsent || manufacturer != null) {
      map['manufacturer'] = Variable<String>(manufacturer);
    }
    if (!nullToAbsent || form != null) {
      map['form'] = Variable<String>(form);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['strips_per_box'] = Variable<int>(stripsPerBox);
    map['units_per_strip'] = Variable<int>(unitsPerStrip);
    map['box_name'] = Variable<String>(boxName);
    map['strip_name'] = Variable<String>(stripName);
    map['unit_name'] = Variable<String>(unitName);
    map['allow_strip_sale'] = Variable<bool>(allowStripSale);
    map['allow_unit_sale'] = Variable<bool>(allowUnitSale);
    map['price_usd'] = Variable<double>(priceUsd);
    if (!nullToAbsent || stripPriceUsd != null) {
      map['strip_price_usd'] = Variable<double>(stripPriceUsd);
    }
    if (!nullToAbsent || unitPriceUsd != null) {
      map['unit_price_usd'] = Variable<double>(unitPriceUsd);
    }
    map['min_stock_boxes'] = Variable<double>(minStockBoxes);
    map['requires_prescription'] = Variable<bool>(requiresPrescription);
    map['active'] = Variable<bool>(active);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      id: Value(id),
      name: Value(name),
      scientificName: scientificName == null && nullToAbsent ? const Value.absent() : Value(scientificName),
      manufacturer: manufacturer == null && nullToAbsent ? const Value.absent() : Value(manufacturer),
      form: form == null && nullToAbsent ? const Value.absent() : Value(form),
      category: category == null && nullToAbsent ? const Value.absent() : Value(category),
      barcode: barcode == null && nullToAbsent ? const Value.absent() : Value(barcode),
      stripsPerBox: Value(stripsPerBox),
      unitsPerStrip: Value(unitsPerStrip),
      boxName: Value(boxName),
      stripName: Value(stripName),
      unitName: Value(unitName),
      allowStripSale: Value(allowStripSale),
      allowUnitSale: Value(allowUnitSale),
      priceUsd: Value(priceUsd),
      stripPriceUsd: stripPriceUsd == null && nullToAbsent ? const Value.absent() : Value(stripPriceUsd),
      unitPriceUsd: unitPriceUsd == null && nullToAbsent ? const Value.absent() : Value(unitPriceUsd),
      minStockBoxes: Value(minStockBoxes),
      requiresPrescription: Value(requiresPrescription),
      active: Value(active),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Medicine.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medicine(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      scientificName: serializer.fromJson<String?>(json['scientificName']),
      manufacturer: serializer.fromJson<String?>(json['manufacturer']),
      form: serializer.fromJson<String?>(json['form']),
      category: serializer.fromJson<String?>(json['category']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      stripsPerBox: serializer.fromJson<int>(json['stripsPerBox']),
      unitsPerStrip: serializer.fromJson<int>(json['unitsPerStrip']),
      boxName: serializer.fromJson<String>(json['boxName']),
      stripName: serializer.fromJson<String>(json['stripName']),
      unitName: serializer.fromJson<String>(json['unitName']),
      allowStripSale: serializer.fromJson<bool>(json['allowStripSale']),
      allowUnitSale: serializer.fromJson<bool>(json['allowUnitSale']),
      priceUsd: serializer.fromJson<double>(json['priceUsd']),
      stripPriceUsd: serializer.fromJson<double?>(json['stripPriceUsd']),
      unitPriceUsd: serializer.fromJson<double?>(json['unitPriceUsd']),
      minStockBoxes: serializer.fromJson<double>(json['minStockBoxes']),
      requiresPrescription: serializer.fromJson<bool>(json['requiresPrescription']),
      active: serializer.fromJson<bool>(json['active']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'scientificName': serializer.toJson<String?>(scientificName),
      'manufacturer': serializer.toJson<String?>(manufacturer),
      'form': serializer.toJson<String?>(form),
      'category': serializer.toJson<String?>(category),
      'barcode': serializer.toJson<String?>(barcode),
      'stripsPerBox': serializer.toJson<int>(stripsPerBox),
      'unitsPerStrip': serializer.toJson<int>(unitsPerStrip),
      'boxName': serializer.toJson<String>(boxName),
      'stripName': serializer.toJson<String>(stripName),
      'unitName': serializer.toJson<String>(unitName),
      'allowStripSale': serializer.toJson<bool>(allowStripSale),
      'allowUnitSale': serializer.toJson<bool>(allowUnitSale),
      'priceUsd': serializer.toJson<double>(priceUsd),
      'stripPriceUsd': serializer.toJson<double?>(stripPriceUsd),
      'unitPriceUsd': serializer.toJson<double?>(unitPriceUsd),
      'minStockBoxes': serializer.toJson<double>(minStockBoxes),
      'requiresPrescription': serializer.toJson<bool>(requiresPrescription),
      'active': serializer.toJson<bool>(active),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Medicine copyWith({
    int? id,
    String? name,
    Value<String?> scientificName = const Value.absent(),
    Value<String?> manufacturer = const Value.absent(),
    Value<String?> form = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    int? stripsPerBox,
    int? unitsPerStrip,
    String? boxName,
    String? stripName,
    String? unitName,
    bool? allowStripSale,
    bool? allowUnitSale,
    double? priceUsd,
    Value<double?> stripPriceUsd = const Value.absent(),
    Value<double?> unitPriceUsd = const Value.absent(),
    double? minStockBoxes,
    bool? requiresPrescription,
    bool? active,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Medicine(
    id: id ?? this.id,
    name: name ?? this.name,
    scientificName: scientificName.present ? scientificName.value : this.scientificName,
    manufacturer: manufacturer.present ? manufacturer.value : this.manufacturer,
    form: form.present ? form.value : this.form,
    category: category.present ? category.value : this.category,
    barcode: barcode.present ? barcode.value : this.barcode,
    stripsPerBox: stripsPerBox ?? this.stripsPerBox,
    unitsPerStrip: unitsPerStrip ?? this.unitsPerStrip,
    boxName: boxName ?? this.boxName,
    stripName: stripName ?? this.stripName,
    unitName: unitName ?? this.unitName,
    allowStripSale: allowStripSale ?? this.allowStripSale,
    allowUnitSale: allowUnitSale ?? this.allowUnitSale,
    priceUsd: priceUsd ?? this.priceUsd,
    stripPriceUsd: stripPriceUsd.present ? stripPriceUsd.value : this.stripPriceUsd,
    unitPriceUsd: unitPriceUsd.present ? unitPriceUsd.value : this.unitPriceUsd,
    minStockBoxes: minStockBoxes ?? this.minStockBoxes,
    requiresPrescription: requiresPrescription ?? this.requiresPrescription,
    active: active ?? this.active,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Medicine copyWithCompanion(MedicinesCompanion data) {
    return Medicine(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      scientificName: data.scientificName.present ? data.scientificName.value : this.scientificName,
      manufacturer: data.manufacturer.present ? data.manufacturer.value : this.manufacturer,
      form: data.form.present ? data.form.value : this.form,
      category: data.category.present ? data.category.value : this.category,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      stripsPerBox: data.stripsPerBox.present ? data.stripsPerBox.value : this.stripsPerBox,
      unitsPerStrip: data.unitsPerStrip.present ? data.unitsPerStrip.value : this.unitsPerStrip,
      boxName: data.boxName.present ? data.boxName.value : this.boxName,
      stripName: data.stripName.present ? data.stripName.value : this.stripName,
      unitName: data.unitName.present ? data.unitName.value : this.unitName,
      allowStripSale: data.allowStripSale.present ? data.allowStripSale.value : this.allowStripSale,
      allowUnitSale: data.allowUnitSale.present ? data.allowUnitSale.value : this.allowUnitSale,
      priceUsd: data.priceUsd.present ? data.priceUsd.value : this.priceUsd,
      stripPriceUsd: data.stripPriceUsd.present ? data.stripPriceUsd.value : this.stripPriceUsd,
      unitPriceUsd: data.unitPriceUsd.present ? data.unitPriceUsd.value : this.unitPriceUsd,
      minStockBoxes: data.minStockBoxes.present ? data.minStockBoxes.value : this.minStockBoxes,
      requiresPrescription: data.requiresPrescription.present
          ? data.requiresPrescription.value
          : this.requiresPrescription,
      active: data.active.present ? data.active.value : this.active,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medicine(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('scientificName: $scientificName, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('form: $form, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('stripsPerBox: $stripsPerBox, ')
          ..write('unitsPerStrip: $unitsPerStrip, ')
          ..write('boxName: $boxName, ')
          ..write('stripName: $stripName, ')
          ..write('unitName: $unitName, ')
          ..write('allowStripSale: $allowStripSale, ')
          ..write('allowUnitSale: $allowUnitSale, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('stripPriceUsd: $stripPriceUsd, ')
          ..write('unitPriceUsd: $unitPriceUsd, ')
          ..write('minStockBoxes: $minStockBoxes, ')
          ..write('requiresPrescription: $requiresPrescription, ')
          ..write('active: $active, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    name,
    scientificName,
    manufacturer,
    form,
    category,
    barcode,
    stripsPerBox,
    unitsPerStrip,
    boxName,
    stripName,
    unitName,
    allowStripSale,
    allowUnitSale,
    priceUsd,
    stripPriceUsd,
    unitPriceUsd,
    minStockBoxes,
    requiresPrescription,
    active,
    notes,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medicine &&
          other.id == this.id &&
          other.name == this.name &&
          other.scientificName == this.scientificName &&
          other.manufacturer == this.manufacturer &&
          other.form == this.form &&
          other.category == this.category &&
          other.barcode == this.barcode &&
          other.stripsPerBox == this.stripsPerBox &&
          other.unitsPerStrip == this.unitsPerStrip &&
          other.boxName == this.boxName &&
          other.stripName == this.stripName &&
          other.unitName == this.unitName &&
          other.allowStripSale == this.allowStripSale &&
          other.allowUnitSale == this.allowUnitSale &&
          other.priceUsd == this.priceUsd &&
          other.stripPriceUsd == this.stripPriceUsd &&
          other.unitPriceUsd == this.unitPriceUsd &&
          other.minStockBoxes == this.minStockBoxes &&
          other.requiresPrescription == this.requiresPrescription &&
          other.active == this.active &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MedicinesCompanion extends UpdateCompanion<Medicine> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> scientificName;
  final Value<String?> manufacturer;
  final Value<String?> form;
  final Value<String?> category;
  final Value<String?> barcode;
  final Value<int> stripsPerBox;
  final Value<int> unitsPerStrip;
  final Value<String> boxName;
  final Value<String> stripName;
  final Value<String> unitName;
  final Value<bool> allowStripSale;
  final Value<bool> allowUnitSale;
  final Value<double> priceUsd;
  final Value<double?> stripPriceUsd;
  final Value<double?> unitPriceUsd;
  final Value<double> minStockBoxes;
  final Value<bool> requiresPrescription;
  final Value<bool> active;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MedicinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.form = const Value.absent(),
    this.category = const Value.absent(),
    this.barcode = const Value.absent(),
    this.stripsPerBox = const Value.absent(),
    this.unitsPerStrip = const Value.absent(),
    this.boxName = const Value.absent(),
    this.stripName = const Value.absent(),
    this.unitName = const Value.absent(),
    this.allowStripSale = const Value.absent(),
    this.allowUnitSale = const Value.absent(),
    this.priceUsd = const Value.absent(),
    this.stripPriceUsd = const Value.absent(),
    this.unitPriceUsd = const Value.absent(),
    this.minStockBoxes = const Value.absent(),
    this.requiresPrescription = const Value.absent(),
    this.active = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MedicinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.scientificName = const Value.absent(),
    this.manufacturer = const Value.absent(),
    this.form = const Value.absent(),
    this.category = const Value.absent(),
    this.barcode = const Value.absent(),
    this.stripsPerBox = const Value.absent(),
    this.unitsPerStrip = const Value.absent(),
    this.boxName = const Value.absent(),
    this.stripName = const Value.absent(),
    this.unitName = const Value.absent(),
    this.allowStripSale = const Value.absent(),
    this.allowUnitSale = const Value.absent(),
    this.priceUsd = const Value.absent(),
    this.stripPriceUsd = const Value.absent(),
    this.unitPriceUsd = const Value.absent(),
    this.minStockBoxes = const Value.absent(),
    this.requiresPrescription = const Value.absent(),
    this.active = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Medicine> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? scientificName,
    Expression<String>? manufacturer,
    Expression<String>? form,
    Expression<String>? category,
    Expression<String>? barcode,
    Expression<int>? stripsPerBox,
    Expression<int>? unitsPerStrip,
    Expression<String>? boxName,
    Expression<String>? stripName,
    Expression<String>? unitName,
    Expression<bool>? allowStripSale,
    Expression<bool>? allowUnitSale,
    Expression<double>? priceUsd,
    Expression<double>? stripPriceUsd,
    Expression<double>? unitPriceUsd,
    Expression<double>? minStockBoxes,
    Expression<bool>? requiresPrescription,
    Expression<bool>? active,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (scientificName != null) 'scientific_name': scientificName,
      if (manufacturer != null) 'manufacturer': manufacturer,
      if (form != null) 'form': form,
      if (category != null) 'category': category,
      if (barcode != null) 'barcode': barcode,
      if (stripsPerBox != null) 'strips_per_box': stripsPerBox,
      if (unitsPerStrip != null) 'units_per_strip': unitsPerStrip,
      if (boxName != null) 'box_name': boxName,
      if (stripName != null) 'strip_name': stripName,
      if (unitName != null) 'unit_name': unitName,
      if (allowStripSale != null) 'allow_strip_sale': allowStripSale,
      if (allowUnitSale != null) 'allow_unit_sale': allowUnitSale,
      if (priceUsd != null) 'price_usd': priceUsd,
      if (stripPriceUsd != null) 'strip_price_usd': stripPriceUsd,
      if (unitPriceUsd != null) 'unit_price_usd': unitPriceUsd,
      if (minStockBoxes != null) 'min_stock_boxes': minStockBoxes,
      if (requiresPrescription != null) 'requires_prescription': requiresPrescription,
      if (active != null) 'active': active,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MedicinesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? scientificName,
    Value<String?>? manufacturer,
    Value<String?>? form,
    Value<String?>? category,
    Value<String?>? barcode,
    Value<int>? stripsPerBox,
    Value<int>? unitsPerStrip,
    Value<String>? boxName,
    Value<String>? stripName,
    Value<String>? unitName,
    Value<bool>? allowStripSale,
    Value<bool>? allowUnitSale,
    Value<double>? priceUsd,
    Value<double?>? stripPriceUsd,
    Value<double?>? unitPriceUsd,
    Value<double>? minStockBoxes,
    Value<bool>? requiresPrescription,
    Value<bool>? active,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MedicinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      scientificName: scientificName ?? this.scientificName,
      manufacturer: manufacturer ?? this.manufacturer,
      form: form ?? this.form,
      category: category ?? this.category,
      barcode: barcode ?? this.barcode,
      stripsPerBox: stripsPerBox ?? this.stripsPerBox,
      unitsPerStrip: unitsPerStrip ?? this.unitsPerStrip,
      boxName: boxName ?? this.boxName,
      stripName: stripName ?? this.stripName,
      unitName: unitName ?? this.unitName,
      allowStripSale: allowStripSale ?? this.allowStripSale,
      allowUnitSale: allowUnitSale ?? this.allowUnitSale,
      priceUsd: priceUsd ?? this.priceUsd,
      stripPriceUsd: stripPriceUsd ?? this.stripPriceUsd,
      unitPriceUsd: unitPriceUsd ?? this.unitPriceUsd,
      minStockBoxes: minStockBoxes ?? this.minStockBoxes,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      active: active ?? this.active,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (manufacturer.present) {
      map['manufacturer'] = Variable<String>(manufacturer.value);
    }
    if (form.present) {
      map['form'] = Variable<String>(form.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (stripsPerBox.present) {
      map['strips_per_box'] = Variable<int>(stripsPerBox.value);
    }
    if (unitsPerStrip.present) {
      map['units_per_strip'] = Variable<int>(unitsPerStrip.value);
    }
    if (boxName.present) {
      map['box_name'] = Variable<String>(boxName.value);
    }
    if (stripName.present) {
      map['strip_name'] = Variable<String>(stripName.value);
    }
    if (unitName.present) {
      map['unit_name'] = Variable<String>(unitName.value);
    }
    if (allowStripSale.present) {
      map['allow_strip_sale'] = Variable<bool>(allowStripSale.value);
    }
    if (allowUnitSale.present) {
      map['allow_unit_sale'] = Variable<bool>(allowUnitSale.value);
    }
    if (priceUsd.present) {
      map['price_usd'] = Variable<double>(priceUsd.value);
    }
    if (stripPriceUsd.present) {
      map['strip_price_usd'] = Variable<double>(stripPriceUsd.value);
    }
    if (unitPriceUsd.present) {
      map['unit_price_usd'] = Variable<double>(unitPriceUsd.value);
    }
    if (minStockBoxes.present) {
      map['min_stock_boxes'] = Variable<double>(minStockBoxes.value);
    }
    if (requiresPrescription.present) {
      map['requires_prescription'] = Variable<bool>(requiresPrescription.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('scientificName: $scientificName, ')
          ..write('manufacturer: $manufacturer, ')
          ..write('form: $form, ')
          ..write('category: $category, ')
          ..write('barcode: $barcode, ')
          ..write('stripsPerBox: $stripsPerBox, ')
          ..write('unitsPerStrip: $unitsPerStrip, ')
          ..write('boxName: $boxName, ')
          ..write('stripName: $stripName, ')
          ..write('unitName: $unitName, ')
          ..write('allowStripSale: $allowStripSale, ')
          ..write('allowUnitSale: $allowUnitSale, ')
          ..write('priceUsd: $priceUsd, ')
          ..write('stripPriceUsd: $stripPriceUsd, ')
          ..write('unitPriceUsd: $unitPriceUsd, ')
          ..write('minStockBoxes: $minStockBoxes, ')
          ..write('requiresPrescription: $requiresPrescription, ')
          ..write('active: $active, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SuppliersTable extends Suppliers with TableInfo<$SuppliersTable, Supplier> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SuppliersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta('address');
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
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, address, notes, active, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'suppliers';
  @override
  VerificationContext validateIntegrity(Insertable<Supplier> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(_phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta, address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Supplier map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Supplier(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}phone']),
      address: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}address']),
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
      active: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SuppliersTable createAlias(String alias) {
    return $SuppliersTable(attachedDatabase, alias);
  }
}

class Supplier extends DataClass implements Insertable<Supplier> {
  final int id;
  final String name;
  final String? phone;
  final String? address;
  final String? notes;
  final bool active;
  final DateTime createdAt;
  const Supplier({
    required this.id,
    required this.name,
    this.phone,
    this.address,
    this.notes,
    required this.active,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SuppliersCompanion toCompanion(bool nullToAbsent) {
    return SuppliersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      address: address == null && nullToAbsent ? const Value.absent() : Value(address),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      active: Value(active),
      createdAt: Value(createdAt),
    );
  }

  factory Supplier.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Supplier(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Supplier copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? active,
    DateTime? createdAt,
  }) => Supplier(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
  );
  Supplier copyWithCompanion(SuppliersCompanion data) {
    return Supplier(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Supplier(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, address, notes, active, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Supplier &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.active == this.active &&
          other.createdAt == this.createdAt);
}

class SuppliersCompanion extends UpdateCompanion<Supplier> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  const SuppliersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SuppliersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Supplier> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SuppliersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<String?>? notes,
    Value<bool>? active,
    Value<DateTime>? createdAt,
  }) {
    return SuppliersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SuppliersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BatchesTable extends Batches with TableInfo<$BatchesTable, StockBatch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES medicines (id)'),
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta('batchNumber');
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialQuantityMeta = const VerificationMeta('initialQuantity');
  @override
  late final GeneratedColumn<int> initialQuantity = GeneratedColumn<int>(
    'initial_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costUsdPerBoxMeta = const VerificationMeta('costUsdPerBox');
  @override
  late final GeneratedColumn<double> costUsdPerBox = GeneratedColumn<double>(
    'cost_usd_per_box',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta('purchaseId');
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    medicineId,
    batchNumber,
    expiryDate,
    quantity,
    initialQuantity,
    costUsdPerBox,
    supplierId,
    purchaseId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'batches';
  @override
  VerificationContext validateIntegrity(Insertable<StockBatch> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('medicine_id')) {
      context.handle(_medicineIdMeta, medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('batch_number')) {
      context.handle(_batchNumberMeta, batchNumber.isAcceptableOrUnknown(data['batch_number']!, _batchNumberMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(_expiryDateMeta, expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta, quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('initial_quantity')) {
      context.handle(
        _initialQuantityMeta,
        initialQuantity.isAcceptableOrUnknown(data['initial_quantity']!, _initialQuantityMeta),
      );
    } else if (isInserting) {
      context.missing(_initialQuantityMeta);
    }
    if (data.containsKey('cost_usd_per_box')) {
      context.handle(
        _costUsdPerBoxMeta,
        costUsdPerBox.isAcceptableOrUnknown(data['cost_usd_per_box']!, _costUsdPerBoxMeta),
      );
    }
    if (data.containsKey('supplier_id')) {
      context.handle(_supplierIdMeta, supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(_purchaseIdMeta, purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockBatch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockBatch(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      medicineId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      batchNumber: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}batch_number']),
      expiryDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
      quantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      initialQuantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}initial_quantity'])!,
      costUsdPerBox: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_usd_per_box'],
      )!,
      supplierId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}supplier_id']),
      purchaseId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}purchase_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $BatchesTable createAlias(String alias) {
    return $BatchesTable(attachedDatabase, alias);
  }
}

class StockBatch extends DataClass implements Insertable<StockBatch> {
  final int id;
  final int medicineId;
  final String? batchNumber;
  final DateTime? expiryDate;

  /// الكمية المتبقية بأصغر وحدة
  final int quantity;
  final int initialQuantity;

  /// تكلفة العلبة بالدولار
  final double costUsdPerBox;
  final int? supplierId;
  final int? purchaseId;
  final DateTime createdAt;
  const StockBatch({
    required this.id,
    required this.medicineId,
    this.batchNumber,
    this.expiryDate,
    required this.quantity,
    required this.initialQuantity,
    required this.costUsdPerBox,
    this.supplierId,
    this.purchaseId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['medicine_id'] = Variable<int>(medicineId);
    if (!nullToAbsent || batchNumber != null) {
      map['batch_number'] = Variable<String>(batchNumber);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['quantity'] = Variable<int>(quantity);
    map['initial_quantity'] = Variable<int>(initialQuantity);
    map['cost_usd_per_box'] = Variable<double>(costUsdPerBox);
    if (!nullToAbsent || supplierId != null) {
      map['supplier_id'] = Variable<int>(supplierId);
    }
    if (!nullToAbsent || purchaseId != null) {
      map['purchase_id'] = Variable<int>(purchaseId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BatchesCompanion toCompanion(bool nullToAbsent) {
    return BatchesCompanion(
      id: Value(id),
      medicineId: Value(medicineId),
      batchNumber: batchNumber == null && nullToAbsent ? const Value.absent() : Value(batchNumber),
      expiryDate: expiryDate == null && nullToAbsent ? const Value.absent() : Value(expiryDate),
      quantity: Value(quantity),
      initialQuantity: Value(initialQuantity),
      costUsdPerBox: Value(costUsdPerBox),
      supplierId: supplierId == null && nullToAbsent ? const Value.absent() : Value(supplierId),
      purchaseId: purchaseId == null && nullToAbsent ? const Value.absent() : Value(purchaseId),
      createdAt: Value(createdAt),
    );
  }

  factory StockBatch.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockBatch(
      id: serializer.fromJson<int>(json['id']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      batchNumber: serializer.fromJson<String?>(json['batchNumber']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      quantity: serializer.fromJson<int>(json['quantity']),
      initialQuantity: serializer.fromJson<int>(json['initialQuantity']),
      costUsdPerBox: serializer.fromJson<double>(json['costUsdPerBox']),
      supplierId: serializer.fromJson<int?>(json['supplierId']),
      purchaseId: serializer.fromJson<int?>(json['purchaseId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'medicineId': serializer.toJson<int>(medicineId),
      'batchNumber': serializer.toJson<String?>(batchNumber),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'quantity': serializer.toJson<int>(quantity),
      'initialQuantity': serializer.toJson<int>(initialQuantity),
      'costUsdPerBox': serializer.toJson<double>(costUsdPerBox),
      'supplierId': serializer.toJson<int?>(supplierId),
      'purchaseId': serializer.toJson<int?>(purchaseId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockBatch copyWith({
    int? id,
    int? medicineId,
    Value<String?> batchNumber = const Value.absent(),
    Value<DateTime?> expiryDate = const Value.absent(),
    int? quantity,
    int? initialQuantity,
    double? costUsdPerBox,
    Value<int?> supplierId = const Value.absent(),
    Value<int?> purchaseId = const Value.absent(),
    DateTime? createdAt,
  }) => StockBatch(
    id: id ?? this.id,
    medicineId: medicineId ?? this.medicineId,
    batchNumber: batchNumber.present ? batchNumber.value : this.batchNumber,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    quantity: quantity ?? this.quantity,
    initialQuantity: initialQuantity ?? this.initialQuantity,
    costUsdPerBox: costUsdPerBox ?? this.costUsdPerBox,
    supplierId: supplierId.present ? supplierId.value : this.supplierId,
    purchaseId: purchaseId.present ? purchaseId.value : this.purchaseId,
    createdAt: createdAt ?? this.createdAt,
  );
  StockBatch copyWithCompanion(BatchesCompanion data) {
    return StockBatch(
      id: data.id.present ? data.id.value : this.id,
      medicineId: data.medicineId.present ? data.medicineId.value : this.medicineId,
      batchNumber: data.batchNumber.present ? data.batchNumber.value : this.batchNumber,
      expiryDate: data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      initialQuantity: data.initialQuantity.present ? data.initialQuantity.value : this.initialQuantity,
      costUsdPerBox: data.costUsdPerBox.present ? data.costUsdPerBox.value : this.costUsdPerBox,
      supplierId: data.supplierId.present ? data.supplierId.value : this.supplierId,
      purchaseId: data.purchaseId.present ? data.purchaseId.value : this.purchaseId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockBatch(')
          ..write('id: $id, ')
          ..write('medicineId: $medicineId, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('quantity: $quantity, ')
          ..write('initialQuantity: $initialQuantity, ')
          ..write('costUsdPerBox: $costUsdPerBox, ')
          ..write('supplierId: $supplierId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    medicineId,
    batchNumber,
    expiryDate,
    quantity,
    initialQuantity,
    costUsdPerBox,
    supplierId,
    purchaseId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockBatch &&
          other.id == this.id &&
          other.medicineId == this.medicineId &&
          other.batchNumber == this.batchNumber &&
          other.expiryDate == this.expiryDate &&
          other.quantity == this.quantity &&
          other.initialQuantity == this.initialQuantity &&
          other.costUsdPerBox == this.costUsdPerBox &&
          other.supplierId == this.supplierId &&
          other.purchaseId == this.purchaseId &&
          other.createdAt == this.createdAt);
}

class BatchesCompanion extends UpdateCompanion<StockBatch> {
  final Value<int> id;
  final Value<int> medicineId;
  final Value<String?> batchNumber;
  final Value<DateTime?> expiryDate;
  final Value<int> quantity;
  final Value<int> initialQuantity;
  final Value<double> costUsdPerBox;
  final Value<int?> supplierId;
  final Value<int?> purchaseId;
  final Value<DateTime> createdAt;
  const BatchesCompanion({
    this.id = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.quantity = const Value.absent(),
    this.initialQuantity = const Value.absent(),
    this.costUsdPerBox = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  BatchesCompanion.insert({
    this.id = const Value.absent(),
    required int medicineId,
    this.batchNumber = const Value.absent(),
    this.expiryDate = const Value.absent(),
    required int quantity,
    required int initialQuantity,
    this.costUsdPerBox = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : medicineId = Value(medicineId),
       quantity = Value(quantity),
       initialQuantity = Value(initialQuantity);
  static Insertable<StockBatch> custom({
    Expression<int>? id,
    Expression<int>? medicineId,
    Expression<String>? batchNumber,
    Expression<DateTime>? expiryDate,
    Expression<int>? quantity,
    Expression<int>? initialQuantity,
    Expression<double>? costUsdPerBox,
    Expression<int>? supplierId,
    Expression<int>? purchaseId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (medicineId != null) 'medicine_id': medicineId,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (quantity != null) 'quantity': quantity,
      if (initialQuantity != null) 'initial_quantity': initialQuantity,
      if (costUsdPerBox != null) 'cost_usd_per_box': costUsdPerBox,
      if (supplierId != null) 'supplier_id': supplierId,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  BatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? medicineId,
    Value<String?>? batchNumber,
    Value<DateTime?>? expiryDate,
    Value<int>? quantity,
    Value<int>? initialQuantity,
    Value<double>? costUsdPerBox,
    Value<int?>? supplierId,
    Value<int?>? purchaseId,
    Value<DateTime>? createdAt,
  }) {
    return BatchesCompanion(
      id: id ?? this.id,
      medicineId: medicineId ?? this.medicineId,
      batchNumber: batchNumber ?? this.batchNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      costUsdPerBox: costUsdPerBox ?? this.costUsdPerBox,
      supplierId: supplierId ?? this.supplierId,
      purchaseId: purchaseId ?? this.purchaseId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (initialQuantity.present) {
      map['initial_quantity'] = Variable<int>(initialQuantity.value);
    }
    if (costUsdPerBox.present) {
      map['cost_usd_per_box'] = Variable<double>(costUsdPerBox.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BatchesCompanion(')
          ..write('id: $id, ')
          ..write('medicineId: $medicineId, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('quantity: $quantity, ')
          ..write('initialQuantity: $initialQuantity, ')
          ..write('costUsdPerBox: $costUsdPerBox, ')
          ..write('supplierId: $supplierId, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $StockAdjustmentsTable extends StockAdjustments with TableInfo<$StockAdjustmentsTable, StockAdjustment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StockAdjustmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<int> batchId = GeneratedColumn<int>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES batches (id)'),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES medicines (id)'),
  );
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<int> delta = GeneratedColumn<int>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES users (id)'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, batchId, medicineId, delta, reason, note, userId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'stock_adjustments';
  @override
  VerificationContext validateIntegrity(Insertable<StockAdjustment> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta, batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('medicine_id')) {
      context.handle(_medicineIdMeta, medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(_deltaMeta, delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta));
    } else if (isInserting) {
      context.missing(_deltaMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(_reasonMeta, reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta));
    } else if (isInserting) {
      context.missing(_reasonMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StockAdjustment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StockAdjustment(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      batchId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}batch_id'])!,
      medicineId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      delta: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}delta'])!,
      reason: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}reason'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $StockAdjustmentsTable createAlias(String alias) {
    return $StockAdjustmentsTable(attachedDatabase, alias);
  }
}

class StockAdjustment extends DataClass implements Insertable<StockAdjustment> {
  final int id;
  final int batchId;
  final int medicineId;

  /// الفرق بأصغر وحدة (موجب = زيادة، سالب = نقص)
  final int delta;

  /// count = جرد، damaged = تالف، expired = منتهي، other
  final String reason;
  final String? note;
  final int? userId;
  final DateTime createdAt;
  const StockAdjustment({
    required this.id,
    required this.batchId,
    required this.medicineId,
    required this.delta,
    required this.reason,
    this.note,
    this.userId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['batch_id'] = Variable<int>(batchId);
    map['medicine_id'] = Variable<int>(medicineId);
    map['delta'] = Variable<int>(delta);
    map['reason'] = Variable<String>(reason);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StockAdjustmentsCompanion toCompanion(bool nullToAbsent) {
    return StockAdjustmentsCompanion(
      id: Value(id),
      batchId: Value(batchId),
      medicineId: Value(medicineId),
      delta: Value(delta),
      reason: Value(reason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory StockAdjustment.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StockAdjustment(
      id: serializer.fromJson<int>(json['id']),
      batchId: serializer.fromJson<int>(json['batchId']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      delta: serializer.fromJson<int>(json['delta']),
      reason: serializer.fromJson<String>(json['reason']),
      note: serializer.fromJson<String?>(json['note']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'batchId': serializer.toJson<int>(batchId),
      'medicineId': serializer.toJson<int>(medicineId),
      'delta': serializer.toJson<int>(delta),
      'reason': serializer.toJson<String>(reason),
      'note': serializer.toJson<String?>(note),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StockAdjustment copyWith({
    int? id,
    int? batchId,
    int? medicineId,
    int? delta,
    String? reason,
    Value<String?> note = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    DateTime? createdAt,
  }) => StockAdjustment(
    id: id ?? this.id,
    batchId: batchId ?? this.batchId,
    medicineId: medicineId ?? this.medicineId,
    delta: delta ?? this.delta,
    reason: reason ?? this.reason,
    note: note.present ? note.value : this.note,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
  );
  StockAdjustment copyWithCompanion(StockAdjustmentsCompanion data) {
    return StockAdjustment(
      id: data.id.present ? data.id.value : this.id,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      medicineId: data.medicineId.present ? data.medicineId.value : this.medicineId,
      delta: data.delta.present ? data.delta.value : this.delta,
      reason: data.reason.present ? data.reason.value : this.reason,
      note: data.note.present ? data.note.value : this.note,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StockAdjustment(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('medicineId: $medicineId, ')
          ..write('delta: $delta, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, batchId, medicineId, delta, reason, note, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StockAdjustment &&
          other.id == this.id &&
          other.batchId == this.batchId &&
          other.medicineId == this.medicineId &&
          other.delta == this.delta &&
          other.reason == this.reason &&
          other.note == this.note &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class StockAdjustmentsCompanion extends UpdateCompanion<StockAdjustment> {
  final Value<int> id;
  final Value<int> batchId;
  final Value<int> medicineId;
  final Value<int> delta;
  final Value<String> reason;
  final Value<String?> note;
  final Value<int?> userId;
  final Value<DateTime> createdAt;
  const StockAdjustmentsCompanion({
    this.id = const Value.absent(),
    this.batchId = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.delta = const Value.absent(),
    this.reason = const Value.absent(),
    this.note = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  StockAdjustmentsCompanion.insert({
    this.id = const Value.absent(),
    required int batchId,
    required int medicineId,
    required int delta,
    required String reason,
    this.note = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : batchId = Value(batchId),
       medicineId = Value(medicineId),
       delta = Value(delta),
       reason = Value(reason);
  static Insertable<StockAdjustment> custom({
    Expression<int>? id,
    Expression<int>? batchId,
    Expression<int>? medicineId,
    Expression<int>? delta,
    Expression<String>? reason,
    Expression<String>? note,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (batchId != null) 'batch_id': batchId,
      if (medicineId != null) 'medicine_id': medicineId,
      if (delta != null) 'delta': delta,
      if (reason != null) 'reason': reason,
      if (note != null) 'note': note,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  StockAdjustmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? batchId,
    Value<int>? medicineId,
    Value<int>? delta,
    Value<String>? reason,
    Value<String?>? note,
    Value<int?>? userId,
    Value<DateTime>? createdAt,
  }) {
    return StockAdjustmentsCompanion(
      id: id ?? this.id,
      batchId: batchId ?? this.batchId,
      medicineId: medicineId ?? this.medicineId,
      delta: delta ?? this.delta,
      reason: reason ?? this.reason,
      note: note ?? this.note,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<int>(batchId.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<int>(delta.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StockAdjustmentsCompanion(')
          ..write('id: $id, ')
          ..write('batchId: $batchId, ')
          ..write('medicineId: $medicineId, ')
          ..write('delta: $delta, ')
          ..write('reason: $reason, ')
          ..write('note: $note, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SupplierTransactionsTable extends SupplierTransactions
    with TableInfo<$SupplierTransactionsTable, SupplierTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountUsdMeta = const VerificationMeta('amountUsd');
  @override
  late final GeneratedColumn<double> amountUsd = GeneratedColumn<double>(
    'amount_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('USD'),
  );
  static const VerificationMeta _originalAmountMeta = const VerificationMeta('originalAmount');
  @override
  late final GeneratedColumn<double> originalAmount = GeneratedColumn<double>(
    'original_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<int> refId = GeneratedColumn<int>(
    'ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    type,
    amountUsd,
    currency,
    originalAmount,
    rate,
    refId,
    shiftId,
    userId,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<SupplierTransaction> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(_supplierIdMeta, supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_usd')) {
      context.handle(_amountUsdMeta, amountUsd.isAcceptableOrUnknown(data['amount_usd']!, _amountUsdMeta));
    } else if (isInserting) {
      context.missing(_amountUsdMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta, currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('original_amount')) {
      context.handle(
        _originalAmountMeta,
        originalAmount.isAcceptableOrUnknown(data['original_amount']!, _originalAmountMeta),
      );
    }
    if (data.containsKey('rate')) {
      context.handle(_rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    }
    if (data.containsKey('ref_id')) {
      context.handle(_refIdMeta, refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta));
    }
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta, shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierTransaction(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      type: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amountUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}amount_usd'])!,
      currency: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      originalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_amount'],
      )!,
      rate: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      refId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ref_id']),
      shiftId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}shift_id']),
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SupplierTransactionsTable createAlias(String alias) {
    return $SupplierTransactionsTable(attachedDatabase, alias);
  }
}

class SupplierTransaction extends DataClass implements Insertable<SupplierTransaction> {
  final int id;
  final int supplierId;

  /// purchase, payment, return, adjustment
  final String type;
  final double amountUsd;
  final String currency;
  final double originalAmount;
  final double rate;
  final int? refId;
  final int? shiftId;
  final int? userId;
  final String? note;
  final DateTime createdAt;
  const SupplierTransaction({
    required this.id,
    required this.supplierId,
    required this.type,
    required this.amountUsd,
    required this.currency,
    required this.originalAmount,
    required this.rate,
    this.refId,
    this.shiftId,
    this.userId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    map['type'] = Variable<String>(type);
    map['amount_usd'] = Variable<double>(amountUsd);
    map['currency'] = Variable<String>(currency);
    map['original_amount'] = Variable<double>(originalAmount);
    map['rate'] = Variable<double>(rate);
    if (!nullToAbsent || refId != null) {
      map['ref_id'] = Variable<int>(refId);
    }
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<int>(shiftId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SupplierTransactionsCompanion toCompanion(bool nullToAbsent) {
    return SupplierTransactionsCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      type: Value(type),
      amountUsd: Value(amountUsd),
      currency: Value(currency),
      originalAmount: Value(originalAmount),
      rate: Value(rate),
      refId: refId == null && nullToAbsent ? const Value.absent() : Value(refId),
      shiftId: shiftId == null && nullToAbsent ? const Value.absent() : Value(shiftId),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory SupplierTransaction.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierTransaction(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      type: serializer.fromJson<String>(json['type']),
      amountUsd: serializer.fromJson<double>(json['amountUsd']),
      currency: serializer.fromJson<String>(json['currency']),
      originalAmount: serializer.fromJson<double>(json['originalAmount']),
      rate: serializer.fromJson<double>(json['rate']),
      refId: serializer.fromJson<int?>(json['refId']),
      shiftId: serializer.fromJson<int?>(json['shiftId']),
      userId: serializer.fromJson<int?>(json['userId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'type': serializer.toJson<String>(type),
      'amountUsd': serializer.toJson<double>(amountUsd),
      'currency': serializer.toJson<String>(currency),
      'originalAmount': serializer.toJson<double>(originalAmount),
      'rate': serializer.toJson<double>(rate),
      'refId': serializer.toJson<int?>(refId),
      'shiftId': serializer.toJson<int?>(shiftId),
      'userId': serializer.toJson<int?>(userId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SupplierTransaction copyWith({
    int? id,
    int? supplierId,
    String? type,
    double? amountUsd,
    String? currency,
    double? originalAmount,
    double? rate,
    Value<int?> refId = const Value.absent(),
    Value<int?> shiftId = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => SupplierTransaction(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    type: type ?? this.type,
    amountUsd: amountUsd ?? this.amountUsd,
    currency: currency ?? this.currency,
    originalAmount: originalAmount ?? this.originalAmount,
    rate: rate ?? this.rate,
    refId: refId.present ? refId.value : this.refId,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
    userId: userId.present ? userId.value : this.userId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  SupplierTransaction copyWithCompanion(SupplierTransactionsCompanion data) {
    return SupplierTransaction(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present ? data.supplierId.value : this.supplierId,
      type: data.type.present ? data.type.value : this.type,
      amountUsd: data.amountUsd.present ? data.amountUsd.value : this.amountUsd,
      currency: data.currency.present ? data.currency.value : this.currency,
      originalAmount: data.originalAmount.present ? data.originalAmount.value : this.originalAmount,
      rate: data.rate.present ? data.rate.value : this.rate,
      refId: data.refId.present ? data.refId.value : this.refId,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      userId: data.userId.present ? data.userId.value : this.userId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierTransaction(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('type: $type, ')
          ..write('amountUsd: $amountUsd, ')
          ..write('currency: $currency, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('rate: $rate, ')
          ..write('refId: $refId, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    supplierId,
    type,
    amountUsd,
    currency,
    originalAmount,
    rate,
    refId,
    shiftId,
    userId,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierTransaction &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.type == this.type &&
          other.amountUsd == this.amountUsd &&
          other.currency == this.currency &&
          other.originalAmount == this.originalAmount &&
          other.rate == this.rate &&
          other.refId == this.refId &&
          other.shiftId == this.shiftId &&
          other.userId == this.userId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class SupplierTransactionsCompanion extends UpdateCompanion<SupplierTransaction> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<String> type;
  final Value<double> amountUsd;
  final Value<String> currency;
  final Value<double> originalAmount;
  final Value<double> rate;
  final Value<int?> refId;
  final Value<int?> shiftId;
  final Value<int?> userId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const SupplierTransactionsCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.type = const Value.absent(),
    this.amountUsd = const Value.absent(),
    this.currency = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.rate = const Value.absent(),
    this.refId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SupplierTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    required String type,
    required double amountUsd,
    this.currency = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.rate = const Value.absent(),
    this.refId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : supplierId = Value(supplierId),
       type = Value(type),
       amountUsd = Value(amountUsd);
  static Insertable<SupplierTransaction> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<String>? type,
    Expression<double>? amountUsd,
    Expression<String>? currency,
    Expression<double>? originalAmount,
    Expression<double>? rate,
    Expression<int>? refId,
    Expression<int>? shiftId,
    Expression<int>? userId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (type != null) 'type': type,
      if (amountUsd != null) 'amount_usd': amountUsd,
      if (currency != null) 'currency': currency,
      if (originalAmount != null) 'original_amount': originalAmount,
      if (rate != null) 'rate': rate,
      if (refId != null) 'ref_id': refId,
      if (shiftId != null) 'shift_id': shiftId,
      if (userId != null) 'user_id': userId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SupplierTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<String>? type,
    Value<double>? amountUsd,
    Value<String>? currency,
    Value<double>? originalAmount,
    Value<double>? rate,
    Value<int?>? refId,
    Value<int?>? shiftId,
    Value<int?>? userId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return SupplierTransactionsCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      type: type ?? this.type,
      amountUsd: amountUsd ?? this.amountUsd,
      currency: currency ?? this.currency,
      originalAmount: originalAmount ?? this.originalAmount,
      rate: rate ?? this.rate,
      refId: refId ?? this.refId,
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountUsd.present) {
      map['amount_usd'] = Variable<double>(amountUsd.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (originalAmount.present) {
      map['original_amount'] = Variable<double>(originalAmount.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<int>(refId.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('type: $type, ')
          ..write('amountUsd: $amountUsd, ')
          ..write('currency: $currency, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('rate: $rate, ')
          ..write('refId: $refId, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers with TableInfo<$CustomersTable, Customer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
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
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
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
  static const VerificationMeta _creditLimitUsdMeta = const VerificationMeta('creditLimitUsd');
  @override
  late final GeneratedColumn<double> creditLimitUsd = GeneratedColumn<double>(
    'credit_limit_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMeta = const VerificationMeta('active');
  @override
  late final GeneratedColumn<bool> active = GeneratedColumn<bool>(
    'active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("active" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, notes, creditLimitUsd, active, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(Insertable<Customer> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(_phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('credit_limit_usd')) {
      context.handle(
        _creditLimitUsdMeta,
        creditLimitUsd.isAcceptableOrUnknown(data['credit_limit_usd']!, _creditLimitUsdMeta),
      );
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Customer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Customer(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}phone']),
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
      creditLimitUsd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit_usd'],
      ),
      active: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}active'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class Customer extends DataClass implements Insertable<Customer> {
  final int id;
  final String name;
  final String? phone;
  final String? notes;

  /// سقف الدين بالدولار (اختياري)
  final double? creditLimitUsd;
  final bool active;
  final DateTime createdAt;
  const Customer({
    required this.id,
    required this.name,
    this.phone,
    this.notes,
    this.creditLimitUsd,
    required this.active,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || creditLimitUsd != null) {
      map['credit_limit_usd'] = Variable<double>(creditLimitUsd);
    }
    map['active'] = Variable<bool>(active);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      name: Value(name),
      phone: phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      creditLimitUsd: creditLimitUsd == null && nullToAbsent ? const Value.absent() : Value(creditLimitUsd),
      active: Value(active),
      createdAt: Value(createdAt),
    );
  }

  factory Customer.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Customer(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      notes: serializer.fromJson<String?>(json['notes']),
      creditLimitUsd: serializer.fromJson<double?>(json['creditLimitUsd']),
      active: serializer.fromJson<bool>(json['active']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'notes': serializer.toJson<String?>(notes),
      'creditLimitUsd': serializer.toJson<double?>(creditLimitUsd),
      'active': serializer.toJson<bool>(active),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Customer copyWith({
    int? id,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<double?> creditLimitUsd = const Value.absent(),
    bool? active,
    DateTime? createdAt,
  }) => Customer(
    id: id ?? this.id,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    notes: notes.present ? notes.value : this.notes,
    creditLimitUsd: creditLimitUsd.present ? creditLimitUsd.value : this.creditLimitUsd,
    active: active ?? this.active,
    createdAt: createdAt ?? this.createdAt,
  );
  Customer copyWithCompanion(CustomersCompanion data) {
    return Customer(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      notes: data.notes.present ? data.notes.value : this.notes,
      creditLimitUsd: data.creditLimitUsd.present ? data.creditLimitUsd.value : this.creditLimitUsd,
      active: data.active.present ? data.active.value : this.active,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Customer(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('creditLimitUsd: $creditLimitUsd, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, notes, creditLimitUsd, active, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Customer &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.notes == this.notes &&
          other.creditLimitUsd == this.creditLimitUsd &&
          other.active == this.active &&
          other.createdAt == this.createdAt);
}

class CustomersCompanion extends UpdateCompanion<Customer> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> notes;
  final Value<double?> creditLimitUsd;
  final Value<bool> active;
  final Value<DateTime> createdAt;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.creditLimitUsd = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.notes = const Value.absent(),
    this.creditLimitUsd = const Value.absent(),
    this.active = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Customer> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? notes,
    Expression<double>? creditLimitUsd,
    Expression<bool>? active,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (notes != null) 'notes': notes,
      if (creditLimitUsd != null) 'credit_limit_usd': creditLimitUsd,
      if (active != null) 'active': active,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? notes,
    Value<double?>? creditLimitUsd,
    Value<bool>? active,
    Value<DateTime>? createdAt,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      creditLimitUsd: creditLimitUsd ?? this.creditLimitUsd,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (creditLimitUsd.present) {
      map['credit_limit_usd'] = Variable<double>(creditLimitUsd.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('notes: $notes, ')
          ..write('creditLimitUsd: $creditLimitUsd, ')
          ..write('active: $active, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CustomerTransactionsTable extends CustomerTransactions
    with TableInfo<$CustomerTransactionsTable, CustomerTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES customers (id)'),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountUsdMeta = const VerificationMeta('amountUsd');
  @override
  late final GeneratedColumn<double> amountUsd = GeneratedColumn<double>(
    'amount_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('SYP'),
  );
  static const VerificationMeta _originalAmountMeta = const VerificationMeta('originalAmount');
  @override
  late final GeneratedColumn<double> originalAmount = GeneratedColumn<double>(
    'original_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<int> refId = GeneratedColumn<int>(
    'ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerId,
    type,
    amountUsd,
    currency,
    originalAmount,
    rate,
    refId,
    shiftId,
    userId,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_transactions';
  @override
  VerificationContext validateIntegrity(Insertable<CustomerTransaction> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(_customerIdMeta, customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_usd')) {
      context.handle(_amountUsdMeta, amountUsd.isAcceptableOrUnknown(data['amount_usd']!, _amountUsdMeta));
    } else if (isInserting) {
      context.missing(_amountUsdMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta, currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('original_amount')) {
      context.handle(
        _originalAmountMeta,
        originalAmount.isAcceptableOrUnknown(data['original_amount']!, _originalAmountMeta),
      );
    }
    if (data.containsKey('rate')) {
      context.handle(_rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    }
    if (data.containsKey('ref_id')) {
      context.handle(_refIdMeta, refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta));
    }
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta, shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerTransaction(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      customerId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}customer_id'])!,
      type: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      amountUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}amount_usd'])!,
      currency: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      originalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}original_amount'],
      )!,
      rate: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      refId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ref_id']),
      shiftId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}shift_id']),
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CustomerTransactionsTable createAlias(String alias) {
    return $CustomerTransactionsTable(attachedDatabase, alias);
  }
}

class CustomerTransaction extends DataClass implements Insertable<CustomerTransaction> {
  final int id;
  final int customerId;

  /// sale, payment, return, adjustment, void
  final String type;
  final double amountUsd;
  final String currency;
  final double originalAmount;
  final double rate;
  final int? refId;
  final int? shiftId;
  final int? userId;
  final String? note;
  final DateTime createdAt;
  const CustomerTransaction({
    required this.id,
    required this.customerId,
    required this.type,
    required this.amountUsd,
    required this.currency,
    required this.originalAmount,
    required this.rate,
    this.refId,
    this.shiftId,
    this.userId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_id'] = Variable<int>(customerId);
    map['type'] = Variable<String>(type);
    map['amount_usd'] = Variable<double>(amountUsd);
    map['currency'] = Variable<String>(currency);
    map['original_amount'] = Variable<double>(originalAmount);
    map['rate'] = Variable<double>(rate);
    if (!nullToAbsent || refId != null) {
      map['ref_id'] = Variable<int>(refId);
    }
    if (!nullToAbsent || shiftId != null) {
      map['shift_id'] = Variable<int>(shiftId);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CustomerTransactionsCompanion toCompanion(bool nullToAbsent) {
    return CustomerTransactionsCompanion(
      id: Value(id),
      customerId: Value(customerId),
      type: Value(type),
      amountUsd: Value(amountUsd),
      currency: Value(currency),
      originalAmount: Value(originalAmount),
      rate: Value(rate),
      refId: refId == null && nullToAbsent ? const Value.absent() : Value(refId),
      shiftId: shiftId == null && nullToAbsent ? const Value.absent() : Value(shiftId),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory CustomerTransaction.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerTransaction(
      id: serializer.fromJson<int>(json['id']),
      customerId: serializer.fromJson<int>(json['customerId']),
      type: serializer.fromJson<String>(json['type']),
      amountUsd: serializer.fromJson<double>(json['amountUsd']),
      currency: serializer.fromJson<String>(json['currency']),
      originalAmount: serializer.fromJson<double>(json['originalAmount']),
      rate: serializer.fromJson<double>(json['rate']),
      refId: serializer.fromJson<int?>(json['refId']),
      shiftId: serializer.fromJson<int?>(json['shiftId']),
      userId: serializer.fromJson<int?>(json['userId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerId': serializer.toJson<int>(customerId),
      'type': serializer.toJson<String>(type),
      'amountUsd': serializer.toJson<double>(amountUsd),
      'currency': serializer.toJson<String>(currency),
      'originalAmount': serializer.toJson<double>(originalAmount),
      'rate': serializer.toJson<double>(rate),
      'refId': serializer.toJson<int?>(refId),
      'shiftId': serializer.toJson<int?>(shiftId),
      'userId': serializer.toJson<int?>(userId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CustomerTransaction copyWith({
    int? id,
    int? customerId,
    String? type,
    double? amountUsd,
    String? currency,
    double? originalAmount,
    double? rate,
    Value<int?> refId = const Value.absent(),
    Value<int?> shiftId = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => CustomerTransaction(
    id: id ?? this.id,
    customerId: customerId ?? this.customerId,
    type: type ?? this.type,
    amountUsd: amountUsd ?? this.amountUsd,
    currency: currency ?? this.currency,
    originalAmount: originalAmount ?? this.originalAmount,
    rate: rate ?? this.rate,
    refId: refId.present ? refId.value : this.refId,
    shiftId: shiftId.present ? shiftId.value : this.shiftId,
    userId: userId.present ? userId.value : this.userId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  CustomerTransaction copyWithCompanion(CustomerTransactionsCompanion data) {
    return CustomerTransaction(
      id: data.id.present ? data.id.value : this.id,
      customerId: data.customerId.present ? data.customerId.value : this.customerId,
      type: data.type.present ? data.type.value : this.type,
      amountUsd: data.amountUsd.present ? data.amountUsd.value : this.amountUsd,
      currency: data.currency.present ? data.currency.value : this.currency,
      originalAmount: data.originalAmount.present ? data.originalAmount.value : this.originalAmount,
      rate: data.rate.present ? data.rate.value : this.rate,
      refId: data.refId.present ? data.refId.value : this.refId,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      userId: data.userId.present ? data.userId.value : this.userId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerTransaction(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('amountUsd: $amountUsd, ')
          ..write('currency: $currency, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('rate: $rate, ')
          ..write('refId: $refId, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerId,
    type,
    amountUsd,
    currency,
    originalAmount,
    rate,
    refId,
    shiftId,
    userId,
    note,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerTransaction &&
          other.id == this.id &&
          other.customerId == this.customerId &&
          other.type == this.type &&
          other.amountUsd == this.amountUsd &&
          other.currency == this.currency &&
          other.originalAmount == this.originalAmount &&
          other.rate == this.rate &&
          other.refId == this.refId &&
          other.shiftId == this.shiftId &&
          other.userId == this.userId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class CustomerTransactionsCompanion extends UpdateCompanion<CustomerTransaction> {
  final Value<int> id;
  final Value<int> customerId;
  final Value<String> type;
  final Value<double> amountUsd;
  final Value<String> currency;
  final Value<double> originalAmount;
  final Value<double> rate;
  final Value<int?> refId;
  final Value<int?> shiftId;
  final Value<int?> userId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const CustomerTransactionsCompanion({
    this.id = const Value.absent(),
    this.customerId = const Value.absent(),
    this.type = const Value.absent(),
    this.amountUsd = const Value.absent(),
    this.currency = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.rate = const Value.absent(),
    this.refId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CustomerTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required int customerId,
    required String type,
    required double amountUsd,
    this.currency = const Value.absent(),
    this.originalAmount = const Value.absent(),
    this.rate = const Value.absent(),
    this.refId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : customerId = Value(customerId),
       type = Value(type),
       amountUsd = Value(amountUsd);
  static Insertable<CustomerTransaction> custom({
    Expression<int>? id,
    Expression<int>? customerId,
    Expression<String>? type,
    Expression<double>? amountUsd,
    Expression<String>? currency,
    Expression<double>? originalAmount,
    Expression<double>? rate,
    Expression<int>? refId,
    Expression<int>? shiftId,
    Expression<int>? userId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerId != null) 'customer_id': customerId,
      if (type != null) 'type': type,
      if (amountUsd != null) 'amount_usd': amountUsd,
      if (currency != null) 'currency': currency,
      if (originalAmount != null) 'original_amount': originalAmount,
      if (rate != null) 'rate': rate,
      if (refId != null) 'ref_id': refId,
      if (shiftId != null) 'shift_id': shiftId,
      if (userId != null) 'user_id': userId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CustomerTransactionsCompanion copyWith({
    Value<int>? id,
    Value<int>? customerId,
    Value<String>? type,
    Value<double>? amountUsd,
    Value<String>? currency,
    Value<double>? originalAmount,
    Value<double>? rate,
    Value<int?>? refId,
    Value<int?>? shiftId,
    Value<int?>? userId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return CustomerTransactionsCompanion(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      amountUsd: amountUsd ?? this.amountUsd,
      currency: currency ?? this.currency,
      originalAmount: originalAmount ?? this.originalAmount,
      rate: rate ?? this.rate,
      refId: refId ?? this.refId,
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountUsd.present) {
      map['amount_usd'] = Variable<double>(amountUsd.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (originalAmount.present) {
      map['original_amount'] = Variable<double>(originalAmount.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<int>(refId.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('amountUsd: $amountUsd, ')
          ..write('currency: $currency, ')
          ..write('originalAmount: $originalAmount, ')
          ..write('rate: $rate, ')
          ..write('refId: $refId, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchasesTable extends Purchases with TableInfo<$PurchasesTable, Purchase> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'),
  );
  static const VerificationMeta _invoiceNumberMeta = const VerificationMeta('invoiceNumber');
  @override
  late final GeneratedColumn<String> invoiceNumber = GeneratedColumn<String>(
    'invoice_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _invoiceDateMeta = const VerificationMeta('invoiceDate');
  @override
  late final GeneratedColumn<DateTime> invoiceDate = GeneratedColumn<DateTime>(
    'invoice_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalUsdMeta = const VerificationMeta('totalUsd');
  @override
  late final GeneratedColumn<double> totalUsd = GeneratedColumn<double>(
    'total_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountUsdMeta = const VerificationMeta('discountUsd');
  @override
  late final GeneratedColumn<double> discountUsd = GeneratedColumn<double>(
    'discount_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidUsdMeta = const VerificationMeta('paidUsd');
  @override
  late final GeneratedColumn<double> paidUsd = GeneratedColumn<double>(
    'paid_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    supplierId,
    invoiceNumber,
    invoiceDate,
    totalUsd,
    discountUsd,
    paidUsd,
    notes,
    userId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchases';
  @override
  VerificationContext validateIntegrity(Insertable<Purchase> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(_supplierIdMeta, supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('invoice_number')) {
      context.handle(
        _invoiceNumberMeta,
        invoiceNumber.isAcceptableOrUnknown(data['invoice_number']!, _invoiceNumberMeta),
      );
    }
    if (data.containsKey('invoice_date')) {
      context.handle(_invoiceDateMeta, invoiceDate.isAcceptableOrUnknown(data['invoice_date']!, _invoiceDateMeta));
    } else if (isInserting) {
      context.missing(_invoiceDateMeta);
    }
    if (data.containsKey('total_usd')) {
      context.handle(_totalUsdMeta, totalUsd.isAcceptableOrUnknown(data['total_usd']!, _totalUsdMeta));
    } else if (isInserting) {
      context.missing(_totalUsdMeta);
    }
    if (data.containsKey('discount_usd')) {
      context.handle(_discountUsdMeta, discountUsd.isAcceptableOrUnknown(data['discount_usd']!, _discountUsdMeta));
    }
    if (data.containsKey('paid_usd')) {
      context.handle(_paidUsdMeta, paidUsd.isAcceptableOrUnknown(data['paid_usd']!, _paidUsdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(_notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Purchase map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Purchase(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      invoiceNumber: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}invoice_number']),
      invoiceDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}invoice_date'])!,
      totalUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_usd'])!,
      discountUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}discount_usd'])!,
      paidUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}paid_usd'])!,
      notes: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}notes']),
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $PurchasesTable createAlias(String alias) {
    return $PurchasesTable(attachedDatabase, alias);
  }
}

class Purchase extends DataClass implements Insertable<Purchase> {
  final int id;
  final int supplierId;
  final String? invoiceNumber;
  final DateTime invoiceDate;
  final double totalUsd;
  final double discountUsd;
  final double paidUsd;
  final String? notes;
  final int? userId;
  final DateTime createdAt;
  const Purchase({
    required this.id,
    required this.supplierId,
    this.invoiceNumber,
    required this.invoiceDate,
    required this.totalUsd,
    required this.discountUsd,
    required this.paidUsd,
    this.notes,
    this.userId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    if (!nullToAbsent || invoiceNumber != null) {
      map['invoice_number'] = Variable<String>(invoiceNumber);
    }
    map['invoice_date'] = Variable<DateTime>(invoiceDate);
    map['total_usd'] = Variable<double>(totalUsd);
    map['discount_usd'] = Variable<double>(discountUsd);
    map['paid_usd'] = Variable<double>(paidUsd);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PurchasesCompanion toCompanion(bool nullToAbsent) {
    return PurchasesCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      invoiceNumber: invoiceNumber == null && nullToAbsent ? const Value.absent() : Value(invoiceNumber),
      invoiceDate: Value(invoiceDate),
      totalUsd: Value(totalUsd),
      discountUsd: Value(discountUsd),
      paidUsd: Value(paidUsd),
      notes: notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdAt: Value(createdAt),
    );
  }

  factory Purchase.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Purchase(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      invoiceNumber: serializer.fromJson<String?>(json['invoiceNumber']),
      invoiceDate: serializer.fromJson<DateTime>(json['invoiceDate']),
      totalUsd: serializer.fromJson<double>(json['totalUsd']),
      discountUsd: serializer.fromJson<double>(json['discountUsd']),
      paidUsd: serializer.fromJson<double>(json['paidUsd']),
      notes: serializer.fromJson<String?>(json['notes']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'invoiceNumber': serializer.toJson<String?>(invoiceNumber),
      'invoiceDate': serializer.toJson<DateTime>(invoiceDate),
      'totalUsd': serializer.toJson<double>(totalUsd),
      'discountUsd': serializer.toJson<double>(discountUsd),
      'paidUsd': serializer.toJson<double>(paidUsd),
      'notes': serializer.toJson<String?>(notes),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Purchase copyWith({
    int? id,
    int? supplierId,
    Value<String?> invoiceNumber = const Value.absent(),
    DateTime? invoiceDate,
    double? totalUsd,
    double? discountUsd,
    double? paidUsd,
    Value<String?> notes = const Value.absent(),
    Value<int?> userId = const Value.absent(),
    DateTime? createdAt,
  }) => Purchase(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    invoiceNumber: invoiceNumber.present ? invoiceNumber.value : this.invoiceNumber,
    invoiceDate: invoiceDate ?? this.invoiceDate,
    totalUsd: totalUsd ?? this.totalUsd,
    discountUsd: discountUsd ?? this.discountUsd,
    paidUsd: paidUsd ?? this.paidUsd,
    notes: notes.present ? notes.value : this.notes,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
  );
  Purchase copyWithCompanion(PurchasesCompanion data) {
    return Purchase(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present ? data.supplierId.value : this.supplierId,
      invoiceNumber: data.invoiceNumber.present ? data.invoiceNumber.value : this.invoiceNumber,
      invoiceDate: data.invoiceDate.present ? data.invoiceDate.value : this.invoiceDate,
      totalUsd: data.totalUsd.present ? data.totalUsd.value : this.totalUsd,
      discountUsd: data.discountUsd.present ? data.discountUsd.value : this.discountUsd,
      paidUsd: data.paidUsd.present ? data.paidUsd.value : this.paidUsd,
      notes: data.notes.present ? data.notes.value : this.notes,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Purchase(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('discountUsd: $discountUsd, ')
          ..write('paidUsd: $paidUsd, ')
          ..write('notes: $notes, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, supplierId, invoiceNumber, invoiceDate, totalUsd, discountUsd, paidUsd, notes, userId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Purchase &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.invoiceNumber == this.invoiceNumber &&
          other.invoiceDate == this.invoiceDate &&
          other.totalUsd == this.totalUsd &&
          other.discountUsd == this.discountUsd &&
          other.paidUsd == this.paidUsd &&
          other.notes == this.notes &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt);
}

class PurchasesCompanion extends UpdateCompanion<Purchase> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<String?> invoiceNumber;
  final Value<DateTime> invoiceDate;
  final Value<double> totalUsd;
  final Value<double> discountUsd;
  final Value<double> paidUsd;
  final Value<String?> notes;
  final Value<int?> userId;
  final Value<DateTime> createdAt;
  const PurchasesCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.invoiceNumber = const Value.absent(),
    this.invoiceDate = const Value.absent(),
    this.totalUsd = const Value.absent(),
    this.discountUsd = const Value.absent(),
    this.paidUsd = const Value.absent(),
    this.notes = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PurchasesCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    this.invoiceNumber = const Value.absent(),
    required DateTime invoiceDate,
    required double totalUsd,
    this.discountUsd = const Value.absent(),
    this.paidUsd = const Value.absent(),
    this.notes = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : supplierId = Value(supplierId),
       invoiceDate = Value(invoiceDate),
       totalUsd = Value(totalUsd);
  static Insertable<Purchase> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<String>? invoiceNumber,
    Expression<DateTime>? invoiceDate,
    Expression<double>? totalUsd,
    Expression<double>? discountUsd,
    Expression<double>? paidUsd,
    Expression<String>? notes,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (invoiceNumber != null) 'invoice_number': invoiceNumber,
      if (invoiceDate != null) 'invoice_date': invoiceDate,
      if (totalUsd != null) 'total_usd': totalUsd,
      if (discountUsd != null) 'discount_usd': discountUsd,
      if (paidUsd != null) 'paid_usd': paidUsd,
      if (notes != null) 'notes': notes,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PurchasesCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<String?>? invoiceNumber,
    Value<DateTime>? invoiceDate,
    Value<double>? totalUsd,
    Value<double>? discountUsd,
    Value<double>? paidUsd,
    Value<String?>? notes,
    Value<int?>? userId,
    Value<DateTime>? createdAt,
  }) {
    return PurchasesCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      totalUsd: totalUsd ?? this.totalUsd,
      discountUsd: discountUsd ?? this.discountUsd,
      paidUsd: paidUsd ?? this.paidUsd,
      notes: notes ?? this.notes,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (invoiceNumber.present) {
      map['invoice_number'] = Variable<String>(invoiceNumber.value);
    }
    if (invoiceDate.present) {
      map['invoice_date'] = Variable<DateTime>(invoiceDate.value);
    }
    if (totalUsd.present) {
      map['total_usd'] = Variable<double>(totalUsd.value);
    }
    if (discountUsd.present) {
      map['discount_usd'] = Variable<double>(discountUsd.value);
    }
    if (paidUsd.present) {
      map['paid_usd'] = Variable<double>(paidUsd.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchasesCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('invoiceNumber: $invoiceNumber, ')
          ..write('invoiceDate: $invoiceDate, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('discountUsd: $discountUsd, ')
          ..write('paidUsd: $paidUsd, ')
          ..write('notes: $notes, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $PurchaseItemsTable extends PurchaseItems with TableInfo<$PurchaseItemsTable, PurchaseItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PurchaseItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _purchaseIdMeta = const VerificationMeta('purchaseId');
  @override
  late final GeneratedColumn<int> purchaseId = GeneratedColumn<int>(
    'purchase_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES purchases (id)'),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES medicines (id)'),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<int> batchId = GeneratedColumn<int>(
    'batch_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityBoxesMeta = const VerificationMeta('quantityBoxes');
  @override
  late final GeneratedColumn<int> quantityBoxes = GeneratedColumn<int>(
    'quantity_boxes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bonusBoxesMeta = const VerificationMeta('bonusBoxes');
  @override
  late final GeneratedColumn<int> bonusBoxes = GeneratedColumn<int>(
    'bonus_boxes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _costUsdPerBoxMeta = const VerificationMeta('costUsdPerBox');
  @override
  late final GeneratedColumn<double> costUsdPerBox = GeneratedColumn<double>(
    'cost_usd_per_box',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _batchNumberMeta = const VerificationMeta('batchNumber');
  @override
  late final GeneratedColumn<String> batchNumber = GeneratedColumn<String>(
    'batch_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expiryDateMeta = const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
    'expiry_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalUsdMeta = const VerificationMeta('totalUsd');
  @override
  late final GeneratedColumn<double> totalUsd = GeneratedColumn<double>(
    'total_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    purchaseId,
    medicineId,
    batchId,
    quantityBoxes,
    bonusBoxes,
    costUsdPerBox,
    batchNumber,
    expiryDate,
    totalUsd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'purchase_items';
  @override
  VerificationContext validateIntegrity(Insertable<PurchaseItem> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('purchase_id')) {
      context.handle(_purchaseIdMeta, purchaseId.isAcceptableOrUnknown(data['purchase_id']!, _purchaseIdMeta));
    } else if (isInserting) {
      context.missing(_purchaseIdMeta);
    }
    if (data.containsKey('medicine_id')) {
      context.handle(_medicineIdMeta, medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta, batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    }
    if (data.containsKey('quantity_boxes')) {
      context.handle(
        _quantityBoxesMeta,
        quantityBoxes.isAcceptableOrUnknown(data['quantity_boxes']!, _quantityBoxesMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityBoxesMeta);
    }
    if (data.containsKey('bonus_boxes')) {
      context.handle(_bonusBoxesMeta, bonusBoxes.isAcceptableOrUnknown(data['bonus_boxes']!, _bonusBoxesMeta));
    }
    if (data.containsKey('cost_usd_per_box')) {
      context.handle(
        _costUsdPerBoxMeta,
        costUsdPerBox.isAcceptableOrUnknown(data['cost_usd_per_box']!, _costUsdPerBoxMeta),
      );
    } else if (isInserting) {
      context.missing(_costUsdPerBoxMeta);
    }
    if (data.containsKey('batch_number')) {
      context.handle(_batchNumberMeta, batchNumber.isAcceptableOrUnknown(data['batch_number']!, _batchNumberMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(_expiryDateMeta, expiryDate.isAcceptableOrUnknown(data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('total_usd')) {
      context.handle(_totalUsdMeta, totalUsd.isAcceptableOrUnknown(data['total_usd']!, _totalUsdMeta));
    } else if (isInserting) {
      context.missing(_totalUsdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PurchaseItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PurchaseItem(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      purchaseId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}purchase_id'])!,
      medicineId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      batchId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}batch_id']),
      quantityBoxes: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}quantity_boxes'])!,
      bonusBoxes: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}bonus_boxes'])!,
      costUsdPerBox: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_usd_per_box'],
      )!,
      batchNumber: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}batch_number']),
      expiryDate: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
      totalUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_usd'])!,
    );
  }

  @override
  $PurchaseItemsTable createAlias(String alias) {
    return $PurchaseItemsTable(attachedDatabase, alias);
  }
}

class PurchaseItem extends DataClass implements Insertable<PurchaseItem> {
  final int id;
  final int purchaseId;
  final int medicineId;
  final int? batchId;
  final int quantityBoxes;
  final int bonusBoxes;
  final double costUsdPerBox;
  final String? batchNumber;
  final DateTime? expiryDate;
  final double totalUsd;
  const PurchaseItem({
    required this.id,
    required this.purchaseId,
    required this.medicineId,
    this.batchId,
    required this.quantityBoxes,
    required this.bonusBoxes,
    required this.costUsdPerBox,
    this.batchNumber,
    this.expiryDate,
    required this.totalUsd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['purchase_id'] = Variable<int>(purchaseId);
    map['medicine_id'] = Variable<int>(medicineId);
    if (!nullToAbsent || batchId != null) {
      map['batch_id'] = Variable<int>(batchId);
    }
    map['quantity_boxes'] = Variable<int>(quantityBoxes);
    map['bonus_boxes'] = Variable<int>(bonusBoxes);
    map['cost_usd_per_box'] = Variable<double>(costUsdPerBox);
    if (!nullToAbsent || batchNumber != null) {
      map['batch_number'] = Variable<String>(batchNumber);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    map['total_usd'] = Variable<double>(totalUsd);
    return map;
  }

  PurchaseItemsCompanion toCompanion(bool nullToAbsent) {
    return PurchaseItemsCompanion(
      id: Value(id),
      purchaseId: Value(purchaseId),
      medicineId: Value(medicineId),
      batchId: batchId == null && nullToAbsent ? const Value.absent() : Value(batchId),
      quantityBoxes: Value(quantityBoxes),
      bonusBoxes: Value(bonusBoxes),
      costUsdPerBox: Value(costUsdPerBox),
      batchNumber: batchNumber == null && nullToAbsent ? const Value.absent() : Value(batchNumber),
      expiryDate: expiryDate == null && nullToAbsent ? const Value.absent() : Value(expiryDate),
      totalUsd: Value(totalUsd),
    );
  }

  factory PurchaseItem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PurchaseItem(
      id: serializer.fromJson<int>(json['id']),
      purchaseId: serializer.fromJson<int>(json['purchaseId']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      batchId: serializer.fromJson<int?>(json['batchId']),
      quantityBoxes: serializer.fromJson<int>(json['quantityBoxes']),
      bonusBoxes: serializer.fromJson<int>(json['bonusBoxes']),
      costUsdPerBox: serializer.fromJson<double>(json['costUsdPerBox']),
      batchNumber: serializer.fromJson<String?>(json['batchNumber']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      totalUsd: serializer.fromJson<double>(json['totalUsd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'purchaseId': serializer.toJson<int>(purchaseId),
      'medicineId': serializer.toJson<int>(medicineId),
      'batchId': serializer.toJson<int?>(batchId),
      'quantityBoxes': serializer.toJson<int>(quantityBoxes),
      'bonusBoxes': serializer.toJson<int>(bonusBoxes),
      'costUsdPerBox': serializer.toJson<double>(costUsdPerBox),
      'batchNumber': serializer.toJson<String?>(batchNumber),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'totalUsd': serializer.toJson<double>(totalUsd),
    };
  }

  PurchaseItem copyWith({
    int? id,
    int? purchaseId,
    int? medicineId,
    Value<int?> batchId = const Value.absent(),
    int? quantityBoxes,
    int? bonusBoxes,
    double? costUsdPerBox,
    Value<String?> batchNumber = const Value.absent(),
    Value<DateTime?> expiryDate = const Value.absent(),
    double? totalUsd,
  }) => PurchaseItem(
    id: id ?? this.id,
    purchaseId: purchaseId ?? this.purchaseId,
    medicineId: medicineId ?? this.medicineId,
    batchId: batchId.present ? batchId.value : this.batchId,
    quantityBoxes: quantityBoxes ?? this.quantityBoxes,
    bonusBoxes: bonusBoxes ?? this.bonusBoxes,
    costUsdPerBox: costUsdPerBox ?? this.costUsdPerBox,
    batchNumber: batchNumber.present ? batchNumber.value : this.batchNumber,
    expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
    totalUsd: totalUsd ?? this.totalUsd,
  );
  PurchaseItem copyWithCompanion(PurchaseItemsCompanion data) {
    return PurchaseItem(
      id: data.id.present ? data.id.value : this.id,
      purchaseId: data.purchaseId.present ? data.purchaseId.value : this.purchaseId,
      medicineId: data.medicineId.present ? data.medicineId.value : this.medicineId,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      quantityBoxes: data.quantityBoxes.present ? data.quantityBoxes.value : this.quantityBoxes,
      bonusBoxes: data.bonusBoxes.present ? data.bonusBoxes.value : this.bonusBoxes,
      costUsdPerBox: data.costUsdPerBox.present ? data.costUsdPerBox.value : this.costUsdPerBox,
      batchNumber: data.batchNumber.present ? data.batchNumber.value : this.batchNumber,
      expiryDate: data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      totalUsd: data.totalUsd.present ? data.totalUsd.value : this.totalUsd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItem(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('medicineId: $medicineId, ')
          ..write('batchId: $batchId, ')
          ..write('quantityBoxes: $quantityBoxes, ')
          ..write('bonusBoxes: $bonusBoxes, ')
          ..write('costUsdPerBox: $costUsdPerBox, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('totalUsd: $totalUsd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    purchaseId,
    medicineId,
    batchId,
    quantityBoxes,
    bonusBoxes,
    costUsdPerBox,
    batchNumber,
    expiryDate,
    totalUsd,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PurchaseItem &&
          other.id == this.id &&
          other.purchaseId == this.purchaseId &&
          other.medicineId == this.medicineId &&
          other.batchId == this.batchId &&
          other.quantityBoxes == this.quantityBoxes &&
          other.bonusBoxes == this.bonusBoxes &&
          other.costUsdPerBox == this.costUsdPerBox &&
          other.batchNumber == this.batchNumber &&
          other.expiryDate == this.expiryDate &&
          other.totalUsd == this.totalUsd);
}

class PurchaseItemsCompanion extends UpdateCompanion<PurchaseItem> {
  final Value<int> id;
  final Value<int> purchaseId;
  final Value<int> medicineId;
  final Value<int?> batchId;
  final Value<int> quantityBoxes;
  final Value<int> bonusBoxes;
  final Value<double> costUsdPerBox;
  final Value<String?> batchNumber;
  final Value<DateTime?> expiryDate;
  final Value<double> totalUsd;
  const PurchaseItemsCompanion({
    this.id = const Value.absent(),
    this.purchaseId = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.batchId = const Value.absent(),
    this.quantityBoxes = const Value.absent(),
    this.bonusBoxes = const Value.absent(),
    this.costUsdPerBox = const Value.absent(),
    this.batchNumber = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.totalUsd = const Value.absent(),
  });
  PurchaseItemsCompanion.insert({
    this.id = const Value.absent(),
    required int purchaseId,
    required int medicineId,
    this.batchId = const Value.absent(),
    required int quantityBoxes,
    this.bonusBoxes = const Value.absent(),
    required double costUsdPerBox,
    this.batchNumber = const Value.absent(),
    this.expiryDate = const Value.absent(),
    required double totalUsd,
  }) : purchaseId = Value(purchaseId),
       medicineId = Value(medicineId),
       quantityBoxes = Value(quantityBoxes),
       costUsdPerBox = Value(costUsdPerBox),
       totalUsd = Value(totalUsd);
  static Insertable<PurchaseItem> custom({
    Expression<int>? id,
    Expression<int>? purchaseId,
    Expression<int>? medicineId,
    Expression<int>? batchId,
    Expression<int>? quantityBoxes,
    Expression<int>? bonusBoxes,
    Expression<double>? costUsdPerBox,
    Expression<String>? batchNumber,
    Expression<DateTime>? expiryDate,
    Expression<double>? totalUsd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (purchaseId != null) 'purchase_id': purchaseId,
      if (medicineId != null) 'medicine_id': medicineId,
      if (batchId != null) 'batch_id': batchId,
      if (quantityBoxes != null) 'quantity_boxes': quantityBoxes,
      if (bonusBoxes != null) 'bonus_boxes': bonusBoxes,
      if (costUsdPerBox != null) 'cost_usd_per_box': costUsdPerBox,
      if (batchNumber != null) 'batch_number': batchNumber,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (totalUsd != null) 'total_usd': totalUsd,
    });
  }

  PurchaseItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? purchaseId,
    Value<int>? medicineId,
    Value<int?>? batchId,
    Value<int>? quantityBoxes,
    Value<int>? bonusBoxes,
    Value<double>? costUsdPerBox,
    Value<String?>? batchNumber,
    Value<DateTime?>? expiryDate,
    Value<double>? totalUsd,
  }) {
    return PurchaseItemsCompanion(
      id: id ?? this.id,
      purchaseId: purchaseId ?? this.purchaseId,
      medicineId: medicineId ?? this.medicineId,
      batchId: batchId ?? this.batchId,
      quantityBoxes: quantityBoxes ?? this.quantityBoxes,
      bonusBoxes: bonusBoxes ?? this.bonusBoxes,
      costUsdPerBox: costUsdPerBox ?? this.costUsdPerBox,
      batchNumber: batchNumber ?? this.batchNumber,
      expiryDate: expiryDate ?? this.expiryDate,
      totalUsd: totalUsd ?? this.totalUsd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (purchaseId.present) {
      map['purchase_id'] = Variable<int>(purchaseId.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<int>(batchId.value);
    }
    if (quantityBoxes.present) {
      map['quantity_boxes'] = Variable<int>(quantityBoxes.value);
    }
    if (bonusBoxes.present) {
      map['bonus_boxes'] = Variable<int>(bonusBoxes.value);
    }
    if (costUsdPerBox.present) {
      map['cost_usd_per_box'] = Variable<double>(costUsdPerBox.value);
    }
    if (batchNumber.present) {
      map['batch_number'] = Variable<String>(batchNumber.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (totalUsd.present) {
      map['total_usd'] = Variable<double>(totalUsd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PurchaseItemsCompanion(')
          ..write('id: $id, ')
          ..write('purchaseId: $purchaseId, ')
          ..write('medicineId: $medicineId, ')
          ..write('batchId: $batchId, ')
          ..write('quantityBoxes: $quantityBoxes, ')
          ..write('bonusBoxes: $bonusBoxes, ')
          ..write('costUsdPerBox: $costUsdPerBox, ')
          ..write('batchNumber: $batchNumber, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('totalUsd: $totalUsd')
          ..write(')'))
        .toString();
  }
}

class $ShiftsTable extends Shifts with TableInfo<$ShiftsTable, Shift> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES users (id)'),
  );
  static const VerificationMeta _openedAtMeta = const VerificationMeta('openedAt');
  @override
  late final GeneratedColumn<DateTime> openedAt = GeneratedColumn<DateTime>(
    'opened_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _closedAtMeta = const VerificationMeta('closedAt');
  @override
  late final GeneratedColumn<DateTime> closedAt = GeneratedColumn<DateTime>(
    'closed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openingSypMeta = const VerificationMeta('openingSyp');
  @override
  late final GeneratedColumn<double> openingSyp = GeneratedColumn<double>(
    'opening_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _openingUsdMeta = const VerificationMeta('openingUsd');
  @override
  late final GeneratedColumn<double> openingUsd = GeneratedColumn<double>(
    'opening_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _expectedSypMeta = const VerificationMeta('expectedSyp');
  @override
  late final GeneratedColumn<double> expectedSyp = GeneratedColumn<double>(
    'expected_syp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _expectedUsdMeta = const VerificationMeta('expectedUsd');
  @override
  late final GeneratedColumn<double> expectedUsd = GeneratedColumn<double>(
    'expected_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualSypMeta = const VerificationMeta('actualSyp');
  @override
  late final GeneratedColumn<double> actualSyp = GeneratedColumn<double>(
    'actual_syp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actualUsdMeta = const VerificationMeta('actualUsd');
  @override
  late final GeneratedColumn<double> actualUsd = GeneratedColumn<double>(
    'actual_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diffSypMeta = const VerificationMeta('diffSyp');
  @override
  late final GeneratedColumn<double> diffSyp = GeneratedColumn<double>(
    'diff_syp',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diffUsdMeta = const VerificationMeta('diffUsd');
  @override
  late final GeneratedColumn<double> diffUsd = GeneratedColumn<double>(
    'diff_usd',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _receivedByIdMeta = const VerificationMeta('receivedById');
  @override
  late final GeneratedColumn<int> receivedById = GeneratedColumn<int>(
    'received_by_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('open'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    openedAt,
    closedAt,
    openingSyp,
    openingUsd,
    expectedSyp,
    expectedUsd,
    actualSyp,
    actualUsd,
    diffSyp,
    diffUsd,
    receivedById,
    note,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shifts';
  @override
  VerificationContext validateIntegrity(Insertable<Shift> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('opened_at')) {
      context.handle(_openedAtMeta, openedAt.isAcceptableOrUnknown(data['opened_at']!, _openedAtMeta));
    }
    if (data.containsKey('closed_at')) {
      context.handle(_closedAtMeta, closedAt.isAcceptableOrUnknown(data['closed_at']!, _closedAtMeta));
    }
    if (data.containsKey('opening_syp')) {
      context.handle(_openingSypMeta, openingSyp.isAcceptableOrUnknown(data['opening_syp']!, _openingSypMeta));
    }
    if (data.containsKey('opening_usd')) {
      context.handle(_openingUsdMeta, openingUsd.isAcceptableOrUnknown(data['opening_usd']!, _openingUsdMeta));
    }
    if (data.containsKey('expected_syp')) {
      context.handle(_expectedSypMeta, expectedSyp.isAcceptableOrUnknown(data['expected_syp']!, _expectedSypMeta));
    }
    if (data.containsKey('expected_usd')) {
      context.handle(_expectedUsdMeta, expectedUsd.isAcceptableOrUnknown(data['expected_usd']!, _expectedUsdMeta));
    }
    if (data.containsKey('actual_syp')) {
      context.handle(_actualSypMeta, actualSyp.isAcceptableOrUnknown(data['actual_syp']!, _actualSypMeta));
    }
    if (data.containsKey('actual_usd')) {
      context.handle(_actualUsdMeta, actualUsd.isAcceptableOrUnknown(data['actual_usd']!, _actualUsdMeta));
    }
    if (data.containsKey('diff_syp')) {
      context.handle(_diffSypMeta, diffSyp.isAcceptableOrUnknown(data['diff_syp']!, _diffSypMeta));
    }
    if (data.containsKey('diff_usd')) {
      context.handle(_diffUsdMeta, diffUsd.isAcceptableOrUnknown(data['diff_usd']!, _diffUsdMeta));
    }
    if (data.containsKey('received_by_id')) {
      context.handle(_receivedByIdMeta, receivedById.isAcceptableOrUnknown(data['received_by_id']!, _receivedByIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Shift map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Shift(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      openedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}opened_at'])!,
      closedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}closed_at']),
      openingSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}opening_syp'])!,
      openingUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}opening_usd'])!,
      expectedSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}expected_syp']),
      expectedUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}expected_usd']),
      actualSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}actual_syp']),
      actualUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}actual_usd']),
      diffSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}diff_syp']),
      diffUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}diff_usd']),
      receivedById: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}received_by_id']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!,
    );
  }

  @override
  $ShiftsTable createAlias(String alias) {
    return $ShiftsTable(attachedDatabase, alias);
  }
}

class Shift extends DataClass implements Insertable<Shift> {
  final int id;
  final int userId;
  final DateTime openedAt;
  final DateTime? closedAt;
  final double openingSyp;
  final double openingUsd;
  final double? expectedSyp;
  final double? expectedUsd;
  final double? actualSyp;
  final double? actualUsd;
  final double? diffSyp;
  final double? diffUsd;

  /// المستلم (المالك أو صيدلي آخر)
  final int? receivedById;
  final String? note;

  /// open / closed
  final String status;
  const Shift({
    required this.id,
    required this.userId,
    required this.openedAt,
    this.closedAt,
    required this.openingSyp,
    required this.openingUsd,
    this.expectedSyp,
    this.expectedUsd,
    this.actualSyp,
    this.actualUsd,
    this.diffSyp,
    this.diffUsd,
    this.receivedById,
    this.note,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['opened_at'] = Variable<DateTime>(openedAt);
    if (!nullToAbsent || closedAt != null) {
      map['closed_at'] = Variable<DateTime>(closedAt);
    }
    map['opening_syp'] = Variable<double>(openingSyp);
    map['opening_usd'] = Variable<double>(openingUsd);
    if (!nullToAbsent || expectedSyp != null) {
      map['expected_syp'] = Variable<double>(expectedSyp);
    }
    if (!nullToAbsent || expectedUsd != null) {
      map['expected_usd'] = Variable<double>(expectedUsd);
    }
    if (!nullToAbsent || actualSyp != null) {
      map['actual_syp'] = Variable<double>(actualSyp);
    }
    if (!nullToAbsent || actualUsd != null) {
      map['actual_usd'] = Variable<double>(actualUsd);
    }
    if (!nullToAbsent || diffSyp != null) {
      map['diff_syp'] = Variable<double>(diffSyp);
    }
    if (!nullToAbsent || diffUsd != null) {
      map['diff_usd'] = Variable<double>(diffUsd);
    }
    if (!nullToAbsent || receivedById != null) {
      map['received_by_id'] = Variable<int>(receivedById);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['status'] = Variable<String>(status);
    return map;
  }

  ShiftsCompanion toCompanion(bool nullToAbsent) {
    return ShiftsCompanion(
      id: Value(id),
      userId: Value(userId),
      openedAt: Value(openedAt),
      closedAt: closedAt == null && nullToAbsent ? const Value.absent() : Value(closedAt),
      openingSyp: Value(openingSyp),
      openingUsd: Value(openingUsd),
      expectedSyp: expectedSyp == null && nullToAbsent ? const Value.absent() : Value(expectedSyp),
      expectedUsd: expectedUsd == null && nullToAbsent ? const Value.absent() : Value(expectedUsd),
      actualSyp: actualSyp == null && nullToAbsent ? const Value.absent() : Value(actualSyp),
      actualUsd: actualUsd == null && nullToAbsent ? const Value.absent() : Value(actualUsd),
      diffSyp: diffSyp == null && nullToAbsent ? const Value.absent() : Value(diffSyp),
      diffUsd: diffUsd == null && nullToAbsent ? const Value.absent() : Value(diffUsd),
      receivedById: receivedById == null && nullToAbsent ? const Value.absent() : Value(receivedById),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      status: Value(status),
    );
  }

  factory Shift.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Shift(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      openedAt: serializer.fromJson<DateTime>(json['openedAt']),
      closedAt: serializer.fromJson<DateTime?>(json['closedAt']),
      openingSyp: serializer.fromJson<double>(json['openingSyp']),
      openingUsd: serializer.fromJson<double>(json['openingUsd']),
      expectedSyp: serializer.fromJson<double?>(json['expectedSyp']),
      expectedUsd: serializer.fromJson<double?>(json['expectedUsd']),
      actualSyp: serializer.fromJson<double?>(json['actualSyp']),
      actualUsd: serializer.fromJson<double?>(json['actualUsd']),
      diffSyp: serializer.fromJson<double?>(json['diffSyp']),
      diffUsd: serializer.fromJson<double?>(json['diffUsd']),
      receivedById: serializer.fromJson<int?>(json['receivedById']),
      note: serializer.fromJson<String?>(json['note']),
      status: serializer.fromJson<String>(json['status']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'openedAt': serializer.toJson<DateTime>(openedAt),
      'closedAt': serializer.toJson<DateTime?>(closedAt),
      'openingSyp': serializer.toJson<double>(openingSyp),
      'openingUsd': serializer.toJson<double>(openingUsd),
      'expectedSyp': serializer.toJson<double?>(expectedSyp),
      'expectedUsd': serializer.toJson<double?>(expectedUsd),
      'actualSyp': serializer.toJson<double?>(actualSyp),
      'actualUsd': serializer.toJson<double?>(actualUsd),
      'diffSyp': serializer.toJson<double?>(diffSyp),
      'diffUsd': serializer.toJson<double?>(diffUsd),
      'receivedById': serializer.toJson<int?>(receivedById),
      'note': serializer.toJson<String?>(note),
      'status': serializer.toJson<String>(status),
    };
  }

  Shift copyWith({
    int? id,
    int? userId,
    DateTime? openedAt,
    Value<DateTime?> closedAt = const Value.absent(),
    double? openingSyp,
    double? openingUsd,
    Value<double?> expectedSyp = const Value.absent(),
    Value<double?> expectedUsd = const Value.absent(),
    Value<double?> actualSyp = const Value.absent(),
    Value<double?> actualUsd = const Value.absent(),
    Value<double?> diffSyp = const Value.absent(),
    Value<double?> diffUsd = const Value.absent(),
    Value<int?> receivedById = const Value.absent(),
    Value<String?> note = const Value.absent(),
    String? status,
  }) => Shift(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    openedAt: openedAt ?? this.openedAt,
    closedAt: closedAt.present ? closedAt.value : this.closedAt,
    openingSyp: openingSyp ?? this.openingSyp,
    openingUsd: openingUsd ?? this.openingUsd,
    expectedSyp: expectedSyp.present ? expectedSyp.value : this.expectedSyp,
    expectedUsd: expectedUsd.present ? expectedUsd.value : this.expectedUsd,
    actualSyp: actualSyp.present ? actualSyp.value : this.actualSyp,
    actualUsd: actualUsd.present ? actualUsd.value : this.actualUsd,
    diffSyp: diffSyp.present ? diffSyp.value : this.diffSyp,
    diffUsd: diffUsd.present ? diffUsd.value : this.diffUsd,
    receivedById: receivedById.present ? receivedById.value : this.receivedById,
    note: note.present ? note.value : this.note,
    status: status ?? this.status,
  );
  Shift copyWithCompanion(ShiftsCompanion data) {
    return Shift(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      openedAt: data.openedAt.present ? data.openedAt.value : this.openedAt,
      closedAt: data.closedAt.present ? data.closedAt.value : this.closedAt,
      openingSyp: data.openingSyp.present ? data.openingSyp.value : this.openingSyp,
      openingUsd: data.openingUsd.present ? data.openingUsd.value : this.openingUsd,
      expectedSyp: data.expectedSyp.present ? data.expectedSyp.value : this.expectedSyp,
      expectedUsd: data.expectedUsd.present ? data.expectedUsd.value : this.expectedUsd,
      actualSyp: data.actualSyp.present ? data.actualSyp.value : this.actualSyp,
      actualUsd: data.actualUsd.present ? data.actualUsd.value : this.actualUsd,
      diffSyp: data.diffSyp.present ? data.diffSyp.value : this.diffSyp,
      diffUsd: data.diffUsd.present ? data.diffUsd.value : this.diffUsd,
      receivedById: data.receivedById.present ? data.receivedById.value : this.receivedById,
      note: data.note.present ? data.note.value : this.note,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Shift(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingSyp: $openingSyp, ')
          ..write('openingUsd: $openingUsd, ')
          ..write('expectedSyp: $expectedSyp, ')
          ..write('expectedUsd: $expectedUsd, ')
          ..write('actualSyp: $actualSyp, ')
          ..write('actualUsd: $actualUsd, ')
          ..write('diffSyp: $diffSyp, ')
          ..write('diffUsd: $diffUsd, ')
          ..write('receivedById: $receivedById, ')
          ..write('note: $note, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    openedAt,
    closedAt,
    openingSyp,
    openingUsd,
    expectedSyp,
    expectedUsd,
    actualSyp,
    actualUsd,
    diffSyp,
    diffUsd,
    receivedById,
    note,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Shift &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.openedAt == this.openedAt &&
          other.closedAt == this.closedAt &&
          other.openingSyp == this.openingSyp &&
          other.openingUsd == this.openingUsd &&
          other.expectedSyp == this.expectedSyp &&
          other.expectedUsd == this.expectedUsd &&
          other.actualSyp == this.actualSyp &&
          other.actualUsd == this.actualUsd &&
          other.diffSyp == this.diffSyp &&
          other.diffUsd == this.diffUsd &&
          other.receivedById == this.receivedById &&
          other.note == this.note &&
          other.status == this.status);
}

class ShiftsCompanion extends UpdateCompanion<Shift> {
  final Value<int> id;
  final Value<int> userId;
  final Value<DateTime> openedAt;
  final Value<DateTime?> closedAt;
  final Value<double> openingSyp;
  final Value<double> openingUsd;
  final Value<double?> expectedSyp;
  final Value<double?> expectedUsd;
  final Value<double?> actualSyp;
  final Value<double?> actualUsd;
  final Value<double?> diffSyp;
  final Value<double?> diffUsd;
  final Value<int?> receivedById;
  final Value<String?> note;
  final Value<String> status;
  const ShiftsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingSyp = const Value.absent(),
    this.openingUsd = const Value.absent(),
    this.expectedSyp = const Value.absent(),
    this.expectedUsd = const Value.absent(),
    this.actualSyp = const Value.absent(),
    this.actualUsd = const Value.absent(),
    this.diffSyp = const Value.absent(),
    this.diffUsd = const Value.absent(),
    this.receivedById = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
  });
  ShiftsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.openedAt = const Value.absent(),
    this.closedAt = const Value.absent(),
    this.openingSyp = const Value.absent(),
    this.openingUsd = const Value.absent(),
    this.expectedSyp = const Value.absent(),
    this.expectedUsd = const Value.absent(),
    this.actualSyp = const Value.absent(),
    this.actualUsd = const Value.absent(),
    this.diffSyp = const Value.absent(),
    this.diffUsd = const Value.absent(),
    this.receivedById = const Value.absent(),
    this.note = const Value.absent(),
    this.status = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<Shift> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<DateTime>? openedAt,
    Expression<DateTime>? closedAt,
    Expression<double>? openingSyp,
    Expression<double>? openingUsd,
    Expression<double>? expectedSyp,
    Expression<double>? expectedUsd,
    Expression<double>? actualSyp,
    Expression<double>? actualUsd,
    Expression<double>? diffSyp,
    Expression<double>? diffUsd,
    Expression<int>? receivedById,
    Expression<String>? note,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (openedAt != null) 'opened_at': openedAt,
      if (closedAt != null) 'closed_at': closedAt,
      if (openingSyp != null) 'opening_syp': openingSyp,
      if (openingUsd != null) 'opening_usd': openingUsd,
      if (expectedSyp != null) 'expected_syp': expectedSyp,
      if (expectedUsd != null) 'expected_usd': expectedUsd,
      if (actualSyp != null) 'actual_syp': actualSyp,
      if (actualUsd != null) 'actual_usd': actualUsd,
      if (diffSyp != null) 'diff_syp': diffSyp,
      if (diffUsd != null) 'diff_usd': diffUsd,
      if (receivedById != null) 'received_by_id': receivedById,
      if (note != null) 'note': note,
      if (status != null) 'status': status,
    });
  }

  ShiftsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<DateTime>? openedAt,
    Value<DateTime?>? closedAt,
    Value<double>? openingSyp,
    Value<double>? openingUsd,
    Value<double?>? expectedSyp,
    Value<double?>? expectedUsd,
    Value<double?>? actualSyp,
    Value<double?>? actualUsd,
    Value<double?>? diffSyp,
    Value<double?>? diffUsd,
    Value<int?>? receivedById,
    Value<String?>? note,
    Value<String>? status,
  }) {
    return ShiftsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      openedAt: openedAt ?? this.openedAt,
      closedAt: closedAt ?? this.closedAt,
      openingSyp: openingSyp ?? this.openingSyp,
      openingUsd: openingUsd ?? this.openingUsd,
      expectedSyp: expectedSyp ?? this.expectedSyp,
      expectedUsd: expectedUsd ?? this.expectedUsd,
      actualSyp: actualSyp ?? this.actualSyp,
      actualUsd: actualUsd ?? this.actualUsd,
      diffSyp: diffSyp ?? this.diffSyp,
      diffUsd: diffUsd ?? this.diffUsd,
      receivedById: receivedById ?? this.receivedById,
      note: note ?? this.note,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (openedAt.present) {
      map['opened_at'] = Variable<DateTime>(openedAt.value);
    }
    if (closedAt.present) {
      map['closed_at'] = Variable<DateTime>(closedAt.value);
    }
    if (openingSyp.present) {
      map['opening_syp'] = Variable<double>(openingSyp.value);
    }
    if (openingUsd.present) {
      map['opening_usd'] = Variable<double>(openingUsd.value);
    }
    if (expectedSyp.present) {
      map['expected_syp'] = Variable<double>(expectedSyp.value);
    }
    if (expectedUsd.present) {
      map['expected_usd'] = Variable<double>(expectedUsd.value);
    }
    if (actualSyp.present) {
      map['actual_syp'] = Variable<double>(actualSyp.value);
    }
    if (actualUsd.present) {
      map['actual_usd'] = Variable<double>(actualUsd.value);
    }
    if (diffSyp.present) {
      map['diff_syp'] = Variable<double>(diffSyp.value);
    }
    if (diffUsd.present) {
      map['diff_usd'] = Variable<double>(diffUsd.value);
    }
    if (receivedById.present) {
      map['received_by_id'] = Variable<int>(receivedById.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('openedAt: $openedAt, ')
          ..write('closedAt: $closedAt, ')
          ..write('openingSyp: $openingSyp, ')
          ..write('openingUsd: $openingUsd, ')
          ..write('expectedSyp: $expectedSyp, ')
          ..write('expectedUsd: $expectedUsd, ')
          ..write('actualSyp: $actualSyp, ')
          ..write('actualUsd: $actualUsd, ')
          ..write('diffSyp: $diffSyp, ')
          ..write('diffUsd: $diffUsd, ')
          ..write('receivedById: $receivedById, ')
          ..write('note: $note, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $CashMovementsTable extends CashMovements with TableInfo<$CashMovementsTable, CashMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CashMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES shifts (id)'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta('currency');
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<int> refId = GeneratedColumn<int>(
    'ref_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, shiftId, userId, type, currency, amount, refId, note, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cash_movements';
  @override
  VerificationContext validateIntegrity(Insertable<CashMovement> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta, shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta, currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('ref_id')) {
      context.handle(_refIdMeta, refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CashMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CashMovement(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      shiftId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}shift_id'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      type: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      currency: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      amount: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      refId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}ref_id']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $CashMovementsTable createAlias(String alias) {
    return $CashMovementsTable(attachedDatabase, alias);
  }
}

class CashMovement extends DataClass implements Insertable<CashMovement> {
  final int id;
  final int shiftId;
  final int? userId;

  /// opening, sale, change, refund, expense, withdrawal, deposit,
  /// supplier_payment, customer_payment, supplier_return, void, handover
  final String type;

  /// SYP / USD
  final String currency;
  final double amount;
  final int? refId;
  final String? note;
  final DateTime createdAt;
  const CashMovement({
    required this.id,
    required this.shiftId,
    this.userId,
    required this.type,
    required this.currency,
    required this.amount,
    this.refId,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shift_id'] = Variable<int>(shiftId);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['type'] = Variable<String>(type);
    map['currency'] = Variable<String>(currency);
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || refId != null) {
      map['ref_id'] = Variable<int>(refId);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  CashMovementsCompanion toCompanion(bool nullToAbsent) {
    return CashMovementsCompanion(
      id: Value(id),
      shiftId: Value(shiftId),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      type: Value(type),
      currency: Value(currency),
      amount: Value(amount),
      refId: refId == null && nullToAbsent ? const Value.absent() : Value(refId),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory CashMovement.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CashMovement(
      id: serializer.fromJson<int>(json['id']),
      shiftId: serializer.fromJson<int>(json['shiftId']),
      userId: serializer.fromJson<int?>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      currency: serializer.fromJson<String>(json['currency']),
      amount: serializer.fromJson<double>(json['amount']),
      refId: serializer.fromJson<int?>(json['refId']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shiftId': serializer.toJson<int>(shiftId),
      'userId': serializer.toJson<int?>(userId),
      'type': serializer.toJson<String>(type),
      'currency': serializer.toJson<String>(currency),
      'amount': serializer.toJson<double>(amount),
      'refId': serializer.toJson<int?>(refId),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  CashMovement copyWith({
    int? id,
    int? shiftId,
    Value<int?> userId = const Value.absent(),
    String? type,
    String? currency,
    double? amount,
    Value<int?> refId = const Value.absent(),
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => CashMovement(
    id: id ?? this.id,
    shiftId: shiftId ?? this.shiftId,
    userId: userId.present ? userId.value : this.userId,
    type: type ?? this.type,
    currency: currency ?? this.currency,
    amount: amount ?? this.amount,
    refId: refId.present ? refId.value : this.refId,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  CashMovement copyWithCompanion(CashMovementsCompanion data) {
    return CashMovement(
      id: data.id.present ? data.id.value : this.id,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      currency: data.currency.present ? data.currency.value : this.currency,
      amount: data.amount.present ? data.amount.value : this.amount,
      refId: data.refId.present ? data.refId.value : this.refId,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CashMovement(')
          ..write('id: $id, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('currency: $currency, ')
          ..write('amount: $amount, ')
          ..write('refId: $refId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, shiftId, userId, type, currency, amount, refId, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CashMovement &&
          other.id == this.id &&
          other.shiftId == this.shiftId &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.currency == this.currency &&
          other.amount == this.amount &&
          other.refId == this.refId &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class CashMovementsCompanion extends UpdateCompanion<CashMovement> {
  final Value<int> id;
  final Value<int> shiftId;
  final Value<int?> userId;
  final Value<String> type;
  final Value<String> currency;
  final Value<double> amount;
  final Value<int?> refId;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const CashMovementsCompanion({
    this.id = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.currency = const Value.absent(),
    this.amount = const Value.absent(),
    this.refId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  CashMovementsCompanion.insert({
    this.id = const Value.absent(),
    required int shiftId,
    this.userId = const Value.absent(),
    required String type,
    required String currency,
    required double amount,
    this.refId = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : shiftId = Value(shiftId),
       type = Value(type),
       currency = Value(currency),
       amount = Value(amount);
  static Insertable<CashMovement> custom({
    Expression<int>? id,
    Expression<int>? shiftId,
    Expression<int>? userId,
    Expression<String>? type,
    Expression<String>? currency,
    Expression<double>? amount,
    Expression<int>? refId,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shiftId != null) 'shift_id': shiftId,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (currency != null) 'currency': currency,
      if (amount != null) 'amount': amount,
      if (refId != null) 'ref_id': refId,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  CashMovementsCompanion copyWith({
    Value<int>? id,
    Value<int>? shiftId,
    Value<int?>? userId,
    Value<String>? type,
    Value<String>? currency,
    Value<double>? amount,
    Value<int?>? refId,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return CashMovementsCompanion(
      id: id ?? this.id,
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      currency: currency ?? this.currency,
      amount: amount ?? this.amount,
      refId: refId ?? this.refId,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<int>(refId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CashMovementsCompanion(')
          ..write('id: $id, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('currency: $currency, ')
          ..write('amount: $amount, ')
          ..write('refId: $refId, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $SalesTable extends Sales with TableInfo<$SalesTable, Sale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES shifts (id)'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES users (id)'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalSypMeta = const VerificationMeta('subtotalSyp');
  @override
  late final GeneratedColumn<double> subtotalSyp = GeneratedColumn<double>(
    'subtotal_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _discountSypMeta = const VerificationMeta('discountSyp');
  @override
  late final GeneratedColumn<double> discountSyp = GeneratedColumn<double>(
    'discount_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalSypMeta = const VerificationMeta('totalSyp');
  @override
  late final GeneratedColumn<double> totalSyp = GeneratedColumn<double>(
    'total_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalUsdMeta = const VerificationMeta('totalUsd');
  @override
  late final GeneratedColumn<double> totalUsd = GeneratedColumn<double>(
    'total_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costUsdMeta = const VerificationMeta('costUsd');
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
    'cost_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidSypMeta = const VerificationMeta('paidSyp');
  @override
  late final GeneratedColumn<double> paidSyp = GeneratedColumn<double>(
    'paid_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _paidUsdMeta = const VerificationMeta('paidUsd');
  @override
  late final GeneratedColumn<double> paidUsd = GeneratedColumn<double>(
    'paid_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _changeSypMeta = const VerificationMeta('changeSyp');
  @override
  late final GeneratedColumn<double> changeSyp = GeneratedColumn<double>(
    'change_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _debtSypMeta = const VerificationMeta('debtSyp');
  @override
  late final GeneratedColumn<double> debtSyp = GeneratedColumn<double>(
    'debt_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('completed'),
  );
  static const VerificationMeta _voidedByIdMeta = const VerificationMeta('voidedById');
  @override
  late final GeneratedColumn<int> voidedById = GeneratedColumn<int>(
    'voided_by_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voidedAtMeta = const VerificationMeta('voidedAt');
  @override
  late final GeneratedColumn<DateTime> voidedAt = GeneratedColumn<DateTime>(
    'voided_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _voidReasonMeta = const VerificationMeta('voidReason');
  @override
  late final GeneratedColumn<String> voidReason = GeneratedColumn<String>(
    'void_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shiftId,
    userId,
    customerId,
    createdAt,
    rate,
    subtotalSyp,
    discountSyp,
    totalSyp,
    totalUsd,
    costUsd,
    paidSyp,
    paidUsd,
    changeSyp,
    debtSyp,
    status,
    voidedById,
    voidedAt,
    voidReason,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sales';
  @override
  VerificationContext validateIntegrity(Insertable<Sale> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta, shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(_customerIdMeta, customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('rate')) {
      context.handle(_rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('subtotal_syp')) {
      context.handle(_subtotalSypMeta, subtotalSyp.isAcceptableOrUnknown(data['subtotal_syp']!, _subtotalSypMeta));
    } else if (isInserting) {
      context.missing(_subtotalSypMeta);
    }
    if (data.containsKey('discount_syp')) {
      context.handle(_discountSypMeta, discountSyp.isAcceptableOrUnknown(data['discount_syp']!, _discountSypMeta));
    }
    if (data.containsKey('total_syp')) {
      context.handle(_totalSypMeta, totalSyp.isAcceptableOrUnknown(data['total_syp']!, _totalSypMeta));
    } else if (isInserting) {
      context.missing(_totalSypMeta);
    }
    if (data.containsKey('total_usd')) {
      context.handle(_totalUsdMeta, totalUsd.isAcceptableOrUnknown(data['total_usd']!, _totalUsdMeta));
    } else if (isInserting) {
      context.missing(_totalUsdMeta);
    }
    if (data.containsKey('cost_usd')) {
      context.handle(_costUsdMeta, costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta));
    }
    if (data.containsKey('paid_syp')) {
      context.handle(_paidSypMeta, paidSyp.isAcceptableOrUnknown(data['paid_syp']!, _paidSypMeta));
    }
    if (data.containsKey('paid_usd')) {
      context.handle(_paidUsdMeta, paidUsd.isAcceptableOrUnknown(data['paid_usd']!, _paidUsdMeta));
    }
    if (data.containsKey('change_syp')) {
      context.handle(_changeSypMeta, changeSyp.isAcceptableOrUnknown(data['change_syp']!, _changeSypMeta));
    }
    if (data.containsKey('debt_syp')) {
      context.handle(_debtSypMeta, debtSyp.isAcceptableOrUnknown(data['debt_syp']!, _debtSypMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('voided_by_id')) {
      context.handle(_voidedByIdMeta, voidedById.isAcceptableOrUnknown(data['voided_by_id']!, _voidedByIdMeta));
    }
    if (data.containsKey('voided_at')) {
      context.handle(_voidedAtMeta, voidedAt.isAcceptableOrUnknown(data['voided_at']!, _voidedAtMeta));
    }
    if (data.containsKey('void_reason')) {
      context.handle(_voidReasonMeta, voidReason.isAcceptableOrUnknown(data['void_reason']!, _voidReasonMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Sale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Sale(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      shiftId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}shift_id'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      customerId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      rate: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      subtotalSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}subtotal_syp'])!,
      discountSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}discount_syp'])!,
      totalSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_syp'])!,
      totalUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_usd'])!,
      costUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}cost_usd'])!,
      paidSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}paid_syp'])!,
      paidUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}paid_usd'])!,
      changeSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}change_syp'])!,
      debtSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}debt_syp'])!,
      status: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      voidedById: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}voided_by_id']),
      voidedAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}voided_at']),
      voidReason: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}void_reason']),
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $SalesTable createAlias(String alias) {
    return $SalesTable(attachedDatabase, alias);
  }
}

class Sale extends DataClass implements Insertable<Sale> {
  final int id;
  final int shiftId;
  final int userId;
  final int? customerId;
  final DateTime createdAt;

  /// سعر الصرف وقت البيع
  final double rate;
  final double subtotalSyp;
  final double discountSyp;
  final double totalSyp;
  final double totalUsd;

  /// تكلفة الأدوية المباعة بالدولار (لحساب الربح)
  final double costUsd;
  final double paidSyp;
  final double paidUsd;
  final double changeSyp;

  /// المبلغ المسجَّل ديناً على الزبون بالليرة
  final double debtSyp;

  /// completed / voided
  final String status;
  final int? voidedById;
  final DateTime? voidedAt;
  final String? voidReason;
  final String? note;
  const Sale({
    required this.id,
    required this.shiftId,
    required this.userId,
    this.customerId,
    required this.createdAt,
    required this.rate,
    required this.subtotalSyp,
    required this.discountSyp,
    required this.totalSyp,
    required this.totalUsd,
    required this.costUsd,
    required this.paidSyp,
    required this.paidUsd,
    required this.changeSyp,
    required this.debtSyp,
    required this.status,
    this.voidedById,
    this.voidedAt,
    this.voidReason,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['shift_id'] = Variable<int>(shiftId);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['rate'] = Variable<double>(rate);
    map['subtotal_syp'] = Variable<double>(subtotalSyp);
    map['discount_syp'] = Variable<double>(discountSyp);
    map['total_syp'] = Variable<double>(totalSyp);
    map['total_usd'] = Variable<double>(totalUsd);
    map['cost_usd'] = Variable<double>(costUsd);
    map['paid_syp'] = Variable<double>(paidSyp);
    map['paid_usd'] = Variable<double>(paidUsd);
    map['change_syp'] = Variable<double>(changeSyp);
    map['debt_syp'] = Variable<double>(debtSyp);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || voidedById != null) {
      map['voided_by_id'] = Variable<int>(voidedById);
    }
    if (!nullToAbsent || voidedAt != null) {
      map['voided_at'] = Variable<DateTime>(voidedAt);
    }
    if (!nullToAbsent || voidReason != null) {
      map['void_reason'] = Variable<String>(voidReason);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SalesCompanion toCompanion(bool nullToAbsent) {
    return SalesCompanion(
      id: Value(id),
      shiftId: Value(shiftId),
      userId: Value(userId),
      customerId: customerId == null && nullToAbsent ? const Value.absent() : Value(customerId),
      createdAt: Value(createdAt),
      rate: Value(rate),
      subtotalSyp: Value(subtotalSyp),
      discountSyp: Value(discountSyp),
      totalSyp: Value(totalSyp),
      totalUsd: Value(totalUsd),
      costUsd: Value(costUsd),
      paidSyp: Value(paidSyp),
      paidUsd: Value(paidUsd),
      changeSyp: Value(changeSyp),
      debtSyp: Value(debtSyp),
      status: Value(status),
      voidedById: voidedById == null && nullToAbsent ? const Value.absent() : Value(voidedById),
      voidedAt: voidedAt == null && nullToAbsent ? const Value.absent() : Value(voidedAt),
      voidReason: voidReason == null && nullToAbsent ? const Value.absent() : Value(voidReason),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory Sale.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sale(
      id: serializer.fromJson<int>(json['id']),
      shiftId: serializer.fromJson<int>(json['shiftId']),
      userId: serializer.fromJson<int>(json['userId']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      rate: serializer.fromJson<double>(json['rate']),
      subtotalSyp: serializer.fromJson<double>(json['subtotalSyp']),
      discountSyp: serializer.fromJson<double>(json['discountSyp']),
      totalSyp: serializer.fromJson<double>(json['totalSyp']),
      totalUsd: serializer.fromJson<double>(json['totalUsd']),
      costUsd: serializer.fromJson<double>(json['costUsd']),
      paidSyp: serializer.fromJson<double>(json['paidSyp']),
      paidUsd: serializer.fromJson<double>(json['paidUsd']),
      changeSyp: serializer.fromJson<double>(json['changeSyp']),
      debtSyp: serializer.fromJson<double>(json['debtSyp']),
      status: serializer.fromJson<String>(json['status']),
      voidedById: serializer.fromJson<int?>(json['voidedById']),
      voidedAt: serializer.fromJson<DateTime?>(json['voidedAt']),
      voidReason: serializer.fromJson<String?>(json['voidReason']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'shiftId': serializer.toJson<int>(shiftId),
      'userId': serializer.toJson<int>(userId),
      'customerId': serializer.toJson<int?>(customerId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'rate': serializer.toJson<double>(rate),
      'subtotalSyp': serializer.toJson<double>(subtotalSyp),
      'discountSyp': serializer.toJson<double>(discountSyp),
      'totalSyp': serializer.toJson<double>(totalSyp),
      'totalUsd': serializer.toJson<double>(totalUsd),
      'costUsd': serializer.toJson<double>(costUsd),
      'paidSyp': serializer.toJson<double>(paidSyp),
      'paidUsd': serializer.toJson<double>(paidUsd),
      'changeSyp': serializer.toJson<double>(changeSyp),
      'debtSyp': serializer.toJson<double>(debtSyp),
      'status': serializer.toJson<String>(status),
      'voidedById': serializer.toJson<int?>(voidedById),
      'voidedAt': serializer.toJson<DateTime?>(voidedAt),
      'voidReason': serializer.toJson<String?>(voidReason),
      'note': serializer.toJson<String?>(note),
    };
  }

  Sale copyWith({
    int? id,
    int? shiftId,
    int? userId,
    Value<int?> customerId = const Value.absent(),
    DateTime? createdAt,
    double? rate,
    double? subtotalSyp,
    double? discountSyp,
    double? totalSyp,
    double? totalUsd,
    double? costUsd,
    double? paidSyp,
    double? paidUsd,
    double? changeSyp,
    double? debtSyp,
    String? status,
    Value<int?> voidedById = const Value.absent(),
    Value<DateTime?> voidedAt = const Value.absent(),
    Value<String?> voidReason = const Value.absent(),
    Value<String?> note = const Value.absent(),
  }) => Sale(
    id: id ?? this.id,
    shiftId: shiftId ?? this.shiftId,
    userId: userId ?? this.userId,
    customerId: customerId.present ? customerId.value : this.customerId,
    createdAt: createdAt ?? this.createdAt,
    rate: rate ?? this.rate,
    subtotalSyp: subtotalSyp ?? this.subtotalSyp,
    discountSyp: discountSyp ?? this.discountSyp,
    totalSyp: totalSyp ?? this.totalSyp,
    totalUsd: totalUsd ?? this.totalUsd,
    costUsd: costUsd ?? this.costUsd,
    paidSyp: paidSyp ?? this.paidSyp,
    paidUsd: paidUsd ?? this.paidUsd,
    changeSyp: changeSyp ?? this.changeSyp,
    debtSyp: debtSyp ?? this.debtSyp,
    status: status ?? this.status,
    voidedById: voidedById.present ? voidedById.value : this.voidedById,
    voidedAt: voidedAt.present ? voidedAt.value : this.voidedAt,
    voidReason: voidReason.present ? voidReason.value : this.voidReason,
    note: note.present ? note.value : this.note,
  );
  Sale copyWithCompanion(SalesCompanion data) {
    return Sale(
      id: data.id.present ? data.id.value : this.id,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      userId: data.userId.present ? data.userId.value : this.userId,
      customerId: data.customerId.present ? data.customerId.value : this.customerId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      rate: data.rate.present ? data.rate.value : this.rate,
      subtotalSyp: data.subtotalSyp.present ? data.subtotalSyp.value : this.subtotalSyp,
      discountSyp: data.discountSyp.present ? data.discountSyp.value : this.discountSyp,
      totalSyp: data.totalSyp.present ? data.totalSyp.value : this.totalSyp,
      totalUsd: data.totalUsd.present ? data.totalUsd.value : this.totalUsd,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      paidSyp: data.paidSyp.present ? data.paidSyp.value : this.paidSyp,
      paidUsd: data.paidUsd.present ? data.paidUsd.value : this.paidUsd,
      changeSyp: data.changeSyp.present ? data.changeSyp.value : this.changeSyp,
      debtSyp: data.debtSyp.present ? data.debtSyp.value : this.debtSyp,
      status: data.status.present ? data.status.value : this.status,
      voidedById: data.voidedById.present ? data.voidedById.value : this.voidedById,
      voidedAt: data.voidedAt.present ? data.voidedAt.value : this.voidedAt,
      voidReason: data.voidReason.present ? data.voidReason.value : this.voidReason,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Sale(')
          ..write('id: $id, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('customerId: $customerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rate: $rate, ')
          ..write('subtotalSyp: $subtotalSyp, ')
          ..write('discountSyp: $discountSyp, ')
          ..write('totalSyp: $totalSyp, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('costUsd: $costUsd, ')
          ..write('paidSyp: $paidSyp, ')
          ..write('paidUsd: $paidUsd, ')
          ..write('changeSyp: $changeSyp, ')
          ..write('debtSyp: $debtSyp, ')
          ..write('status: $status, ')
          ..write('voidedById: $voidedById, ')
          ..write('voidedAt: $voidedAt, ')
          ..write('voidReason: $voidReason, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shiftId,
    userId,
    customerId,
    createdAt,
    rate,
    subtotalSyp,
    discountSyp,
    totalSyp,
    totalUsd,
    costUsd,
    paidSyp,
    paidUsd,
    changeSyp,
    debtSyp,
    status,
    voidedById,
    voidedAt,
    voidReason,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sale &&
          other.id == this.id &&
          other.shiftId == this.shiftId &&
          other.userId == this.userId &&
          other.customerId == this.customerId &&
          other.createdAt == this.createdAt &&
          other.rate == this.rate &&
          other.subtotalSyp == this.subtotalSyp &&
          other.discountSyp == this.discountSyp &&
          other.totalSyp == this.totalSyp &&
          other.totalUsd == this.totalUsd &&
          other.costUsd == this.costUsd &&
          other.paidSyp == this.paidSyp &&
          other.paidUsd == this.paidUsd &&
          other.changeSyp == this.changeSyp &&
          other.debtSyp == this.debtSyp &&
          other.status == this.status &&
          other.voidedById == this.voidedById &&
          other.voidedAt == this.voidedAt &&
          other.voidReason == this.voidReason &&
          other.note == this.note);
}

class SalesCompanion extends UpdateCompanion<Sale> {
  final Value<int> id;
  final Value<int> shiftId;
  final Value<int> userId;
  final Value<int?> customerId;
  final Value<DateTime> createdAt;
  final Value<double> rate;
  final Value<double> subtotalSyp;
  final Value<double> discountSyp;
  final Value<double> totalSyp;
  final Value<double> totalUsd;
  final Value<double> costUsd;
  final Value<double> paidSyp;
  final Value<double> paidUsd;
  final Value<double> changeSyp;
  final Value<double> debtSyp;
  final Value<String> status;
  final Value<int?> voidedById;
  final Value<DateTime?> voidedAt;
  final Value<String?> voidReason;
  final Value<String?> note;
  const SalesCompanion({
    this.id = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rate = const Value.absent(),
    this.subtotalSyp = const Value.absent(),
    this.discountSyp = const Value.absent(),
    this.totalSyp = const Value.absent(),
    this.totalUsd = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.paidSyp = const Value.absent(),
    this.paidUsd = const Value.absent(),
    this.changeSyp = const Value.absent(),
    this.debtSyp = const Value.absent(),
    this.status = const Value.absent(),
    this.voidedById = const Value.absent(),
    this.voidedAt = const Value.absent(),
    this.voidReason = const Value.absent(),
    this.note = const Value.absent(),
  });
  SalesCompanion.insert({
    this.id = const Value.absent(),
    required int shiftId,
    required int userId,
    this.customerId = const Value.absent(),
    this.createdAt = const Value.absent(),
    required double rate,
    required double subtotalSyp,
    this.discountSyp = const Value.absent(),
    required double totalSyp,
    required double totalUsd,
    this.costUsd = const Value.absent(),
    this.paidSyp = const Value.absent(),
    this.paidUsd = const Value.absent(),
    this.changeSyp = const Value.absent(),
    this.debtSyp = const Value.absent(),
    this.status = const Value.absent(),
    this.voidedById = const Value.absent(),
    this.voidedAt = const Value.absent(),
    this.voidReason = const Value.absent(),
    this.note = const Value.absent(),
  }) : shiftId = Value(shiftId),
       userId = Value(userId),
       rate = Value(rate),
       subtotalSyp = Value(subtotalSyp),
       totalSyp = Value(totalSyp),
       totalUsd = Value(totalUsd);
  static Insertable<Sale> custom({
    Expression<int>? id,
    Expression<int>? shiftId,
    Expression<int>? userId,
    Expression<int>? customerId,
    Expression<DateTime>? createdAt,
    Expression<double>? rate,
    Expression<double>? subtotalSyp,
    Expression<double>? discountSyp,
    Expression<double>? totalSyp,
    Expression<double>? totalUsd,
    Expression<double>? costUsd,
    Expression<double>? paidSyp,
    Expression<double>? paidUsd,
    Expression<double>? changeSyp,
    Expression<double>? debtSyp,
    Expression<String>? status,
    Expression<int>? voidedById,
    Expression<DateTime>? voidedAt,
    Expression<String>? voidReason,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shiftId != null) 'shift_id': shiftId,
      if (userId != null) 'user_id': userId,
      if (customerId != null) 'customer_id': customerId,
      if (createdAt != null) 'created_at': createdAt,
      if (rate != null) 'rate': rate,
      if (subtotalSyp != null) 'subtotal_syp': subtotalSyp,
      if (discountSyp != null) 'discount_syp': discountSyp,
      if (totalSyp != null) 'total_syp': totalSyp,
      if (totalUsd != null) 'total_usd': totalUsd,
      if (costUsd != null) 'cost_usd': costUsd,
      if (paidSyp != null) 'paid_syp': paidSyp,
      if (paidUsd != null) 'paid_usd': paidUsd,
      if (changeSyp != null) 'change_syp': changeSyp,
      if (debtSyp != null) 'debt_syp': debtSyp,
      if (status != null) 'status': status,
      if (voidedById != null) 'voided_by_id': voidedById,
      if (voidedAt != null) 'voided_at': voidedAt,
      if (voidReason != null) 'void_reason': voidReason,
      if (note != null) 'note': note,
    });
  }

  SalesCompanion copyWith({
    Value<int>? id,
    Value<int>? shiftId,
    Value<int>? userId,
    Value<int?>? customerId,
    Value<DateTime>? createdAt,
    Value<double>? rate,
    Value<double>? subtotalSyp,
    Value<double>? discountSyp,
    Value<double>? totalSyp,
    Value<double>? totalUsd,
    Value<double>? costUsd,
    Value<double>? paidSyp,
    Value<double>? paidUsd,
    Value<double>? changeSyp,
    Value<double>? debtSyp,
    Value<String>? status,
    Value<int?>? voidedById,
    Value<DateTime?>? voidedAt,
    Value<String?>? voidReason,
    Value<String?>? note,
  }) {
    return SalesCompanion(
      id: id ?? this.id,
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      customerId: customerId ?? this.customerId,
      createdAt: createdAt ?? this.createdAt,
      rate: rate ?? this.rate,
      subtotalSyp: subtotalSyp ?? this.subtotalSyp,
      discountSyp: discountSyp ?? this.discountSyp,
      totalSyp: totalSyp ?? this.totalSyp,
      totalUsd: totalUsd ?? this.totalUsd,
      costUsd: costUsd ?? this.costUsd,
      paidSyp: paidSyp ?? this.paidSyp,
      paidUsd: paidUsd ?? this.paidUsd,
      changeSyp: changeSyp ?? this.changeSyp,
      debtSyp: debtSyp ?? this.debtSyp,
      status: status ?? this.status,
      voidedById: voidedById ?? this.voidedById,
      voidedAt: voidedAt ?? this.voidedAt,
      voidReason: voidReason ?? this.voidReason,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (subtotalSyp.present) {
      map['subtotal_syp'] = Variable<double>(subtotalSyp.value);
    }
    if (discountSyp.present) {
      map['discount_syp'] = Variable<double>(discountSyp.value);
    }
    if (totalSyp.present) {
      map['total_syp'] = Variable<double>(totalSyp.value);
    }
    if (totalUsd.present) {
      map['total_usd'] = Variable<double>(totalUsd.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (paidSyp.present) {
      map['paid_syp'] = Variable<double>(paidSyp.value);
    }
    if (paidUsd.present) {
      map['paid_usd'] = Variable<double>(paidUsd.value);
    }
    if (changeSyp.present) {
      map['change_syp'] = Variable<double>(changeSyp.value);
    }
    if (debtSyp.present) {
      map['debt_syp'] = Variable<double>(debtSyp.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (voidedById.present) {
      map['voided_by_id'] = Variable<int>(voidedById.value);
    }
    if (voidedAt.present) {
      map['voided_at'] = Variable<DateTime>(voidedAt.value);
    }
    if (voidReason.present) {
      map['void_reason'] = Variable<String>(voidReason.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SalesCompanion(')
          ..write('id: $id, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('customerId: $customerId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rate: $rate, ')
          ..write('subtotalSyp: $subtotalSyp, ')
          ..write('discountSyp: $discountSyp, ')
          ..write('totalSyp: $totalSyp, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('costUsd: $costUsd, ')
          ..write('paidSyp: $paidSyp, ')
          ..write('paidUsd: $paidUsd, ')
          ..write('changeSyp: $changeSyp, ')
          ..write('debtSyp: $debtSyp, ')
          ..write('status: $status, ')
          ..write('voidedById: $voidedById, ')
          ..write('voidedAt: $voidedAt, ')
          ..write('voidReason: $voidReason, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SaleItemsTable extends SaleItems with TableInfo<$SaleItemsTable, SaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES sales (id)'),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES medicines (id)'),
  );
  static const VerificationMeta _medicineNameMeta = const VerificationMeta('medicineName');
  @override
  late final GeneratedColumn<String> medicineName = GeneratedColumn<String>(
    'medicine_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<int> unit = GeneratedColumn<int>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitLabelMeta = const VerificationMeta('unitLabel');
  @override
  late final GeneratedColumn<String> unitLabel = GeneratedColumn<String>(
    'unit_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseQuantityMeta = const VerificationMeta('baseQuantity');
  @override
  late final GeneratedColumn<int> baseQuantity = GeneratedColumn<int>(
    'base_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceUsdMeta = const VerificationMeta('unitPriceUsd');
  @override
  late final GeneratedColumn<double> unitPriceUsd = GeneratedColumn<double>(
    'unit_price_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceSypMeta = const VerificationMeta('unitPriceSyp');
  @override
  late final GeneratedColumn<double> unitPriceSyp = GeneratedColumn<double>(
    'unit_price_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSypMeta = const VerificationMeta('totalSyp');
  @override
  late final GeneratedColumn<double> totalSyp = GeneratedColumn<double>(
    'total_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costUsdMeta = const VerificationMeta('costUsd');
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
    'cost_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnedBaseMeta = const VerificationMeta('returnedBase');
  @override
  late final GeneratedColumn<int> returnedBase = GeneratedColumn<int>(
    'returned_base',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    medicineId,
    medicineName,
    unit,
    unitLabel,
    quantity,
    baseQuantity,
    unitPriceUsd,
    unitPriceSyp,
    totalSyp,
    costUsd,
    returnedBase,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_items';
  @override
  VerificationContext validateIntegrity(Insertable<SaleItem> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta, saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('medicine_id')) {
      context.handle(_medicineIdMeta, medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('medicine_name')) {
      context.handle(_medicineNameMeta, medicineName.isAcceptableOrUnknown(data['medicine_name']!, _medicineNameMeta));
    } else if (isInserting) {
      context.missing(_medicineNameMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(_unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('unit_label')) {
      context.handle(_unitLabelMeta, unitLabel.isAcceptableOrUnknown(data['unit_label']!, _unitLabelMeta));
    } else if (isInserting) {
      context.missing(_unitLabelMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta, quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('base_quantity')) {
      context.handle(_baseQuantityMeta, baseQuantity.isAcceptableOrUnknown(data['base_quantity']!, _baseQuantityMeta));
    } else if (isInserting) {
      context.missing(_baseQuantityMeta);
    }
    if (data.containsKey('unit_price_usd')) {
      context.handle(_unitPriceUsdMeta, unitPriceUsd.isAcceptableOrUnknown(data['unit_price_usd']!, _unitPriceUsdMeta));
    } else if (isInserting) {
      context.missing(_unitPriceUsdMeta);
    }
    if (data.containsKey('unit_price_syp')) {
      context.handle(_unitPriceSypMeta, unitPriceSyp.isAcceptableOrUnknown(data['unit_price_syp']!, _unitPriceSypMeta));
    } else if (isInserting) {
      context.missing(_unitPriceSypMeta);
    }
    if (data.containsKey('total_syp')) {
      context.handle(_totalSypMeta, totalSyp.isAcceptableOrUnknown(data['total_syp']!, _totalSypMeta));
    } else if (isInserting) {
      context.missing(_totalSypMeta);
    }
    if (data.containsKey('cost_usd')) {
      context.handle(_costUsdMeta, costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta));
    } else if (isInserting) {
      context.missing(_costUsdMeta);
    }
    if (data.containsKey('returned_base')) {
      context.handle(_returnedBaseMeta, returnedBase.isAcceptableOrUnknown(data['returned_base']!, _returnedBaseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItem(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      saleId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sale_id'])!,
      medicineId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      medicineName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}medicine_name'])!,
      unit: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}unit'])!,
      unitLabel: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}unit_label'])!,
      quantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      baseQuantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}base_quantity'])!,
      unitPriceUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}unit_price_usd'])!,
      unitPriceSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}unit_price_syp'])!,
      totalSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_syp'])!,
      costUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}cost_usd'])!,
      returnedBase: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}returned_base'])!,
    );
  }

  @override
  $SaleItemsTable createAlias(String alias) {
    return $SaleItemsTable(attachedDatabase, alias);
  }
}

class SaleItem extends DataClass implements Insertable<SaleItem> {
  final int id;
  final int saleId;
  final int medicineId;
  final String medicineName;

  /// 0 = علبة، 1 = شريط، 2 = حبة
  final int unit;
  final String unitLabel;
  final int quantity;

  /// الكمية بأصغر وحدة
  final int baseQuantity;
  final double unitPriceUsd;
  final double unitPriceSyp;
  final double totalSyp;
  final double costUsd;

  /// الكمية المرتجعة بأصغر وحدة
  final int returnedBase;
  const SaleItem({
    required this.id,
    required this.saleId,
    required this.medicineId,
    required this.medicineName,
    required this.unit,
    required this.unitLabel,
    required this.quantity,
    required this.baseQuantity,
    required this.unitPriceUsd,
    required this.unitPriceSyp,
    required this.totalSyp,
    required this.costUsd,
    required this.returnedBase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    map['medicine_id'] = Variable<int>(medicineId);
    map['medicine_name'] = Variable<String>(medicineName);
    map['unit'] = Variable<int>(unit);
    map['unit_label'] = Variable<String>(unitLabel);
    map['quantity'] = Variable<int>(quantity);
    map['base_quantity'] = Variable<int>(baseQuantity);
    map['unit_price_usd'] = Variable<double>(unitPriceUsd);
    map['unit_price_syp'] = Variable<double>(unitPriceSyp);
    map['total_syp'] = Variable<double>(totalSyp);
    map['cost_usd'] = Variable<double>(costUsd);
    map['returned_base'] = Variable<int>(returnedBase);
    return map;
  }

  SaleItemsCompanion toCompanion(bool nullToAbsent) {
    return SaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      medicineId: Value(medicineId),
      medicineName: Value(medicineName),
      unit: Value(unit),
      unitLabel: Value(unitLabel),
      quantity: Value(quantity),
      baseQuantity: Value(baseQuantity),
      unitPriceUsd: Value(unitPriceUsd),
      unitPriceSyp: Value(unitPriceSyp),
      totalSyp: Value(totalSyp),
      costUsd: Value(costUsd),
      returnedBase: Value(returnedBase),
    );
  }

  factory SaleItem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItem(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      medicineName: serializer.fromJson<String>(json['medicineName']),
      unit: serializer.fromJson<int>(json['unit']),
      unitLabel: serializer.fromJson<String>(json['unitLabel']),
      quantity: serializer.fromJson<int>(json['quantity']),
      baseQuantity: serializer.fromJson<int>(json['baseQuantity']),
      unitPriceUsd: serializer.fromJson<double>(json['unitPriceUsd']),
      unitPriceSyp: serializer.fromJson<double>(json['unitPriceSyp']),
      totalSyp: serializer.fromJson<double>(json['totalSyp']),
      costUsd: serializer.fromJson<double>(json['costUsd']),
      returnedBase: serializer.fromJson<int>(json['returnedBase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'medicineId': serializer.toJson<int>(medicineId),
      'medicineName': serializer.toJson<String>(medicineName),
      'unit': serializer.toJson<int>(unit),
      'unitLabel': serializer.toJson<String>(unitLabel),
      'quantity': serializer.toJson<int>(quantity),
      'baseQuantity': serializer.toJson<int>(baseQuantity),
      'unitPriceUsd': serializer.toJson<double>(unitPriceUsd),
      'unitPriceSyp': serializer.toJson<double>(unitPriceSyp),
      'totalSyp': serializer.toJson<double>(totalSyp),
      'costUsd': serializer.toJson<double>(costUsd),
      'returnedBase': serializer.toJson<int>(returnedBase),
    };
  }

  SaleItem copyWith({
    int? id,
    int? saleId,
    int? medicineId,
    String? medicineName,
    int? unit,
    String? unitLabel,
    int? quantity,
    int? baseQuantity,
    double? unitPriceUsd,
    double? unitPriceSyp,
    double? totalSyp,
    double? costUsd,
    int? returnedBase,
  }) => SaleItem(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    medicineId: medicineId ?? this.medicineId,
    medicineName: medicineName ?? this.medicineName,
    unit: unit ?? this.unit,
    unitLabel: unitLabel ?? this.unitLabel,
    quantity: quantity ?? this.quantity,
    baseQuantity: baseQuantity ?? this.baseQuantity,
    unitPriceUsd: unitPriceUsd ?? this.unitPriceUsd,
    unitPriceSyp: unitPriceSyp ?? this.unitPriceSyp,
    totalSyp: totalSyp ?? this.totalSyp,
    costUsd: costUsd ?? this.costUsd,
    returnedBase: returnedBase ?? this.returnedBase,
  );
  SaleItem copyWithCompanion(SaleItemsCompanion data) {
    return SaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      medicineId: data.medicineId.present ? data.medicineId.value : this.medicineId,
      medicineName: data.medicineName.present ? data.medicineName.value : this.medicineName,
      unit: data.unit.present ? data.unit.value : this.unit,
      unitLabel: data.unitLabel.present ? data.unitLabel.value : this.unitLabel,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      baseQuantity: data.baseQuantity.present ? data.baseQuantity.value : this.baseQuantity,
      unitPriceUsd: data.unitPriceUsd.present ? data.unitPriceUsd.value : this.unitPriceUsd,
      unitPriceSyp: data.unitPriceSyp.present ? data.unitPriceSyp.value : this.unitPriceSyp,
      totalSyp: data.totalSyp.present ? data.totalSyp.value : this.totalSyp,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      returnedBase: data.returnedBase.present ? data.returnedBase.value : this.returnedBase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('medicineId: $medicineId, ')
          ..write('medicineName: $medicineName, ')
          ..write('unit: $unit, ')
          ..write('unitLabel: $unitLabel, ')
          ..write('quantity: $quantity, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('unitPriceUsd: $unitPriceUsd, ')
          ..write('unitPriceSyp: $unitPriceSyp, ')
          ..write('totalSyp: $totalSyp, ')
          ..write('costUsd: $costUsd, ')
          ..write('returnedBase: $returnedBase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    medicineId,
    medicineName,
    unit,
    unitLabel,
    quantity,
    baseQuantity,
    unitPriceUsd,
    unitPriceSyp,
    totalSyp,
    costUsd,
    returnedBase,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.medicineId == this.medicineId &&
          other.medicineName == this.medicineName &&
          other.unit == this.unit &&
          other.unitLabel == this.unitLabel &&
          other.quantity == this.quantity &&
          other.baseQuantity == this.baseQuantity &&
          other.unitPriceUsd == this.unitPriceUsd &&
          other.unitPriceSyp == this.unitPriceSyp &&
          other.totalSyp == this.totalSyp &&
          other.costUsd == this.costUsd &&
          other.returnedBase == this.returnedBase);
}

class SaleItemsCompanion extends UpdateCompanion<SaleItem> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<int> medicineId;
  final Value<String> medicineName;
  final Value<int> unit;
  final Value<String> unitLabel;
  final Value<int> quantity;
  final Value<int> baseQuantity;
  final Value<double> unitPriceUsd;
  final Value<double> unitPriceSyp;
  final Value<double> totalSyp;
  final Value<double> costUsd;
  final Value<int> returnedBase;
  const SaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.medicineName = const Value.absent(),
    this.unit = const Value.absent(),
    this.unitLabel = const Value.absent(),
    this.quantity = const Value.absent(),
    this.baseQuantity = const Value.absent(),
    this.unitPriceUsd = const Value.absent(),
    this.unitPriceSyp = const Value.absent(),
    this.totalSyp = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.returnedBase = const Value.absent(),
  });
  SaleItemsCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    required int medicineId,
    required String medicineName,
    required int unit,
    required String unitLabel,
    required int quantity,
    required int baseQuantity,
    required double unitPriceUsd,
    required double unitPriceSyp,
    required double totalSyp,
    required double costUsd,
    this.returnedBase = const Value.absent(),
  }) : saleId = Value(saleId),
       medicineId = Value(medicineId),
       medicineName = Value(medicineName),
       unit = Value(unit),
       unitLabel = Value(unitLabel),
       quantity = Value(quantity),
       baseQuantity = Value(baseQuantity),
       unitPriceUsd = Value(unitPriceUsd),
       unitPriceSyp = Value(unitPriceSyp),
       totalSyp = Value(totalSyp),
       costUsd = Value(costUsd);
  static Insertable<SaleItem> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<int>? medicineId,
    Expression<String>? medicineName,
    Expression<int>? unit,
    Expression<String>? unitLabel,
    Expression<int>? quantity,
    Expression<int>? baseQuantity,
    Expression<double>? unitPriceUsd,
    Expression<double>? unitPriceSyp,
    Expression<double>? totalSyp,
    Expression<double>? costUsd,
    Expression<int>? returnedBase,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (medicineId != null) 'medicine_id': medicineId,
      if (medicineName != null) 'medicine_name': medicineName,
      if (unit != null) 'unit': unit,
      if (unitLabel != null) 'unit_label': unitLabel,
      if (quantity != null) 'quantity': quantity,
      if (baseQuantity != null) 'base_quantity': baseQuantity,
      if (unitPriceUsd != null) 'unit_price_usd': unitPriceUsd,
      if (unitPriceSyp != null) 'unit_price_syp': unitPriceSyp,
      if (totalSyp != null) 'total_syp': totalSyp,
      if (costUsd != null) 'cost_usd': costUsd,
      if (returnedBase != null) 'returned_base': returnedBase,
    });
  }

  SaleItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<int>? medicineId,
    Value<String>? medicineName,
    Value<int>? unit,
    Value<String>? unitLabel,
    Value<int>? quantity,
    Value<int>? baseQuantity,
    Value<double>? unitPriceUsd,
    Value<double>? unitPriceSyp,
    Value<double>? totalSyp,
    Value<double>? costUsd,
    Value<int>? returnedBase,
  }) {
    return SaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      unit: unit ?? this.unit,
      unitLabel: unitLabel ?? this.unitLabel,
      quantity: quantity ?? this.quantity,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      unitPriceUsd: unitPriceUsd ?? this.unitPriceUsd,
      unitPriceSyp: unitPriceSyp ?? this.unitPriceSyp,
      totalSyp: totalSyp ?? this.totalSyp,
      costUsd: costUsd ?? this.costUsd,
      returnedBase: returnedBase ?? this.returnedBase,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (medicineName.present) {
      map['medicine_name'] = Variable<String>(medicineName.value);
    }
    if (unit.present) {
      map['unit'] = Variable<int>(unit.value);
    }
    if (unitLabel.present) {
      map['unit_label'] = Variable<String>(unitLabel.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (baseQuantity.present) {
      map['base_quantity'] = Variable<int>(baseQuantity.value);
    }
    if (unitPriceUsd.present) {
      map['unit_price_usd'] = Variable<double>(unitPriceUsd.value);
    }
    if (unitPriceSyp.present) {
      map['unit_price_syp'] = Variable<double>(unitPriceSyp.value);
    }
    if (totalSyp.present) {
      map['total_syp'] = Variable<double>(totalSyp.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (returnedBase.present) {
      map['returned_base'] = Variable<int>(returnedBase.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('medicineId: $medicineId, ')
          ..write('medicineName: $medicineName, ')
          ..write('unit: $unit, ')
          ..write('unitLabel: $unitLabel, ')
          ..write('quantity: $quantity, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('unitPriceUsd: $unitPriceUsd, ')
          ..write('unitPriceSyp: $unitPriceSyp, ')
          ..write('totalSyp: $totalSyp, ')
          ..write('costUsd: $costUsd, ')
          ..write('returnedBase: $returnedBase')
          ..write(')'))
        .toString();
  }
}

class $SaleItemBatchesTable extends SaleItemBatches with TableInfo<$SaleItemBatchesTable, SaleItemBatch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SaleItemBatchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _saleItemIdMeta = const VerificationMeta('saleItemId');
  @override
  late final GeneratedColumn<int> saleItemId = GeneratedColumn<int>(
    'sale_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES sale_items (id)'),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<int> batchId = GeneratedColumn<int>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES batches (id)'),
  );
  static const VerificationMeta _baseQuantityMeta = const VerificationMeta('baseQuantity');
  @override
  late final GeneratedColumn<int> baseQuantity = GeneratedColumn<int>(
    'base_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costUsdMeta = const VerificationMeta('costUsd');
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
    'cost_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _returnedBaseMeta = const VerificationMeta('returnedBase');
  @override
  late final GeneratedColumn<int> returnedBase = GeneratedColumn<int>(
    'returned_base',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, saleItemId, batchId, baseQuantity, costUsd, returnedBase];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sale_item_batches';
  @override
  VerificationContext validateIntegrity(Insertable<SaleItemBatch> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_item_id')) {
      context.handle(_saleItemIdMeta, saleItemId.isAcceptableOrUnknown(data['sale_item_id']!, _saleItemIdMeta));
    } else if (isInserting) {
      context.missing(_saleItemIdMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta, batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('base_quantity')) {
      context.handle(_baseQuantityMeta, baseQuantity.isAcceptableOrUnknown(data['base_quantity']!, _baseQuantityMeta));
    } else if (isInserting) {
      context.missing(_baseQuantityMeta);
    }
    if (data.containsKey('cost_usd')) {
      context.handle(_costUsdMeta, costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta));
    } else if (isInserting) {
      context.missing(_costUsdMeta);
    }
    if (data.containsKey('returned_base')) {
      context.handle(_returnedBaseMeta, returnedBase.isAcceptableOrUnknown(data['returned_base']!, _returnedBaseMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SaleItemBatch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SaleItemBatch(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      saleItemId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sale_item_id'])!,
      batchId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}batch_id'])!,
      baseQuantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}base_quantity'])!,
      costUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}cost_usd'])!,
      returnedBase: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}returned_base'])!,
    );
  }

  @override
  $SaleItemBatchesTable createAlias(String alias) {
    return $SaleItemBatchesTable(attachedDatabase, alias);
  }
}

class SaleItemBatch extends DataClass implements Insertable<SaleItemBatch> {
  final int id;
  final int saleItemId;
  final int batchId;
  final int baseQuantity;
  final double costUsd;
  final int returnedBase;
  const SaleItemBatch({
    required this.id,
    required this.saleItemId,
    required this.batchId,
    required this.baseQuantity,
    required this.costUsd,
    required this.returnedBase,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_item_id'] = Variable<int>(saleItemId);
    map['batch_id'] = Variable<int>(batchId);
    map['base_quantity'] = Variable<int>(baseQuantity);
    map['cost_usd'] = Variable<double>(costUsd);
    map['returned_base'] = Variable<int>(returnedBase);
    return map;
  }

  SaleItemBatchesCompanion toCompanion(bool nullToAbsent) {
    return SaleItemBatchesCompanion(
      id: Value(id),
      saleItemId: Value(saleItemId),
      batchId: Value(batchId),
      baseQuantity: Value(baseQuantity),
      costUsd: Value(costUsd),
      returnedBase: Value(returnedBase),
    );
  }

  factory SaleItemBatch.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SaleItemBatch(
      id: serializer.fromJson<int>(json['id']),
      saleItemId: serializer.fromJson<int>(json['saleItemId']),
      batchId: serializer.fromJson<int>(json['batchId']),
      baseQuantity: serializer.fromJson<int>(json['baseQuantity']),
      costUsd: serializer.fromJson<double>(json['costUsd']),
      returnedBase: serializer.fromJson<int>(json['returnedBase']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleItemId': serializer.toJson<int>(saleItemId),
      'batchId': serializer.toJson<int>(batchId),
      'baseQuantity': serializer.toJson<int>(baseQuantity),
      'costUsd': serializer.toJson<double>(costUsd),
      'returnedBase': serializer.toJson<int>(returnedBase),
    };
  }

  SaleItemBatch copyWith({
    int? id,
    int? saleItemId,
    int? batchId,
    int? baseQuantity,
    double? costUsd,
    int? returnedBase,
  }) => SaleItemBatch(
    id: id ?? this.id,
    saleItemId: saleItemId ?? this.saleItemId,
    batchId: batchId ?? this.batchId,
    baseQuantity: baseQuantity ?? this.baseQuantity,
    costUsd: costUsd ?? this.costUsd,
    returnedBase: returnedBase ?? this.returnedBase,
  );
  SaleItemBatch copyWithCompanion(SaleItemBatchesCompanion data) {
    return SaleItemBatch(
      id: data.id.present ? data.id.value : this.id,
      saleItemId: data.saleItemId.present ? data.saleItemId.value : this.saleItemId,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      baseQuantity: data.baseQuantity.present ? data.baseQuantity.value : this.baseQuantity,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      returnedBase: data.returnedBase.present ? data.returnedBase.value : this.returnedBase,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemBatch(')
          ..write('id: $id, ')
          ..write('saleItemId: $saleItemId, ')
          ..write('batchId: $batchId, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('costUsd: $costUsd, ')
          ..write('returnedBase: $returnedBase')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, saleItemId, batchId, baseQuantity, costUsd, returnedBase);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SaleItemBatch &&
          other.id == this.id &&
          other.saleItemId == this.saleItemId &&
          other.batchId == this.batchId &&
          other.baseQuantity == this.baseQuantity &&
          other.costUsd == this.costUsd &&
          other.returnedBase == this.returnedBase);
}

class SaleItemBatchesCompanion extends UpdateCompanion<SaleItemBatch> {
  final Value<int> id;
  final Value<int> saleItemId;
  final Value<int> batchId;
  final Value<int> baseQuantity;
  final Value<double> costUsd;
  final Value<int> returnedBase;
  const SaleItemBatchesCompanion({
    this.id = const Value.absent(),
    this.saleItemId = const Value.absent(),
    this.batchId = const Value.absent(),
    this.baseQuantity = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.returnedBase = const Value.absent(),
  });
  SaleItemBatchesCompanion.insert({
    this.id = const Value.absent(),
    required int saleItemId,
    required int batchId,
    required int baseQuantity,
    required double costUsd,
    this.returnedBase = const Value.absent(),
  }) : saleItemId = Value(saleItemId),
       batchId = Value(batchId),
       baseQuantity = Value(baseQuantity),
       costUsd = Value(costUsd);
  static Insertable<SaleItemBatch> custom({
    Expression<int>? id,
    Expression<int>? saleItemId,
    Expression<int>? batchId,
    Expression<int>? baseQuantity,
    Expression<double>? costUsd,
    Expression<int>? returnedBase,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleItemId != null) 'sale_item_id': saleItemId,
      if (batchId != null) 'batch_id': batchId,
      if (baseQuantity != null) 'base_quantity': baseQuantity,
      if (costUsd != null) 'cost_usd': costUsd,
      if (returnedBase != null) 'returned_base': returnedBase,
    });
  }

  SaleItemBatchesCompanion copyWith({
    Value<int>? id,
    Value<int>? saleItemId,
    Value<int>? batchId,
    Value<int>? baseQuantity,
    Value<double>? costUsd,
    Value<int>? returnedBase,
  }) {
    return SaleItemBatchesCompanion(
      id: id ?? this.id,
      saleItemId: saleItemId ?? this.saleItemId,
      batchId: batchId ?? this.batchId,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      costUsd: costUsd ?? this.costUsd,
      returnedBase: returnedBase ?? this.returnedBase,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleItemId.present) {
      map['sale_item_id'] = Variable<int>(saleItemId.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<int>(batchId.value);
    }
    if (baseQuantity.present) {
      map['base_quantity'] = Variable<int>(baseQuantity.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (returnedBase.present) {
      map['returned_base'] = Variable<int>(returnedBase.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SaleItemBatchesCompanion(')
          ..write('id: $id, ')
          ..write('saleItemId: $saleItemId, ')
          ..write('batchId: $batchId, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('costUsd: $costUsd, ')
          ..write('returnedBase: $returnedBase')
          ..write(')'))
        .toString();
  }
}

class $CustomerReturnsTable extends CustomerReturns with TableInfo<$CustomerReturnsTable, CustomerReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerReturnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<int> saleId = GeneratedColumn<int>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES sales (id)'),
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<int> customerId = GeneratedColumn<int>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shiftIdMeta = const VerificationMeta('shiftId');
  @override
  late final GeneratedColumn<int> shiftId = GeneratedColumn<int>(
    'shift_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES shifts (id)'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES users (id)'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _rateMeta = const VerificationMeta('rate');
  @override
  late final GeneratedColumn<double> rate = GeneratedColumn<double>(
    'rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalSypMeta = const VerificationMeta('totalSyp');
  @override
  late final GeneratedColumn<double> totalSyp = GeneratedColumn<double>(
    'total_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refundSypMeta = const VerificationMeta('refundSyp');
  @override
  late final GeneratedColumn<double> refundSyp = GeneratedColumn<double>(
    'refund_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _debtReducedSypMeta = const VerificationMeta('debtReducedSyp');
  @override
  late final GeneratedColumn<double> debtReducedSyp = GeneratedColumn<double>(
    'debt_reduced_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _costUsdMeta = const VerificationMeta('costUsd');
  @override
  late final GeneratedColumn<double> costUsd = GeneratedColumn<double>(
    'cost_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    customerId,
    shiftId,
    userId,
    createdAt,
    rate,
    totalSyp,
    refundSyp,
    debtReducedSyp,
    costUsd,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_returns';
  @override
  VerificationContext validateIntegrity(Insertable<CustomerReturn> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta, saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(_customerIdMeta, customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('shift_id')) {
      context.handle(_shiftIdMeta, shiftId.isAcceptableOrUnknown(data['shift_id']!, _shiftIdMeta));
    } else if (isInserting) {
      context.missing(_shiftIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('rate')) {
      context.handle(_rateMeta, rate.isAcceptableOrUnknown(data['rate']!, _rateMeta));
    } else if (isInserting) {
      context.missing(_rateMeta);
    }
    if (data.containsKey('total_syp')) {
      context.handle(_totalSypMeta, totalSyp.isAcceptableOrUnknown(data['total_syp']!, _totalSypMeta));
    } else if (isInserting) {
      context.missing(_totalSypMeta);
    }
    if (data.containsKey('refund_syp')) {
      context.handle(_refundSypMeta, refundSyp.isAcceptableOrUnknown(data['refund_syp']!, _refundSypMeta));
    }
    if (data.containsKey('debt_reduced_syp')) {
      context.handle(
        _debtReducedSypMeta,
        debtReducedSyp.isAcceptableOrUnknown(data['debt_reduced_syp']!, _debtReducedSypMeta),
      );
    }
    if (data.containsKey('cost_usd')) {
      context.handle(_costUsdMeta, costUsd.isAcceptableOrUnknown(data['cost_usd']!, _costUsdMeta));
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerReturn(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      saleId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sale_id'])!,
      customerId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}customer_id']),
      shiftId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}shift_id'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      rate: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}rate'])!,
      totalSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_syp'])!,
      refundSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}refund_syp'])!,
      debtReducedSyp: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}debt_reduced_syp'],
      )!,
      costUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}cost_usd'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $CustomerReturnsTable createAlias(String alias) {
    return $CustomerReturnsTable(attachedDatabase, alias);
  }
}

class CustomerReturn extends DataClass implements Insertable<CustomerReturn> {
  final int id;
  final int saleId;
  final int? customerId;
  final int shiftId;
  final int userId;
  final DateTime createdAt;
  final double rate;
  final double totalSyp;
  final double refundSyp;

  /// المبلغ الذي خُصم من دين الزبون
  final double debtReducedSyp;
  final double costUsd;
  final String? note;
  const CustomerReturn({
    required this.id,
    required this.saleId,
    this.customerId,
    required this.shiftId,
    required this.userId,
    required this.createdAt,
    required this.rate,
    required this.totalSyp,
    required this.refundSyp,
    required this.debtReducedSyp,
    required this.costUsd,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sale_id'] = Variable<int>(saleId);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<int>(customerId);
    }
    map['shift_id'] = Variable<int>(shiftId);
    map['user_id'] = Variable<int>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['rate'] = Variable<double>(rate);
    map['total_syp'] = Variable<double>(totalSyp);
    map['refund_syp'] = Variable<double>(refundSyp);
    map['debt_reduced_syp'] = Variable<double>(debtReducedSyp);
    map['cost_usd'] = Variable<double>(costUsd);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  CustomerReturnsCompanion toCompanion(bool nullToAbsent) {
    return CustomerReturnsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      customerId: customerId == null && nullToAbsent ? const Value.absent() : Value(customerId),
      shiftId: Value(shiftId),
      userId: Value(userId),
      createdAt: Value(createdAt),
      rate: Value(rate),
      totalSyp: Value(totalSyp),
      refundSyp: Value(refundSyp),
      debtReducedSyp: Value(debtReducedSyp),
      costUsd: Value(costUsd),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory CustomerReturn.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerReturn(
      id: serializer.fromJson<int>(json['id']),
      saleId: serializer.fromJson<int>(json['saleId']),
      customerId: serializer.fromJson<int?>(json['customerId']),
      shiftId: serializer.fromJson<int>(json['shiftId']),
      userId: serializer.fromJson<int>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      rate: serializer.fromJson<double>(json['rate']),
      totalSyp: serializer.fromJson<double>(json['totalSyp']),
      refundSyp: serializer.fromJson<double>(json['refundSyp']),
      debtReducedSyp: serializer.fromJson<double>(json['debtReducedSyp']),
      costUsd: serializer.fromJson<double>(json['costUsd']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'saleId': serializer.toJson<int>(saleId),
      'customerId': serializer.toJson<int?>(customerId),
      'shiftId': serializer.toJson<int>(shiftId),
      'userId': serializer.toJson<int>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'rate': serializer.toJson<double>(rate),
      'totalSyp': serializer.toJson<double>(totalSyp),
      'refundSyp': serializer.toJson<double>(refundSyp),
      'debtReducedSyp': serializer.toJson<double>(debtReducedSyp),
      'costUsd': serializer.toJson<double>(costUsd),
      'note': serializer.toJson<String?>(note),
    };
  }

  CustomerReturn copyWith({
    int? id,
    int? saleId,
    Value<int?> customerId = const Value.absent(),
    int? shiftId,
    int? userId,
    DateTime? createdAt,
    double? rate,
    double? totalSyp,
    double? refundSyp,
    double? debtReducedSyp,
    double? costUsd,
    Value<String?> note = const Value.absent(),
  }) => CustomerReturn(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    customerId: customerId.present ? customerId.value : this.customerId,
    shiftId: shiftId ?? this.shiftId,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    rate: rate ?? this.rate,
    totalSyp: totalSyp ?? this.totalSyp,
    refundSyp: refundSyp ?? this.refundSyp,
    debtReducedSyp: debtReducedSyp ?? this.debtReducedSyp,
    costUsd: costUsd ?? this.costUsd,
    note: note.present ? note.value : this.note,
  );
  CustomerReturn copyWithCompanion(CustomerReturnsCompanion data) {
    return CustomerReturn(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      customerId: data.customerId.present ? data.customerId.value : this.customerId,
      shiftId: data.shiftId.present ? data.shiftId.value : this.shiftId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      rate: data.rate.present ? data.rate.value : this.rate,
      totalSyp: data.totalSyp.present ? data.totalSyp.value : this.totalSyp,
      refundSyp: data.refundSyp.present ? data.refundSyp.value : this.refundSyp,
      debtReducedSyp: data.debtReducedSyp.present ? data.debtReducedSyp.value : this.debtReducedSyp,
      costUsd: data.costUsd.present ? data.costUsd.value : this.costUsd,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerReturn(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('customerId: $customerId, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rate: $rate, ')
          ..write('totalSyp: $totalSyp, ')
          ..write('refundSyp: $refundSyp, ')
          ..write('debtReducedSyp: $debtReducedSyp, ')
          ..write('costUsd: $costUsd, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    customerId,
    shiftId,
    userId,
    createdAt,
    rate,
    totalSyp,
    refundSyp,
    debtReducedSyp,
    costUsd,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerReturn &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.customerId == this.customerId &&
          other.shiftId == this.shiftId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.rate == this.rate &&
          other.totalSyp == this.totalSyp &&
          other.refundSyp == this.refundSyp &&
          other.debtReducedSyp == this.debtReducedSyp &&
          other.costUsd == this.costUsd &&
          other.note == this.note);
}

class CustomerReturnsCompanion extends UpdateCompanion<CustomerReturn> {
  final Value<int> id;
  final Value<int> saleId;
  final Value<int?> customerId;
  final Value<int> shiftId;
  final Value<int> userId;
  final Value<DateTime> createdAt;
  final Value<double> rate;
  final Value<double> totalSyp;
  final Value<double> refundSyp;
  final Value<double> debtReducedSyp;
  final Value<double> costUsd;
  final Value<String?> note;
  const CustomerReturnsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.shiftId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rate = const Value.absent(),
    this.totalSyp = const Value.absent(),
    this.refundSyp = const Value.absent(),
    this.debtReducedSyp = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.note = const Value.absent(),
  });
  CustomerReturnsCompanion.insert({
    this.id = const Value.absent(),
    required int saleId,
    this.customerId = const Value.absent(),
    required int shiftId,
    required int userId,
    this.createdAt = const Value.absent(),
    required double rate,
    required double totalSyp,
    this.refundSyp = const Value.absent(),
    this.debtReducedSyp = const Value.absent(),
    this.costUsd = const Value.absent(),
    this.note = const Value.absent(),
  }) : saleId = Value(saleId),
       shiftId = Value(shiftId),
       userId = Value(userId),
       rate = Value(rate),
       totalSyp = Value(totalSyp);
  static Insertable<CustomerReturn> custom({
    Expression<int>? id,
    Expression<int>? saleId,
    Expression<int>? customerId,
    Expression<int>? shiftId,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
    Expression<double>? rate,
    Expression<double>? totalSyp,
    Expression<double>? refundSyp,
    Expression<double>? debtReducedSyp,
    Expression<double>? costUsd,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (customerId != null) 'customer_id': customerId,
      if (shiftId != null) 'shift_id': shiftId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (rate != null) 'rate': rate,
      if (totalSyp != null) 'total_syp': totalSyp,
      if (refundSyp != null) 'refund_syp': refundSyp,
      if (debtReducedSyp != null) 'debt_reduced_syp': debtReducedSyp,
      if (costUsd != null) 'cost_usd': costUsd,
      if (note != null) 'note': note,
    });
  }

  CustomerReturnsCompanion copyWith({
    Value<int>? id,
    Value<int>? saleId,
    Value<int?>? customerId,
    Value<int>? shiftId,
    Value<int>? userId,
    Value<DateTime>? createdAt,
    Value<double>? rate,
    Value<double>? totalSyp,
    Value<double>? refundSyp,
    Value<double>? debtReducedSyp,
    Value<double>? costUsd,
    Value<String?>? note,
  }) {
    return CustomerReturnsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      customerId: customerId ?? this.customerId,
      shiftId: shiftId ?? this.shiftId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      rate: rate ?? this.rate,
      totalSyp: totalSyp ?? this.totalSyp,
      refundSyp: refundSyp ?? this.refundSyp,
      debtReducedSyp: debtReducedSyp ?? this.debtReducedSyp,
      costUsd: costUsd ?? this.costUsd,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<int>(saleId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<int>(customerId.value);
    }
    if (shiftId.present) {
      map['shift_id'] = Variable<int>(shiftId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rate.present) {
      map['rate'] = Variable<double>(rate.value);
    }
    if (totalSyp.present) {
      map['total_syp'] = Variable<double>(totalSyp.value);
    }
    if (refundSyp.present) {
      map['refund_syp'] = Variable<double>(refundSyp.value);
    }
    if (debtReducedSyp.present) {
      map['debt_reduced_syp'] = Variable<double>(debtReducedSyp.value);
    }
    if (costUsd.present) {
      map['cost_usd'] = Variable<double>(costUsd.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerReturnsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('customerId: $customerId, ')
          ..write('shiftId: $shiftId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rate: $rate, ')
          ..write('totalSyp: $totalSyp, ')
          ..write('refundSyp: $refundSyp, ')
          ..write('debtReducedSyp: $debtReducedSyp, ')
          ..write('costUsd: $costUsd, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $CustomerReturnItemsTable extends CustomerReturnItems
    with TableInfo<$CustomerReturnItemsTable, CustomerReturnItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomerReturnItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _returnIdMeta = const VerificationMeta('returnId');
  @override
  late final GeneratedColumn<int> returnId = GeneratedColumn<int>(
    'return_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES customer_returns (id)'),
  );
  static const VerificationMeta _saleItemIdMeta = const VerificationMeta('saleItemId');
  @override
  late final GeneratedColumn<int> saleItemId = GeneratedColumn<int>(
    'sale_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES sale_items (id)'),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES medicines (id)'),
  );
  static const VerificationMeta _baseQuantityMeta = const VerificationMeta('baseQuantity');
  @override
  late final GeneratedColumn<int> baseQuantity = GeneratedColumn<int>(
    'base_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountSypMeta = const VerificationMeta('amountSyp');
  @override
  late final GeneratedColumn<double> amountSyp = GeneratedColumn<double>(
    'amount_syp',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _restockedMeta = const VerificationMeta('restocked');
  @override
  late final GeneratedColumn<bool> restocked = GeneratedColumn<bool>(
    'restocked',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('CHECK ("restocked" IN (0, 1))'),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [id, returnId, saleItemId, medicineId, baseQuantity, amountSyp, restocked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customer_return_items';
  @override
  VerificationContext validateIntegrity(Insertable<CustomerReturnItem> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('return_id')) {
      context.handle(_returnIdMeta, returnId.isAcceptableOrUnknown(data['return_id']!, _returnIdMeta));
    } else if (isInserting) {
      context.missing(_returnIdMeta);
    }
    if (data.containsKey('sale_item_id')) {
      context.handle(_saleItemIdMeta, saleItemId.isAcceptableOrUnknown(data['sale_item_id']!, _saleItemIdMeta));
    } else if (isInserting) {
      context.missing(_saleItemIdMeta);
    }
    if (data.containsKey('medicine_id')) {
      context.handle(_medicineIdMeta, medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('base_quantity')) {
      context.handle(_baseQuantityMeta, baseQuantity.isAcceptableOrUnknown(data['base_quantity']!, _baseQuantityMeta));
    } else if (isInserting) {
      context.missing(_baseQuantityMeta);
    }
    if (data.containsKey('amount_syp')) {
      context.handle(_amountSypMeta, amountSyp.isAcceptableOrUnknown(data['amount_syp']!, _amountSypMeta));
    } else if (isInserting) {
      context.missing(_amountSypMeta);
    }
    if (data.containsKey('restocked')) {
      context.handle(_restockedMeta, restocked.isAcceptableOrUnknown(data['restocked']!, _restockedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerReturnItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerReturnItem(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      returnId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}return_id'])!,
      saleItemId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}sale_item_id'])!,
      medicineId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      baseQuantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}base_quantity'])!,
      amountSyp: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}amount_syp'])!,
      restocked: attachedDatabase.typeMapping.read(DriftSqlType.bool, data['${effectivePrefix}restocked'])!,
    );
  }

  @override
  $CustomerReturnItemsTable createAlias(String alias) {
    return $CustomerReturnItemsTable(attachedDatabase, alias);
  }
}

class CustomerReturnItem extends DataClass implements Insertable<CustomerReturnItem> {
  final int id;
  final int returnId;
  final int saleItemId;
  final int medicineId;
  final int baseQuantity;
  final double amountSyp;
  final bool restocked;
  const CustomerReturnItem({
    required this.id,
    required this.returnId,
    required this.saleItemId,
    required this.medicineId,
    required this.baseQuantity,
    required this.amountSyp,
    required this.restocked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['return_id'] = Variable<int>(returnId);
    map['sale_item_id'] = Variable<int>(saleItemId);
    map['medicine_id'] = Variable<int>(medicineId);
    map['base_quantity'] = Variable<int>(baseQuantity);
    map['amount_syp'] = Variable<double>(amountSyp);
    map['restocked'] = Variable<bool>(restocked);
    return map;
  }

  CustomerReturnItemsCompanion toCompanion(bool nullToAbsent) {
    return CustomerReturnItemsCompanion(
      id: Value(id),
      returnId: Value(returnId),
      saleItemId: Value(saleItemId),
      medicineId: Value(medicineId),
      baseQuantity: Value(baseQuantity),
      amountSyp: Value(amountSyp),
      restocked: Value(restocked),
    );
  }

  factory CustomerReturnItem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerReturnItem(
      id: serializer.fromJson<int>(json['id']),
      returnId: serializer.fromJson<int>(json['returnId']),
      saleItemId: serializer.fromJson<int>(json['saleItemId']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      baseQuantity: serializer.fromJson<int>(json['baseQuantity']),
      amountSyp: serializer.fromJson<double>(json['amountSyp']),
      restocked: serializer.fromJson<bool>(json['restocked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'returnId': serializer.toJson<int>(returnId),
      'saleItemId': serializer.toJson<int>(saleItemId),
      'medicineId': serializer.toJson<int>(medicineId),
      'baseQuantity': serializer.toJson<int>(baseQuantity),
      'amountSyp': serializer.toJson<double>(amountSyp),
      'restocked': serializer.toJson<bool>(restocked),
    };
  }

  CustomerReturnItem copyWith({
    int? id,
    int? returnId,
    int? saleItemId,
    int? medicineId,
    int? baseQuantity,
    double? amountSyp,
    bool? restocked,
  }) => CustomerReturnItem(
    id: id ?? this.id,
    returnId: returnId ?? this.returnId,
    saleItemId: saleItemId ?? this.saleItemId,
    medicineId: medicineId ?? this.medicineId,
    baseQuantity: baseQuantity ?? this.baseQuantity,
    amountSyp: amountSyp ?? this.amountSyp,
    restocked: restocked ?? this.restocked,
  );
  CustomerReturnItem copyWithCompanion(CustomerReturnItemsCompanion data) {
    return CustomerReturnItem(
      id: data.id.present ? data.id.value : this.id,
      returnId: data.returnId.present ? data.returnId.value : this.returnId,
      saleItemId: data.saleItemId.present ? data.saleItemId.value : this.saleItemId,
      medicineId: data.medicineId.present ? data.medicineId.value : this.medicineId,
      baseQuantity: data.baseQuantity.present ? data.baseQuantity.value : this.baseQuantity,
      amountSyp: data.amountSyp.present ? data.amountSyp.value : this.amountSyp,
      restocked: data.restocked.present ? data.restocked.value : this.restocked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerReturnItem(')
          ..write('id: $id, ')
          ..write('returnId: $returnId, ')
          ..write('saleItemId: $saleItemId, ')
          ..write('medicineId: $medicineId, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('amountSyp: $amountSyp, ')
          ..write('restocked: $restocked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, returnId, saleItemId, medicineId, baseQuantity, amountSyp, restocked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerReturnItem &&
          other.id == this.id &&
          other.returnId == this.returnId &&
          other.saleItemId == this.saleItemId &&
          other.medicineId == this.medicineId &&
          other.baseQuantity == this.baseQuantity &&
          other.amountSyp == this.amountSyp &&
          other.restocked == this.restocked);
}

class CustomerReturnItemsCompanion extends UpdateCompanion<CustomerReturnItem> {
  final Value<int> id;
  final Value<int> returnId;
  final Value<int> saleItemId;
  final Value<int> medicineId;
  final Value<int> baseQuantity;
  final Value<double> amountSyp;
  final Value<bool> restocked;
  const CustomerReturnItemsCompanion({
    this.id = const Value.absent(),
    this.returnId = const Value.absent(),
    this.saleItemId = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.baseQuantity = const Value.absent(),
    this.amountSyp = const Value.absent(),
    this.restocked = const Value.absent(),
  });
  CustomerReturnItemsCompanion.insert({
    this.id = const Value.absent(),
    required int returnId,
    required int saleItemId,
    required int medicineId,
    required int baseQuantity,
    required double amountSyp,
    this.restocked = const Value.absent(),
  }) : returnId = Value(returnId),
       saleItemId = Value(saleItemId),
       medicineId = Value(medicineId),
       baseQuantity = Value(baseQuantity),
       amountSyp = Value(amountSyp);
  static Insertable<CustomerReturnItem> custom({
    Expression<int>? id,
    Expression<int>? returnId,
    Expression<int>? saleItemId,
    Expression<int>? medicineId,
    Expression<int>? baseQuantity,
    Expression<double>? amountSyp,
    Expression<bool>? restocked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (returnId != null) 'return_id': returnId,
      if (saleItemId != null) 'sale_item_id': saleItemId,
      if (medicineId != null) 'medicine_id': medicineId,
      if (baseQuantity != null) 'base_quantity': baseQuantity,
      if (amountSyp != null) 'amount_syp': amountSyp,
      if (restocked != null) 'restocked': restocked,
    });
  }

  CustomerReturnItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? returnId,
    Value<int>? saleItemId,
    Value<int>? medicineId,
    Value<int>? baseQuantity,
    Value<double>? amountSyp,
    Value<bool>? restocked,
  }) {
    return CustomerReturnItemsCompanion(
      id: id ?? this.id,
      returnId: returnId ?? this.returnId,
      saleItemId: saleItemId ?? this.saleItemId,
      medicineId: medicineId ?? this.medicineId,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      amountSyp: amountSyp ?? this.amountSyp,
      restocked: restocked ?? this.restocked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (returnId.present) {
      map['return_id'] = Variable<int>(returnId.value);
    }
    if (saleItemId.present) {
      map['sale_item_id'] = Variable<int>(saleItemId.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (baseQuantity.present) {
      map['base_quantity'] = Variable<int>(baseQuantity.value);
    }
    if (amountSyp.present) {
      map['amount_syp'] = Variable<double>(amountSyp.value);
    }
    if (restocked.present) {
      map['restocked'] = Variable<bool>(restocked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomerReturnItemsCompanion(')
          ..write('id: $id, ')
          ..write('returnId: $returnId, ')
          ..write('saleItemId: $saleItemId, ')
          ..write('medicineId: $medicineId, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('amountSyp: $amountSyp, ')
          ..write('restocked: $restocked')
          ..write(')'))
        .toString();
  }
}

class $SupplierReturnsTable extends SupplierReturns with TableInfo<$SupplierReturnsTable, SupplierReturn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierReturnsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _supplierIdMeta = const VerificationMeta('supplierId');
  @override
  late final GeneratedColumn<int> supplierId = GeneratedColumn<int>(
    'supplier_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES suppliers (id)'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _totalUsdMeta = const VerificationMeta('totalUsd');
  @override
  late final GeneratedColumn<double> totalUsd = GeneratedColumn<double>(
    'total_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _settlementMeta = const VerificationMeta('settlement');
  @override
  late final GeneratedColumn<String> settlement = GeneratedColumn<String>(
    'settlement',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, supplierId, userId, createdAt, totalUsd, settlement, note];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_returns';
  @override
  VerificationContext validateIntegrity(Insertable<SupplierReturn> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('supplier_id')) {
      context.handle(_supplierIdMeta, supplierId.isAcceptableOrUnknown(data['supplier_id']!, _supplierIdMeta));
    } else if (isInserting) {
      context.missing(_supplierIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('total_usd')) {
      context.handle(_totalUsdMeta, totalUsd.isAcceptableOrUnknown(data['total_usd']!, _totalUsdMeta));
    } else if (isInserting) {
      context.missing(_totalUsdMeta);
    }
    if (data.containsKey('settlement')) {
      context.handle(_settlementMeta, settlement.isAcceptableOrUnknown(data['settlement']!, _settlementMeta));
    } else if (isInserting) {
      context.missing(_settlementMeta);
    }
    if (data.containsKey('note')) {
      context.handle(_noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierReturn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierReturn(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      supplierId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}supplier_id'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      totalUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}total_usd'])!,
      settlement: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}settlement'])!,
      note: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}note']),
    );
  }

  @override
  $SupplierReturnsTable createAlias(String alias) {
    return $SupplierReturnsTable(attachedDatabase, alias);
  }
}

class SupplierReturn extends DataClass implements Insertable<SupplierReturn> {
  final int id;
  final int supplierId;
  final int? userId;
  final DateTime createdAt;
  final double totalUsd;

  /// credit = خصم من دين المورد، cash = استلام نقدي
  final String settlement;
  final String? note;
  const SupplierReturn({
    required this.id,
    required this.supplierId,
    this.userId,
    required this.createdAt,
    required this.totalUsd,
    required this.settlement,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['supplier_id'] = Variable<int>(supplierId);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['total_usd'] = Variable<double>(totalUsd);
    map['settlement'] = Variable<String>(settlement);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  SupplierReturnsCompanion toCompanion(bool nullToAbsent) {
    return SupplierReturnsCompanion(
      id: Value(id),
      supplierId: Value(supplierId),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      createdAt: Value(createdAt),
      totalUsd: Value(totalUsd),
      settlement: Value(settlement),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory SupplierReturn.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierReturn(
      id: serializer.fromJson<int>(json['id']),
      supplierId: serializer.fromJson<int>(json['supplierId']),
      userId: serializer.fromJson<int?>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      totalUsd: serializer.fromJson<double>(json['totalUsd']),
      settlement: serializer.fromJson<String>(json['settlement']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'supplierId': serializer.toJson<int>(supplierId),
      'userId': serializer.toJson<int?>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'totalUsd': serializer.toJson<double>(totalUsd),
      'settlement': serializer.toJson<String>(settlement),
      'note': serializer.toJson<String?>(note),
    };
  }

  SupplierReturn copyWith({
    int? id,
    int? supplierId,
    Value<int?> userId = const Value.absent(),
    DateTime? createdAt,
    double? totalUsd,
    String? settlement,
    Value<String?> note = const Value.absent(),
  }) => SupplierReturn(
    id: id ?? this.id,
    supplierId: supplierId ?? this.supplierId,
    userId: userId.present ? userId.value : this.userId,
    createdAt: createdAt ?? this.createdAt,
    totalUsd: totalUsd ?? this.totalUsd,
    settlement: settlement ?? this.settlement,
    note: note.present ? note.value : this.note,
  );
  SupplierReturn copyWithCompanion(SupplierReturnsCompanion data) {
    return SupplierReturn(
      id: data.id.present ? data.id.value : this.id,
      supplierId: data.supplierId.present ? data.supplierId.value : this.supplierId,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      totalUsd: data.totalUsd.present ? data.totalUsd.value : this.totalUsd,
      settlement: data.settlement.present ? data.settlement.value : this.settlement,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReturn(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('settlement: $settlement, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, supplierId, userId, createdAt, totalUsd, settlement, note);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierReturn &&
          other.id == this.id &&
          other.supplierId == this.supplierId &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.totalUsd == this.totalUsd &&
          other.settlement == this.settlement &&
          other.note == this.note);
}

class SupplierReturnsCompanion extends UpdateCompanion<SupplierReturn> {
  final Value<int> id;
  final Value<int> supplierId;
  final Value<int?> userId;
  final Value<DateTime> createdAt;
  final Value<double> totalUsd;
  final Value<String> settlement;
  final Value<String?> note;
  const SupplierReturnsCompanion({
    this.id = const Value.absent(),
    this.supplierId = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.totalUsd = const Value.absent(),
    this.settlement = const Value.absent(),
    this.note = const Value.absent(),
  });
  SupplierReturnsCompanion.insert({
    this.id = const Value.absent(),
    required int supplierId,
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    required double totalUsd,
    required String settlement,
    this.note = const Value.absent(),
  }) : supplierId = Value(supplierId),
       totalUsd = Value(totalUsd),
       settlement = Value(settlement);
  static Insertable<SupplierReturn> custom({
    Expression<int>? id,
    Expression<int>? supplierId,
    Expression<int>? userId,
    Expression<DateTime>? createdAt,
    Expression<double>? totalUsd,
    Expression<String>? settlement,
    Expression<String>? note,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (supplierId != null) 'supplier_id': supplierId,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (totalUsd != null) 'total_usd': totalUsd,
      if (settlement != null) 'settlement': settlement,
      if (note != null) 'note': note,
    });
  }

  SupplierReturnsCompanion copyWith({
    Value<int>? id,
    Value<int>? supplierId,
    Value<int?>? userId,
    Value<DateTime>? createdAt,
    Value<double>? totalUsd,
    Value<String>? settlement,
    Value<String?>? note,
  }) {
    return SupplierReturnsCompanion(
      id: id ?? this.id,
      supplierId: supplierId ?? this.supplierId,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      totalUsd: totalUsd ?? this.totalUsd,
      settlement: settlement ?? this.settlement,
      note: note ?? this.note,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (supplierId.present) {
      map['supplier_id'] = Variable<int>(supplierId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (totalUsd.present) {
      map['total_usd'] = Variable<double>(totalUsd.value);
    }
    if (settlement.present) {
      map['settlement'] = Variable<String>(settlement.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReturnsCompanion(')
          ..write('id: $id, ')
          ..write('supplierId: $supplierId, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('totalUsd: $totalUsd, ')
          ..write('settlement: $settlement, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }
}

class $SupplierReturnItemsTable extends SupplierReturnItems
    with TableInfo<$SupplierReturnItemsTable, SupplierReturnItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SupplierReturnItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _returnIdMeta = const VerificationMeta('returnId');
  @override
  late final GeneratedColumn<int> returnId = GeneratedColumn<int>(
    'return_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES supplier_returns (id)'),
  );
  static const VerificationMeta _batchIdMeta = const VerificationMeta('batchId');
  @override
  late final GeneratedColumn<int> batchId = GeneratedColumn<int>(
    'batch_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES batches (id)'),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta('medicineId');
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('REFERENCES medicines (id)'),
  );
  static const VerificationMeta _baseQuantityMeta = const VerificationMeta('baseQuantity');
  @override
  late final GeneratedColumn<int> baseQuantity = GeneratedColumn<int>(
    'base_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountUsdMeta = const VerificationMeta('amountUsd');
  @override
  late final GeneratedColumn<double> amountUsd = GeneratedColumn<double>(
    'amount_usd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, returnId, batchId, medicineId, baseQuantity, amountUsd];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'supplier_return_items';
  @override
  VerificationContext validateIntegrity(Insertable<SupplierReturnItem> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('return_id')) {
      context.handle(_returnIdMeta, returnId.isAcceptableOrUnknown(data['return_id']!, _returnIdMeta));
    } else if (isInserting) {
      context.missing(_returnIdMeta);
    }
    if (data.containsKey('batch_id')) {
      context.handle(_batchIdMeta, batchId.isAcceptableOrUnknown(data['batch_id']!, _batchIdMeta));
    } else if (isInserting) {
      context.missing(_batchIdMeta);
    }
    if (data.containsKey('medicine_id')) {
      context.handle(_medicineIdMeta, medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta));
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('base_quantity')) {
      context.handle(_baseQuantityMeta, baseQuantity.isAcceptableOrUnknown(data['base_quantity']!, _baseQuantityMeta));
    } else if (isInserting) {
      context.missing(_baseQuantityMeta);
    }
    if (data.containsKey('amount_usd')) {
      context.handle(_amountUsdMeta, amountUsd.isAcceptableOrUnknown(data['amount_usd']!, _amountUsdMeta));
    } else if (isInserting) {
      context.missing(_amountUsdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SupplierReturnItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SupplierReturnItem(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      returnId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}return_id'])!,
      batchId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}batch_id'])!,
      medicineId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}medicine_id'])!,
      baseQuantity: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}base_quantity'])!,
      amountUsd: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}amount_usd'])!,
    );
  }

  @override
  $SupplierReturnItemsTable createAlias(String alias) {
    return $SupplierReturnItemsTable(attachedDatabase, alias);
  }
}

class SupplierReturnItem extends DataClass implements Insertable<SupplierReturnItem> {
  final int id;
  final int returnId;
  final int batchId;
  final int medicineId;
  final int baseQuantity;
  final double amountUsd;
  const SupplierReturnItem({
    required this.id,
    required this.returnId,
    required this.batchId,
    required this.medicineId,
    required this.baseQuantity,
    required this.amountUsd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['return_id'] = Variable<int>(returnId);
    map['batch_id'] = Variable<int>(batchId);
    map['medicine_id'] = Variable<int>(medicineId);
    map['base_quantity'] = Variable<int>(baseQuantity);
    map['amount_usd'] = Variable<double>(amountUsd);
    return map;
  }

  SupplierReturnItemsCompanion toCompanion(bool nullToAbsent) {
    return SupplierReturnItemsCompanion(
      id: Value(id),
      returnId: Value(returnId),
      batchId: Value(batchId),
      medicineId: Value(medicineId),
      baseQuantity: Value(baseQuantity),
      amountUsd: Value(amountUsd),
    );
  }

  factory SupplierReturnItem.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SupplierReturnItem(
      id: serializer.fromJson<int>(json['id']),
      returnId: serializer.fromJson<int>(json['returnId']),
      batchId: serializer.fromJson<int>(json['batchId']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      baseQuantity: serializer.fromJson<int>(json['baseQuantity']),
      amountUsd: serializer.fromJson<double>(json['amountUsd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'returnId': serializer.toJson<int>(returnId),
      'batchId': serializer.toJson<int>(batchId),
      'medicineId': serializer.toJson<int>(medicineId),
      'baseQuantity': serializer.toJson<int>(baseQuantity),
      'amountUsd': serializer.toJson<double>(amountUsd),
    };
  }

  SupplierReturnItem copyWith({
    int? id,
    int? returnId,
    int? batchId,
    int? medicineId,
    int? baseQuantity,
    double? amountUsd,
  }) => SupplierReturnItem(
    id: id ?? this.id,
    returnId: returnId ?? this.returnId,
    batchId: batchId ?? this.batchId,
    medicineId: medicineId ?? this.medicineId,
    baseQuantity: baseQuantity ?? this.baseQuantity,
    amountUsd: amountUsd ?? this.amountUsd,
  );
  SupplierReturnItem copyWithCompanion(SupplierReturnItemsCompanion data) {
    return SupplierReturnItem(
      id: data.id.present ? data.id.value : this.id,
      returnId: data.returnId.present ? data.returnId.value : this.returnId,
      batchId: data.batchId.present ? data.batchId.value : this.batchId,
      medicineId: data.medicineId.present ? data.medicineId.value : this.medicineId,
      baseQuantity: data.baseQuantity.present ? data.baseQuantity.value : this.baseQuantity,
      amountUsd: data.amountUsd.present ? data.amountUsd.value : this.amountUsd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReturnItem(')
          ..write('id: $id, ')
          ..write('returnId: $returnId, ')
          ..write('batchId: $batchId, ')
          ..write('medicineId: $medicineId, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('amountUsd: $amountUsd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, returnId, batchId, medicineId, baseQuantity, amountUsd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SupplierReturnItem &&
          other.id == this.id &&
          other.returnId == this.returnId &&
          other.batchId == this.batchId &&
          other.medicineId == this.medicineId &&
          other.baseQuantity == this.baseQuantity &&
          other.amountUsd == this.amountUsd);
}

class SupplierReturnItemsCompanion extends UpdateCompanion<SupplierReturnItem> {
  final Value<int> id;
  final Value<int> returnId;
  final Value<int> batchId;
  final Value<int> medicineId;
  final Value<int> baseQuantity;
  final Value<double> amountUsd;
  const SupplierReturnItemsCompanion({
    this.id = const Value.absent(),
    this.returnId = const Value.absent(),
    this.batchId = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.baseQuantity = const Value.absent(),
    this.amountUsd = const Value.absent(),
  });
  SupplierReturnItemsCompanion.insert({
    this.id = const Value.absent(),
    required int returnId,
    required int batchId,
    required int medicineId,
    required int baseQuantity,
    required double amountUsd,
  }) : returnId = Value(returnId),
       batchId = Value(batchId),
       medicineId = Value(medicineId),
       baseQuantity = Value(baseQuantity),
       amountUsd = Value(amountUsd);
  static Insertable<SupplierReturnItem> custom({
    Expression<int>? id,
    Expression<int>? returnId,
    Expression<int>? batchId,
    Expression<int>? medicineId,
    Expression<int>? baseQuantity,
    Expression<double>? amountUsd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (returnId != null) 'return_id': returnId,
      if (batchId != null) 'batch_id': batchId,
      if (medicineId != null) 'medicine_id': medicineId,
      if (baseQuantity != null) 'base_quantity': baseQuantity,
      if (amountUsd != null) 'amount_usd': amountUsd,
    });
  }

  SupplierReturnItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? returnId,
    Value<int>? batchId,
    Value<int>? medicineId,
    Value<int>? baseQuantity,
    Value<double>? amountUsd,
  }) {
    return SupplierReturnItemsCompanion(
      id: id ?? this.id,
      returnId: returnId ?? this.returnId,
      batchId: batchId ?? this.batchId,
      medicineId: medicineId ?? this.medicineId,
      baseQuantity: baseQuantity ?? this.baseQuantity,
      amountUsd: amountUsd ?? this.amountUsd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (returnId.present) {
      map['return_id'] = Variable<int>(returnId.value);
    }
    if (batchId.present) {
      map['batch_id'] = Variable<int>(batchId.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (baseQuantity.present) {
      map['base_quantity'] = Variable<int>(baseQuantity.value);
    }
    if (amountUsd.present) {
      map['amount_usd'] = Variable<double>(amountUsd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SupplierReturnItemsCompanion(')
          ..write('id: $id, ')
          ..write('returnId: $returnId, ')
          ..write('batchId: $batchId, ')
          ..write('medicineId: $medicineId, ')
          ..write('baseQuantity: $baseQuantity, ')
          ..write('amountUsd: $amountUsd')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, userName, action, entity, entityId, details, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(Insertable<AuditLog> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta, userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    }
    if (data.containsKey('action')) {
      context.handle(_actionMeta, action.isAcceptableOrUnknown(data['action']!, _actionMeta));
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(_entityMeta, entity.isAcceptableOrUnknown(data['entity']!, _entityMeta));
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta, entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta, details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      userName: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_name']),
      action: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}action'])!,
      entity: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}entity']),
      entityId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}entity_id']),
      details: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}details']),
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;
  final int? userId;
  final String? userName;
  final String action;
  final String? entity;
  final int? entityId;
  final String? details;
  final DateTime createdAt;
  const AuditLog({
    required this.id,
    this.userId,
    this.userName,
    required this.action,
    this.entity,
    this.entityId,
    this.details,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    if (!nullToAbsent || userName != null) {
      map['user_name'] = Variable<String>(userName);
    }
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || entity != null) {
      map['entity'] = Variable<String>(entity);
    }
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<int>(entityId);
    }
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      userId: userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      userName: userName == null && nullToAbsent ? const Value.absent() : Value(userName),
      action: Value(action),
      entity: entity == null && nullToAbsent ? const Value.absent() : Value(entity),
      entityId: entityId == null && nullToAbsent ? const Value.absent() : Value(entityId),
      details: details == null && nullToAbsent ? const Value.absent() : Value(details),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int?>(json['userId']),
      userName: serializer.fromJson<String?>(json['userName']),
      action: serializer.fromJson<String>(json['action']),
      entity: serializer.fromJson<String?>(json['entity']),
      entityId: serializer.fromJson<int?>(json['entityId']),
      details: serializer.fromJson<String?>(json['details']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int?>(userId),
      'userName': serializer.toJson<String?>(userName),
      'action': serializer.toJson<String>(action),
      'entity': serializer.toJson<String?>(entity),
      'entityId': serializer.toJson<int?>(entityId),
      'details': serializer.toJson<String?>(details),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith({
    int? id,
    Value<int?> userId = const Value.absent(),
    Value<String?> userName = const Value.absent(),
    String? action,
    Value<String?> entity = const Value.absent(),
    Value<int?> entityId = const Value.absent(),
    Value<String?> details = const Value.absent(),
    DateTime? createdAt,
  }) => AuditLog(
    id: id ?? this.id,
    userId: userId.present ? userId.value : this.userId,
    userName: userName.present ? userName.value : this.userName,
    action: action ?? this.action,
    entity: entity.present ? entity.value : this.entity,
    entityId: entityId.present ? entityId.value : this.entityId,
    details: details.present ? details.value : this.details,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      action: data.action.present ? data.action.value : this.action,
      entity: data.entity.present ? data.entity.value : this.entity,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      details: data.details.present ? data.details.value : this.details,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('action: $action, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, userName, action, entity, entityId, details, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.action == this.action &&
          other.entity == this.entity &&
          other.entityId == this.entityId &&
          other.details == this.details &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<int?> userId;
  final Value<String?> userName;
  final Value<String> action;
  final Value<String?> entity;
  final Value<int?> entityId;
  final Value<String?> details;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.action = const Value.absent(),
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    required String action,
    this.entity = const Value.absent(),
    this.entityId = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : action = Value(action);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? userName,
    Expression<String>? action,
    Expression<String>? entity,
    Expression<int>? entityId,
    Expression<String>? details,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (action != null) 'action': action,
      if (entity != null) 'entity': entity,
      if (entityId != null) 'entity_id': entityId,
      if (details != null) 'details': details,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<int?>? userId,
    Value<String?>? userName,
    Value<String>? action,
    Value<String?>? entity,
    Value<int?>? entityId,
    Value<String?>? details,
    Value<DateTime>? createdAt,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      action: action ?? this.action,
      entity: entity ?? this.entity,
      entityId: entityId ?? this.entityId,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('action: $action, ')
          ..write('entity: $entity, ')
          ..write('entityId: $entityId, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  late final $ExchangeRatesTable exchangeRates = $ExchangeRatesTable(this);
  late final $MedicinesTable medicines = $MedicinesTable(this);
  late final $SuppliersTable suppliers = $SuppliersTable(this);
  late final $BatchesTable batches = $BatchesTable(this);
  late final $StockAdjustmentsTable stockAdjustments = $StockAdjustmentsTable(this);
  late final $SupplierTransactionsTable supplierTransactions = $SupplierTransactionsTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $CustomerTransactionsTable customerTransactions = $CustomerTransactionsTable(this);
  late final $PurchasesTable purchases = $PurchasesTable(this);
  late final $PurchaseItemsTable purchaseItems = $PurchaseItemsTable(this);
  late final $ShiftsTable shifts = $ShiftsTable(this);
  late final $CashMovementsTable cashMovements = $CashMovementsTable(this);
  late final $SalesTable sales = $SalesTable(this);
  late final $SaleItemsTable saleItems = $SaleItemsTable(this);
  late final $SaleItemBatchesTable saleItemBatches = $SaleItemBatchesTable(this);
  late final $CustomerReturnsTable customerReturns = $CustomerReturnsTable(this);
  late final $CustomerReturnItemsTable customerReturnItems = $CustomerReturnItemsTable(this);
  late final $SupplierReturnsTable supplierReturns = $SupplierReturnsTable(this);
  late final $SupplierReturnItemsTable supplierReturnItems = $SupplierReturnItemsTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    settings,
    exchangeRates,
    medicines,
    suppliers,
    batches,
    stockAdjustments,
    supplierTransactions,
    customers,
    customerTransactions,
    purchases,
    purchaseItems,
    shifts,
    cashMovements,
    sales,
    saleItems,
    saleItemBatches,
    customerReturns,
    customerReturnItems,
    supplierReturns,
    supplierReturnItems,
    auditLogs,
  ];
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String username,
  required String fullName,
  required String passwordHash,
  required String salt,
  required String role,
  Value<String> permissions,
  Value<bool> active,
  Value<DateTime> createdAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> username,
  Value<String> fullName,
  Value<String> passwordHash,
  Value<String> salt,
  Value<String> role,
  Value<String> permissions,
  Value<bool> active,
  Value<DateTime> createdAt,
});

final class $$UsersTableReferences extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExchangeRatesTable, List<ExchangeRate>> _exchangeRatesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exchangeRates, aliasName: 'users__id__exchange_rates__user_id');

  $$ExchangeRatesTableProcessedTableManager get exchangeRatesRefs {
    final manager = $$ExchangeRatesTableTableManager(
      $_db,
      $_db.exchangeRates,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_exchangeRatesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StockAdjustmentsTable, List<StockAdjustment>> _stockAdjustmentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(db.stockAdjustments, aliasName: 'users__id__stock_adjustments__user_id');

  $$StockAdjustmentsTableProcessedTableManager get stockAdjustmentsRefs {
    final manager = $$StockAdjustmentsTableTableManager(
      $_db,
      $_db.stockAdjustments,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockAdjustmentsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ShiftsTable, List<Shift>> _shiftsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.shifts, aliasName: 'users__id__shifts__user_id');

  $$ShiftsTableProcessedTableManager get shiftsRefs {
    final manager = $$ShiftsTableTableManager(
      $_db,
      $_db.shifts,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_shiftsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SalesTable, List<Sale>> _salesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sales, aliasName: 'users__id__sales__user_id');

  $$SalesTableProcessedTableManager get salesRefs {
    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CustomerReturnsTable, List<CustomerReturn>> _customerReturnsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.customerReturns, aliasName: 'users__id__customer_returns__user_id');

  $$CustomerReturnsTableProcessedTableManager get customerReturnsRefs {
    final manager = $$CustomerReturnsTableTableManager(
      $_db,
      $_db.customerReturns,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerReturnsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get passwordHash =>
      $composableBuilder(column: $table.passwordHash, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salt => $composableBuilder(column: $table.salt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get permissions =>
      $composableBuilder(column: $table.permissions, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> exchangeRatesRefs(Expression<bool> Function($$ExchangeRatesTableFilterComposer f) f) {
    final $$ExchangeRatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exchangeRates,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ExchangeRatesTableFilterComposer(
            $db: $db,
            $table: $db.exchangeRates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockAdjustmentsRefs(Expression<bool> Function($$StockAdjustmentsTableFilterComposer f) f) {
    final $$StockAdjustmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAdjustments,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockAdjustmentsTableFilterComposer(
            $db: $db,
            $table: $db.stockAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> shiftsRefs(Expression<bool> Function($$ShiftsTableFilterComposer f) f) {
    final $$ShiftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableFilterComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesRefs(Expression<bool> Function($$SalesTableFilterComposer f) f) {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerReturnsRefs(Expression<bool> Function($$CustomerReturnsTableFilterComposer f) f) {
    final $$CustomerReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableOrderingComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get passwordHash =>
      $composableBuilder(column: $table.passwordHash, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salt =>
      $composableBuilder(column: $table.salt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get permissions =>
      $composableBuilder(column: $table.permissions, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username => $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get fullName => $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get passwordHash =>
      $composableBuilder(column: $table.passwordHash, builder: (column) => column);

  GeneratedColumn<String> get salt => $composableBuilder(column: $table.salt, builder: (column) => column);

  GeneratedColumn<String> get role => $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get permissions =>
      $composableBuilder(column: $table.permissions, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> exchangeRatesRefs<T extends Object>(
    Expression<T> Function($$ExchangeRatesTableAnnotationComposer a) f,
  ) {
    final $$ExchangeRatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.exchangeRates,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ExchangeRatesTableAnnotationComposer(
            $db: $db,
            $table: $db.exchangeRates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockAdjustmentsRefs<T extends Object>(
    Expression<T> Function($$StockAdjustmentsTableAnnotationComposer a) f,
  ) {
    final $$StockAdjustmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAdjustments,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockAdjustmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> shiftsRefs<T extends Object>(Expression<T> Function($$ShiftsTableAnnotationComposer a) f) {
    final $$ShiftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableAnnotationComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesRefs<T extends Object>(Expression<T> Function($$SalesTableAnnotationComposer a) f) {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerReturnsRefs<T extends Object>(
    Expression<T> Function($$CustomerReturnsTableAnnotationComposer a) f,
  ) {
    final $$CustomerReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.userId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, $$UsersTableReferences),
          User,
          PrefetchHooks Function({
            bool exchangeRatesRefs,
            bool stockAdjustmentsRefs,
            bool shiftsRefs,
            bool salesRefs,
            bool customerReturnsRefs,
          })
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String> passwordHash = const Value.absent(),
                Value<String> salt = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> permissions = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                username: username,
                fullName: fullName,
                passwordHash: passwordHash,
                salt: salt,
                role: role,
                permissions: permissions,
                active: active,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required String fullName,
                required String passwordHash,
                required String salt,
                required String role,
                Value<String> permissions = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                username: username,
                fullName: fullName,
                passwordHash: passwordHash,
                salt: salt,
                role: role,
                permissions: permissions,
                active: active,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable<$UsersTable, User>(table), $$UsersTableReferences(db, table, e))).toList(),
          prefetchHooksCallback:
              ({
                exchangeRatesRefs = false,
                stockAdjustmentsRefs = false,
                shiftsRefs = false,
                salesRefs = false,
                customerReturnsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (exchangeRatesRefs) db.exchangeRates,
                    if (stockAdjustmentsRefs) db.stockAdjustments,
                    if (shiftsRefs) db.shifts,
                    if (salesRefs) db.sales,
                    if (customerReturnsRefs) db.customerReturns,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (exchangeRatesRefs)
                        await $_getPrefetchedDataByColumns<User, $UsersTable, ExchangeRate, $ExchangeRatesTable>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences._exchangeRatesRefsTable(db),
                          managerFromTypedResult: (p0) => $$UsersTableReferences(db, table, p0).exchangeRatesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (stockAdjustmentsRefs)
                        await $_getPrefetchedDataByColumns<User, $UsersTable, StockAdjustment, $StockAdjustmentsTable>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences._stockAdjustmentsRefsTable(db),
                          managerFromTypedResult: (p0) => $$UsersTableReferences(db, table, p0).stockAdjustmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (shiftsRefs)
                        await $_getPrefetchedDataByColumns<User, $UsersTable, Shift, $ShiftsTable>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences._shiftsRefsTable(db),
                          managerFromTypedResult: (p0) => $$UsersTableReferences(db, table, p0).shiftsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (salesRefs)
                        await $_getPrefetchedDataByColumns<User, $UsersTable, Sale, $SalesTable>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences._salesRefsTable(db),
                          managerFromTypedResult: (p0) => $$UsersTableReferences(db, table, p0).salesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                      if (customerReturnsRefs)
                        await $_getPrefetchedDataByColumns<User, $UsersTable, CustomerReturn, $CustomerReturnsTable>(
                          currentTable: table,
                          referencedTable: $$UsersTableReferences._customerReturnsRefsTable(db),
                          managerFromTypedResult: (p0) => $$UsersTableReferences(db, table, p0).customerReturnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'user_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, $$UsersTableReferences),
      User,
      PrefetchHooks Function({
        bool exchangeRatesRefs,
        bool stockAdjustmentsRefs,
        bool shiftsRefs,
        bool salesRefs,
        bool customerReturnsRefs,
      })
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  required String value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(column: $table.key, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => ColumnFilters(column));
}

class $$SettingsTableOrderingComposer extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => ColumnOrderings(column));
}

class $$SettingsTableAnnotationComposer extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key => $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value => $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            required String value,
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, Setting>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, Setting>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;
typedef $$ExchangeRatesTableCreateCompanionBuilder = ExchangeRatesCompanion Function({
  Value<int> id,
  required double rate,
  Value<int?> userId,
  Value<DateTime> createdAt,
});
typedef $$ExchangeRatesTableUpdateCompanionBuilder = ExchangeRatesCompanion Function({
  Value<int> id,
  Value<double> rate,
  Value<int?> userId,
  Value<DateTime> createdAt,
});

final class $$ExchangeRatesTableReferences extends BaseReferences<_$AppDatabase, $ExchangeRatesTable, ExchangeRate> {
  $$ExchangeRatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias('exchange_rates__user_id__users__id');

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExchangeRatesTableFilterComposer extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExchangeRatesTableOrderingComposer extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExchangeRatesTableAnnotationComposer extends Composer<_$AppDatabase, $ExchangeRatesTable> {
  $$ExchangeRatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExchangeRatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExchangeRatesTable,
          ExchangeRate,
          $$ExchangeRatesTableFilterComposer,
          $$ExchangeRatesTableOrderingComposer,
          $$ExchangeRatesTableAnnotationComposer,
          $$ExchangeRatesTableCreateCompanionBuilder,
          $$ExchangeRatesTableUpdateCompanionBuilder,
          (ExchangeRate, $$ExchangeRatesTableReferences),
          ExchangeRate,
          PrefetchHooks Function({bool userId})
        > {
  $$ExchangeRatesTableTableManager(_$AppDatabase db, $ExchangeRatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ExchangeRatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ExchangeRatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ExchangeRatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<double> rate = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) => ExchangeRatesCompanion(id: id, rate: rate, userId: userId, createdAt: createdAt),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required double rate,
            Value<int?> userId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) => ExchangeRatesCompanion.insert(id: id, rate: rate, userId: userId, createdAt: createdAt),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ExchangeRatesTable, ExchangeRate>(table),
                  $$ExchangeRatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userId = false}) {
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
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$ExchangeRatesTableReferences._userIdTable(db),
                        referencedColumn: $$ExchangeRatesTableReferences._userIdTable(db).id,
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

typedef $$ExchangeRatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExchangeRatesTable,
      ExchangeRate,
      $$ExchangeRatesTableFilterComposer,
      $$ExchangeRatesTableOrderingComposer,
      $$ExchangeRatesTableAnnotationComposer,
      $$ExchangeRatesTableCreateCompanionBuilder,
      $$ExchangeRatesTableUpdateCompanionBuilder,
      (ExchangeRate, $$ExchangeRatesTableReferences),
      ExchangeRate,
      PrefetchHooks Function({bool userId})
    >;
typedef $$MedicinesTableCreateCompanionBuilder = MedicinesCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> scientificName,
  Value<String?> manufacturer,
  Value<String?> form,
  Value<String?> category,
  Value<String?> barcode,
  Value<int> stripsPerBox,
  Value<int> unitsPerStrip,
  Value<String> boxName,
  Value<String> stripName,
  Value<String> unitName,
  Value<bool> allowStripSale,
  Value<bool> allowUnitSale,
  Value<double> priceUsd,
  Value<double?> stripPriceUsd,
  Value<double?> unitPriceUsd,
  Value<double> minStockBoxes,
  Value<bool> requiresPrescription,
  Value<bool> active,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$MedicinesTableUpdateCompanionBuilder = MedicinesCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> scientificName,
  Value<String?> manufacturer,
  Value<String?> form,
  Value<String?> category,
  Value<String?> barcode,
  Value<int> stripsPerBox,
  Value<int> unitsPerStrip,
  Value<String> boxName,
  Value<String> stripName,
  Value<String> unitName,
  Value<bool> allowStripSale,
  Value<bool> allowUnitSale,
  Value<double> priceUsd,
  Value<double?> stripPriceUsd,
  Value<double?> unitPriceUsd,
  Value<double> minStockBoxes,
  Value<bool> requiresPrescription,
  Value<bool> active,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$MedicinesTableReferences extends BaseReferences<_$AppDatabase, $MedicinesTable, Medicine> {
  $$MedicinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BatchesTable, List<StockBatch>> _batchesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.batches, aliasName: 'medicines__id__batches__medicine_id');

  $$BatchesTableProcessedTableManager get batchesRefs {
    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StockAdjustmentsTable, List<StockAdjustment>> _stockAdjustmentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(db.stockAdjustments, aliasName: 'medicines__id__stock_adjustments__medicine_id');

  $$StockAdjustmentsTableProcessedTableManager get stockAdjustmentsRefs {
    final manager = $$StockAdjustmentsTableTableManager(
      $_db,
      $_db.stockAdjustments,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockAdjustmentsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>> _purchaseItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.purchaseItems, aliasName: 'medicines__id__purchase_items__medicine_id');

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>> _saleItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.saleItems, aliasName: 'medicines__id__sale_items__medicine_id');

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CustomerReturnItemsTable, List<CustomerReturnItem>> _customerReturnItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.customerReturnItems,
    aliasName: 'medicines__id__customer_return_items__medicine_id',
  );

  $$CustomerReturnItemsTableProcessedTableManager get customerReturnItemsRefs {
    final manager = $$CustomerReturnItemsTableTableManager(
      $_db,
      $_db.customerReturnItems,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerReturnItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierReturnItemsTable, List<SupplierReturnItem>> _supplierReturnItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.supplierReturnItems,
    aliasName: 'medicines__id__supplier_return_items__medicine_id',
  );

  $$SupplierReturnItemsTableProcessedTableManager get supplierReturnItemsRefs {
    final manager = $$SupplierReturnItemsTableTableManager(
      $_db,
      $_db.supplierReturnItems,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_supplierReturnItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MedicinesTableFilterComposer extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get scientificName =>
      $composableBuilder(column: $table.scientificName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get manufacturer =>
      $composableBuilder(column: $table.manufacturer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get form => $composableBuilder(column: $table.form, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stripsPerBox =>
      $composableBuilder(column: $table.stripsPerBox, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unitsPerStrip =>
      $composableBuilder(column: $table.unitsPerStrip, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get boxName =>
      $composableBuilder(column: $table.boxName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stripName =>
      $composableBuilder(column: $table.stripName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitName =>
      $composableBuilder(column: $table.unitName, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowStripSale =>
      $composableBuilder(column: $table.allowStripSale, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get allowUnitSale =>
      $composableBuilder(column: $table.allowUnitSale, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get priceUsd =>
      $composableBuilder(column: $table.priceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get stripPriceUsd =>
      $composableBuilder(column: $table.stripPriceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPriceUsd =>
      $composableBuilder(column: $table.unitPriceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get minStockBoxes =>
      $composableBuilder(column: $table.minStockBoxes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get requiresPrescription =>
      $composableBuilder(column: $table.requiresPrescription, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> batchesRefs(Expression<bool> Function($$BatchesTableFilterComposer f) f) {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> stockAdjustmentsRefs(Expression<bool> Function($$StockAdjustmentsTableFilterComposer f) f) {
    final $$StockAdjustmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAdjustments,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockAdjustmentsTableFilterComposer(
            $db: $db,
            $table: $db.stockAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchaseItemsRefs(Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemsRefs(Expression<bool> Function($$SaleItemsTableFilterComposer f) f) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerReturnItemsRefs(Expression<bool> Function($$CustomerReturnItemsTableFilterComposer f) f) {
    final $$CustomerReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturnItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierReturnItemsRefs(Expression<bool> Function($$SupplierReturnItemsTableFilterComposer f) f) {
    final $$SupplierReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturnItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.supplierReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MedicinesTableOrderingComposer extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get scientificName =>
      $composableBuilder(column: $table.scientificName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get manufacturer =>
      $composableBuilder(column: $table.manufacturer, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get form =>
      $composableBuilder(column: $table.form, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stripsPerBox =>
      $composableBuilder(column: $table.stripsPerBox, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unitsPerStrip =>
      $composableBuilder(column: $table.unitsPerStrip, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get boxName =>
      $composableBuilder(column: $table.boxName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stripName =>
      $composableBuilder(column: $table.stripName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitName =>
      $composableBuilder(column: $table.unitName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowStripSale =>
      $composableBuilder(column: $table.allowStripSale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get allowUnitSale =>
      $composableBuilder(column: $table.allowUnitSale, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get priceUsd =>
      $composableBuilder(column: $table.priceUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get stripPriceUsd =>
      $composableBuilder(column: $table.stripPriceUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPriceUsd =>
      $composableBuilder(column: $table.unitPriceUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get minStockBoxes =>
      $composableBuilder(column: $table.minStockBoxes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get requiresPrescription =>
      $composableBuilder(column: $table.requiresPrescription, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$MedicinesTableAnnotationComposer extends Composer<_$AppDatabase, $MedicinesTable> {
  $$MedicinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get scientificName =>
      $composableBuilder(column: $table.scientificName, builder: (column) => column);

  GeneratedColumn<String> get manufacturer =>
      $composableBuilder(column: $table.manufacturer, builder: (column) => column);

  GeneratedColumn<String> get form => $composableBuilder(column: $table.form, builder: (column) => column);

  GeneratedColumn<String> get category => $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get barcode => $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get stripsPerBox => $composableBuilder(column: $table.stripsPerBox, builder: (column) => column);

  GeneratedColumn<int> get unitsPerStrip =>
      $composableBuilder(column: $table.unitsPerStrip, builder: (column) => column);

  GeneratedColumn<String> get boxName => $composableBuilder(column: $table.boxName, builder: (column) => column);

  GeneratedColumn<String> get stripName => $composableBuilder(column: $table.stripName, builder: (column) => column);

  GeneratedColumn<String> get unitName => $composableBuilder(column: $table.unitName, builder: (column) => column);

  GeneratedColumn<bool> get allowStripSale =>
      $composableBuilder(column: $table.allowStripSale, builder: (column) => column);

  GeneratedColumn<bool> get allowUnitSale =>
      $composableBuilder(column: $table.allowUnitSale, builder: (column) => column);

  GeneratedColumn<double> get priceUsd => $composableBuilder(column: $table.priceUsd, builder: (column) => column);

  GeneratedColumn<double> get stripPriceUsd =>
      $composableBuilder(column: $table.stripPriceUsd, builder: (column) => column);

  GeneratedColumn<double> get unitPriceUsd =>
      $composableBuilder(column: $table.unitPriceUsd, builder: (column) => column);

  GeneratedColumn<double> get minStockBoxes =>
      $composableBuilder(column: $table.minStockBoxes, builder: (column) => column);

  GeneratedColumn<bool> get requiresPrescription =>
      $composableBuilder(column: $table.requiresPrescription, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt => $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> batchesRefs<T extends Object>(Expression<T> Function($$BatchesTableAnnotationComposer a) f) {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> stockAdjustmentsRefs<T extends Object>(
    Expression<T> Function($$StockAdjustmentsTableAnnotationComposer a) f,
  ) {
    final $$StockAdjustmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAdjustments,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockAdjustmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemsRefs<T extends Object>(Expression<T> Function($$SaleItemsTableAnnotationComposer a) f) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerReturnItemsRefs<T extends Object>(
    Expression<T> Function($$CustomerReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$CustomerReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturnItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> supplierReturnItemsRefs<T extends Object>(
    Expression<T> Function($$SupplierReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$SupplierReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturnItems,
      getReferencedColumn: (t) => t.medicineId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.supplierReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MedicinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicinesTable,
          Medicine,
          $$MedicinesTableFilterComposer,
          $$MedicinesTableOrderingComposer,
          $$MedicinesTableAnnotationComposer,
          $$MedicinesTableCreateCompanionBuilder,
          $$MedicinesTableUpdateCompanionBuilder,
          (Medicine, $$MedicinesTableReferences),
          Medicine,
          PrefetchHooks Function({
            bool batchesRefs,
            bool stockAdjustmentsRefs,
            bool purchaseItemsRefs,
            bool saleItemsRefs,
            bool customerReturnItemsRefs,
            bool supplierReturnItemsRefs,
          })
        > {
  $$MedicinesTableTableManager(_$AppDatabase db, $MedicinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$MedicinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$MedicinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$MedicinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> scientificName = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> form = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int> stripsPerBox = const Value.absent(),
                Value<int> unitsPerStrip = const Value.absent(),
                Value<String> boxName = const Value.absent(),
                Value<String> stripName = const Value.absent(),
                Value<String> unitName = const Value.absent(),
                Value<bool> allowStripSale = const Value.absent(),
                Value<bool> allowUnitSale = const Value.absent(),
                Value<double> priceUsd = const Value.absent(),
                Value<double?> stripPriceUsd = const Value.absent(),
                Value<double?> unitPriceUsd = const Value.absent(),
                Value<double> minStockBoxes = const Value.absent(),
                Value<bool> requiresPrescription = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MedicinesCompanion(
                id: id,
                name: name,
                scientificName: scientificName,
                manufacturer: manufacturer,
                form: form,
                category: category,
                barcode: barcode,
                stripsPerBox: stripsPerBox,
                unitsPerStrip: unitsPerStrip,
                boxName: boxName,
                stripName: stripName,
                unitName: unitName,
                allowStripSale: allowStripSale,
                allowUnitSale: allowUnitSale,
                priceUsd: priceUsd,
                stripPriceUsd: stripPriceUsd,
                unitPriceUsd: unitPriceUsd,
                minStockBoxes: minStockBoxes,
                requiresPrescription: requiresPrescription,
                active: active,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> scientificName = const Value.absent(),
                Value<String?> manufacturer = const Value.absent(),
                Value<String?> form = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int> stripsPerBox = const Value.absent(),
                Value<int> unitsPerStrip = const Value.absent(),
                Value<String> boxName = const Value.absent(),
                Value<String> stripName = const Value.absent(),
                Value<String> unitName = const Value.absent(),
                Value<bool> allowStripSale = const Value.absent(),
                Value<bool> allowUnitSale = const Value.absent(),
                Value<double> priceUsd = const Value.absent(),
                Value<double?> stripPriceUsd = const Value.absent(),
                Value<double?> unitPriceUsd = const Value.absent(),
                Value<double> minStockBoxes = const Value.absent(),
                Value<bool> requiresPrescription = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MedicinesCompanion.insert(
                id: id,
                name: name,
                scientificName: scientificName,
                manufacturer: manufacturer,
                form: form,
                category: category,
                barcode: barcode,
                stripsPerBox: stripsPerBox,
                unitsPerStrip: unitsPerStrip,
                boxName: boxName,
                stripName: stripName,
                unitName: unitName,
                allowStripSale: allowStripSale,
                allowUnitSale: allowUnitSale,
                priceUsd: priceUsd,
                stripPriceUsd: stripPriceUsd,
                unitPriceUsd: unitPriceUsd,
                minStockBoxes: minStockBoxes,
                requiresPrescription: requiresPrescription,
                active: active,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$MedicinesTable, Medicine>(table), $$MedicinesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({
                batchesRefs = false,
                stockAdjustmentsRefs = false,
                purchaseItemsRefs = false,
                saleItemsRefs = false,
                customerReturnItemsRefs = false,
                supplierReturnItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (batchesRefs) db.batches,
                    if (stockAdjustmentsRefs) db.stockAdjustments,
                    if (purchaseItemsRefs) db.purchaseItems,
                    if (saleItemsRefs) db.saleItems,
                    if (customerReturnItemsRefs) db.customerReturnItems,
                    if (supplierReturnItemsRefs) db.supplierReturnItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (batchesRefs)
                        await $_getPrefetchedDataByColumns<Medicine, $MedicinesTable, StockBatch, $BatchesTable>(
                          currentTable: table,
                          referencedTable: $$MedicinesTableReferences._batchesRefsTable(db),
                          managerFromTypedResult: (p0) => $$MedicinesTableReferences(db, table, p0).batchesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'medicine_id',
                          typedResults: items,
                        ),
                      if (stockAdjustmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          Medicine,
                          $MedicinesTable,
                          StockAdjustment,
                          $StockAdjustmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MedicinesTableReferences._stockAdjustmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MedicinesTableReferences(db, table, p0).stockAdjustmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'medicine_id',
                          typedResults: items,
                        ),
                      if (purchaseItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Medicine,
                          $MedicinesTable,
                          PurchaseItem,
                          $PurchaseItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MedicinesTableReferences._purchaseItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $$MedicinesTableReferences(db, table, p0).purchaseItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'medicine_id',
                          typedResults: items,
                        ),
                      if (saleItemsRefs)
                        await $_getPrefetchedDataByColumns<Medicine, $MedicinesTable, SaleItem, $SaleItemsTable>(
                          currentTable: table,
                          referencedTable: $$MedicinesTableReferences._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $$MedicinesTableReferences(db, table, p0).saleItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'medicine_id',
                          typedResults: items,
                        ),
                      if (customerReturnItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Medicine,
                          $MedicinesTable,
                          CustomerReturnItem,
                          $CustomerReturnItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MedicinesTableReferences._customerReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MedicinesTableReferences(db, table, p0).customerReturnItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'medicine_id',
                          typedResults: items,
                        ),
                      if (supplierReturnItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Medicine,
                          $MedicinesTable,
                          SupplierReturnItem,
                          $SupplierReturnItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$MedicinesTableReferences._supplierReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MedicinesTableReferences(db, table, p0).supplierReturnItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'medicine_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MedicinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicinesTable,
      Medicine,
      $$MedicinesTableFilterComposer,
      $$MedicinesTableOrderingComposer,
      $$MedicinesTableAnnotationComposer,
      $$MedicinesTableCreateCompanionBuilder,
      $$MedicinesTableUpdateCompanionBuilder,
      (Medicine, $$MedicinesTableReferences),
      Medicine,
      PrefetchHooks Function({
        bool batchesRefs,
        bool stockAdjustmentsRefs,
        bool purchaseItemsRefs,
        bool saleItemsRefs,
        bool customerReturnItemsRefs,
        bool supplierReturnItemsRefs,
      })
    >;
typedef $$SuppliersTableCreateCompanionBuilder = SuppliersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> notes,
  Value<bool> active,
  Value<DateTime> createdAt,
});
typedef $$SuppliersTableUpdateCompanionBuilder = SuppliersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> address,
  Value<String?> notes,
  Value<bool> active,
  Value<DateTime> createdAt,
});

final class $$SuppliersTableReferences extends BaseReferences<_$AppDatabase, $SuppliersTable, Supplier> {
  $$SuppliersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BatchesTable, List<StockBatch>> _batchesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.batches, aliasName: 'suppliers__id__batches__supplier_id');

  $$BatchesTableProcessedTableManager get batchesRefs {
    final manager = $$BatchesTableTableManager(
      $_db,
      $_db.batches,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_batchesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierTransactionsTable, List<SupplierTransaction>> _supplierTransactionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.supplierTransactions,
    aliasName: 'suppliers__id__supplier_transactions__supplier_id',
  );

  $$SupplierTransactionsTableProcessedTableManager get supplierTransactionsRefs {
    final manager = $$SupplierTransactionsTableTableManager(
      $_db,
      $_db.supplierTransactions,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_supplierTransactionsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$PurchasesTable, List<Purchase>> _purchasesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.purchases, aliasName: 'suppliers__id__purchases__supplier_id');

  $$PurchasesTableProcessedTableManager get purchasesRefs {
    final manager = $$PurchasesTableTableManager(
      $_db,
      $_db.purchases,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchasesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierReturnsTable, List<SupplierReturn>> _supplierReturnsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.supplierReturns, aliasName: 'suppliers__id__supplier_returns__supplier_id');

  $$SupplierReturnsTableProcessedTableManager get supplierReturnsRefs {
    final manager = $$SupplierReturnsTableTableManager(
      $_db,
      $_db.supplierReturns,
    ).filter((f) => f.supplierId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_supplierReturnsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SuppliersTableFilterComposer extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> batchesRefs(Expression<bool> Function($$BatchesTableFilterComposer f) f) {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierTransactionsRefs(Expression<bool> Function($$SupplierTransactionsTableFilterComposer f) f) {
    final $$SupplierTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierTransactions,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.supplierTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> purchasesRefs(Expression<bool> Function($$PurchasesTableFilterComposer f) f) {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierReturnsRefs(Expression<bool> Function($$SupplierReturnsTableFilterComposer f) f) {
    final $$SupplierReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturns,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnsTableFilterComposer(
            $db: $db,
            $table: $db.supplierReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableOrderingComposer extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SuppliersTableAnnotationComposer extends Composer<_$AppDatabase, $SuppliersTable> {
  $$SuppliersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone => $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address => $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> batchesRefs<T extends Object>(Expression<T> Function($$BatchesTableAnnotationComposer a) f) {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> supplierTransactionsRefs<T extends Object>(
    Expression<T> Function($$SupplierTransactionsTableAnnotationComposer a) f,
  ) {
    final $$SupplierTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierTransactions,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.supplierTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> purchasesRefs<T extends Object>(Expression<T> Function($$PurchasesTableAnnotationComposer a) f) {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> supplierReturnsRefs<T extends Object>(
    Expression<T> Function($$SupplierReturnsTableAnnotationComposer a) f,
  ) {
    final $$SupplierReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturns,
      getReferencedColumn: (t) => t.supplierId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.supplierReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SuppliersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SuppliersTable,
          Supplier,
          $$SuppliersTableFilterComposer,
          $$SuppliersTableOrderingComposer,
          $$SuppliersTableAnnotationComposer,
          $$SuppliersTableCreateCompanionBuilder,
          $$SuppliersTableUpdateCompanionBuilder,
          (Supplier, $$SuppliersTableReferences),
          Supplier,
          PrefetchHooks Function({
            bool batchesRefs,
            bool supplierTransactionsRefs,
            bool purchasesRefs,
            bool supplierReturnsRefs,
          })
        > {
  $$SuppliersTableTableManager(_$AppDatabase db, $SuppliersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SuppliersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SuppliersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SuppliersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion(
                id: id,
                name: name,
                phone: phone,
                address: address,
                notes: notes,
                active: active,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SuppliersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                address: address,
                notes: notes,
                active: active,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$SuppliersTable, Supplier>(table), $$SuppliersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({
                batchesRefs = false,
                supplierTransactionsRefs = false,
                purchasesRefs = false,
                supplierReturnsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (batchesRefs) db.batches,
                    if (supplierTransactionsRefs) db.supplierTransactions,
                    if (purchasesRefs) db.purchases,
                    if (supplierReturnsRefs) db.supplierReturns,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (batchesRefs)
                        await $_getPrefetchedDataByColumns<Supplier, $SuppliersTable, StockBatch, $BatchesTable>(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences._batchesRefsTable(db),
                          managerFromTypedResult: (p0) => $$SuppliersTableReferences(db, table, p0).batchesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'supplier_id',
                          typedResults: items,
                        ),
                      if (supplierTransactionsRefs)
                        await $_getPrefetchedDataByColumns<
                          Supplier,
                          $SuppliersTable,
                          SupplierTransaction,
                          $SupplierTransactionsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences._supplierTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SuppliersTableReferences(db, table, p0).supplierTransactionsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'supplier_id',
                          typedResults: items,
                        ),
                      if (purchasesRefs)
                        await $_getPrefetchedDataByColumns<Supplier, $SuppliersTable, Purchase, $PurchasesTable>(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences._purchasesRefsTable(db),
                          managerFromTypedResult: (p0) => $$SuppliersTableReferences(db, table, p0).purchasesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'supplier_id',
                          typedResults: items,
                        ),
                      if (supplierReturnsRefs)
                        await $_getPrefetchedDataByColumns<
                          Supplier,
                          $SuppliersTable,
                          SupplierReturn,
                          $SupplierReturnsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SuppliersTableReferences._supplierReturnsRefsTable(db),
                          managerFromTypedResult: (p0) => $$SuppliersTableReferences(db, table, p0).supplierReturnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'supplier_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SuppliersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SuppliersTable,
      Supplier,
      $$SuppliersTableFilterComposer,
      $$SuppliersTableOrderingComposer,
      $$SuppliersTableAnnotationComposer,
      $$SuppliersTableCreateCompanionBuilder,
      $$SuppliersTableUpdateCompanionBuilder,
      (Supplier, $$SuppliersTableReferences),
      Supplier,
      PrefetchHooks Function({
        bool batchesRefs,
        bool supplierTransactionsRefs,
        bool purchasesRefs,
        bool supplierReturnsRefs,
      })
    >;
typedef $$BatchesTableCreateCompanionBuilder = BatchesCompanion Function({
  Value<int> id,
  required int medicineId,
  Value<String?> batchNumber,
  Value<DateTime?> expiryDate,
  required int quantity,
  required int initialQuantity,
  Value<double> costUsdPerBox,
  Value<int?> supplierId,
  Value<int?> purchaseId,
  Value<DateTime> createdAt,
});
typedef $$BatchesTableUpdateCompanionBuilder = BatchesCompanion Function({
  Value<int> id,
  Value<int> medicineId,
  Value<String?> batchNumber,
  Value<DateTime?> expiryDate,
  Value<int> quantity,
  Value<int> initialQuantity,
  Value<double> costUsdPerBox,
  Value<int?> supplierId,
  Value<int?> purchaseId,
  Value<DateTime> createdAt,
});

final class $$BatchesTableReferences extends BaseReferences<_$AppDatabase, $BatchesTable, StockBatch> {
  $$BatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias('batches__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias('batches__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager? get supplierId {
    final $_column = $_itemColumn<int>('supplier_id');
    if ($_column == null) return null;
    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StockAdjustmentsTable, List<StockAdjustment>> _stockAdjustmentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(db.stockAdjustments, aliasName: 'batches__id__stock_adjustments__batch_id');

  $$StockAdjustmentsTableProcessedTableManager get stockAdjustmentsRefs {
    final manager = $$StockAdjustmentsTableTableManager(
      $_db,
      $_db.stockAdjustments,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_stockAdjustmentsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SaleItemBatchesTable, List<SaleItemBatch>> _saleItemBatchesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.saleItemBatches, aliasName: 'batches__id__sale_item_batches__batch_id');

  $$SaleItemBatchesTableProcessedTableManager get saleItemBatchesRefs {
    final manager = $$SaleItemBatchesTableTableManager(
      $_db,
      $_db.saleItemBatches,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemBatchesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SupplierReturnItemsTable, List<SupplierReturnItem>> _supplierReturnItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(db.supplierReturnItems, aliasName: 'batches__id__supplier_return_items__batch_id');

  $$SupplierReturnItemsTableProcessedTableManager get supplierReturnItemsRefs {
    final manager = $$SupplierReturnItemsTableTableManager(
      $_db,
      $_db.supplierReturnItems,
    ).filter((f) => f.batchId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_supplierReturnItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$BatchesTableFilterComposer extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get batchNumber =>
      $composableBuilder(column: $table.batchNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate =>
      $composableBuilder(column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get initialQuantity =>
      $composableBuilder(column: $table.initialQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsdPerBox =>
      $composableBuilder(column: $table.costUsdPerBox, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get purchaseId =>
      $composableBuilder(column: $table.purchaseId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> stockAdjustmentsRefs(Expression<bool> Function($$StockAdjustmentsTableFilterComposer f) f) {
    final $$StockAdjustmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAdjustments,
      getReferencedColumn: (t) => t.batchId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockAdjustmentsTableFilterComposer(
            $db: $db,
            $table: $db.stockAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> saleItemBatchesRefs(Expression<bool> Function($$SaleItemBatchesTableFilterComposer f) f) {
    final $$SaleItemBatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItemBatches,
      getReferencedColumn: (t) => t.batchId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemBatchesTableFilterComposer(
            $db: $db,
            $table: $db.saleItemBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> supplierReturnItemsRefs(Expression<bool> Function($$SupplierReturnItemsTableFilterComposer f) f) {
    final $$SupplierReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturnItems,
      getReferencedColumn: (t) => t.batchId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.supplierReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchesTableOrderingComposer extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get batchNumber =>
      $composableBuilder(column: $table.batchNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate =>
      $composableBuilder(column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get initialQuantity =>
      $composableBuilder(column: $table.initialQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsdPerBox =>
      $composableBuilder(column: $table.costUsdPerBox, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get purchaseId =>
      $composableBuilder(column: $table.purchaseId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BatchesTableAnnotationComposer extends Composer<_$AppDatabase, $BatchesTable> {
  $$BatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get batchNumber =>
      $composableBuilder(column: $table.batchNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate =>
      $composableBuilder(column: $table.expiryDate, builder: (column) => column);

  GeneratedColumn<int> get quantity => $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get initialQuantity =>
      $composableBuilder(column: $table.initialQuantity, builder: (column) => column);

  GeneratedColumn<double> get costUsdPerBox =>
      $composableBuilder(column: $table.costUsdPerBox, builder: (column) => column);

  GeneratedColumn<int> get purchaseId => $composableBuilder(column: $table.purchaseId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> stockAdjustmentsRefs<T extends Object>(
    Expression<T> Function($$StockAdjustmentsTableAnnotationComposer a) f,
  ) {
    final $$StockAdjustmentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.stockAdjustments,
      getReferencedColumn: (t) => t.batchId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$StockAdjustmentsTableAnnotationComposer(
            $db: $db,
            $table: $db.stockAdjustments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> saleItemBatchesRefs<T extends Object>(
    Expression<T> Function($$SaleItemBatchesTableAnnotationComposer a) f,
  ) {
    final $$SaleItemBatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItemBatches,
      getReferencedColumn: (t) => t.batchId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemBatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItemBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> supplierReturnItemsRefs<T extends Object>(
    Expression<T> Function($$SupplierReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$SupplierReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturnItems,
      getReferencedColumn: (t) => t.batchId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.supplierReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BatchesTable,
          StockBatch,
          $$BatchesTableFilterComposer,
          $$BatchesTableOrderingComposer,
          $$BatchesTableAnnotationComposer,
          $$BatchesTableCreateCompanionBuilder,
          $$BatchesTableUpdateCompanionBuilder,
          (StockBatch, $$BatchesTableReferences),
          StockBatch,
          PrefetchHooks Function({
            bool medicineId,
            bool supplierId,
            bool stockAdjustmentsRefs,
            bool saleItemBatchesRefs,
            bool supplierReturnItemsRefs,
          })
        > {
  $$BatchesTableTableManager(_$AppDatabase db, $BatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$BatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$BatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$BatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<String?> batchNumber = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> initialQuantity = const Value.absent(),
                Value<double> costUsdPerBox = const Value.absent(),
                Value<int?> supplierId = const Value.absent(),
                Value<int?> purchaseId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BatchesCompanion(
                id: id,
                medicineId: medicineId,
                batchNumber: batchNumber,
                expiryDate: expiryDate,
                quantity: quantity,
                initialQuantity: initialQuantity,
                costUsdPerBox: costUsdPerBox,
                supplierId: supplierId,
                purchaseId: purchaseId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int medicineId,
                Value<String?> batchNumber = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                required int quantity,
                required int initialQuantity,
                Value<double> costUsdPerBox = const Value.absent(),
                Value<int?> supplierId = const Value.absent(),
                Value<int?> purchaseId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => BatchesCompanion.insert(
                id: id,
                medicineId: medicineId,
                batchNumber: batchNumber,
                expiryDate: expiryDate,
                quantity: quantity,
                initialQuantity: initialQuantity,
                costUsdPerBox: costUsdPerBox,
                supplierId: supplierId,
                purchaseId: purchaseId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$BatchesTable, StockBatch>(table), $$BatchesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({
                medicineId = false,
                supplierId = false,
                stockAdjustmentsRefs = false,
                saleItemBatchesRefs = false,
                supplierReturnItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (stockAdjustmentsRefs) db.stockAdjustments,
                    if (saleItemBatchesRefs) db.saleItemBatches,
                    if (supplierReturnItemsRefs) db.supplierReturnItems,
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
                        if (medicineId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.medicineId,
                            referencedTable: $$BatchesTableReferences._medicineIdTable(db),
                            referencedColumn: $$BatchesTableReferences._medicineIdTable(db).id,
                          ) as T;
                        }
                        if (supplierId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.supplierId,
                            referencedTable: $$BatchesTableReferences._supplierIdTable(db),
                            referencedColumn: $$BatchesTableReferences._supplierIdTable(db).id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (stockAdjustmentsRefs)
                        await $_getPrefetchedDataByColumns<
                          StockBatch,
                          $BatchesTable,
                          StockAdjustment,
                          $StockAdjustmentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences._stockAdjustmentsRefsTable(db),
                          managerFromTypedResult: (p0) => $$BatchesTableReferences(db, table, p0).stockAdjustmentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (saleItemBatchesRefs)
                        await $_getPrefetchedDataByColumns<
                          StockBatch,
                          $BatchesTable,
                          SaleItemBatch,
                          $SaleItemBatchesTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences._saleItemBatchesRefsTable(db),
                          managerFromTypedResult: (p0) => $$BatchesTableReferences(db, table, p0).saleItemBatchesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                      if (supplierReturnItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          StockBatch,
                          $BatchesTable,
                          SupplierReturnItem,
                          $SupplierReturnItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BatchesTableReferences._supplierReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BatchesTableReferences(db, table, p0).supplierReturnItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'batch_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BatchesTable,
      StockBatch,
      $$BatchesTableFilterComposer,
      $$BatchesTableOrderingComposer,
      $$BatchesTableAnnotationComposer,
      $$BatchesTableCreateCompanionBuilder,
      $$BatchesTableUpdateCompanionBuilder,
      (StockBatch, $$BatchesTableReferences),
      StockBatch,
      PrefetchHooks Function({
        bool medicineId,
        bool supplierId,
        bool stockAdjustmentsRefs,
        bool saleItemBatchesRefs,
        bool supplierReturnItemsRefs,
      })
    >;
typedef $$StockAdjustmentsTableCreateCompanionBuilder = StockAdjustmentsCompanion Function({
  Value<int> id,
  required int batchId,
  required int medicineId,
  required int delta,
  required String reason,
  Value<String?> note,
  Value<int?> userId,
  Value<DateTime> createdAt,
});
typedef $$StockAdjustmentsTableUpdateCompanionBuilder = StockAdjustmentsCompanion Function({
  Value<int> id,
  Value<int> batchId,
  Value<int> medicineId,
  Value<int> delta,
  Value<String> reason,
  Value<String?> note,
  Value<int?> userId,
  Value<DateTime> createdAt,
});

final class $$StockAdjustmentsTableReferences
    extends BaseReferences<_$AppDatabase, $StockAdjustmentsTable, StockAdjustment> {
  $$StockAdjustmentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('stock_adjustments__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<int>('batch_id')!;

    final manager = $$BatchesTableTableManager($_db, $_db.batches).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias('stock_adjustments__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias('stock_adjustments__user_id__users__id');

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$StockAdjustmentsTableFilterComposer extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get delta => $composableBuilder(column: $table.delta, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockAdjustmentsTableOrderingComposer extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockAdjustmentsTableAnnotationComposer extends Composer<_$AppDatabase, $StockAdjustmentsTable> {
  $$StockAdjustmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get delta => $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<String> get reason => $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StockAdjustmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StockAdjustmentsTable,
          StockAdjustment,
          $$StockAdjustmentsTableFilterComposer,
          $$StockAdjustmentsTableOrderingComposer,
          $$StockAdjustmentsTableAnnotationComposer,
          $$StockAdjustmentsTableCreateCompanionBuilder,
          $$StockAdjustmentsTableUpdateCompanionBuilder,
          (StockAdjustment, $$StockAdjustmentsTableReferences),
          StockAdjustment,
          PrefetchHooks Function({bool batchId, bool medicineId, bool userId})
        > {
  $$StockAdjustmentsTableTableManager(_$AppDatabase db, $StockAdjustmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$StockAdjustmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$StockAdjustmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$StockAdjustmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> batchId = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<int> delta = const Value.absent(),
                Value<String> reason = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockAdjustmentsCompanion(
                id: id,
                batchId: batchId,
                medicineId: medicineId,
                delta: delta,
                reason: reason,
                note: note,
                userId: userId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int batchId,
                required int medicineId,
                required int delta,
                required String reason,
                Value<String?> note = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => StockAdjustmentsCompanion.insert(
                id: id,
                batchId: batchId,
                medicineId: medicineId,
                delta: delta,
                reason: reason,
                note: note,
                userId: userId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StockAdjustmentsTable, StockAdjustment>(table),
                  $$StockAdjustmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({batchId = false, medicineId = false, userId = false}) {
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
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$StockAdjustmentsTableReferences._batchIdTable(db),
                        referencedColumn: $$StockAdjustmentsTableReferences._batchIdTable(db).id,
                      ) as T;
                    }
                    if (medicineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.medicineId,
                        referencedTable: $$StockAdjustmentsTableReferences._medicineIdTable(db),
                        referencedColumn: $$StockAdjustmentsTableReferences._medicineIdTable(db).id,
                      ) as T;
                    }
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$StockAdjustmentsTableReferences._userIdTable(db),
                        referencedColumn: $$StockAdjustmentsTableReferences._userIdTable(db).id,
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

typedef $$StockAdjustmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StockAdjustmentsTable,
      StockAdjustment,
      $$StockAdjustmentsTableFilterComposer,
      $$StockAdjustmentsTableOrderingComposer,
      $$StockAdjustmentsTableAnnotationComposer,
      $$StockAdjustmentsTableCreateCompanionBuilder,
      $$StockAdjustmentsTableUpdateCompanionBuilder,
      (StockAdjustment, $$StockAdjustmentsTableReferences),
      StockAdjustment,
      PrefetchHooks Function({bool batchId, bool medicineId, bool userId})
    >;
typedef $$SupplierTransactionsTableCreateCompanionBuilder = SupplierTransactionsCompanion Function({
  Value<int> id,
  required int supplierId,
  required String type,
  required double amountUsd,
  Value<String> currency,
  Value<double> originalAmount,
  Value<double> rate,
  Value<int?> refId,
  Value<int?> shiftId,
  Value<int?> userId,
  Value<String?> note,
  Value<DateTime> createdAt,
});
typedef $$SupplierTransactionsTableUpdateCompanionBuilder = SupplierTransactionsCompanion Function({
  Value<int> id,
  Value<int> supplierId,
  Value<String> type,
  Value<double> amountUsd,
  Value<String> currency,
  Value<double> originalAmount,
  Value<double> rate,
  Value<int?> refId,
  Value<int?> shiftId,
  Value<int?> userId,
  Value<String?> note,
  Value<DateTime> createdAt,
});

final class $$SupplierTransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $SupplierTransactionsTable, SupplierTransaction> {
  $$SupplierTransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias('supplier_transactions__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SupplierTransactionsTableFilterComposer extends Composer<_$AppDatabase, $SupplierTransactionsTable> {
  $$SupplierTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountUsd =>
      $composableBuilder(column: $table.amountUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get originalAmount =>
      $composableBuilder(column: $table.originalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get refId => $composableBuilder(column: $table.refId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierTransactionsTableOrderingComposer extends Composer<_$AppDatabase, $SupplierTransactionsTable> {
  $$SupplierTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountUsd =>
      $composableBuilder(column: $table.amountUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get originalAmount =>
      $composableBuilder(column: $table.originalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierTransactionsTableAnnotationComposer extends Composer<_$AppDatabase, $SupplierTransactionsTable> {
  $$SupplierTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type => $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amountUsd => $composableBuilder(column: $table.amountUsd, builder: (column) => column);

  GeneratedColumn<String> get currency => $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get originalAmount =>
      $composableBuilder(column: $table.originalAmount, builder: (column) => column);

  GeneratedColumn<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<int> get refId => $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<int> get shiftId => $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<int> get userId => $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierTransactionsTable,
          SupplierTransaction,
          $$SupplierTransactionsTableFilterComposer,
          $$SupplierTransactionsTableOrderingComposer,
          $$SupplierTransactionsTableAnnotationComposer,
          $$SupplierTransactionsTableCreateCompanionBuilder,
          $$SupplierTransactionsTableUpdateCompanionBuilder,
          (SupplierTransaction, $$SupplierTransactionsTableReferences),
          SupplierTransaction,
          PrefetchHooks Function({bool supplierId})
        > {
  $$SupplierTransactionsTableTableManager(_$AppDatabase db, $SupplierTransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SupplierTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SupplierTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SupplierTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amountUsd = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> originalAmount = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SupplierTransactionsCompanion(
                id: id,
                supplierId: supplierId,
                type: type,
                amountUsd: amountUsd,
                currency: currency,
                originalAmount: originalAmount,
                rate: rate,
                refId: refId,
                shiftId: shiftId,
                userId: userId,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                required String type,
                required double amountUsd,
                Value<String> currency = const Value.absent(),
                Value<double> originalAmount = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SupplierTransactionsCompanion.insert(
                id: id,
                supplierId: supplierId,
                type: type,
                amountUsd: amountUsd,
                currency: currency,
                originalAmount: originalAmount,
                rate: rate,
                refId: refId,
                shiftId: shiftId,
                userId: userId,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SupplierTransactionsTable, SupplierTransaction>(table),
                  $$SupplierTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({supplierId = false}) {
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
                    if (supplierId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.supplierId,
                        referencedTable: $$SupplierTransactionsTableReferences._supplierIdTable(db),
                        referencedColumn: $$SupplierTransactionsTableReferences._supplierIdTable(db).id,
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

typedef $$SupplierTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierTransactionsTable,
      SupplierTransaction,
      $$SupplierTransactionsTableFilterComposer,
      $$SupplierTransactionsTableOrderingComposer,
      $$SupplierTransactionsTableAnnotationComposer,
      $$SupplierTransactionsTableCreateCompanionBuilder,
      $$SupplierTransactionsTableUpdateCompanionBuilder,
      (SupplierTransaction, $$SupplierTransactionsTableReferences),
      SupplierTransaction,
      PrefetchHooks Function({bool supplierId})
    >;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  required String name,
  Value<String?> phone,
  Value<String?> notes,
  Value<double?> creditLimitUsd,
  Value<bool> active,
  Value<DateTime> createdAt,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String?> phone,
  Value<String?> notes,
  Value<double?> creditLimitUsd,
  Value<bool> active,
  Value<DateTime> createdAt,
});

final class $$CustomersTableReferences extends BaseReferences<_$AppDatabase, $CustomersTable, Customer> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CustomerTransactionsTable, List<CustomerTransaction>> _customerTransactionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.customerTransactions,
    aliasName: 'customers__id__customer_transactions__customer_id',
  );

  $$CustomerTransactionsTableProcessedTableManager get customerTransactionsRefs {
    final manager = $$CustomerTransactionsTableTableManager(
      $_db,
      $_db.customerTransactions,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerTransactionsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomersTableFilterComposer extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get creditLimitUsd =>
      $composableBuilder(column: $table.creditLimitUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> customerTransactionsRefs(Expression<bool> Function($$CustomerTransactionsTableFilterComposer f) f) {
    final $$CustomerTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerTransactions,
      getReferencedColumn: (t) => t.customerId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.customerTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get creditLimitUsd =>
      $composableBuilder(column: $table.creditLimitUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get active =>
      $composableBuilder(column: $table.active, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$CustomersTableAnnotationComposer extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone => $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get creditLimitUsd =>
      $composableBuilder(column: $table.creditLimitUsd, builder: (column) => column);

  GeneratedColumn<bool> get active => $composableBuilder(column: $table.active, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> customerTransactionsRefs<T extends Object>(
    Expression<T> Function($$CustomerTransactionsTableAnnotationComposer a) f,
  ) {
    final $$CustomerTransactionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerTransactions,
      getReferencedColumn: (t) => t.customerId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerTransactionsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          Customer,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (Customer, $$CustomersTableReferences),
          Customer,
          PrefetchHooks Function({bool customerTransactionsRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> creditLimitUsd = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                name: name,
                phone: phone,
                notes: notes,
                creditLimitUsd: creditLimitUsd,
                active: active,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<double?> creditLimitUsd = const Value.absent(),
                Value<bool> active = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                name: name,
                phone: phone,
                notes: notes,
                creditLimitUsd: creditLimitUsd,
                active: active,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$CustomersTable, Customer>(table), $$CustomersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({customerTransactionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (customerTransactionsRefs) db.customerTransactions],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (customerTransactionsRefs)
                    await $_getPrefetchedDataByColumns<
                      Customer,
                      $CustomersTable,
                      CustomerTransaction,
                      $CustomerTransactionsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences._customerTransactionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(db, table, p0).customerTransactionsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'customer_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      Customer,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (Customer, $$CustomersTableReferences),
      Customer,
      PrefetchHooks Function({bool customerTransactionsRefs})
    >;
typedef $$CustomerTransactionsTableCreateCompanionBuilder = CustomerTransactionsCompanion Function({
  Value<int> id,
  required int customerId,
  required String type,
  required double amountUsd,
  Value<String> currency,
  Value<double> originalAmount,
  Value<double> rate,
  Value<int?> refId,
  Value<int?> shiftId,
  Value<int?> userId,
  Value<String?> note,
  Value<DateTime> createdAt,
});
typedef $$CustomerTransactionsTableUpdateCompanionBuilder = CustomerTransactionsCompanion Function({
  Value<int> id,
  Value<int> customerId,
  Value<String> type,
  Value<double> amountUsd,
  Value<String> currency,
  Value<double> originalAmount,
  Value<double> rate,
  Value<int?> refId,
  Value<int?> shiftId,
  Value<int?> userId,
  Value<String?> note,
  Value<DateTime> createdAt,
});

final class $$CustomerTransactionsTableReferences
    extends BaseReferences<_$AppDatabase, $CustomerTransactionsTable, CustomerTransaction> {
  $$CustomerTransactionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('customer_transactions__customer_id__customers__id');

  $$CustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<int>('customer_id')!;

    final manager = $$CustomersTableTableManager($_db, $_db.customers).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CustomerTransactionsTableFilterComposer extends Composer<_$AppDatabase, $CustomerTransactionsTable> {
  $$CustomerTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountUsd =>
      $composableBuilder(column: $table.amountUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get originalAmount =>
      $composableBuilder(column: $table.originalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get refId => $composableBuilder(column: $table.refId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerTransactionsTableOrderingComposer extends Composer<_$AppDatabase, $CustomerTransactionsTable> {
  $$CustomerTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountUsd =>
      $composableBuilder(column: $table.amountUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get originalAmount =>
      $composableBuilder(column: $table.originalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get shiftId =>
      $composableBuilder(column: $table.shiftId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerTransactionsTableAnnotationComposer extends Composer<_$AppDatabase, $CustomerTransactionsTable> {
  $$CustomerTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type => $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get amountUsd => $composableBuilder(column: $table.amountUsd, builder: (column) => column);

  GeneratedColumn<String> get currency => $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get originalAmount =>
      $composableBuilder(column: $table.originalAmount, builder: (column) => column);

  GeneratedColumn<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<int> get refId => $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<int> get shiftId => $composableBuilder(column: $table.shiftId, builder: (column) => column);

  GeneratedColumn<int> get userId => $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerTransactionsTable,
          CustomerTransaction,
          $$CustomerTransactionsTableFilterComposer,
          $$CustomerTransactionsTableOrderingComposer,
          $$CustomerTransactionsTableAnnotationComposer,
          $$CustomerTransactionsTableCreateCompanionBuilder,
          $$CustomerTransactionsTableUpdateCompanionBuilder,
          (CustomerTransaction, $$CustomerTransactionsTableReferences),
          CustomerTransaction,
          PrefetchHooks Function({bool customerId})
        > {
  $$CustomerTransactionsTableTableManager(_$AppDatabase db, $CustomerTransactionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CustomerTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CustomerTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CustomerTransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> customerId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<double> amountUsd = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> originalAmount = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerTransactionsCompanion(
                id: id,
                customerId: customerId,
                type: type,
                amountUsd: amountUsd,
                currency: currency,
                originalAmount: originalAmount,
                rate: rate,
                refId: refId,
                shiftId: shiftId,
                userId: userId,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int customerId,
                required String type,
                required double amountUsd,
                Value<String> currency = const Value.absent(),
                Value<double> originalAmount = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<int?> shiftId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CustomerTransactionsCompanion.insert(
                id: id,
                customerId: customerId,
                type: type,
                amountUsd: amountUsd,
                currency: currency,
                originalAmount: originalAmount,
                rate: rate,
                refId: refId,
                shiftId: shiftId,
                userId: userId,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomerTransactionsTable, CustomerTransaction>(table),
                  $$CustomerTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({customerId = false}) {
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
                    if (customerId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.customerId,
                        referencedTable: $$CustomerTransactionsTableReferences._customerIdTable(db),
                        referencedColumn: $$CustomerTransactionsTableReferences._customerIdTable(db).id,
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

typedef $$CustomerTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerTransactionsTable,
      CustomerTransaction,
      $$CustomerTransactionsTableFilterComposer,
      $$CustomerTransactionsTableOrderingComposer,
      $$CustomerTransactionsTableAnnotationComposer,
      $$CustomerTransactionsTableCreateCompanionBuilder,
      $$CustomerTransactionsTableUpdateCompanionBuilder,
      (CustomerTransaction, $$CustomerTransactionsTableReferences),
      CustomerTransaction,
      PrefetchHooks Function({bool customerId})
    >;
typedef $$PurchasesTableCreateCompanionBuilder = PurchasesCompanion Function({
  Value<int> id,
  required int supplierId,
  Value<String?> invoiceNumber,
  required DateTime invoiceDate,
  required double totalUsd,
  Value<double> discountUsd,
  Value<double> paidUsd,
  Value<String?> notes,
  Value<int?> userId,
  Value<DateTime> createdAt,
});
typedef $$PurchasesTableUpdateCompanionBuilder = PurchasesCompanion Function({
  Value<int> id,
  Value<int> supplierId,
  Value<String?> invoiceNumber,
  Value<DateTime> invoiceDate,
  Value<double> totalUsd,
  Value<double> discountUsd,
  Value<double> paidUsd,
  Value<String?> notes,
  Value<int?> userId,
  Value<DateTime> createdAt,
});

final class $$PurchasesTableReferences extends BaseReferences<_$AppDatabase, $PurchasesTable, Purchase> {
  $$PurchasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias('purchases__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$PurchaseItemsTable, List<PurchaseItem>> _purchaseItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.purchaseItems, aliasName: 'purchases__id__purchase_items__purchase_id');

  $$PurchaseItemsTableProcessedTableManager get purchaseItemsRefs {
    final manager = $$PurchaseItemsTableTableManager(
      $_db,
      $_db.purchaseItems,
    ).filter((f) => f.purchaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_purchaseItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$PurchasesTableFilterComposer extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get invoiceNumber =>
      $composableBuilder(column: $table.invoiceNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get invoiceDate =>
      $composableBuilder(column: $table.invoiceDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountUsd =>
      $composableBuilder(column: $table.discountUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get paidUsd =>
      $composableBuilder(column: $table.paidUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> purchaseItemsRefs(Expression<bool> Function($$PurchaseItemsTableFilterComposer f) f) {
    final $$PurchaseItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchaseItemsTableFilterComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableOrderingComposer extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get invoiceNumber =>
      $composableBuilder(column: $table.invoiceNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get invoiceDate =>
      $composableBuilder(column: $table.invoiceDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountUsd =>
      $composableBuilder(column: $table.discountUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get paidUsd =>
      $composableBuilder(column: $table.paidUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchasesTableAnnotationComposer extends Composer<_$AppDatabase, $PurchasesTable> {
  $$PurchasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get invoiceNumber =>
      $composableBuilder(column: $table.invoiceNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get invoiceDate =>
      $composableBuilder(column: $table.invoiceDate, builder: (column) => column);

  GeneratedColumn<double> get totalUsd => $composableBuilder(column: $table.totalUsd, builder: (column) => column);

  GeneratedColumn<double> get discountUsd =>
      $composableBuilder(column: $table.discountUsd, builder: (column) => column);

  GeneratedColumn<double> get paidUsd => $composableBuilder(column: $table.paidUsd, builder: (column) => column);

  GeneratedColumn<String> get notes => $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get userId => $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> purchaseItemsRefs<T extends Object>(
    Expression<T> Function($$PurchaseItemsTableAnnotationComposer a) f,
  ) {
    final $$PurchaseItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.purchaseItems,
      getReferencedColumn: (t) => t.purchaseId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchaseItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.purchaseItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PurchasesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchasesTable,
          Purchase,
          $$PurchasesTableFilterComposer,
          $$PurchasesTableOrderingComposer,
          $$PurchasesTableAnnotationComposer,
          $$PurchasesTableCreateCompanionBuilder,
          $$PurchasesTableUpdateCompanionBuilder,
          (Purchase, $$PurchasesTableReferences),
          Purchase,
          PrefetchHooks Function({bool supplierId, bool purchaseItemsRefs})
        > {
  $$PurchasesTableTableManager(_$AppDatabase db, $PurchasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PurchasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PurchasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PurchasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<String?> invoiceNumber = const Value.absent(),
                Value<DateTime> invoiceDate = const Value.absent(),
                Value<double> totalUsd = const Value.absent(),
                Value<double> discountUsd = const Value.absent(),
                Value<double> paidUsd = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesCompanion(
                id: id,
                supplierId: supplierId,
                invoiceNumber: invoiceNumber,
                invoiceDate: invoiceDate,
                totalUsd: totalUsd,
                discountUsd: discountUsd,
                paidUsd: paidUsd,
                notes: notes,
                userId: userId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                Value<String?> invoiceNumber = const Value.absent(),
                required DateTime invoiceDate,
                required double totalUsd,
                Value<double> discountUsd = const Value.absent(),
                Value<double> paidUsd = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PurchasesCompanion.insert(
                id: id,
                supplierId: supplierId,
                invoiceNumber: invoiceNumber,
                invoiceDate: invoiceDate,
                totalUsd: totalUsd,
                discountUsd: discountUsd,
                paidUsd: paidUsd,
                notes: notes,
                userId: userId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$PurchasesTable, Purchase>(table), $$PurchasesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({supplierId = false, purchaseItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (purchaseItemsRefs) db.purchaseItems],
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
                    if (supplierId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.supplierId,
                        referencedTable: $$PurchasesTableReferences._supplierIdTable(db),
                        referencedColumn: $$PurchasesTableReferences._supplierIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (purchaseItemsRefs)
                    await $_getPrefetchedDataByColumns<Purchase, $PurchasesTable, PurchaseItem, $PurchaseItemsTable>(
                      currentTable: table,
                      referencedTable: $$PurchasesTableReferences._purchaseItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$PurchasesTableReferences(db, table, p0).purchaseItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'purchase_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PurchasesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchasesTable,
      Purchase,
      $$PurchasesTableFilterComposer,
      $$PurchasesTableOrderingComposer,
      $$PurchasesTableAnnotationComposer,
      $$PurchasesTableCreateCompanionBuilder,
      $$PurchasesTableUpdateCompanionBuilder,
      (Purchase, $$PurchasesTableReferences),
      Purchase,
      PrefetchHooks Function({bool supplierId, bool purchaseItemsRefs})
    >;
typedef $$PurchaseItemsTableCreateCompanionBuilder = PurchaseItemsCompanion Function({
  Value<int> id,
  required int purchaseId,
  required int medicineId,
  Value<int?> batchId,
  required int quantityBoxes,
  Value<int> bonusBoxes,
  required double costUsdPerBox,
  Value<String?> batchNumber,
  Value<DateTime?> expiryDate,
  required double totalUsd,
});
typedef $$PurchaseItemsTableUpdateCompanionBuilder = PurchaseItemsCompanion Function({
  Value<int> id,
  Value<int> purchaseId,
  Value<int> medicineId,
  Value<int?> batchId,
  Value<int> quantityBoxes,
  Value<int> bonusBoxes,
  Value<double> costUsdPerBox,
  Value<String?> batchNumber,
  Value<DateTime?> expiryDate,
  Value<double> totalUsd,
});

final class $$PurchaseItemsTableReferences extends BaseReferences<_$AppDatabase, $PurchaseItemsTable, PurchaseItem> {
  $$PurchaseItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PurchasesTable _purchaseIdTable(_$AppDatabase db) =>
      db.purchases.createAlias('purchase_items__purchase_id__purchases__id');

  $$PurchasesTableProcessedTableManager get purchaseId {
    final $_column = $_itemColumn<int>('purchase_id')!;

    final manager = $$PurchasesTableTableManager($_db, $_db.purchases).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_purchaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias('purchase_items__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$PurchaseItemsTableFilterComposer extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get batchId =>
      $composableBuilder(column: $table.batchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantityBoxes =>
      $composableBuilder(column: $table.quantityBoxes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get bonusBoxes =>
      $composableBuilder(column: $table.bonusBoxes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsdPerBox =>
      $composableBuilder(column: $table.costUsdPerBox, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get batchNumber =>
      $composableBuilder(column: $table.batchNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate =>
      $composableBuilder(column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnFilters(column));

  $$PurchasesTableFilterComposer get purchaseId {
    final $$PurchasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchasesTableFilterComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableOrderingComposer extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get batchId =>
      $composableBuilder(column: $table.batchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantityBoxes =>
      $composableBuilder(column: $table.quantityBoxes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get bonusBoxes =>
      $composableBuilder(column: $table.bonusBoxes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsdPerBox =>
      $composableBuilder(column: $table.costUsdPerBox, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get batchNumber =>
      $composableBuilder(column: $table.batchNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate =>
      $composableBuilder(column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnOrderings(column));

  $$PurchasesTableOrderingComposer get purchaseId {
    final $$PurchasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchasesTableOrderingComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableAnnotationComposer extends Composer<_$AppDatabase, $PurchaseItemsTable> {
  $$PurchaseItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get batchId => $composableBuilder(column: $table.batchId, builder: (column) => column);

  GeneratedColumn<int> get quantityBoxes =>
      $composableBuilder(column: $table.quantityBoxes, builder: (column) => column);

  GeneratedColumn<int> get bonusBoxes => $composableBuilder(column: $table.bonusBoxes, builder: (column) => column);

  GeneratedColumn<double> get costUsdPerBox =>
      $composableBuilder(column: $table.costUsdPerBox, builder: (column) => column);

  GeneratedColumn<String> get batchNumber =>
      $composableBuilder(column: $table.batchNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate =>
      $composableBuilder(column: $table.expiryDate, builder: (column) => column);

  GeneratedColumn<double> get totalUsd => $composableBuilder(column: $table.totalUsd, builder: (column) => column);

  $$PurchasesTableAnnotationComposer get purchaseId {
    final $$PurchasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.purchaseId,
      referencedTable: $db.purchases,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$PurchasesTableAnnotationComposer(
            $db: $db,
            $table: $db.purchases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PurchaseItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PurchaseItemsTable,
          PurchaseItem,
          $$PurchaseItemsTableFilterComposer,
          $$PurchaseItemsTableOrderingComposer,
          $$PurchaseItemsTableAnnotationComposer,
          $$PurchaseItemsTableCreateCompanionBuilder,
          $$PurchaseItemsTableUpdateCompanionBuilder,
          (PurchaseItem, $$PurchaseItemsTableReferences),
          PurchaseItem,
          PrefetchHooks Function({bool purchaseId, bool medicineId})
        > {
  $$PurchaseItemsTableTableManager(_$AppDatabase db, $PurchaseItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$PurchaseItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$PurchaseItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$PurchaseItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> purchaseId = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<int?> batchId = const Value.absent(),
                Value<int> quantityBoxes = const Value.absent(),
                Value<int> bonusBoxes = const Value.absent(),
                Value<double> costUsdPerBox = const Value.absent(),
                Value<String?> batchNumber = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                Value<double> totalUsd = const Value.absent(),
              }) => PurchaseItemsCompanion(
                id: id,
                purchaseId: purchaseId,
                medicineId: medicineId,
                batchId: batchId,
                quantityBoxes: quantityBoxes,
                bonusBoxes: bonusBoxes,
                costUsdPerBox: costUsdPerBox,
                batchNumber: batchNumber,
                expiryDate: expiryDate,
                totalUsd: totalUsd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int purchaseId,
                required int medicineId,
                Value<int?> batchId = const Value.absent(),
                required int quantityBoxes,
                Value<int> bonusBoxes = const Value.absent(),
                required double costUsdPerBox,
                Value<String?> batchNumber = const Value.absent(),
                Value<DateTime?> expiryDate = const Value.absent(),
                required double totalUsd,
              }) => PurchaseItemsCompanion.insert(
                id: id,
                purchaseId: purchaseId,
                medicineId: medicineId,
                batchId: batchId,
                quantityBoxes: quantityBoxes,
                bonusBoxes: bonusBoxes,
                costUsdPerBox: costUsdPerBox,
                batchNumber: batchNumber,
                expiryDate: expiryDate,
                totalUsd: totalUsd,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PurchaseItemsTable, PurchaseItem>(table),
                  $$PurchaseItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({purchaseId = false, medicineId = false}) {
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
                    if (purchaseId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.purchaseId,
                        referencedTable: $$PurchaseItemsTableReferences._purchaseIdTable(db),
                        referencedColumn: $$PurchaseItemsTableReferences._purchaseIdTable(db).id,
                      ) as T;
                    }
                    if (medicineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.medicineId,
                        referencedTable: $$PurchaseItemsTableReferences._medicineIdTable(db),
                        referencedColumn: $$PurchaseItemsTableReferences._medicineIdTable(db).id,
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

typedef $$PurchaseItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PurchaseItemsTable,
      PurchaseItem,
      $$PurchaseItemsTableFilterComposer,
      $$PurchaseItemsTableOrderingComposer,
      $$PurchaseItemsTableAnnotationComposer,
      $$PurchaseItemsTableCreateCompanionBuilder,
      $$PurchaseItemsTableUpdateCompanionBuilder,
      (PurchaseItem, $$PurchaseItemsTableReferences),
      PurchaseItem,
      PrefetchHooks Function({bool purchaseId, bool medicineId})
    >;
typedef $$ShiftsTableCreateCompanionBuilder = ShiftsCompanion Function({
  Value<int> id,
  required int userId,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<double> openingSyp,
  Value<double> openingUsd,
  Value<double?> expectedSyp,
  Value<double?> expectedUsd,
  Value<double?> actualSyp,
  Value<double?> actualUsd,
  Value<double?> diffSyp,
  Value<double?> diffUsd,
  Value<int?> receivedById,
  Value<String?> note,
  Value<String> status,
});
typedef $$ShiftsTableUpdateCompanionBuilder = ShiftsCompanion Function({
  Value<int> id,
  Value<int> userId,
  Value<DateTime> openedAt,
  Value<DateTime?> closedAt,
  Value<double> openingSyp,
  Value<double> openingUsd,
  Value<double?> expectedSyp,
  Value<double?> expectedUsd,
  Value<double?> actualSyp,
  Value<double?> actualUsd,
  Value<double?> diffSyp,
  Value<double?> diffUsd,
  Value<int?> receivedById,
  Value<String?> note,
  Value<String> status,
});

final class $$ShiftsTableReferences extends BaseReferences<_$AppDatabase, $ShiftsTable, Shift> {
  $$ShiftsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias('shifts__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CashMovementsTable, List<CashMovement>> _cashMovementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.cashMovements, aliasName: 'shifts__id__cash_movements__shift_id');

  $$CashMovementsTableProcessedTableManager get cashMovementsRefs {
    final manager = $$CashMovementsTableTableManager(
      $_db,
      $_db.cashMovements,
    ).filter((f) => f.shiftId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_cashMovementsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SalesTable, List<Sale>> _salesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sales, aliasName: 'shifts__id__sales__shift_id');

  $$SalesTableProcessedTableManager get salesRefs {
    final manager = $$SalesTableTableManager(
      $_db,
      $_db.sales,
    ).filter((f) => f.shiftId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_salesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CustomerReturnsTable, List<CustomerReturn>> _customerReturnsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.customerReturns, aliasName: 'shifts__id__customer_returns__shift_id');

  $$CustomerReturnsTableProcessedTableManager get customerReturnsRefs {
    final manager = $$CustomerReturnsTableTableManager(
      $_db,
      $_db.customerReturns,
    ).filter((f) => f.shiftId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerReturnsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ShiftsTableFilterComposer extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingSyp =>
      $composableBuilder(column: $table.openingSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get openingUsd =>
      $composableBuilder(column: $table.openingUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get expectedSyp =>
      $composableBuilder(column: $table.expectedSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get expectedUsd =>
      $composableBuilder(column: $table.expectedUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualSyp =>
      $composableBuilder(column: $table.actualSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get actualUsd =>
      $composableBuilder(column: $table.actualUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get diffSyp =>
      $composableBuilder(column: $table.diffSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get diffUsd =>
      $composableBuilder(column: $table.diffUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get receivedById =>
      $composableBuilder(column: $table.receivedById, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> cashMovementsRefs(Expression<bool> Function($$CashMovementsTableFilterComposer f) f) {
    final $$CashMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashMovements,
      getReferencedColumn: (t) => t.shiftId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CashMovementsTableFilterComposer(
            $db: $db,
            $table: $db.cashMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> salesRefs(Expression<bool> Function($$SalesTableFilterComposer f) f) {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.shiftId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerReturnsRefs(Expression<bool> Function($$CustomerReturnsTableFilterComposer f) f) {
    final $$CustomerReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.shiftId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftsTableOrderingComposer extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openedAt =>
      $composableBuilder(column: $table.openedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closedAt =>
      $composableBuilder(column: $table.closedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingSyp =>
      $composableBuilder(column: $table.openingSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get openingUsd =>
      $composableBuilder(column: $table.openingUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get expectedSyp =>
      $composableBuilder(column: $table.expectedSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get expectedUsd =>
      $composableBuilder(column: $table.expectedUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualSyp =>
      $composableBuilder(column: $table.actualSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get actualUsd =>
      $composableBuilder(column: $table.actualUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get diffSyp =>
      $composableBuilder(column: $table.diffSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get diffUsd =>
      $composableBuilder(column: $table.diffUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get receivedById =>
      $composableBuilder(column: $table.receivedById, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ShiftsTableAnnotationComposer extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get openedAt => $composableBuilder(column: $table.openedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get closedAt => $composableBuilder(column: $table.closedAt, builder: (column) => column);

  GeneratedColumn<double> get openingSyp => $composableBuilder(column: $table.openingSyp, builder: (column) => column);

  GeneratedColumn<double> get openingUsd => $composableBuilder(column: $table.openingUsd, builder: (column) => column);

  GeneratedColumn<double> get expectedSyp =>
      $composableBuilder(column: $table.expectedSyp, builder: (column) => column);

  GeneratedColumn<double> get expectedUsd =>
      $composableBuilder(column: $table.expectedUsd, builder: (column) => column);

  GeneratedColumn<double> get actualSyp => $composableBuilder(column: $table.actualSyp, builder: (column) => column);

  GeneratedColumn<double> get actualUsd => $composableBuilder(column: $table.actualUsd, builder: (column) => column);

  GeneratedColumn<double> get diffSyp => $composableBuilder(column: $table.diffSyp, builder: (column) => column);

  GeneratedColumn<double> get diffUsd => $composableBuilder(column: $table.diffUsd, builder: (column) => column);

  GeneratedColumn<int> get receivedById => $composableBuilder(column: $table.receivedById, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> cashMovementsRefs<T extends Object>(
    Expression<T> Function($$CashMovementsTableAnnotationComposer a) f,
  ) {
    final $$CashMovementsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cashMovements,
      getReferencedColumn: (t) => t.shiftId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CashMovementsTableAnnotationComposer(
            $db: $db,
            $table: $db.cashMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> salesRefs<T extends Object>(Expression<T> Function($$SalesTableAnnotationComposer a) f) {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.shiftId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerReturnsRefs<T extends Object>(
    Expression<T> Function($$CustomerReturnsTableAnnotationComposer a) f,
  ) {
    final $$CustomerReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.shiftId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ShiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftsTable,
          Shift,
          $$ShiftsTableFilterComposer,
          $$ShiftsTableOrderingComposer,
          $$ShiftsTableAnnotationComposer,
          $$ShiftsTableCreateCompanionBuilder,
          $$ShiftsTableUpdateCompanionBuilder,
          (Shift, $$ShiftsTableReferences),
          Shift,
          PrefetchHooks Function({bool userId, bool cashMovementsRefs, bool salesRefs, bool customerReturnsRefs})
        > {
  $$ShiftsTableTableManager(_$AppDatabase db, $ShiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$ShiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$ShiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$ShiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> openedAt = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<double> openingSyp = const Value.absent(),
                Value<double> openingUsd = const Value.absent(),
                Value<double?> expectedSyp = const Value.absent(),
                Value<double?> expectedUsd = const Value.absent(),
                Value<double?> actualSyp = const Value.absent(),
                Value<double?> actualUsd = const Value.absent(),
                Value<double?> diffSyp = const Value.absent(),
                Value<double?> diffUsd = const Value.absent(),
                Value<int?> receivedById = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => ShiftsCompanion(
                id: id,
                userId: userId,
                openedAt: openedAt,
                closedAt: closedAt,
                openingSyp: openingSyp,
                openingUsd: openingUsd,
                expectedSyp: expectedSyp,
                expectedUsd: expectedUsd,
                actualSyp: actualSyp,
                actualUsd: actualUsd,
                diffSyp: diffSyp,
                diffUsd: diffUsd,
                receivedById: receivedById,
                note: note,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                Value<DateTime> openedAt = const Value.absent(),
                Value<DateTime?> closedAt = const Value.absent(),
                Value<double> openingSyp = const Value.absent(),
                Value<double> openingUsd = const Value.absent(),
                Value<double?> expectedSyp = const Value.absent(),
                Value<double?> expectedUsd = const Value.absent(),
                Value<double?> actualSyp = const Value.absent(),
                Value<double?> actualUsd = const Value.absent(),
                Value<double?> diffSyp = const Value.absent(),
                Value<double?> diffUsd = const Value.absent(),
                Value<int?> receivedById = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String> status = const Value.absent(),
              }) => ShiftsCompanion.insert(
                id: id,
                userId: userId,
                openedAt: openedAt,
                closedAt: closedAt,
                openingSyp: openingSyp,
                openingUsd: openingUsd,
                expectedSyp: expectedSyp,
                expectedUsd: expectedUsd,
                actualSyp: actualSyp,
                actualUsd: actualUsd,
                diffSyp: diffSyp,
                diffUsd: diffUsd,
                receivedById: receivedById,
                note: note,
                status: status,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable<$ShiftsTable, Shift>(table), $$ShiftsTableReferences(db, table, e))).toList(),
          prefetchHooksCallback:
              ({userId = false, cashMovementsRefs = false, salesRefs = false, customerReturnsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (cashMovementsRefs) db.cashMovements,
                    if (salesRefs) db.sales,
                    if (customerReturnsRefs) db.customerReturns,
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
                        if (userId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$ShiftsTableReferences._userIdTable(db),
                            referencedColumn: $$ShiftsTableReferences._userIdTable(db).id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (cashMovementsRefs)
                        await $_getPrefetchedDataByColumns<Shift, $ShiftsTable, CashMovement, $CashMovementsTable>(
                          currentTable: table,
                          referencedTable: $$ShiftsTableReferences._cashMovementsRefsTable(db),
                          managerFromTypedResult: (p0) => $$ShiftsTableReferences(db, table, p0).cashMovementsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'shift_id',
                          typedResults: items,
                        ),
                      if (salesRefs)
                        await $_getPrefetchedDataByColumns<Shift, $ShiftsTable, Sale, $SalesTable>(
                          currentTable: table,
                          referencedTable: $$ShiftsTableReferences._salesRefsTable(db),
                          managerFromTypedResult: (p0) => $$ShiftsTableReferences(db, table, p0).salesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'shift_id',
                          typedResults: items,
                        ),
                      if (customerReturnsRefs)
                        await $_getPrefetchedDataByColumns<Shift, $ShiftsTable, CustomerReturn, $CustomerReturnsTable>(
                          currentTable: table,
                          referencedTable: $$ShiftsTableReferences._customerReturnsRefsTable(db),
                          managerFromTypedResult: (p0) => $$ShiftsTableReferences(db, table, p0).customerReturnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'shift_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ShiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftsTable,
      Shift,
      $$ShiftsTableFilterComposer,
      $$ShiftsTableOrderingComposer,
      $$ShiftsTableAnnotationComposer,
      $$ShiftsTableCreateCompanionBuilder,
      $$ShiftsTableUpdateCompanionBuilder,
      (Shift, $$ShiftsTableReferences),
      Shift,
      PrefetchHooks Function({bool userId, bool cashMovementsRefs, bool salesRefs, bool customerReturnsRefs})
    >;
typedef $$CashMovementsTableCreateCompanionBuilder = CashMovementsCompanion Function({
  Value<int> id,
  required int shiftId,
  Value<int?> userId,
  required String type,
  required String currency,
  required double amount,
  Value<int?> refId,
  Value<String?> note,
  Value<DateTime> createdAt,
});
typedef $$CashMovementsTableUpdateCompanionBuilder = CashMovementsCompanion Function({
  Value<int> id,
  Value<int> shiftId,
  Value<int?> userId,
  Value<String> type,
  Value<String> currency,
  Value<double> amount,
  Value<int?> refId,
  Value<String?> note,
  Value<DateTime> createdAt,
});

final class $$CashMovementsTableReferences extends BaseReferences<_$AppDatabase, $CashMovementsTable, CashMovement> {
  $$CashMovementsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShiftsTable _shiftIdTable(_$AppDatabase db) => db.shifts.createAlias('cash_movements__shift_id__shifts__id');

  $$ShiftsTableProcessedTableManager get shiftId {
    final $_column = $_itemColumn<int>('shift_id')!;

    final manager = $$ShiftsTableTableManager($_db, $_db.shifts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shiftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CashMovementsTableFilterComposer extends Composer<_$AppDatabase, $CashMovementsTable> {
  $$CashMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get refId => $composableBuilder(column: $table.refId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ShiftsTableFilterComposer get shiftId {
    final $$ShiftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableFilterComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashMovementsTableOrderingComposer extends Composer<_$AppDatabase, $CashMovementsTable> {
  $$CashMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ShiftsTableOrderingComposer get shiftId {
    final $$ShiftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableOrderingComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashMovementsTableAnnotationComposer extends Composer<_$AppDatabase, $CashMovementsTable> {
  $$CashMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId => $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get type => $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get currency => $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get amount => $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get refId => $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ShiftsTableAnnotationComposer get shiftId {
    final $$ShiftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableAnnotationComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CashMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CashMovementsTable,
          CashMovement,
          $$CashMovementsTableFilterComposer,
          $$CashMovementsTableOrderingComposer,
          $$CashMovementsTableAnnotationComposer,
          $$CashMovementsTableCreateCompanionBuilder,
          $$CashMovementsTableUpdateCompanionBuilder,
          (CashMovement, $$CashMovementsTableReferences),
          CashMovement,
          PrefetchHooks Function({bool shiftId})
        > {
  $$CashMovementsTableTableManager(_$AppDatabase db, $CashMovementsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CashMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CashMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CashMovementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> shiftId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<int?> refId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CashMovementsCompanion(
                id: id,
                shiftId: shiftId,
                userId: userId,
                type: type,
                currency: currency,
                amount: amount,
                refId: refId,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int shiftId,
                Value<int?> userId = const Value.absent(),
                required String type,
                required String currency,
                required double amount,
                Value<int?> refId = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => CashMovementsCompanion.insert(
                id: id,
                shiftId: shiftId,
                userId: userId,
                type: type,
                currency: currency,
                amount: amount,
                refId: refId,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CashMovementsTable, CashMovement>(table),
                  $$CashMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({shiftId = false}) {
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
                    if (shiftId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.shiftId,
                        referencedTable: $$CashMovementsTableReferences._shiftIdTable(db),
                        referencedColumn: $$CashMovementsTableReferences._shiftIdTable(db).id,
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

typedef $$CashMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CashMovementsTable,
      CashMovement,
      $$CashMovementsTableFilterComposer,
      $$CashMovementsTableOrderingComposer,
      $$CashMovementsTableAnnotationComposer,
      $$CashMovementsTableCreateCompanionBuilder,
      $$CashMovementsTableUpdateCompanionBuilder,
      (CashMovement, $$CashMovementsTableReferences),
      CashMovement,
      PrefetchHooks Function({bool shiftId})
    >;
typedef $$SalesTableCreateCompanionBuilder = SalesCompanion Function({
  Value<int> id,
  required int shiftId,
  required int userId,
  Value<int?> customerId,
  Value<DateTime> createdAt,
  required double rate,
  required double subtotalSyp,
  Value<double> discountSyp,
  required double totalSyp,
  required double totalUsd,
  Value<double> costUsd,
  Value<double> paidSyp,
  Value<double> paidUsd,
  Value<double> changeSyp,
  Value<double> debtSyp,
  Value<String> status,
  Value<int?> voidedById,
  Value<DateTime?> voidedAt,
  Value<String?> voidReason,
  Value<String?> note,
});
typedef $$SalesTableUpdateCompanionBuilder = SalesCompanion Function({
  Value<int> id,
  Value<int> shiftId,
  Value<int> userId,
  Value<int?> customerId,
  Value<DateTime> createdAt,
  Value<double> rate,
  Value<double> subtotalSyp,
  Value<double> discountSyp,
  Value<double> totalSyp,
  Value<double> totalUsd,
  Value<double> costUsd,
  Value<double> paidSyp,
  Value<double> paidUsd,
  Value<double> changeSyp,
  Value<double> debtSyp,
  Value<String> status,
  Value<int?> voidedById,
  Value<DateTime?> voidedAt,
  Value<String?> voidReason,
  Value<String?> note,
});

final class $$SalesTableReferences extends BaseReferences<_$AppDatabase, $SalesTable, Sale> {
  $$SalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShiftsTable _shiftIdTable(_$AppDatabase db) => db.shifts.createAlias('sales__shift_id__shifts__id');

  $$ShiftsTableProcessedTableManager get shiftId {
    final $_column = $_itemColumn<int>('shift_id')!;

    final manager = $$ShiftsTableTableManager($_db, $_db.shifts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shiftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias('sales__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SaleItemsTable, List<SaleItem>> _saleItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.saleItems, aliasName: 'sales__id__sale_items__sale_id');

  $$SaleItemsTableProcessedTableManager get saleItemsRefs {
    final manager = $$SaleItemsTableTableManager(
      $_db,
      $_db.saleItems,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CustomerReturnsTable, List<CustomerReturn>> _customerReturnsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.customerReturns, aliasName: 'sales__id__customer_returns__sale_id');

  $$CustomerReturnsTableProcessedTableManager get customerReturnsRefs {
    final manager = $$CustomerReturnsTableTableManager(
      $_db,
      $_db.customerReturns,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerReturnsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SalesTableFilterComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customerId =>
      $composableBuilder(column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotalSyp =>
      $composableBuilder(column: $table.subtotalSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountSyp =>
      $composableBuilder(column: $table.discountSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalSyp =>
      $composableBuilder(column: $table.totalSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get paidSyp =>
      $composableBuilder(column: $table.paidSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get paidUsd =>
      $composableBuilder(column: $table.paidUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get changeSyp =>
      $composableBuilder(column: $table.changeSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get debtSyp =>
      $composableBuilder(column: $table.debtSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get voidedById =>
      $composableBuilder(column: $table.voidedById, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get voidedAt =>
      $composableBuilder(column: $table.voidedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get voidReason =>
      $composableBuilder(column: $table.voidReason, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  $$ShiftsTableFilterComposer get shiftId {
    final $$ShiftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableFilterComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> saleItemsRefs(Expression<bool> Function($$SaleItemsTableFilterComposer f) f) {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerReturnsRefs(Expression<bool> Function($$CustomerReturnsTableFilterComposer f) f) {
    final $$CustomerReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.saleId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableOrderingComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customerId =>
      $composableBuilder(column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotalSyp =>
      $composableBuilder(column: $table.subtotalSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountSyp =>
      $composableBuilder(column: $table.discountSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalSyp =>
      $composableBuilder(column: $table.totalSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get paidSyp =>
      $composableBuilder(column: $table.paidSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get paidUsd =>
      $composableBuilder(column: $table.paidUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get changeSyp =>
      $composableBuilder(column: $table.changeSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get debtSyp =>
      $composableBuilder(column: $table.debtSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get voidedById =>
      $composableBuilder(column: $table.voidedById, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get voidedAt =>
      $composableBuilder(column: $table.voidedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get voidReason =>
      $composableBuilder(column: $table.voidReason, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  $$ShiftsTableOrderingComposer get shiftId {
    final $$ShiftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableOrderingComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SalesTableAnnotationComposer extends Composer<_$AppDatabase, $SalesTable> {
  $$SalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(column: $table.customerId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<double> get subtotalSyp =>
      $composableBuilder(column: $table.subtotalSyp, builder: (column) => column);

  GeneratedColumn<double> get discountSyp =>
      $composableBuilder(column: $table.discountSyp, builder: (column) => column);

  GeneratedColumn<double> get totalSyp => $composableBuilder(column: $table.totalSyp, builder: (column) => column);

  GeneratedColumn<double> get totalUsd => $composableBuilder(column: $table.totalUsd, builder: (column) => column);

  GeneratedColumn<double> get costUsd => $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<double> get paidSyp => $composableBuilder(column: $table.paidSyp, builder: (column) => column);

  GeneratedColumn<double> get paidUsd => $composableBuilder(column: $table.paidUsd, builder: (column) => column);

  GeneratedColumn<double> get changeSyp => $composableBuilder(column: $table.changeSyp, builder: (column) => column);

  GeneratedColumn<double> get debtSyp => $composableBuilder(column: $table.debtSyp, builder: (column) => column);

  GeneratedColumn<String> get status => $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get voidedById => $composableBuilder(column: $table.voidedById, builder: (column) => column);

  GeneratedColumn<DateTime> get voidedAt => $composableBuilder(column: $table.voidedAt, builder: (column) => column);

  GeneratedColumn<String> get voidReason => $composableBuilder(column: $table.voidReason, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  $$ShiftsTableAnnotationComposer get shiftId {
    final $$ShiftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableAnnotationComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> saleItemsRefs<T extends Object>(Expression<T> Function($$SaleItemsTableAnnotationComposer a) f) {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.saleId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerReturnsRefs<T extends Object>(
    Expression<T> Function($$CustomerReturnsTableAnnotationComposer a) f,
  ) {
    final $$CustomerReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.saleId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SalesTable,
          Sale,
          $$SalesTableFilterComposer,
          $$SalesTableOrderingComposer,
          $$SalesTableAnnotationComposer,
          $$SalesTableCreateCompanionBuilder,
          $$SalesTableUpdateCompanionBuilder,
          (Sale, $$SalesTableReferences),
          Sale,
          PrefetchHooks Function({bool shiftId, bool userId, bool saleItemsRefs, bool customerReturnsRefs})
        > {
  $$SalesTableTableManager(_$AppDatabase db, $SalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> shiftId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<double> subtotalSyp = const Value.absent(),
                Value<double> discountSyp = const Value.absent(),
                Value<double> totalSyp = const Value.absent(),
                Value<double> totalUsd = const Value.absent(),
                Value<double> costUsd = const Value.absent(),
                Value<double> paidSyp = const Value.absent(),
                Value<double> paidUsd = const Value.absent(),
                Value<double> changeSyp = const Value.absent(),
                Value<double> debtSyp = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> voidedById = const Value.absent(),
                Value<DateTime?> voidedAt = const Value.absent(),
                Value<String?> voidReason = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SalesCompanion(
                id: id,
                shiftId: shiftId,
                userId: userId,
                customerId: customerId,
                createdAt: createdAt,
                rate: rate,
                subtotalSyp: subtotalSyp,
                discountSyp: discountSyp,
                totalSyp: totalSyp,
                totalUsd: totalUsd,
                costUsd: costUsd,
                paidSyp: paidSyp,
                paidUsd: paidUsd,
                changeSyp: changeSyp,
                debtSyp: debtSyp,
                status: status,
                voidedById: voidedById,
                voidedAt: voidedAt,
                voidReason: voidReason,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int shiftId,
                required int userId,
                Value<int?> customerId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required double rate,
                required double subtotalSyp,
                Value<double> discountSyp = const Value.absent(),
                required double totalSyp,
                required double totalUsd,
                Value<double> costUsd = const Value.absent(),
                Value<double> paidSyp = const Value.absent(),
                Value<double> paidUsd = const Value.absent(),
                Value<double> changeSyp = const Value.absent(),
                Value<double> debtSyp = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> voidedById = const Value.absent(),
                Value<DateTime?> voidedAt = const Value.absent(),
                Value<String?> voidReason = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SalesCompanion.insert(
                id: id,
                shiftId: shiftId,
                userId: userId,
                customerId: customerId,
                createdAt: createdAt,
                rate: rate,
                subtotalSyp: subtotalSyp,
                discountSyp: discountSyp,
                totalSyp: totalSyp,
                totalUsd: totalUsd,
                costUsd: costUsd,
                paidSyp: paidSyp,
                paidUsd: paidUsd,
                changeSyp: changeSyp,
                debtSyp: debtSyp,
                status: status,
                voidedById: voidedById,
                voidedAt: voidedAt,
                voidReason: voidReason,
                note: note,
              ),
          withReferenceMapper: (p0) =>
              p0.map((e) => (e.readTable<$SalesTable, Sale>(table), $$SalesTableReferences(db, table, e))).toList(),
          prefetchHooksCallback:
              ({shiftId = false, userId = false, saleItemsRefs = false, customerReturnsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (saleItemsRefs) db.saleItems,
                    if (customerReturnsRefs) db.customerReturns,
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
                        if (shiftId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.shiftId,
                            referencedTable: $$SalesTableReferences._shiftIdTable(db),
                            referencedColumn: $$SalesTableReferences._shiftIdTable(db).id,
                          ) as T;
                        }
                        if (userId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.userId,
                            referencedTable: $$SalesTableReferences._userIdTable(db),
                            referencedColumn: $$SalesTableReferences._userIdTable(db).id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (saleItemsRefs)
                        await $_getPrefetchedDataByColumns<Sale, $SalesTable, SaleItem, $SaleItemsTable>(
                          currentTable: table,
                          referencedTable: $$SalesTableReferences._saleItemsRefsTable(db),
                          managerFromTypedResult: (p0) => $$SalesTableReferences(db, table, p0).saleItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'sale_id',
                          typedResults: items,
                        ),
                      if (customerReturnsRefs)
                        await $_getPrefetchedDataByColumns<Sale, $SalesTable, CustomerReturn, $CustomerReturnsTable>(
                          currentTable: table,
                          referencedTable: $$SalesTableReferences._customerReturnsRefsTable(db),
                          managerFromTypedResult: (p0) => $$SalesTableReferences(db, table, p0).customerReturnsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'sale_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SalesTable,
      Sale,
      $$SalesTableFilterComposer,
      $$SalesTableOrderingComposer,
      $$SalesTableAnnotationComposer,
      $$SalesTableCreateCompanionBuilder,
      $$SalesTableUpdateCompanionBuilder,
      (Sale, $$SalesTableReferences),
      Sale,
      PrefetchHooks Function({bool shiftId, bool userId, bool saleItemsRefs, bool customerReturnsRefs})
    >;
typedef $$SaleItemsTableCreateCompanionBuilder = SaleItemsCompanion Function({
  Value<int> id,
  required int saleId,
  required int medicineId,
  required String medicineName,
  required int unit,
  required String unitLabel,
  required int quantity,
  required int baseQuantity,
  required double unitPriceUsd,
  required double unitPriceSyp,
  required double totalSyp,
  required double costUsd,
  Value<int> returnedBase,
});
typedef $$SaleItemsTableUpdateCompanionBuilder = SaleItemsCompanion Function({
  Value<int> id,
  Value<int> saleId,
  Value<int> medicineId,
  Value<String> medicineName,
  Value<int> unit,
  Value<String> unitLabel,
  Value<int> quantity,
  Value<int> baseQuantity,
  Value<double> unitPriceUsd,
  Value<double> unitPriceSyp,
  Value<double> totalSyp,
  Value<double> costUsd,
  Value<int> returnedBase,
});

final class $$SaleItemsTableReferences extends BaseReferences<_$AppDatabase, $SaleItemsTable, SaleItem> {
  $$SaleItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias('sale_items__sale_id__sales__id');

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<int>('sale_id')!;

    final manager = $$SalesTableTableManager($_db, $_db.sales).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias('sale_items__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SaleItemBatchesTable, List<SaleItemBatch>> _saleItemBatchesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.saleItemBatches, aliasName: 'sale_items__id__sale_item_batches__sale_item_id');

  $$SaleItemBatchesTableProcessedTableManager get saleItemBatchesRefs {
    final manager = $$SaleItemBatchesTableTableManager(
      $_db,
      $_db.saleItemBatches,
    ).filter((f) => f.saleItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_saleItemBatchesRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$CustomerReturnItemsTable, List<CustomerReturnItem>> _customerReturnItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.customerReturnItems,
    aliasName: 'sale_items__id__customer_return_items__sale_item_id',
  );

  $$CustomerReturnItemsTableProcessedTableManager get customerReturnItemsRefs {
    final manager = $$CustomerReturnItemsTableTableManager(
      $_db,
      $_db.customerReturnItems,
    ).filter((f) => f.saleItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerReturnItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SaleItemsTableFilterComposer extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get medicineName =>
      $composableBuilder(column: $table.medicineName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get unit => $composableBuilder(column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitLabel =>
      $composableBuilder(column: $table.unitLabel, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPriceUsd =>
      $composableBuilder(column: $table.unitPriceUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPriceSyp =>
      $composableBuilder(column: $table.unitPriceSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalSyp =>
      $composableBuilder(column: $table.totalSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get returnedBase =>
      $composableBuilder(column: $table.returnedBase, builder: (column) => ColumnFilters(column));

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> saleItemBatchesRefs(Expression<bool> Function($$SaleItemBatchesTableFilterComposer f) f) {
    final $$SaleItemBatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItemBatches,
      getReferencedColumn: (t) => t.saleItemId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemBatchesTableFilterComposer(
            $db: $db,
            $table: $db.saleItemBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customerReturnItemsRefs(Expression<bool> Function($$CustomerReturnItemsTableFilterComposer f) f) {
    final $$CustomerReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturnItems,
      getReferencedColumn: (t) => t.saleItemId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SaleItemsTableOrderingComposer extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get medicineName =>
      $composableBuilder(column: $table.medicineName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitLabel =>
      $composableBuilder(column: $table.unitLabel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPriceUsd =>
      $composableBuilder(column: $table.unitPriceUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPriceSyp =>
      $composableBuilder(column: $table.unitPriceSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalSyp =>
      $composableBuilder(column: $table.totalSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get returnedBase =>
      $composableBuilder(column: $table.returnedBase, builder: (column) => ColumnOrderings(column));

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemsTableAnnotationComposer extends Composer<_$AppDatabase, $SaleItemsTable> {
  $$SaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get medicineName =>
      $composableBuilder(column: $table.medicineName, builder: (column) => column);

  GeneratedColumn<int> get unit => $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get unitLabel => $composableBuilder(column: $table.unitLabel, builder: (column) => column);

  GeneratedColumn<int> get quantity => $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get baseQuantity => $composableBuilder(column: $table.baseQuantity, builder: (column) => column);

  GeneratedColumn<double> get unitPriceUsd =>
      $composableBuilder(column: $table.unitPriceUsd, builder: (column) => column);

  GeneratedColumn<double> get unitPriceSyp =>
      $composableBuilder(column: $table.unitPriceSyp, builder: (column) => column);

  GeneratedColumn<double> get totalSyp => $composableBuilder(column: $table.totalSyp, builder: (column) => column);

  GeneratedColumn<double> get costUsd => $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<int> get returnedBase => $composableBuilder(column: $table.returnedBase, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> saleItemBatchesRefs<T extends Object>(
    Expression<T> Function($$SaleItemBatchesTableAnnotationComposer a) f,
  ) {
    final $$SaleItemBatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.saleItemBatches,
      getReferencedColumn: (t) => t.saleItemId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemBatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItemBatches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customerReturnItemsRefs<T extends Object>(
    Expression<T> Function($$CustomerReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$CustomerReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturnItems,
      getReferencedColumn: (t) => t.saleItemId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemsTable,
          SaleItem,
          $$SaleItemsTableFilterComposer,
          $$SaleItemsTableOrderingComposer,
          $$SaleItemsTableAnnotationComposer,
          $$SaleItemsTableCreateCompanionBuilder,
          $$SaleItemsTableUpdateCompanionBuilder,
          (SaleItem, $$SaleItemsTableReferences),
          SaleItem,
          PrefetchHooks Function({bool saleId, bool medicineId, bool saleItemBatchesRefs, bool customerReturnItemsRefs})
        > {
  $$SaleItemsTableTableManager(_$AppDatabase db, $SaleItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<String> medicineName = const Value.absent(),
                Value<int> unit = const Value.absent(),
                Value<String> unitLabel = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> baseQuantity = const Value.absent(),
                Value<double> unitPriceUsd = const Value.absent(),
                Value<double> unitPriceSyp = const Value.absent(),
                Value<double> totalSyp = const Value.absent(),
                Value<double> costUsd = const Value.absent(),
                Value<int> returnedBase = const Value.absent(),
              }) => SaleItemsCompanion(
                id: id,
                saleId: saleId,
                medicineId: medicineId,
                medicineName: medicineName,
                unit: unit,
                unitLabel: unitLabel,
                quantity: quantity,
                baseQuantity: baseQuantity,
                unitPriceUsd: unitPriceUsd,
                unitPriceSyp: unitPriceSyp,
                totalSyp: totalSyp,
                costUsd: costUsd,
                returnedBase: returnedBase,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                required int medicineId,
                required String medicineName,
                required int unit,
                required String unitLabel,
                required int quantity,
                required int baseQuantity,
                required double unitPriceUsd,
                required double unitPriceSyp,
                required double totalSyp,
                required double costUsd,
                Value<int> returnedBase = const Value.absent(),
              }) => SaleItemsCompanion.insert(
                id: id,
                saleId: saleId,
                medicineId: medicineId,
                medicineName: medicineName,
                unit: unit,
                unitLabel: unitLabel,
                quantity: quantity,
                baseQuantity: baseQuantity,
                unitPriceUsd: unitPriceUsd,
                unitPriceSyp: unitPriceSyp,
                totalSyp: totalSyp,
                costUsd: costUsd,
                returnedBase: returnedBase,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable<$SaleItemsTable, SaleItem>(table), $$SaleItemsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback:
              ({saleId = false, medicineId = false, saleItemBatchesRefs = false, customerReturnItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (saleItemBatchesRefs) db.saleItemBatches,
                    if (customerReturnItemsRefs) db.customerReturnItems,
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
                        if (saleId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.saleId,
                            referencedTable: $$SaleItemsTableReferences._saleIdTable(db),
                            referencedColumn: $$SaleItemsTableReferences._saleIdTable(db).id,
                          ) as T;
                        }
                        if (medicineId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.medicineId,
                            referencedTable: $$SaleItemsTableReferences._medicineIdTable(db),
                            referencedColumn: $$SaleItemsTableReferences._medicineIdTable(db).id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (saleItemBatchesRefs)
                        await $_getPrefetchedDataByColumns<
                          SaleItem,
                          $SaleItemsTable,
                          SaleItemBatch,
                          $SaleItemBatchesTable
                        >(
                          currentTable: table,
                          referencedTable: $$SaleItemsTableReferences._saleItemBatchesRefsTable(db),
                          managerFromTypedResult: (p0) => $$SaleItemsTableReferences(db, table, p0).saleItemBatchesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'sale_item_id',
                          typedResults: items,
                        ),
                      if (customerReturnItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          SaleItem,
                          $SaleItemsTable,
                          CustomerReturnItem,
                          $CustomerReturnItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$SaleItemsTableReferences._customerReturnItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$SaleItemsTableReferences(db, table, p0).customerReturnItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'sale_item_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$SaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemsTable,
      SaleItem,
      $$SaleItemsTableFilterComposer,
      $$SaleItemsTableOrderingComposer,
      $$SaleItemsTableAnnotationComposer,
      $$SaleItemsTableCreateCompanionBuilder,
      $$SaleItemsTableUpdateCompanionBuilder,
      (SaleItem, $$SaleItemsTableReferences),
      SaleItem,
      PrefetchHooks Function({bool saleId, bool medicineId, bool saleItemBatchesRefs, bool customerReturnItemsRefs})
    >;
typedef $$SaleItemBatchesTableCreateCompanionBuilder = SaleItemBatchesCompanion Function({
  Value<int> id,
  required int saleItemId,
  required int batchId,
  required int baseQuantity,
  required double costUsd,
  Value<int> returnedBase,
});
typedef $$SaleItemBatchesTableUpdateCompanionBuilder = SaleItemBatchesCompanion Function({
  Value<int> id,
  Value<int> saleItemId,
  Value<int> batchId,
  Value<int> baseQuantity,
  Value<double> costUsd,
  Value<int> returnedBase,
});

final class $$SaleItemBatchesTableReferences
    extends BaseReferences<_$AppDatabase, $SaleItemBatchesTable, SaleItemBatch> {
  $$SaleItemBatchesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SaleItemsTable _saleItemIdTable(_$AppDatabase db) =>
      db.saleItems.createAlias('sale_item_batches__sale_item_id__sale_items__id');

  $$SaleItemsTableProcessedTableManager get saleItemId {
    final $_column = $_itemColumn<int>('sale_item_id')!;

    final manager = $$SaleItemsTableTableManager($_db, $_db.saleItems).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('sale_item_batches__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<int>('batch_id')!;

    final manager = $$BatchesTableTableManager($_db, $_db.batches).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SaleItemBatchesTableFilterComposer extends Composer<_$AppDatabase, $SaleItemBatchesTable> {
  $$SaleItemBatchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get returnedBase =>
      $composableBuilder(column: $table.returnedBase, builder: (column) => ColumnFilters(column));

  $$SaleItemsTableFilterComposer get saleItemId {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemBatchesTableOrderingComposer extends Composer<_$AppDatabase, $SaleItemBatchesTable> {
  $$SaleItemBatchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get returnedBase =>
      $composableBuilder(column: $table.returnedBase, builder: (column) => ColumnOrderings(column));

  $$SaleItemsTableOrderingComposer get saleItemId {
    final $$SaleItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableOrderingComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemBatchesTableAnnotationComposer extends Composer<_$AppDatabase, $SaleItemBatchesTable> {
  $$SaleItemBatchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get baseQuantity => $composableBuilder(column: $table.baseQuantity, builder: (column) => column);

  GeneratedColumn<double> get costUsd => $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<int> get returnedBase => $composableBuilder(column: $table.returnedBase, builder: (column) => column);

  $$SaleItemsTableAnnotationComposer get saleItemId {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SaleItemBatchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SaleItemBatchesTable,
          SaleItemBatch,
          $$SaleItemBatchesTableFilterComposer,
          $$SaleItemBatchesTableOrderingComposer,
          $$SaleItemBatchesTableAnnotationComposer,
          $$SaleItemBatchesTableCreateCompanionBuilder,
          $$SaleItemBatchesTableUpdateCompanionBuilder,
          (SaleItemBatch, $$SaleItemBatchesTableReferences),
          SaleItemBatch,
          PrefetchHooks Function({bool saleItemId, bool batchId})
        > {
  $$SaleItemBatchesTableTableManager(_$AppDatabase db, $SaleItemBatchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SaleItemBatchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SaleItemBatchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SaleItemBatchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleItemId = const Value.absent(),
                Value<int> batchId = const Value.absent(),
                Value<int> baseQuantity = const Value.absent(),
                Value<double> costUsd = const Value.absent(),
                Value<int> returnedBase = const Value.absent(),
              }) => SaleItemBatchesCompanion(
                id: id,
                saleItemId: saleItemId,
                batchId: batchId,
                baseQuantity: baseQuantity,
                costUsd: costUsd,
                returnedBase: returnedBase,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleItemId,
                required int batchId,
                required int baseQuantity,
                required double costUsd,
                Value<int> returnedBase = const Value.absent(),
              }) => SaleItemBatchesCompanion.insert(
                id: id,
                saleItemId: saleItemId,
                batchId: batchId,
                baseQuantity: baseQuantity,
                costUsd: costUsd,
                returnedBase: returnedBase,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SaleItemBatchesTable, SaleItemBatch>(table),
                  $$SaleItemBatchesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleItemId = false, batchId = false}) {
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
                    if (saleItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.saleItemId,
                        referencedTable: $$SaleItemBatchesTableReferences._saleItemIdTable(db),
                        referencedColumn: $$SaleItemBatchesTableReferences._saleItemIdTable(db).id,
                      ) as T;
                    }
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$SaleItemBatchesTableReferences._batchIdTable(db),
                        referencedColumn: $$SaleItemBatchesTableReferences._batchIdTable(db).id,
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

typedef $$SaleItemBatchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SaleItemBatchesTable,
      SaleItemBatch,
      $$SaleItemBatchesTableFilterComposer,
      $$SaleItemBatchesTableOrderingComposer,
      $$SaleItemBatchesTableAnnotationComposer,
      $$SaleItemBatchesTableCreateCompanionBuilder,
      $$SaleItemBatchesTableUpdateCompanionBuilder,
      (SaleItemBatch, $$SaleItemBatchesTableReferences),
      SaleItemBatch,
      PrefetchHooks Function({bool saleItemId, bool batchId})
    >;
typedef $$CustomerReturnsTableCreateCompanionBuilder = CustomerReturnsCompanion Function({
  Value<int> id,
  required int saleId,
  Value<int?> customerId,
  required int shiftId,
  required int userId,
  Value<DateTime> createdAt,
  required double rate,
  required double totalSyp,
  Value<double> refundSyp,
  Value<double> debtReducedSyp,
  Value<double> costUsd,
  Value<String?> note,
});
typedef $$CustomerReturnsTableUpdateCompanionBuilder = CustomerReturnsCompanion Function({
  Value<int> id,
  Value<int> saleId,
  Value<int?> customerId,
  Value<int> shiftId,
  Value<int> userId,
  Value<DateTime> createdAt,
  Value<double> rate,
  Value<double> totalSyp,
  Value<double> refundSyp,
  Value<double> debtReducedSyp,
  Value<double> costUsd,
  Value<String?> note,
});

final class $$CustomerReturnsTableReferences
    extends BaseReferences<_$AppDatabase, $CustomerReturnsTable, CustomerReturn> {
  $$CustomerReturnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SalesTable _saleIdTable(_$AppDatabase db) => db.sales.createAlias('customer_returns__sale_id__sales__id');

  $$SalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<int>('sale_id')!;

    final manager = $$SalesTableTableManager($_db, $_db.sales).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ShiftsTable _shiftIdTable(_$AppDatabase db) =>
      db.shifts.createAlias('customer_returns__shift_id__shifts__id');

  $$ShiftsTableProcessedTableManager get shiftId {
    final $_column = $_itemColumn<int>('shift_id')!;

    final manager = $$ShiftsTableTableManager($_db, $_db.shifts).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shiftIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users.createAlias('customer_returns__user_id__users__id');

  $$UsersTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UsersTableTableManager($_db, $_db.users).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$CustomerReturnItemsTable, List<CustomerReturnItem>> _customerReturnItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.customerReturnItems,
    aliasName: 'customer_returns__id__customer_return_items__return_id',
  );

  $$CustomerReturnItemsTableProcessedTableManager get customerReturnItemsRefs {
    final manager = $$CustomerReturnItemsTableTableManager(
      $_db,
      $_db.customerReturnItems,
    ).filter((f) => f.returnId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_customerReturnItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$CustomerReturnsTableFilterComposer extends Composer<_$AppDatabase, $CustomerReturnsTable> {
  $$CustomerReturnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get customerId =>
      $composableBuilder(column: $table.customerId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalSyp =>
      $composableBuilder(column: $table.totalSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get refundSyp =>
      $composableBuilder(column: $table.refundSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get debtReducedSyp =>
      $composableBuilder(column: $table.debtReducedSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  $$SalesTableFilterComposer get saleId {
    final $$SalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableFilterComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShiftsTableFilterComposer get shiftId {
    final $$ShiftsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableFilterComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableFilterComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> customerReturnItemsRefs(Expression<bool> Function($$CustomerReturnItemsTableFilterComposer f) f) {
    final $$CustomerReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturnItems,
      getReferencedColumn: (t) => t.returnId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomerReturnsTableOrderingComposer extends Composer<_$AppDatabase, $CustomerReturnsTable> {
  $$CustomerReturnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get customerId =>
      $composableBuilder(column: $table.customerId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get rate =>
      $composableBuilder(column: $table.rate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalSyp =>
      $composableBuilder(column: $table.totalSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get refundSyp =>
      $composableBuilder(column: $table.refundSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get debtReducedSyp =>
      $composableBuilder(column: $table.debtReducedSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costUsd =>
      $composableBuilder(column: $table.costUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  $$SalesTableOrderingComposer get saleId {
    final $$SalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableOrderingComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShiftsTableOrderingComposer get shiftId {
    final $$ShiftsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableOrderingComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableOrderingComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerReturnsTableAnnotationComposer extends Composer<_$AppDatabase, $CustomerReturnsTable> {
  $$CustomerReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get customerId => $composableBuilder(column: $table.customerId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get rate => $composableBuilder(column: $table.rate, builder: (column) => column);

  GeneratedColumn<double> get totalSyp => $composableBuilder(column: $table.totalSyp, builder: (column) => column);

  GeneratedColumn<double> get refundSyp => $composableBuilder(column: $table.refundSyp, builder: (column) => column);

  GeneratedColumn<double> get debtReducedSyp =>
      $composableBuilder(column: $table.debtReducedSyp, builder: (column) => column);

  GeneratedColumn<double> get costUsd => $composableBuilder(column: $table.costUsd, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  $$SalesTableAnnotationComposer get saleId {
    final $$SalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.sales,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SalesTableAnnotationComposer(
            $db: $db,
            $table: $db.sales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ShiftsTableAnnotationComposer get shiftId {
    final $$ShiftsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.shiftId,
      referencedTable: $db.shifts,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$ShiftsTableAnnotationComposer(
            $db: $db,
            $table: $db.shifts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.users,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$UsersTableAnnotationComposer(
            $db: $db,
            $table: $db.users,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> customerReturnItemsRefs<T extends Object>(
    Expression<T> Function($$CustomerReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$CustomerReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customerReturnItems,
      getReferencedColumn: (t) => t.returnId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomerReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerReturnsTable,
          CustomerReturn,
          $$CustomerReturnsTableFilterComposer,
          $$CustomerReturnsTableOrderingComposer,
          $$CustomerReturnsTableAnnotationComposer,
          $$CustomerReturnsTableCreateCompanionBuilder,
          $$CustomerReturnsTableUpdateCompanionBuilder,
          (CustomerReturn, $$CustomerReturnsTableReferences),
          CustomerReturn,
          PrefetchHooks Function({bool saleId, bool shiftId, bool userId, bool customerReturnItemsRefs})
        > {
  $$CustomerReturnsTableTableManager(_$AppDatabase db, $CustomerReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CustomerReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CustomerReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CustomerReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> saleId = const Value.absent(),
                Value<int?> customerId = const Value.absent(),
                Value<int> shiftId = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> rate = const Value.absent(),
                Value<double> totalSyp = const Value.absent(),
                Value<double> refundSyp = const Value.absent(),
                Value<double> debtReducedSyp = const Value.absent(),
                Value<double> costUsd = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => CustomerReturnsCompanion(
                id: id,
                saleId: saleId,
                customerId: customerId,
                shiftId: shiftId,
                userId: userId,
                createdAt: createdAt,
                rate: rate,
                totalSyp: totalSyp,
                refundSyp: refundSyp,
                debtReducedSyp: debtReducedSyp,
                costUsd: costUsd,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int saleId,
                Value<int?> customerId = const Value.absent(),
                required int shiftId,
                required int userId,
                Value<DateTime> createdAt = const Value.absent(),
                required double rate,
                required double totalSyp,
                Value<double> refundSyp = const Value.absent(),
                Value<double> debtReducedSyp = const Value.absent(),
                Value<double> costUsd = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => CustomerReturnsCompanion.insert(
                id: id,
                saleId: saleId,
                customerId: customerId,
                shiftId: shiftId,
                userId: userId,
                createdAt: createdAt,
                rate: rate,
                totalSyp: totalSyp,
                refundSyp: refundSyp,
                debtReducedSyp: debtReducedSyp,
                costUsd: costUsd,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomerReturnsTable, CustomerReturn>(table),
                  $$CustomerReturnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false, shiftId = false, userId = false, customerReturnItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (customerReturnItemsRefs) db.customerReturnItems],
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
                    if (saleId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.saleId,
                        referencedTable: $$CustomerReturnsTableReferences._saleIdTable(db),
                        referencedColumn: $$CustomerReturnsTableReferences._saleIdTable(db).id,
                      ) as T;
                    }
                    if (shiftId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.shiftId,
                        referencedTable: $$CustomerReturnsTableReferences._shiftIdTable(db),
                        referencedColumn: $$CustomerReturnsTableReferences._shiftIdTable(db).id,
                      ) as T;
                    }
                    if (userId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.userId,
                        referencedTable: $$CustomerReturnsTableReferences._userIdTable(db),
                        referencedColumn: $$CustomerReturnsTableReferences._userIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (customerReturnItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      CustomerReturn,
                      $CustomerReturnsTable,
                      CustomerReturnItem,
                      $CustomerReturnItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$CustomerReturnsTableReferences._customerReturnItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomerReturnsTableReferences(db, table, p0).customerReturnItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'return_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomerReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerReturnsTable,
      CustomerReturn,
      $$CustomerReturnsTableFilterComposer,
      $$CustomerReturnsTableOrderingComposer,
      $$CustomerReturnsTableAnnotationComposer,
      $$CustomerReturnsTableCreateCompanionBuilder,
      $$CustomerReturnsTableUpdateCompanionBuilder,
      (CustomerReturn, $$CustomerReturnsTableReferences),
      CustomerReturn,
      PrefetchHooks Function({bool saleId, bool shiftId, bool userId, bool customerReturnItemsRefs})
    >;
typedef $$CustomerReturnItemsTableCreateCompanionBuilder = CustomerReturnItemsCompanion Function({
  Value<int> id,
  required int returnId,
  required int saleItemId,
  required int medicineId,
  required int baseQuantity,
  required double amountSyp,
  Value<bool> restocked,
});
typedef $$CustomerReturnItemsTableUpdateCompanionBuilder = CustomerReturnItemsCompanion Function({
  Value<int> id,
  Value<int> returnId,
  Value<int> saleItemId,
  Value<int> medicineId,
  Value<int> baseQuantity,
  Value<double> amountSyp,
  Value<bool> restocked,
});

final class $$CustomerReturnItemsTableReferences
    extends BaseReferences<_$AppDatabase, $CustomerReturnItemsTable, CustomerReturnItem> {
  $$CustomerReturnItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CustomerReturnsTable _returnIdTable(_$AppDatabase db) =>
      db.customerReturns.createAlias('customer_return_items__return_id__customer_returns__id');

  $$CustomerReturnsTableProcessedTableManager get returnId {
    final $_column = $_itemColumn<int>('return_id')!;

    final manager = $$CustomerReturnsTableTableManager(
      $_db,
      $_db.customerReturns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_returnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SaleItemsTable _saleItemIdTable(_$AppDatabase db) =>
      db.saleItems.createAlias('customer_return_items__sale_item_id__sale_items__id');

  $$SaleItemsTableProcessedTableManager get saleItemId {
    final $_column = $_itemColumn<int>('sale_item_id')!;

    final manager = $$SaleItemsTableTableManager($_db, $_db.saleItems).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias('customer_return_items__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$CustomerReturnItemsTableFilterComposer extends Composer<_$AppDatabase, $CustomerReturnItemsTable> {
  $$CustomerReturnItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountSyp =>
      $composableBuilder(column: $table.amountSyp, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get restocked =>
      $composableBuilder(column: $table.restocked, builder: (column) => ColumnFilters(column));

  $$CustomerReturnsTableFilterComposer get returnId {
    final $$CustomerReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableFilterComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SaleItemsTableFilterComposer get saleItemId {
    final $$SaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerReturnItemsTableOrderingComposer extends Composer<_$AppDatabase, $CustomerReturnItemsTable> {
  $$CustomerReturnItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountSyp =>
      $composableBuilder(column: $table.amountSyp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get restocked =>
      $composableBuilder(column: $table.restocked, builder: (column) => ColumnOrderings(column));

  $$CustomerReturnsTableOrderingComposer get returnId {
    final $$CustomerReturnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableOrderingComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SaleItemsTableOrderingComposer get saleItemId {
    final $$SaleItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableOrderingComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerReturnItemsTableAnnotationComposer extends Composer<_$AppDatabase, $CustomerReturnItemsTable> {
  $$CustomerReturnItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get baseQuantity => $composableBuilder(column: $table.baseQuantity, builder: (column) => column);

  GeneratedColumn<double> get amountSyp => $composableBuilder(column: $table.amountSyp, builder: (column) => column);

  GeneratedColumn<bool> get restocked => $composableBuilder(column: $table.restocked, builder: (column) => column);

  $$CustomerReturnsTableAnnotationComposer get returnId {
    final $$CustomerReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.customerReturns,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$CustomerReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.customerReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$SaleItemsTableAnnotationComposer get saleItemId {
    final $$SaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleItemId,
      referencedTable: $db.saleItems,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.saleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomerReturnItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomerReturnItemsTable,
          CustomerReturnItem,
          $$CustomerReturnItemsTableFilterComposer,
          $$CustomerReturnItemsTableOrderingComposer,
          $$CustomerReturnItemsTableAnnotationComposer,
          $$CustomerReturnItemsTableCreateCompanionBuilder,
          $$CustomerReturnItemsTableUpdateCompanionBuilder,
          (CustomerReturnItem, $$CustomerReturnItemsTableReferences),
          CustomerReturnItem,
          PrefetchHooks Function({bool returnId, bool saleItemId, bool medicineId})
        > {
  $$CustomerReturnItemsTableTableManager(_$AppDatabase db, $CustomerReturnItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CustomerReturnItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CustomerReturnItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CustomerReturnItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> returnId = const Value.absent(),
                Value<int> saleItemId = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<int> baseQuantity = const Value.absent(),
                Value<double> amountSyp = const Value.absent(),
                Value<bool> restocked = const Value.absent(),
              }) => CustomerReturnItemsCompanion(
                id: id,
                returnId: returnId,
                saleItemId: saleItemId,
                medicineId: medicineId,
                baseQuantity: baseQuantity,
                amountSyp: amountSyp,
                restocked: restocked,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int returnId,
                required int saleItemId,
                required int medicineId,
                required int baseQuantity,
                required double amountSyp,
                Value<bool> restocked = const Value.absent(),
              }) => CustomerReturnItemsCompanion.insert(
                id: id,
                returnId: returnId,
                saleItemId: saleItemId,
                medicineId: medicineId,
                baseQuantity: baseQuantity,
                amountSyp: amountSyp,
                restocked: restocked,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomerReturnItemsTable, CustomerReturnItem>(table),
                  $$CustomerReturnItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({returnId = false, saleItemId = false, medicineId = false}) {
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
                    if (returnId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.returnId,
                        referencedTable: $$CustomerReturnItemsTableReferences._returnIdTable(db),
                        referencedColumn: $$CustomerReturnItemsTableReferences._returnIdTable(db).id,
                      ) as T;
                    }
                    if (saleItemId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.saleItemId,
                        referencedTable: $$CustomerReturnItemsTableReferences._saleItemIdTable(db),
                        referencedColumn: $$CustomerReturnItemsTableReferences._saleItemIdTable(db).id,
                      ) as T;
                    }
                    if (medicineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.medicineId,
                        referencedTable: $$CustomerReturnItemsTableReferences._medicineIdTable(db),
                        referencedColumn: $$CustomerReturnItemsTableReferences._medicineIdTable(db).id,
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

typedef $$CustomerReturnItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomerReturnItemsTable,
      CustomerReturnItem,
      $$CustomerReturnItemsTableFilterComposer,
      $$CustomerReturnItemsTableOrderingComposer,
      $$CustomerReturnItemsTableAnnotationComposer,
      $$CustomerReturnItemsTableCreateCompanionBuilder,
      $$CustomerReturnItemsTableUpdateCompanionBuilder,
      (CustomerReturnItem, $$CustomerReturnItemsTableReferences),
      CustomerReturnItem,
      PrefetchHooks Function({bool returnId, bool saleItemId, bool medicineId})
    >;
typedef $$SupplierReturnsTableCreateCompanionBuilder = SupplierReturnsCompanion Function({
  Value<int> id,
  required int supplierId,
  Value<int?> userId,
  Value<DateTime> createdAt,
  required double totalUsd,
  required String settlement,
  Value<String?> note,
});
typedef $$SupplierReturnsTableUpdateCompanionBuilder = SupplierReturnsCompanion Function({
  Value<int> id,
  Value<int> supplierId,
  Value<int?> userId,
  Value<DateTime> createdAt,
  Value<double> totalUsd,
  Value<String> settlement,
  Value<String?> note,
});

final class $$SupplierReturnsTableReferences
    extends BaseReferences<_$AppDatabase, $SupplierReturnsTable, SupplierReturn> {
  $$SupplierReturnsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SuppliersTable _supplierIdTable(_$AppDatabase db) =>
      db.suppliers.createAlias('supplier_returns__supplier_id__suppliers__id');

  $$SuppliersTableProcessedTableManager get supplierId {
    final $_column = $_itemColumn<int>('supplier_id')!;

    final manager = $$SuppliersTableTableManager($_db, $_db.suppliers).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_supplierIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SupplierReturnItemsTable, List<SupplierReturnItem>> _supplierReturnItemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.supplierReturnItems,
    aliasName: 'supplier_returns__id__supplier_return_items__return_id',
  );

  $$SupplierReturnItemsTableProcessedTableManager get supplierReturnItemsRefs {
    final manager = $$SupplierReturnItemsTableTableManager(
      $_db,
      $_db.supplierReturnItems,
    ).filter((f) => f.returnId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_supplierReturnItemsRefsTable($_db));
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SupplierReturnsTableFilterComposer extends Composer<_$AppDatabase, $SupplierReturnsTable> {
  $$SupplierReturnsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settlement =>
      $composableBuilder(column: $table.settlement, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(column: $table.note, builder: (column) => ColumnFilters(column));

  $$SuppliersTableFilterComposer get supplierId {
    final $$SuppliersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableFilterComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> supplierReturnItemsRefs(Expression<bool> Function($$SupplierReturnItemsTableFilterComposer f) f) {
    final $$SupplierReturnItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturnItems,
      getReferencedColumn: (t) => t.returnId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnItemsTableFilterComposer(
            $db: $db,
            $table: $db.supplierReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SupplierReturnsTableOrderingComposer extends Composer<_$AppDatabase, $SupplierReturnsTable> {
  $$SupplierReturnsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalUsd =>
      $composableBuilder(column: $table.totalUsd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settlement =>
      $composableBuilder(column: $table.settlement, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => ColumnOrderings(column));

  $$SuppliersTableOrderingComposer get supplierId {
    final $$SuppliersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableOrderingComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierReturnsTableAnnotationComposer extends Composer<_$AppDatabase, $SupplierReturnsTable> {
  $$SupplierReturnsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId => $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get totalUsd => $composableBuilder(column: $table.totalUsd, builder: (column) => column);

  GeneratedColumn<String> get settlement => $composableBuilder(column: $table.settlement, builder: (column) => column);

  GeneratedColumn<String> get note => $composableBuilder(column: $table.note, builder: (column) => column);

  $$SuppliersTableAnnotationComposer get supplierId {
    final $$SuppliersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.supplierId,
      referencedTable: $db.suppliers,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SuppliersTableAnnotationComposer(
            $db: $db,
            $table: $db.suppliers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> supplierReturnItemsRefs<T extends Object>(
    Expression<T> Function($$SupplierReturnItemsTableAnnotationComposer a) f,
  ) {
    final $$SupplierReturnItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.supplierReturnItems,
      getReferencedColumn: (t) => t.returnId,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.supplierReturnItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$SupplierReturnsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierReturnsTable,
          SupplierReturn,
          $$SupplierReturnsTableFilterComposer,
          $$SupplierReturnsTableOrderingComposer,
          $$SupplierReturnsTableAnnotationComposer,
          $$SupplierReturnsTableCreateCompanionBuilder,
          $$SupplierReturnsTableUpdateCompanionBuilder,
          (SupplierReturn, $$SupplierReturnsTableReferences),
          SupplierReturn,
          PrefetchHooks Function({bool supplierId, bool supplierReturnItemsRefs})
        > {
  $$SupplierReturnsTableTableManager(_$AppDatabase db, $SupplierReturnsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SupplierReturnsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SupplierReturnsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SupplierReturnsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> supplierId = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> totalUsd = const Value.absent(),
                Value<String> settlement = const Value.absent(),
                Value<String?> note = const Value.absent(),
              }) => SupplierReturnsCompanion(
                id: id,
                supplierId: supplierId,
                userId: userId,
                createdAt: createdAt,
                totalUsd: totalUsd,
                settlement: settlement,
                note: note,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int supplierId,
                Value<int?> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                required double totalUsd,
                required String settlement,
                Value<String?> note = const Value.absent(),
              }) => SupplierReturnsCompanion.insert(
                id: id,
                supplierId: supplierId,
                userId: userId,
                createdAt: createdAt,
                totalUsd: totalUsd,
                settlement: settlement,
                note: note,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SupplierReturnsTable, SupplierReturn>(table),
                  $$SupplierReturnsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({supplierId = false, supplierReturnItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (supplierReturnItemsRefs) db.supplierReturnItems],
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
                    if (supplierId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.supplierId,
                        referencedTable: $$SupplierReturnsTableReferences._supplierIdTable(db),
                        referencedColumn: $$SupplierReturnsTableReferences._supplierIdTable(db).id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (supplierReturnItemsRefs)
                    await $_getPrefetchedDataByColumns<
                      SupplierReturn,
                      $SupplierReturnsTable,
                      SupplierReturnItem,
                      $SupplierReturnItemsTable
                    >(
                      currentTable: table,
                      referencedTable: $$SupplierReturnsTableReferences._supplierReturnItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SupplierReturnsTableReferences(db, table, p0).supplierReturnItemsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'return_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SupplierReturnsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierReturnsTable,
      SupplierReturn,
      $$SupplierReturnsTableFilterComposer,
      $$SupplierReturnsTableOrderingComposer,
      $$SupplierReturnsTableAnnotationComposer,
      $$SupplierReturnsTableCreateCompanionBuilder,
      $$SupplierReturnsTableUpdateCompanionBuilder,
      (SupplierReturn, $$SupplierReturnsTableReferences),
      SupplierReturn,
      PrefetchHooks Function({bool supplierId, bool supplierReturnItemsRefs})
    >;
typedef $$SupplierReturnItemsTableCreateCompanionBuilder = SupplierReturnItemsCompanion Function({
  Value<int> id,
  required int returnId,
  required int batchId,
  required int medicineId,
  required int baseQuantity,
  required double amountUsd,
});
typedef $$SupplierReturnItemsTableUpdateCompanionBuilder = SupplierReturnItemsCompanion Function({
  Value<int> id,
  Value<int> returnId,
  Value<int> batchId,
  Value<int> medicineId,
  Value<int> baseQuantity,
  Value<double> amountUsd,
});

final class $$SupplierReturnItemsTableReferences
    extends BaseReferences<_$AppDatabase, $SupplierReturnItemsTable, SupplierReturnItem> {
  $$SupplierReturnItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SupplierReturnsTable _returnIdTable(_$AppDatabase db) =>
      db.supplierReturns.createAlias('supplier_return_items__return_id__supplier_returns__id');

  $$SupplierReturnsTableProcessedTableManager get returnId {
    final $_column = $_itemColumn<int>('return_id')!;

    final manager = $$SupplierReturnsTableTableManager(
      $_db,
      $_db.supplierReturns,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_returnIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $BatchesTable _batchIdTable(_$AppDatabase db) =>
      db.batches.createAlias('supplier_return_items__batch_id__batches__id');

  $$BatchesTableProcessedTableManager get batchId {
    final $_column = $_itemColumn<int>('batch_id')!;

    final manager = $$BatchesTableTableManager($_db, $_db.batches).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_batchIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }

  static $MedicinesTable _medicineIdTable(_$AppDatabase db) =>
      db.medicines.createAlias('supplier_return_items__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager($_db, $_db.medicines).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$SupplierReturnItemsTableFilterComposer extends Composer<_$AppDatabase, $SupplierReturnItemsTable> {
  $$SupplierReturnItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amountUsd =>
      $composableBuilder(column: $table.amountUsd, builder: (column) => ColumnFilters(column));

  $$SupplierReturnsTableFilterComposer get returnId {
    final $$SupplierReturnsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.supplierReturns,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnsTableFilterComposer(
            $db: $db,
            $table: $db.supplierReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableFilterComposer get batchId {
    final $$BatchesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableFilterComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierReturnItemsTableOrderingComposer extends Composer<_$AppDatabase, $SupplierReturnItemsTable> {
  $$SupplierReturnItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get baseQuantity =>
      $composableBuilder(column: $table.baseQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountUsd =>
      $composableBuilder(column: $table.amountUsd, builder: (column) => ColumnOrderings(column));

  $$SupplierReturnsTableOrderingComposer get returnId {
    final $$SupplierReturnsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.supplierReturns,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnsTableOrderingComposer(
            $db: $db,
            $table: $db.supplierReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableOrderingComposer get batchId {
    final $$BatchesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableOrderingComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierReturnItemsTableAnnotationComposer extends Composer<_$AppDatabase, $SupplierReturnItemsTable> {
  $$SupplierReturnItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get baseQuantity => $composableBuilder(column: $table.baseQuantity, builder: (column) => column);

  GeneratedColumn<double> get amountUsd => $composableBuilder(column: $table.amountUsd, builder: (column) => column);

  $$SupplierReturnsTableAnnotationComposer get returnId {
    final $$SupplierReturnsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.returnId,
      referencedTable: $db.supplierReturns,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$SupplierReturnsTableAnnotationComposer(
            $db: $db,
            $table: $db.supplierReturns,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BatchesTableAnnotationComposer get batchId {
    final $$BatchesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.batchId,
      referencedTable: $db.batches,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$BatchesTableAnnotationComposer(
            $db: $db,
            $table: $db.batches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder: (joinBuilder, {$addJoinBuilderToRootComposer, $removeJoinBuilderFromRootComposer}) =>
          $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer: $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SupplierReturnItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SupplierReturnItemsTable,
          SupplierReturnItem,
          $$SupplierReturnItemsTableFilterComposer,
          $$SupplierReturnItemsTableOrderingComposer,
          $$SupplierReturnItemsTableAnnotationComposer,
          $$SupplierReturnItemsTableCreateCompanionBuilder,
          $$SupplierReturnItemsTableUpdateCompanionBuilder,
          (SupplierReturnItem, $$SupplierReturnItemsTableReferences),
          SupplierReturnItem,
          PrefetchHooks Function({bool returnId, bool batchId, bool medicineId})
        > {
  $$SupplierReturnItemsTableTableManager(_$AppDatabase db, $SupplierReturnItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SupplierReturnItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SupplierReturnItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SupplierReturnItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> returnId = const Value.absent(),
                Value<int> batchId = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<int> baseQuantity = const Value.absent(),
                Value<double> amountUsd = const Value.absent(),
              }) => SupplierReturnItemsCompanion(
                id: id,
                returnId: returnId,
                batchId: batchId,
                medicineId: medicineId,
                baseQuantity: baseQuantity,
                amountUsd: amountUsd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int returnId,
                required int batchId,
                required int medicineId,
                required int baseQuantity,
                required double amountUsd,
              }) => SupplierReturnItemsCompanion.insert(
                id: id,
                returnId: returnId,
                batchId: batchId,
                medicineId: medicineId,
                baseQuantity: baseQuantity,
                amountUsd: amountUsd,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SupplierReturnItemsTable, SupplierReturnItem>(table),
                  $$SupplierReturnItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({returnId = false, batchId = false, medicineId = false}) {
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
                    if (returnId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.returnId,
                        referencedTable: $$SupplierReturnItemsTableReferences._returnIdTable(db),
                        referencedColumn: $$SupplierReturnItemsTableReferences._returnIdTable(db).id,
                      ) as T;
                    }
                    if (batchId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.batchId,
                        referencedTable: $$SupplierReturnItemsTableReferences._batchIdTable(db),
                        referencedColumn: $$SupplierReturnItemsTableReferences._batchIdTable(db).id,
                      ) as T;
                    }
                    if (medicineId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.medicineId,
                        referencedTable: $$SupplierReturnItemsTableReferences._medicineIdTable(db),
                        referencedColumn: $$SupplierReturnItemsTableReferences._medicineIdTable(db).id,
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

typedef $$SupplierReturnItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SupplierReturnItemsTable,
      SupplierReturnItem,
      $$SupplierReturnItemsTableFilterComposer,
      $$SupplierReturnItemsTableOrderingComposer,
      $$SupplierReturnItemsTableAnnotationComposer,
      $$SupplierReturnItemsTableCreateCompanionBuilder,
      $$SupplierReturnItemsTableUpdateCompanionBuilder,
      (SupplierReturnItem, $$SupplierReturnItemsTableReferences),
      SupplierReturnItem,
      PrefetchHooks Function({bool returnId, bool batchId, bool medicineId})
    >;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<int?> userId,
  Value<String?> userName,
  required String action,
  Value<String?> entity,
  Value<int?> entityId,
  Value<String?> details,
  Value<DateTime> createdAt,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<int?> userId,
  Value<String?> userName,
  Value<String> action,
  Value<String?> entity,
  Value<int?> entityId,
  Value<String?> details,
  Value<DateTime> createdAt,
});

class $$AuditLogsTableFilterComposer extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$AuditLogsTableOrderingComposer extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$AuditLogsTableAnnotationComposer extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId => $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get userName => $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get action => $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entity => $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<int> get entityId => $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get details => $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> entity = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                userId: userId,
                userName: userName,
                action: action,
                entity: entity,
                entityId: entityId,
                details: details,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> userId = const Value.absent(),
                Value<String?> userName = const Value.absent(),
                required String action,
                Value<String?> entity = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion.insert(
                id: id,
                userId: userId,
                userName: userName,
                action: action,
                entity: entity,
                entityId: entityId,
                details: details,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogsTable, AuditLog>(table),
                  BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users => $$UsersTableTableManager(_db, _db.users);
  $$SettingsTableTableManager get settings => $$SettingsTableTableManager(_db, _db.settings);
  $$ExchangeRatesTableTableManager get exchangeRates => $$ExchangeRatesTableTableManager(_db, _db.exchangeRates);
  $$MedicinesTableTableManager get medicines => $$MedicinesTableTableManager(_db, _db.medicines);
  $$SuppliersTableTableManager get suppliers => $$SuppliersTableTableManager(_db, _db.suppliers);
  $$BatchesTableTableManager get batches => $$BatchesTableTableManager(_db, _db.batches);
  $$StockAdjustmentsTableTableManager get stockAdjustments =>
      $$StockAdjustmentsTableTableManager(_db, _db.stockAdjustments);
  $$SupplierTransactionsTableTableManager get supplierTransactions =>
      $$SupplierTransactionsTableTableManager(_db, _db.supplierTransactions);
  $$CustomersTableTableManager get customers => $$CustomersTableTableManager(_db, _db.customers);
  $$CustomerTransactionsTableTableManager get customerTransactions =>
      $$CustomerTransactionsTableTableManager(_db, _db.customerTransactions);
  $$PurchasesTableTableManager get purchases => $$PurchasesTableTableManager(_db, _db.purchases);
  $$PurchaseItemsTableTableManager get purchaseItems => $$PurchaseItemsTableTableManager(_db, _db.purchaseItems);
  $$ShiftsTableTableManager get shifts => $$ShiftsTableTableManager(_db, _db.shifts);
  $$CashMovementsTableTableManager get cashMovements => $$CashMovementsTableTableManager(_db, _db.cashMovements);
  $$SalesTableTableManager get sales => $$SalesTableTableManager(_db, _db.sales);
  $$SaleItemsTableTableManager get saleItems => $$SaleItemsTableTableManager(_db, _db.saleItems);
  $$SaleItemBatchesTableTableManager get saleItemBatches =>
      $$SaleItemBatchesTableTableManager(_db, _db.saleItemBatches);
  $$CustomerReturnsTableTableManager get customerReturns =>
      $$CustomerReturnsTableTableManager(_db, _db.customerReturns);
  $$CustomerReturnItemsTableTableManager get customerReturnItems =>
      $$CustomerReturnItemsTableTableManager(_db, _db.customerReturnItems);
  $$SupplierReturnsTableTableManager get supplierReturns =>
      $$SupplierReturnsTableTableManager(_db, _db.supplierReturns);
  $$SupplierReturnItemsTableTableManager get supplierReturnItems =>
      $$SupplierReturnItemsTableTableManager(_db, _db.supplierReturnItems);
  $$AuditLogsTableTableManager get auditLogs => $$AuditLogsTableTableManager(_db, _db.auditLogs);
}
