// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class IzlyCredentialAdapter extends TypeAdapter<IzlyCredential> {
  @override
  final typeId = 15;

  @override
  IzlyCredential read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyCredential(
      username: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyCredential obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyCredentialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IzlyQrCodeAdapter extends TypeAdapter<IzlyQrCode> {
  @override
  final typeId = 16;

  @override
  IzlyQrCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyQrCode(
      qrCode: fields[0] as Uint8List,
      expirationDate: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyQrCode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.qrCode)
      ..writeByte(1)
      ..write(obj.expirationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyQrCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IzlyQrCodeListAdapter extends TypeAdapter<IzlyQrCodeList> {
  @override
  final typeId = 17;

  @override
  IzlyQrCodeList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyQrCodeList(
      qrCodes: (fields[0] as List).cast<IzlyQrCode>(),
    );
  }

  @override
  void write(BinaryWriter writer, IzlyQrCodeList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.qrCodes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyQrCodeListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuCrousAdapter extends TypeAdapter<MenuCrous> {
  @override
  final typeId = 32;

  @override
  MenuCrous read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MenuCrous(
      date: fields[0] as DateTime,
      type: fields[1] as MenuType,
      plats: (fields[3] as List).cast<PlatCrous>(),
    );
  }

  @override
  void write(BinaryWriter writer, MenuCrous obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.plats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuCrousAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RestaurantModelAdapter extends TypeAdapter<RestaurantModel> {
  @override
  final typeId = 33;

  @override
  RestaurantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      description: fields[2] as String,
      shortDescription: fields[3] as String,
      type: fields[4] as CrousType,
      lat: (fields[5] as num).toDouble(),
      lon: (fields[6] as num).toDouble(),
      opening: fields[7] as String,
      menus: (fields[8] as List).cast<MenuCrous>(),
      imageUrl: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.shortDescription)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.lat)
      ..writeByte(6)
      ..write(obj.lon)
      ..writeByte(7)
      ..write(obj.opening)
      ..writeByte(8)
      ..write(obj.menus)
      ..writeByte(9)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MenuTypeAdapter extends TypeAdapter<MenuType> {
  @override
  final typeId = 34;

  @override
  MenuType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MenuType.matin;
      case 1:
        return MenuType.midi;
      case 2:
        return MenuType.soir;
      default:
        return MenuType.matin;
    }
  }

  @override
  void write(BinaryWriter writer, MenuType obj) {
    switch (obj) {
      case MenuType.matin:
        writer.writeByte(0);
      case MenuType.midi:
        writer.writeByte(1);
      case MenuType.soir:
        writer.writeByte(2);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlatCrousAdapter extends TypeAdapter<PlatCrous> {
  @override
  final typeId = 36;

  @override
  PlatCrous read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlatCrous(
      name: fields[0] as String,
      variants: (fields[1] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlatCrous obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.variants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlatCrousAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CrousTypeAdapter extends TypeAdapter<CrousType> {
  @override
  final typeId = 38;

  @override
  CrousType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return CrousType.restaurant;
      case 1:
        return CrousType.cafet;
      default:
        return CrousType.restaurant;
    }
  }

  @override
  void write(BinaryWriter writer, CrousType obj) {
    switch (obj) {
      case CrousType.restaurant:
        writer.writeByte(0);
      case CrousType.cafet:
        writer.writeByte(1);
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CrousTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RestaurantListModelAdapter extends TypeAdapter<RestaurantListModel> {
  @override
  final typeId = 39;

  @override
  RestaurantListModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestaurantListModel(
      restaurantList: (fields[0] as List).cast<RestaurantModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RestaurantListModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.restaurantList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestaurantListModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IzlyPaymentModelAdapter extends TypeAdapter<IzlyPaymentModel> {
  @override
  final typeId = 40;

  @override
  IzlyPaymentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyPaymentModel(
      paymentTime: fields[3] as DateTime,
      amountSpent: (fields[4] as num).toDouble(),
      isSucess: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IzlyPaymentModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(2)
      ..write(obj.isSucess)
      ..writeByte(3)
      ..write(obj.paymentTime)
      ..writeByte(4)
      ..write(obj.amountSpent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyPaymentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class IzlyPaymentModelListAdapter extends TypeAdapter<IzlyPaymentModelList> {
  @override
  final typeId = 41;

  @override
  IzlyPaymentModelList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IzlyPaymentModelList(
      payments: (fields[0] as List).cast<IzlyPaymentModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, IzlyPaymentModelList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.payments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IzlyPaymentModelListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
