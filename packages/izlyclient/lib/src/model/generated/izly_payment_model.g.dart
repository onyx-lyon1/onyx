// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../izly_payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IzlyPaymentModel _$IzlyPaymentModelFromJson(Map<String, dynamic> json) =>
    IzlyPaymentModel(
      paymentTime: DateTime.parse(json['paymentTime'] as String),
      amountSpent: (json['amountSpent'] as num).toDouble(),
      isSucess: json['isSucess'] as bool,
    );

Map<String, dynamic> _$IzlyPaymentModelToJson(IzlyPaymentModel instance) =>
    <String, dynamic>{
      'paymentTime': instance.paymentTime.toIso8601String(),
      'amountSpent': instance.amountSpent,
      'isSucess': instance.isSucess,
    };
