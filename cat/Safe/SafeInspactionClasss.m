//
//  SafeInspactionClasss.m
//  cat
//
//  Created by 王成龙 on 2019/8/14.
//  Copyright © 2019 Charlie. All rights reserved.
//

#import "SafeInspactionClasss.h"

@implementation SafeInspactionClasss

//对一个字符串进行base64编码,并且返回
+ (NSString *)base64EncodeString:(NSString *)string
{
    //1.先转换为二进制数据
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    //2.对二进制数据进行base64编码,完成之后返回字符串
    return [data base64EncodedStringWithOptions:0];
}

//对base64编码之后的字符串解码,并且返回
+ (NSString *)base64DecodeString:(NSString *)string
{
    //注意:该字符串是base64编码后的字符串
    //1.转换为二进制数据(完成了解码的过程)
    NSData *data = [[NSData alloc] initWithBase64EncodedString:string options:0];

    //2.把二进制数据在转换为字符串
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringFromByte:(Byte)byteVal
{
    NSMutableString *str = [NSMutableString string];
    //取高四位
    Byte byte1 = byteVal >> 4;
    //取低四位
    Byte byte2 = byteVal & 0xf;
    //拼接16进制字符串
    [str appendFormat:@"%X", byte1];
    [str appendFormat:@"%X", byte2];
    return str;
}

+ (NSString *)hexStringFromData:(NSData *)data
{
    NSMutableString *str = [NSMutableString string];
    Byte *byte = (Byte *)[data bytes];
    for (int i = 0; i < [data length]; i++) {
        // byte+i为指针
        [str appendString:[self stringFromByte:*(byte + i)]];
    }
    return str;
}
// Base64 -> Data
+ (NSData *)base64Decode:(NSString *)string
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[4];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;

    if (string == nil) {
        return [NSData data];
    }

    ixtext = 0;

    tempcstring = (const unsigned char *)[string UTF8String];

    lentext = [string length];

    theData = [NSMutableData dataWithCapacity:lentext];

    ixinbuf = 0;

    while (true) {
        if (ixtext >= lentext) {
            break;
        }
        ch = tempcstring[ixtext++];

        flignore = false;

        if ((ch >= 'A') && (ch <= 'Z')) {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z')) {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9')) {
            ch = ch - '0' + 52;
        }
        else if (ch == '+') {
            ch = 62;
        }
        else if (ch == '=') {
            flendtext = true;
        }
        else if (ch == '/') {
            ch = 63;
        }
        else {
            flignore = true;
        }

        if (!flignore) {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;

            if (flendtext) {
                if (ixinbuf == 0) {
                    break;
                }

                if ((ixinbuf == 1) || (ixinbuf == 2)) {
                    ctcharsinbuf = 1;
                }
                else {
                    ctcharsinbuf = 2;
                }

                ixinbuf = 3;

                flbreak = true;
            }

            inbuf[ixinbuf++] = ch;

            if (ixinbuf == 4) {
                ixinbuf = 0;

                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);

                for (i = 0; i < ctcharsinbuf; i++) {
                    [theData appendBytes:&outbuf[i] length:1];
                }
            }

            if (flbreak) {
                break;
            }
        }
    }
    return theData;
}

+ (NSData *)dataWithHexString:(NSString *)hexString
{
    const char *chars = [hexString UTF8String];
    int i = 0;
    NSUInteger len = hexString.length;

    NSMutableData *data = [NSMutableData dataWithCapacity:len / 2];
    char byteChars[3] = {'\0', '\0', '\0'};
    unsigned long wholeByte;

    while (i < len) {
        byteChars[0] = chars[i++];
        byteChars[1] = chars[i++];
        wholeByte = strtoul(byteChars, NULL, 16);
        [data appendBytes:&wholeByte length:1];
    }
    return data;
}

+ (NSString *)base64Encode:(NSData *)data
{
    static char base64EncodingTable[64] = {
        'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
        'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
        'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
        'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/'};
    NSInteger length = [data length];
    unsigned long ixtext, lentext;
    long ctremaining;
    unsigned char input[3], output[4];
    short i, charsonline = 0, ctcopy;
    const unsigned char *raw;
    NSMutableString *result;

    lentext = [data length];
    if (lentext < 1)
        return @"";
    result = [NSMutableString stringWithCapacity:lentext];
    raw = [data bytes];
    ixtext = 0;

    while (true) {
        ctremaining = lentext - ixtext;
        if (ctremaining <= 0)
            break;
        for (i = 0; i < 3; i++) {
            unsigned long ix = ixtext + i;
            if (ix < lentext)
                input[i] = raw[ix];
            else
                input[i] = 0;
        }
        output[0] = (input[0] & 0xFC) >> 2;
        output[1] = ((input[0] & 0x03) << 4) | ((input[1] & 0xF0) >> 4);
        output[2] = ((input[1] & 0x0F) << 2) | ((input[2] & 0xC0) >> 6);
        output[3] = input[2] & 0x3F;
        ctcopy = 4;
        switch (ctremaining) {
            case 1:
                ctcopy = 2;
                break;
            case 2:
                ctcopy = 3;
                break;
        }

        for (i = 0; i < ctcopy; i++)
            [result appendString:[NSString stringWithFormat:@"%c", base64EncodingTable[output[i]]]];

        for (i = ctcopy; i < 4; i++)
            [result appendString:@"="];

        ixtext += 3;
        charsonline += 4;

        if ((length > 0) && (charsonline >= length))
            charsonline = 0;
    }
    return result;
}

//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string
{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr = @"";
    for (int i = 0; i < [myD length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x", bytes[i] & 0xff]; ///16进制数

        if ([newHexStr length] == 1)

            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];

        else

            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
    }
    return hexStr;
}


/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal
{

    NSString *hex = @"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i < 9; i++) {

        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {

            case 10:
                letter = @"A";
                break;
            case 11:
                letter = @"B";
                break;
            case 12:
                letter = @"C";
                break;
            case 13:
                letter = @"D";
                break;
            case 14:
                letter = @"E";
                break;
            case 15:
                letter = @"F";
                break;
            default:
                letter = [NSString stringWithFormat:@"%ld", number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) {

            break;
        }
    }
    return hex;
}


@end
