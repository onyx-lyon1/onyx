// ignore_for_file: unused_local_variable

import 'dart:io';
import 'dart:typed_data';

import 'package:izlyclient/izlyclient.dart';

void main() async {
  // Create a new IzlyClient instance
  IzlyClient izlyClient = IzlyClient("username", "password");
  //connect to izly
  await izlyClient.login();
  //get the balance
  double balance = await izlyClient.getBalance();
  //get 3 QRCode
  Uint8List qrCode = await izlyClient.getQRCode();
  //save the QRCode
  await File("qrCode.png").writeAsBytes(qrCode);
  //get the url to recharge with a account transfer
  var transferRequest = await izlyClient.getTransferPaymentUrl(10.0);
  //do a get request to transferRequest.url

  //recharge with a credit card
  //first get available cb
  List<CbModel> cbs = await izlyClient.getAvailableCBs();
  //get the request to pay with a cb
  var cbRequest = await izlyClient.rechargeWithCB(10.0, cbs.first);
  //do a post request to cbRequest.url with the body cbRequest.body

  //recharge via someone else
  bool result2 =
      await izlyClient.rechargeViaSomeoneElse(10.0, "email", "message");
}
