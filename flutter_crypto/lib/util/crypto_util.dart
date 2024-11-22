import 'dart:convert';
import 'dart:typed_data';

class CryptoUtil {
  static List<int> hex2List(String hexStr) {
    if (hexStr == null || hexStr.length % 2 != 0) {
      //十六进制字符串错误
      return [];
    }

    if (hexStr.startsWith('0x')) {
      hexStr = hexStr.substring(2);
    }
    List<int> result = List.filled(hexStr.length ~/ 2, 0);
    String temp = '0123456789ABCDEF';
    for (int i = 0; i < hexStr.length; i += 2) {
      int h = temp.indexOf(hexStr.substring(i, i + 1));
      int l = temp.indexOf(hexStr.substring(i + 1, i + 2));
      result[i ~/ 2] = (h * 16 + l);
    }
    return result;
  }

  static String list2Hex(List<int> list) {
    List<String> results = List.filled(list.length * 2, '');
    String temp = '0123456789ABCDEF';
    for (int i = 0; i < list.length; i++) {
      int h = list[i] ~/ 16;
      int l = list[i] % 16;
      results[i * 2] = temp.substring(h, h + 1);
      results[i * 2 + 1] = temp.substring(l, l + 1);
    }
    return results.join();
  }

  static String base64ToHex(String base64String) {
    // 解码Base64字符串
    Uint8List bytes = base64Decode(base64String);
    // 使用StringBuffer来构建Hex字符串
    StringBuffer hexStringBuffer = StringBuffer();
    for (int i = 0; i < bytes.lengthInBytes; i++) {
      // 将每个字节转换为Hex，并拼接到StringBuffer
      String hex = bytes[i].toRadixString(16).padLeft(2, '0');
      hexStringBuffer.write(hex);
    }
    // 返回构建好的Hex字符串
    return hexStringBuffer.toString().toUpperCase();
  }
}
