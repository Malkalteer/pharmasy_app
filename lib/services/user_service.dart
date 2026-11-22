import 'dart:convert';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:drift/drift.dart';

import '../core/permissions.dart';
import '../data/database.dart';
import 'audit_service.dart';

class UserService {
  final AppDatabase db;
  final AuditService audit;

  UserService(this.db, this.audit);

  static const _iterations = 20000;

  static String _randomSalt() {
    final r = Random.secure();
    return base64Encode(List.generate(16, (_) => r.nextInt(256)));
  }

  static Future<String> hashPassword(String password, String salt) async {
    final algo = Pbkdf2(macAlgorithm: Hmac.sha256(), iterations: _iterations, bits: 256);
    final key = await algo.deriveKeyFromPassword(password: password, nonce: base64Decode(salt));
    return base64Encode(await key.extractBytes());
  }

  Future<bool> hasUsers() async {
    final c = await (db.selectOnly(
      db.users,
    )..addColumns([db.users.id.count()])).map((r) => r.read(db.users.id.count())).getSingle();
    return (c ?? 0) > 0;
  }

  Future<List<User>> list({bool activeOnly = false}) {
    final q = db.select(db.users);
    if (activeOnly) q.where((t) => t.active.equals(true));
    q.orderBy([(t) => OrderingTerm.asc(t.fullName)]);
    return q.get();
  }

  Future<User?> byId(int id) => (db.select(db.users)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<User?> authenticate(String username, String password) async {
    final u = await (db.select(
      db.users,
    )..where((t) => t.username.equals(username.trim().toLowerCase()))).getSingleOrNull();
    if (u == null || !u.active) {
      await audit.log(null, AuditActions.loginFailed, details: username);
      return null;
    }
    final h = await hashPassword(password, u.salt);
    if (h != u.passwordHash) {
      await audit.log(u, AuditActions.loginFailed);
      return null;
    }
    await audit.log(u, AuditActions.login);
    return u;
  }

  Future<bool> verifyPassword(User u, String password) async => await hashPassword(password, u.salt) == u.passwordHash;

  Future<User> create({
    required User? actor,
    required String username,
    required String fullName,
    required String password,
    required String role,
    Set<Permission> permissions = const {},
  }) async {
    if (actor != null && !actor.isOwner) throw PermissionDenied();
    final uname = username.trim().toLowerCase();
    if (uname.isEmpty) throw BusinessException('اسم المستخدم مطلوب');
    if (password.length < 4) {
      throw BusinessException('كلمة المرور يجب أن تكون 4 أحرف على الأقل');
    }
    final exists = await (db.select(db.users)..where((t) => t.username.equals(uname))).getSingleOrNull();
    if (exists != null) throw BusinessException('اسم المستخدم موجود مسبقاً');
    final salt = _randomSalt();
    final id = await db
        .into(db.users)
        .insert(
          UsersCompanion.insert(
            username: uname,
            fullName: fullName.trim(),
            passwordHash: await hashPassword(password, salt),
            salt: salt,
            role: role,
            permissions: Value(encodePermissions(permissions)),
          ),
        );
    final u = (await byId(id))!;
    await audit.log(
      actor ?? u,
      AuditActions.userCreated,
      entity: 'user',
      entityId: id,
      details: {'username': uname, 'role': role},
    );
    return u;
  }

  Future<void> update({
    required User actor,
    required User user,
    required String fullName,
    required String role,
    required Set<Permission> permissions,
    required bool active,
  }) async {
    if (!actor.isOwner) throw PermissionDenied();
    if (user.isOwner && (role != roleOwner || !active)) {
      final owners = (await list()).where((u) => u.isOwner && u.active && u.id != user.id).length;
      if (owners == 0) {
        throw BusinessException('يجب أن يبقى مالك واحد فعّال على الأقل');
      }
    }
    await (db.update(db.users)..where((t) => t.id.equals(user.id))).write(
      UsersCompanion(
        fullName: Value(fullName.trim()),
        role: Value(role),
        permissions: Value(encodePermissions(permissions)),
        active: Value(active),
      ),
    );
    await audit.log(
      actor,
      AuditActions.userUpdated,
      entity: 'user',
      entityId: user.id,
      details: {'role': role, 'active': active, 'permissions': permissions.map((p) => p.label).toList()},
    );
  }

  Future<void> changePassword({required User actor, required User user, required String newPassword}) async {
    if (!actor.isOwner && actor.id != user.id) throw PermissionDenied();
    if (newPassword.length < 4) {
      throw BusinessException('كلمة المرور يجب أن تكون 4 أحرف على الأقل');
    }
    final salt = _randomSalt();
    await (db.update(db.users)..where((t) => t.id.equals(user.id))).write(
      UsersCompanion(salt: Value(salt), passwordHash: Value(await hashPassword(newPassword, salt))),
    );
    await audit.log(actor, AuditActions.passwordChanged, entity: 'user', entityId: user.id, details: user.username);
  }
}
