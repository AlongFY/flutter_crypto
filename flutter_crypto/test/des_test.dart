// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:fluttercrypto/des/des.dart';
import 'package:fluttercrypto/util/crypto_util.dart';
import 'package:fluttercrypto/util/number_utils.dart';

void main() {
  test('hex test', () {
    List<int> list = CryptoUtil.hex2List('0123456789ABCDEF');
    print(list.toString());
    list.forEach((i) {
      print(NumberUtils.to8Bit(i).toString());
      print(NumberUtils.intFromBits(NumberUtils.to8Bit(i)));
    });

    //print([1, 2, 3, 4, 5, 6].sublist(0, 4).toString());
  });

  test('des ecb test', () async {
    //
    String hexKey = 'C2#I2w*j';
    hexKey = CryptoUtil.list2Hex(hexKey.codeUnits);
    String data = '''{
        "error_code": 0,
    }''';

    String cipher = DES().encryptToHexWithECB(data, hexKey);
    print('cipher $cipher');
    String text = 'e6955KPw5ULTr2QEmodPTU5FcndK/n7xnujqjORQcrbcU/hIz1fxPdkrjpkM4Tn6nujqjORQcrY+gRAYOn7ocs191knby4cScZrx23eKlXHnprJ9ZC9XWZa/C/2GE4FdOTkQ5vB7PeYidqRv+PeZRuemsn1kL1dZNxaEiye5gNy2iMTv84aHUgldIN7C1mMa5pB5TZkUy0t4NGKtLwCIqYTMIMYTm/iypXtBQR5cTX1qMzT+weq+vOEREE6As7aoJHffxufH3gupxutsLpTWh920AZCq4wtQefe6+2ca7UM1Ta+kX7uNHDQw/xhYuU83IrhllquUjUYlh4RJtkvrHWyAK2btcEldfxsKnVpRnLBBlldOntu67N7HTX/Ogd1/Xb0OiaMZEfu0d+VEPFuChB6adjrisaU1qQFpTtfLYY8suWYTwaxjI2zNtZg4Q6Fxr+DOlyDFWzadnOX/Fxy4AD1T8GpLMenLjf4DlDF8pdPeHUIsePg+J04oBSZBjyQziws8Sd0weB9aDcPVi5CqC5yQlgXs1FS/sMbg4y8rpKOFgXpC8y78vAfZDB0AY5lxfNEM4dzjDOo/ZfjmQM0B+PwJm7l5iZ6zevyPwqcMelZF+qBWK7NyIGrDU4cSm638rnabvKi18t/w+T0M5YFeROGwRaUQT69QowyXnrkGJXAcPhoKvFL2ZKhZv9k+/UQaCKEZokHyW+ZSpS30dWpgPKzJp62JGSEeyoWUt+7R6cnRVznxEZN34HF6U8q5LboT6RxHEZs6lIQOMY7sUtOn4bxIU6Zp1/F7gXS/qwFFvaIfZgp7jLzuXtShRqYCjNL8N73zfP9Fbf42wSOKNTR80TeafHnARN9aKUa4eX/NRsRqMzT+weq+vGDVgH0j1xGPfJFvwemcrIEFSJ4BXorYyMS/LMVdwocODnhsj3+FkJ6ckVkEIB7OwpD4jsWGsu3k6azV7iFwN5pQIh/9LTd0t+ljPfQR15zM2T61YsW64CVKyuOgag7/zdKduWDx4sKL3S/F7AYkb4VLwpioftdMoZI/NsNpXGDdcYlS8o48/kh4SbD3J4UyE/n8hUEZQckkajM0/sHqvrzdwE5bibVmXQyyRGF2/CYNDjGO7FLTp+HqqbascVBeQj5lO62cEypQ9TBubpXrEk/1xWDSQekHAaecm/+2yiTNakWCZwRdtfHao9qaXnP1VsJTxpGNSmJG4ehGVCHqvRTjdRXBNZTM13Y1mD/pGrFe';
    // text = CryptoUtil.base64ToHex(text);
    // List<int> result = DES().decryptWithEcb(HEX.decode(text), CryptoUtil.hex2List(hexKey));
    String result = DES().decryptFromBase64WithECB(text, 'C2#I2w*j');
    // utf8.decoder.convert(Uint8List.fromList(result));
    print('----$result');
    ///多数在线加密网站的key使用的是utf-8格式 这里是十六进制格式
    String testKey = 'asfd1234';
    print('网站测试key: $testKey');
    print('对应十六进制key: ${CryptoUtil.list2Hex(testKey.codeUnits)}');
    print(
        '对应 cipher: ${DES().encryptToHexWithECB(data, CryptoUtil.list2Hex(testKey.codeUnits))}');
  });

  test('des cbc test', () async {
    //

    String hexKey = '133457799BBCDFF1';
    String data = 'asdasdasd啊啊啊';
    String cipher = DES().encryptToHexWithCBC(data, hexKey);
    print('cipher ' + cipher);
    String plain = DES().decryptFromHexWithCBC(cipher, hexKey);
    print('plain ' + plain);
  });

  test('bit test', () async {
    List<int> bits = NumberUtils.to8Bit(100);
    int number = NumberUtils.intFromBits(bits);
    print(NumberUtils.to4Bit(2));
    print(bits.toString());
    print(number.toString());
  });

  test('e_transform test', () {
    List<int> l1 = NumberUtils.bitsFromIntList(CryptoUtil.hex2List('10A10001'));
    print(l1);
    List<int> p = DES().E_transform(l1);
    print(p);
    List<int> l2 = NumberUtils.intListFromBits(p);
    print(CryptoUtil.list2Hex(l2));
  });

  test('p_transform test', () {
    List<int> l1 = NumberUtils.bitsFromIntList(CryptoUtil.hex2List('10A10001'));
    print(l1);
    List<int> p = DES().P_transform(l1);
    print(p);
    List<int> l2 = NumberUtils.intListFromBits(p);
    print(CryptoUtil.list2Hex(l2));
  });
}
