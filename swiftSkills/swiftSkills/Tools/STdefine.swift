//
//  STdefine.swift
//  swiftSkills
//
//  Created by huanglongshan on 2018/8/8.
//  Copyright © 2018年 huanglongshan. All rights reserved.
//

import Foundation
import UIKit

import Kingfisher
import SnapKit
import Toast_Swift

//MARK: - 颜色方法
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(hex: Int) {
        self.init(red: (hex >> 16) & 0xff, green: (hex >> 8) & 0xff, blue: hex & 0xff)
    }
    convenience init(hex: String) {
        func hex2dec(num:String) -> Float {
            let str = num.uppercased()
            var sum:Float = 0
            for i in str.utf8 {
                sum = sum * 16 + Float(i) - 48 // 0-9 从48开始
                if i >= 65 {                 // A-Z 从65开始，但有初始值10，所以应该是减去55
                    sum -= 7
                }
            }
            return sum
        }
        var hexString = hex
        if (hexString.hasPrefix("#")) {
            hexString = (hexString as NSString).substring(from: 1)
        }
        let index = hexString.index(hexString.startIndex, offsetBy: 2)
        let index2 = hexString.index(hexString.startIndex, offsetBy: 4)
        let range = Range(index ..< index2)
        
        let s1:String = String(hexString[..<index])
        let s2:String = String(hexString[range])
        let s3:String = String(hexString[index...])
        
        self.init(red: Int(hex2dec(num: s1)), green: Int(hex2dec(num: s2)), blue: Int(hex2dec(num: s3)))
    }
    convenience init(rand: Bool) {
        if rand == true {
            self.init(red: Int(arc4random_uniform(256)), green: Int(arc4random_uniform(256)), blue: Int(arc4random_uniform(256)))
        }else {
            self.init()
        }
    }
}

extension String{
    //    func md5() ->String!{
    //        let str = self.cString(using: String.Encoding.utf8)
    //        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
    //        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
    //        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
    //        CC_MD5(str!, strLen, result)
    //        let hash = NSMutableString()
    //        for i in 0 ..< digestLen {
    //            hash.appendFormat("%02x", result[i])
    //        }
    //        result.deinitialize()
    //        return String(format: hash as String)
    //    }
    func base64() ->String!{
        
        let utf8EncodeData = self.data(using: String.Encoding.utf8, allowLossyConversion: true)
        // 将NSData进行Base64编码
        let base64String = utf8EncodeData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: UInt(0)))
        
        return base64String
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }
    
    func heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
}
extension String {
    // MARK: 汉字 -> 拼音
    func transformToPinYin() -> String {
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false)// 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false)// 去掉音标
        let string = String(stringRef)
        return string.uppercased()
        //return string.replacingOccurrences(of: " ", with: "")
    }
    
    // MARK: 判断是否含有中文
    func isContainsChinese() -> Bool {
        for (_, value) in self.enumerated() {
            if ("\u{4E00}" <= value  && value <= "\u{9FA5}") {
                return true
            }
        }
        return false
    }
    // MARK: 获取第一个字符
    func firstWord() -> String {
        return self.prefix(1).uppercased()
    }
}
//字体
func kFont(F:CGFloat) -> (UIFont) {
    return UIFont.systemFont(ofSize: F)
}
//MARK: - 尺寸
let SCREEN_WIDTH    = UIScreen.main.bounds.width
let SCREEN_HEIGHT   = UIScreen.main.bounds.height
func kWidth(w:CGFloat) -> CGFloat {
    return w * SCREEN_WIDTH / 750.0
}
func kHight(h:CGFloat) -> CGFloat {
    return h * SCREEN_HEIGHT / 1334.0
}

// MARK:- 自定义打印方法
func YXLog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("\(fileName):(\(lineNum))-\(message)")
    #endif
}



// MARK:- 占位图片
let  EMPTY_PIC = "rebh"
