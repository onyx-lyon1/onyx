// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'kholle.dart';

class KholleMapper extends ClassMapperBase<Kholle> {
  KholleMapper._();

  static KholleMapper? _instance;
  static KholleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KholleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Kholle';

  static DateTime _$date(Kholle v) => v.date;
  static const Field<Kholle, DateTime> _f$date = Field('date', _$date);
  static String _$subject(Kholle v) => v.subject;
  static const Field<Kholle, String> _f$subject = Field('subject', _$subject);
  static String _$kholleur(Kholle v) => v.kholleur;
  static const Field<Kholle, String> _f$kholleur =
      Field('kholleur', _$kholleur);
  static String? _$message(Kholle v) => v.message;
  static const Field<Kholle, String> _f$message = Field('message', _$message);
  static String? _$room(Kholle v) => v.room;
  static const Field<Kholle, String> _f$room = Field('room', _$room);

  @override
  final Map<Symbol, Field<Kholle, dynamic>> fields = const {
    #date: _f$date,
    #subject: _f$subject,
    #kholleur: _f$kholleur,
    #message: _f$message,
    #room: _f$room,
  };

  static Kholle _instantiate(DecodingData data) {
    return Kholle(data.dec(_f$date), data.dec(_f$subject),
        data.dec(_f$kholleur), data.dec(_f$message), data.dec(_f$room));
  }

  @override
  final Function instantiate = _instantiate;

  static Kholle fromJson(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Kholle>(map);
  }

  static Kholle deserialize(String json) {
    return ensureInitialized().decodeJson<Kholle>(json);
  }
}

mixin KholleMappable {
  String serialize() {
    return KholleMapper.ensureInitialized().encodeJson<Kholle>(this as Kholle);
  }

  Map<String, dynamic> toJson() {
    return KholleMapper.ensureInitialized().encodeMap<Kholle>(this as Kholle);
  }

  KholleCopyWith<Kholle, Kholle, Kholle> get copyWith =>
      _KholleCopyWithImpl(this as Kholle, $identity, $identity);
  @override
  String toString() {
    return KholleMapper.ensureInitialized().stringifyValue(this as Kholle);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (runtimeType == other.runtimeType &&
            KholleMapper.ensureInitialized()
                .isValueEqual(this as Kholle, other));
  }

  @override
  int get hashCode {
    return KholleMapper.ensureInitialized().hashValue(this as Kholle);
  }
}

extension KholleValueCopy<$R, $Out> on ObjectCopyWith<$R, Kholle, $Out> {
  KholleCopyWith<$R, Kholle, $Out> get $asKholle =>
      $base.as((v, t, t2) => _KholleCopyWithImpl(v, t, t2));
}

abstract class KholleCopyWith<$R, $In extends Kholle, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {DateTime? date,
      String? subject,
      String? kholleur,
      String? message,
      String? room});
  KholleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _KholleCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Kholle, $Out>
    implements KholleCopyWith<$R, Kholle, $Out> {
  _KholleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Kholle> $mapper = KholleMapper.ensureInitialized();
  @override
  $R call(
          {DateTime? date,
          String? subject,
          String? kholleur,
          Object? message = $none,
          Object? room = $none}) =>
      $apply(FieldCopyWithData({
        if (date != null) #date: date,
        if (subject != null) #subject: subject,
        if (kholleur != null) #kholleur: kholleur,
        if (message != $none) #message: message,
        if (room != $none) #room: room
      }));
  @override
  Kholle $make(CopyWithData data) => Kholle(
      data.get(#date, or: $value.date),
      data.get(#subject, or: $value.subject),
      data.get(#kholleur, or: $value.kholleur),
      data.get(#message, or: $value.message),
      data.get(#room, or: $value.room));

  @override
  KholleCopyWith<$R2, Kholle, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _KholleCopyWithImpl($value, $cast, t);
}
