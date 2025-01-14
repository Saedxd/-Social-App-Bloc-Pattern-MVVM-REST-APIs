// GENERATED CODE - DO NOT MODIFY BY HAND

part of UsersRequestsModel;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<UsersRequestsModel> _$usersRequestsModelSerializer =
    new _$UsersRequestsModelSerializer();

class _$UsersRequestsModelSerializer
    implements StructuredSerializer<UsersRequestsModel> {
  @override
  final Iterable<Type> types = const [UsersRequestsModel, _$UsersRequestsModel];
  @override
  final String wireName = 'UsersRequestsModel';

  @override
  Iterable<Object?> serialize(
      Serializers serializers, UsersRequestsModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.serial;
    if (value != null) {
      result
        ..add('serial')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.serialnumber;
    if (value != null) {
      result
        ..add('serialnumber')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.alias;
    if (value != null) {
      result
        ..add('alias')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.background_color;
    if (value != null) {
      result
        ..add('background_color')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.avatar;
    if (value != null) {
      result
        ..add('avatar')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.me_id;
    if (value != null) {
      result
        ..add('me_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.is_friend;
    if (value != null) {
      result
        ..add('is_friend')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.bio;
    if (value != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  UsersRequestsModel deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UsersRequestsModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'serial':
          result.serial = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'serialnumber':
          result.serialnumber = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'alias':
          result.alias = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'background_color':
          result.background_color = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'avatar':
          result.avatar = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'me_id':
          result.me_id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'is_friend':
          result.is_friend = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$UsersRequestsModel extends UsersRequestsModel {
  @override
  final String? serial;
  @override
  final String? serialnumber;
  @override
  final String? alias;
  @override
  final String? background_color;
  @override
  final String? avatar;
  @override
  final int? id;
  @override
  final int? me_id;
  @override
  final bool? is_friend;
  @override
  final String? bio;

  factory _$UsersRequestsModel(
          [void Function(UsersRequestsModelBuilder)? updates]) =>
      (new UsersRequestsModelBuilder()..update(updates))._build();

  _$UsersRequestsModel._(
      {this.serial,
      this.serialnumber,
      this.alias,
      this.background_color,
      this.avatar,
      this.id,
      this.me_id,
      this.is_friend,
      this.bio})
      : super._();

  @override
  UsersRequestsModel rebuild(
          void Function(UsersRequestsModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UsersRequestsModelBuilder toBuilder() =>
      new UsersRequestsModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UsersRequestsModel &&
        serial == other.serial &&
        serialnumber == other.serialnumber &&
        alias == other.alias &&
        background_color == other.background_color &&
        avatar == other.avatar &&
        id == other.id &&
        me_id == other.me_id &&
        is_friend == other.is_friend &&
        bio == other.bio;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc(0, serial.hashCode),
                                    serialnumber.hashCode),
                                alias.hashCode),
                            background_color.hashCode),
                        avatar.hashCode),
                    id.hashCode),
                me_id.hashCode),
            is_friend.hashCode),
        bio.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UsersRequestsModel')
          ..add('serial', serial)
          ..add('serialnumber', serialnumber)
          ..add('alias', alias)
          ..add('background_color', background_color)
          ..add('avatar', avatar)
          ..add('id', id)
          ..add('me_id', me_id)
          ..add('is_friend', is_friend)
          ..add('bio', bio))
        .toString();
  }
}

class UsersRequestsModelBuilder
    implements Builder<UsersRequestsModel, UsersRequestsModelBuilder> {
  _$UsersRequestsModel? _$v;

  String? _serial;
  String? get serial => _$this._serial;
  set serial(String? serial) => _$this._serial = serial;

  String? _serialnumber;
  String? get serialnumber => _$this._serialnumber;
  set serialnumber(String? serialnumber) => _$this._serialnumber = serialnumber;

  String? _alias;
  String? get alias => _$this._alias;
  set alias(String? alias) => _$this._alias = alias;

  String? _background_color;
  String? get background_color => _$this._background_color;
  set background_color(String? background_color) =>
      _$this._background_color = background_color;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _me_id;
  int? get me_id => _$this._me_id;
  set me_id(int? me_id) => _$this._me_id = me_id;

  bool? _is_friend;
  bool? get is_friend => _$this._is_friend;
  set is_friend(bool? is_friend) => _$this._is_friend = is_friend;

  String? _bio;
  String? get bio => _$this._bio;
  set bio(String? bio) => _$this._bio = bio;

  UsersRequestsModelBuilder();

  UsersRequestsModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _serial = $v.serial;
      _serialnumber = $v.serialnumber;
      _alias = $v.alias;
      _background_color = $v.background_color;
      _avatar = $v.avatar;
      _id = $v.id;
      _me_id = $v.me_id;
      _is_friend = $v.is_friend;
      _bio = $v.bio;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UsersRequestsModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$UsersRequestsModel;
  }

  @override
  void update(void Function(UsersRequestsModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UsersRequestsModel build() => _build();

  _$UsersRequestsModel _build() {
    final _$result = _$v ??
        new _$UsersRequestsModel._(
            serial: serial,
            serialnumber: serialnumber,
            alias: alias,
            background_color: background_color,
            avatar: avatar,
            id: id,
            me_id: me_id,
            is_friend: is_friend,
            bio: bio);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new,unnecessary_lambdas
