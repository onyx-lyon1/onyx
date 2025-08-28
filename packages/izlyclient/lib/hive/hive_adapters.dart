import 'dart:typed_data';

import 'package:hive_ce/hive.dart';
import 'package:izlyclient/src/model/izly_credential.dart';
import 'package:izlyclient/src/model/izly_payment_model.dart';
import 'package:izlyclient/src/model/izly_payment_model_list.dart';
import 'package:izlyclient/src/model/izly_qrcode.dart';
import 'package:izlyclient/src/model/izly_qrcode_list.dart';
import 'package:izlyclient/src/model/menu_crous.dart';
import 'package:izlyclient/src/model/restaurant.dart';
import 'package:izlyclient/src/model/restaurant_list_model.dart';

@GenerateAdapters([
  AdapterSpec<IzlyCredential>(),
  AdapterSpec<IzlyQrCode>(),
  AdapterSpec<IzlyQrCodeList>(),
  AdapterSpec<MenuCrous>(),
  AdapterSpec<RestaurantModel>(),
  AdapterSpec<MenuType>(),
  AdapterSpec<PlatCrous>(),
  AdapterSpec<CrousType>(),
  AdapterSpec<RestaurantListModel>(),
  AdapterSpec<IzlyPaymentModel>(),
  AdapterSpec<IzlyPaymentModelList>(),
])
part 'generated/hive_adapters.g.dart';
