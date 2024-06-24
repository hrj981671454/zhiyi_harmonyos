import cryptoFramework from '@ohos.security.cryptoFramework';
import buffer from '@ohos.buffer';

export default class MD5Utils {
  // Uint8Array转string
  static uint8ArrayToString(uint8Array: Uint8Array): string {
    let str = buffer.from(uint8Array).toString("hex")
    return str;
  }

  static stringToUint8Array1(hexStr: string): Uint8Array {
    let len = hexStr.length
    if (len % 2 != 0) {
      hexStr = "0" + hexStr
    }
    const byteArray = new Array<number>()
    for (let i = 0; i < hexStr.length; i += 2) {
      byteArray.push(parseInt(hexStr.substring(i, i + 2), 16))
    }
    return new Uint8Array(byteArray)
  }

  static stringToUint8Array(hexStr: string): Uint8Array {
    let uint8Arr = new Uint8Array(buffer.from(hexStr).buffer)
    return uint8Arr;
  }

  static async getMD5(str: string): Promise<string> {
    let md5 = cryptoFramework.createMd("MD5");
    let unit8Array = this.stringToUint8Array(str)
    await md5.update({
      data: unit8Array
    });
    let result = await md5.digest()
    return this.uint8ArrayToString(result.data)
  }
}