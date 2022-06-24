// GENERATED CODE - DO NOT MODIFY BY HAND

part of Chat_Event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetOldMessages extends GetOldMessages {
  @override
  final int? receiver_id;

  factory _$GetOldMessages([void Function(GetOldMessagesBuilder)? updates]) =>
      (new GetOldMessagesBuilder()..update(updates))._build();

  _$GetOldMessages._({this.receiver_id}) : super._();

  @override
  GetOldMessages rebuild(void Function(GetOldMessagesBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetOldMessagesBuilder toBuilder() =>
      new GetOldMessagesBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetOldMessages && receiver_id == other.receiver_id;
  }

  @override
  int get hashCode {
    return $jf($jc(0, receiver_id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetOldMessages')
          ..add('receiver_id', receiver_id))
        .toString();
  }
}

class GetOldMessagesBuilder
    implements Builder<GetOldMessages, GetOldMessagesBuilder> {
  _$GetOldMessages? _$v;

  int? _receiver_id;
  int? get receiver_id => _$this._receiver_id;
  set receiver_id(int? receiver_id) => _$this._receiver_id = receiver_id;

  GetOldMessagesBuilder();

  GetOldMessagesBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiver_id = $v.receiver_id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetOldMessages other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetOldMessages;
  }

  @override
  void update(void Function(GetOldMessagesBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetOldMessages build() => _build();

  _$GetOldMessages _build() {
    final _$result = _$v ?? new _$GetOldMessages._(receiver_id: receiver_id);
    replace(_$result);
    return _$result;
  }
}

class _$Done extends Done {
  @override
  final bool? Donee;

  factory _$Done([void Function(DoneBuilder)? updates]) =>
      (new DoneBuilder()..update(updates))._build();

  _$Done._({this.Donee}) : super._();

  @override
  Done rebuild(void Function(DoneBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DoneBuilder toBuilder() => new DoneBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Done && Donee == other.Donee;
  }

  @override
  int get hashCode {
    return $jf($jc(0, Donee.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Done')..add('Donee', Donee))
        .toString();
  }
}

class DoneBuilder implements Builder<Done, DoneBuilder> {
  _$Done? _$v;

  bool? _Donee;
  bool? get Donee => _$this._Donee;
  set Donee(bool? Donee) => _$this._Donee = Donee;

  DoneBuilder();

  DoneBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _Donee = $v.Donee;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Done other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Done;
  }

  @override
  void update(void Function(DoneBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Done build() => _build();

  _$Done _build() {
    final _$result = _$v ?? new _$Done._(Donee: Donee);
    replace(_$result);
    return _$result;
  }
}

class _$GetAlias extends GetAlias {
  @override
  final int? HIS_ID;
  @override
  final int? My_ID;

  factory _$GetAlias([void Function(GetAliasBuilder)? updates]) =>
      (new GetAliasBuilder()..update(updates))._build();

  _$GetAlias._({this.HIS_ID, this.My_ID}) : super._();

  @override
  GetAlias rebuild(void Function(GetAliasBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetAliasBuilder toBuilder() => new GetAliasBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetAlias && HIS_ID == other.HIS_ID && My_ID == other.My_ID;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, HIS_ID.hashCode), My_ID.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GetAlias')
          ..add('HIS_ID', HIS_ID)
          ..add('My_ID', My_ID))
        .toString();
  }
}

class GetAliasBuilder implements Builder<GetAlias, GetAliasBuilder> {
  _$GetAlias? _$v;

  int? _HIS_ID;
  int? get HIS_ID => _$this._HIS_ID;
  set HIS_ID(int? HIS_ID) => _$this._HIS_ID = HIS_ID;

  int? _My_ID;
  int? get My_ID => _$this._My_ID;
  set My_ID(int? My_ID) => _$this._My_ID = My_ID;

  GetAliasBuilder();

  GetAliasBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _HIS_ID = $v.HIS_ID;
      _My_ID = $v.My_ID;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetAlias other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GetAlias;
  }

  @override
  void update(void Function(GetAliasBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetAlias build() => _build();

  _$GetAlias _build() {
    final _$result = _$v ?? new _$GetAlias._(HIS_ID: HIS_ID, My_ID: My_ID);
    replace(_$result);
    return _$result;
  }
}

class _$SendMessage extends SendMessage {
  @override
  final int? receiver_id;
  @override
  final String? message;

  factory _$SendMessage([void Function(SendMessageBuilder)? updates]) =>
      (new SendMessageBuilder()..update(updates))._build();

  _$SendMessage._({this.receiver_id, this.message}) : super._();

  @override
  SendMessage rebuild(void Function(SendMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendMessageBuilder toBuilder() => new SendMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendMessage &&
        receiver_id == other.receiver_id &&
        message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, receiver_id.hashCode), message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SendMessage')
          ..add('receiver_id', receiver_id)
          ..add('message', message))
        .toString();
  }
}

class SendMessageBuilder implements Builder<SendMessage, SendMessageBuilder> {
  _$SendMessage? _$v;

  int? _receiver_id;
  int? get receiver_id => _$this._receiver_id;
  set receiver_id(int? receiver_id) => _$this._receiver_id = receiver_id;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SendMessageBuilder();

  SendMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _receiver_id = $v.receiver_id;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendMessage other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendMessage;
  }

  @override
  void update(void Function(SendMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendMessage build() => _build();

  _$SendMessage _build() {
    final _$result =
        _$v ?? new _$SendMessage._(receiver_id: receiver_id, message: message);
    replace(_$result);
    return _$result;
  }
}

class _$ShowReplyWidget extends ShowReplyWidget {
  @override
  final String? AvatarPathForRepliedTo;
  @override
  final int? ColorForRepliedTo;
  @override
  final String? RepliedToMessage;
  @override
  final String? AliasForRepliedTo;
  @override
  final bool? Isreply;

  factory _$ShowReplyWidget([void Function(ShowReplyWidgetBuilder)? updates]) =>
      (new ShowReplyWidgetBuilder()..update(updates))._build();

  _$ShowReplyWidget._(
      {this.AvatarPathForRepliedTo,
      this.ColorForRepliedTo,
      this.RepliedToMessage,
      this.AliasForRepliedTo,
      this.Isreply})
      : super._();

  @override
  ShowReplyWidget rebuild(void Function(ShowReplyWidgetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ShowReplyWidgetBuilder toBuilder() =>
      new ShowReplyWidgetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ShowReplyWidget &&
        AvatarPathForRepliedTo == other.AvatarPathForRepliedTo &&
        ColorForRepliedTo == other.ColorForRepliedTo &&
        RepliedToMessage == other.RepliedToMessage &&
        AliasForRepliedTo == other.AliasForRepliedTo &&
        Isreply == other.Isreply;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc(0, AvatarPathForRepliedTo.hashCode),
                    ColorForRepliedTo.hashCode),
                RepliedToMessage.hashCode),
            AliasForRepliedTo.hashCode),
        Isreply.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ShowReplyWidget')
          ..add('AvatarPathForRepliedTo', AvatarPathForRepliedTo)
          ..add('ColorForRepliedTo', ColorForRepliedTo)
          ..add('RepliedToMessage', RepliedToMessage)
          ..add('AliasForRepliedTo', AliasForRepliedTo)
          ..add('Isreply', Isreply))
        .toString();
  }
}

class ShowReplyWidgetBuilder
    implements Builder<ShowReplyWidget, ShowReplyWidgetBuilder> {
  _$ShowReplyWidget? _$v;

  String? _AvatarPathForRepliedTo;
  String? get AvatarPathForRepliedTo => _$this._AvatarPathForRepliedTo;
  set AvatarPathForRepliedTo(String? AvatarPathForRepliedTo) =>
      _$this._AvatarPathForRepliedTo = AvatarPathForRepliedTo;

  int? _ColorForRepliedTo;
  int? get ColorForRepliedTo => _$this._ColorForRepliedTo;
  set ColorForRepliedTo(int? ColorForRepliedTo) =>
      _$this._ColorForRepliedTo = ColorForRepliedTo;

  String? _RepliedToMessage;
  String? get RepliedToMessage => _$this._RepliedToMessage;
  set RepliedToMessage(String? RepliedToMessage) =>
      _$this._RepliedToMessage = RepliedToMessage;

  String? _AliasForRepliedTo;
  String? get AliasForRepliedTo => _$this._AliasForRepliedTo;
  set AliasForRepliedTo(String? AliasForRepliedTo) =>
      _$this._AliasForRepliedTo = AliasForRepliedTo;

  bool? _Isreply;
  bool? get Isreply => _$this._Isreply;
  set Isreply(bool? Isreply) => _$this._Isreply = Isreply;

  ShowReplyWidgetBuilder();

  ShowReplyWidgetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _AvatarPathForRepliedTo = $v.AvatarPathForRepliedTo;
      _ColorForRepliedTo = $v.ColorForRepliedTo;
      _RepliedToMessage = $v.RepliedToMessage;
      _AliasForRepliedTo = $v.AliasForRepliedTo;
      _Isreply = $v.Isreply;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ShowReplyWidget other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ShowReplyWidget;
  }

  @override
  void update(void Function(ShowReplyWidgetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ShowReplyWidget build() => _build();

  _$ShowReplyWidget _build() {
    final _$result = _$v ??
        new _$ShowReplyWidget._(
            AvatarPathForRepliedTo: AvatarPathForRepliedTo,
            ColorForRepliedTo: ColorForRepliedTo,
            RepliedToMessage: RepliedToMessage,
            AliasForRepliedTo: AliasForRepliedTo,
            Isreply: Isreply);
    replace(_$result);
    return _$result;
  }
}

class _$SendStatus extends SendStatus {
  @override
  final bool? Status;

  factory _$SendStatus([void Function(SendStatusBuilder)? updates]) =>
      (new SendStatusBuilder()..update(updates))._build();

  _$SendStatus._({this.Status}) : super._();

  @override
  SendStatus rebuild(void Function(SendStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SendStatusBuilder toBuilder() => new SendStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SendStatus && Status == other.Status;
  }

  @override
  int get hashCode {
    return $jf($jc(0, Status.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SendStatus')..add('Status', Status))
        .toString();
  }
}

class SendStatusBuilder implements Builder<SendStatus, SendStatusBuilder> {
  _$SendStatus? _$v;

  bool? _Status;
  bool? get Status => _$this._Status;
  set Status(bool? Status) => _$this._Status = Status;

  SendStatusBuilder();

  SendStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _Status = $v.Status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SendStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SendStatus;
  }

  @override
  void update(void Function(SendStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SendStatus build() => _build();

  _$SendStatus _build() {
    final _$result = _$v ?? new _$SendStatus._(Status: Status);
    replace(_$result);
    return _$result;
  }
}

class _$addReply extends addReply {
  @override
  final String? comment;
  @override
  final int? message_id;

  factory _$addReply([void Function(addReplyBuilder)? updates]) =>
      (new addReplyBuilder()..update(updates))._build();

  _$addReply._({this.comment, this.message_id}) : super._();

  @override
  addReply rebuild(void Function(addReplyBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  addReplyBuilder toBuilder() => new addReplyBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is addReply &&
        comment == other.comment &&
        message_id == other.message_id;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, comment.hashCode), message_id.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('addReply')
          ..add('comment', comment)
          ..add('message_id', message_id))
        .toString();
  }
}

class addReplyBuilder implements Builder<addReply, addReplyBuilder> {
  _$addReply? _$v;

  String? _comment;
  String? get comment => _$this._comment;
  set comment(String? comment) => _$this._comment = comment;

  int? _message_id;
  int? get message_id => _$this._message_id;
  set message_id(int? message_id) => _$this._message_id = message_id;

  addReplyBuilder();

  addReplyBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _comment = $v.comment;
      _message_id = $v.message_id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(addReply other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$addReply;
  }

  @override
  void update(void Function(addReplyBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  addReply build() => _build();

  _$addReply _build() {
    final _$result =
        _$v ?? new _$addReply._(comment: comment, message_id: message_id);
    replace(_$result);
    return _$result;
  }
}

class _$AddModel extends AddModel {
  @override
  final MessageModel? message;

  factory _$AddModel([void Function(AddModelBuilder)? updates]) =>
      (new AddModelBuilder()..update(updates))._build();

  _$AddModel._({this.message}) : super._();

  @override
  AddModel rebuild(void Function(AddModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AddModelBuilder toBuilder() => new AddModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AddModel && message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AddModel')..add('message', message))
        .toString();
  }
}

class AddModelBuilder implements Builder<AddModel, AddModelBuilder> {
  _$AddModel? _$v;

  MessageModel? _message;
  MessageModel? get message => _$this._message;
  set message(MessageModel? message) => _$this._message = message;

  AddModelBuilder();

  AddModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AddModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$AddModel;
  }

  @override
  void update(void Function(AddModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AddModel build() => _build();

  _$AddModel _build() {
    final _$result = _$v ?? new _$AddModel._(message: message);
    replace(_$result);
    return _$result;
  }
}

class _$ChangeTypingStatus extends ChangeTypingStatus {
  @override
  final bool? ChangeStatus;

  factory _$ChangeTypingStatus(
          [void Function(ChangeTypingStatusBuilder)? updates]) =>
      (new ChangeTypingStatusBuilder()..update(updates))._build();

  _$ChangeTypingStatus._({this.ChangeStatus}) : super._();

  @override
  ChangeTypingStatus rebuild(
          void Function(ChangeTypingStatusBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChangeTypingStatusBuilder toBuilder() =>
      new ChangeTypingStatusBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChangeTypingStatus && ChangeStatus == other.ChangeStatus;
  }

  @override
  int get hashCode {
    return $jf($jc(0, ChangeStatus.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChangeTypingStatus')
          ..add('ChangeStatus', ChangeStatus))
        .toString();
  }
}

class ChangeTypingStatusBuilder
    implements Builder<ChangeTypingStatus, ChangeTypingStatusBuilder> {
  _$ChangeTypingStatus? _$v;

  bool? _ChangeStatus;
  bool? get ChangeStatus => _$this._ChangeStatus;
  set ChangeStatus(bool? ChangeStatus) => _$this._ChangeStatus = ChangeStatus;

  ChangeTypingStatusBuilder();

  ChangeTypingStatusBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ChangeStatus = $v.ChangeStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChangeTypingStatus other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChangeTypingStatus;
  }

  @override
  void update(void Function(ChangeTypingStatusBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChangeTypingStatus build() => _build();

  _$ChangeTypingStatus _build() {
    final _$result =
        _$v ?? new _$ChangeTypingStatus._(ChangeStatus: ChangeStatus);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,no_leading_underscores_for_local_identifiers,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
