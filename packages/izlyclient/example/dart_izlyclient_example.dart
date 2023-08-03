// ignore_for_file: unused_local_variable

import 'dart:typed_data';
import 'dart:io';

import 'package:izlyclient/izlyclient.dart';

void main() async {
  // Create a new IzlyClient instance
  IzlyClient izlyClient = IzlyClient("username", "password");
  //connect to izly
  await izlyClient.login();
  //get the balance
  double balance = await izlyClient.getBalance();
  //get 3 QRCode
  List<Uint8List> qrCodes = await izlyClient.getNQRCode(3);
  //save the QRCode
  for (int i = 0; i < qrCodes.length; i++) {
    await File("qrCode$i.png").writeAsBytes(qrCodes[i]);
  }
  //get the url to recharge with a account transfer
  RequestData transferRequest = await izlyClient.getTransferPaymentUrl(10.0);
  //do a get request to transferRequest.url

  //recharge with a credit card
  //first get available cb
  List<CbModel> cbs = await izlyClient.getAvailableCBs();
  //get the request to pay with a cb
  RequestData cbRequest = await izlyClient.rechargeWithCB(10.0, cbs.first);
  //do a post request to cbRequest.url with the body cbRequest.body

  //recharge via someone else
  bool result2 =
      await izlyClient.rechargeViaSomeoneElse(10.0, "email", "message");
}
