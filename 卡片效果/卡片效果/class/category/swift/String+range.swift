//
//  String+range.swift
//  易火
//
//  Created by YHIOS on 2020/5/26.
//  Copyright © 2020 YHIOS. All rights reserved.
//

import Foundation
import CommonCrypto
extension String {
    func toNSRange(_ range: Range<String.Index>) -> NSRange {
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
//    
// func hmac(algorithm: HMACAlgorithm, key: String) -> String {
//    let cKey = key.cString(using: String.Encoding.utf8)
//    let cData = self.cString(using: NSUTF8StringEncoding)
//       var result = [CUnsignedChar](count: Int(algorithm.digestLength()), repeatedValue: 0)
//       CCHmac(algorithm.toCCHmacAlgorithm(), cKey!, strlen(cKey!), cData!, strlen(cData!), &result)
//       var hmacData:NSData = NSData(bytes: result, length: (Int(algorithm.digestLength())))
//    var hmacBase64 = hmacData.base64EncodedStringWithOptions(NSData.Base64EncodingOptions.Encoding76CharacterLineLength)
//       return String(hmacBase64)
//   }
//   

    
    
}
enum HMACAlgorithm {
       case MD5, SHA1, SHA224, SHA256, SHA384, SHA512

       func toCCHmacAlgorithm() -> CCHmacAlgorithm {
           var result: Int = 0
           switch self {
           case .MD5:
               result = kCCHmacAlgMD5
           case .SHA1:
               result = kCCHmacAlgSHA1
           case .SHA224:
               result = kCCHmacAlgSHA224
           case .SHA256:
               result = kCCHmacAlgSHA256
           case .SHA384:
               result = kCCHmacAlgSHA384
           case .SHA512:
               result = kCCHmacAlgSHA512
           }
           return CCHmacAlgorithm(result)
       }

       func digestLength() -> Int {
           var result: CInt = 0
           switch self {
           case .MD5:
               result = CC_MD5_DIGEST_LENGTH
           case .SHA1:
               result = CC_SHA1_DIGEST_LENGTH
           case .SHA224:
               result = CC_SHA224_DIGEST_LENGTH
           case .SHA256:
               result = CC_SHA256_DIGEST_LENGTH
           case .SHA384:
               result = CC_SHA384_DIGEST_LENGTH
           case .SHA512:
               result = CC_SHA512_DIGEST_LENGTH
           }
           return Int(result)
       }
   }
