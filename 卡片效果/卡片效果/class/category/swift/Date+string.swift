//
//  NSDate+Extension.swift
//  时间NSDate的类别
//
//  Created by 小广 on 16/5/5.
//  Base on Aerolitec Template
//  Copyright © 2016年 小广. All rights reserved.
//
 
import Foundation
 
enum FormatType:Int{
    case all     // yyyy-MM-dd HH:mm:ss
    case toDay     // yyyy-MM-dd
    case toMinute  // yyyy-MM-dd HH:mm
}
 
extension Date {
  // MARK: -> Class methods
    /**
     将日期以格式化的方式转化成字符串
     - parameter date:   时间
     - parameter format: 时间的格式化形式
     - returns: 时间字符串
     */
    static func stringFormat(_ date: Date, format: String) -> String? {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        // NSLocale(localeIdentifier: "zh_Hans_CN");// 中国时区
        formatter.locale = Locale.current;
        let dateString = formatter.string(from: date);
        return dateString;
    }
 
    /**
     将 日期字符串 通过 格式化 转换成 时间对象NSDate()
     - parameter dateString: 时间字符串
     - parameter format:     时间的格式化形式
     - returns: 时间
     */
    static func dateFormat(_ dateString: String, format: String) -> Date? {
        let formatter = DateFormatter();
        formatter.dateFormat = format;
        let date = formatter.date(from: dateString);
        return date;
    }
    
    /**
     *  获取 MM-dd HH:mm 格式的 时间字符串
     */
    static func shortDateTime(_ date: Date) -> String? {
        let format = "MM-dd HH:mm";
        return Date.stringFormat(date, format: format);
    }
    
    /**
     格式化时间到天
     - parameter 格式: yyyy-MM-dd
     */
    static func dateStringToDay(_ date: Date) -> String? {
        let format = "yyyy-MM-dd";
        return Date.stringFormat(date, format: format);
    }
    
    /**
     格式化时间到分
     - parameter 格式: yyyy-MM-dd HH:mm
     */
    
    static func dateStringToMinute(_ date: Date) -> String? {
        let format = "yyyy-MM-dd HH:mm";
        return Date.stringFormat(date, format: format);
    }
    
    /**
     格式化时间到秒
     - parameter 格式: yyyy-MM-dd HH:mm:ss
     */
    static func dateStringToSecond(_ date: Date) -> String? {
        let format = "yyyy-MM-dd HH:mm:ss";
        return Date.stringFormat(date, format: format);
    }
    
    //
    /**
     取到当前月份第一天 例: 2016-01-01 01:00:00
     - returns: 时间字符串
     */
    static func currentMonthFirstDay() -> String {
        var tempDateStr = Date.dateStringToDay(Date());
        let index = tempDateStr!.index(tempDateStr!.startIndex, offsetBy: 7);
//        tempDateStr!.characters.index(tempDateStr!.startIndex, offsetBy: 7);
        tempDateStr = String(tempDateStr!.prefix(upTo: index))
        tempDateStr = String(tempDateStr!.prefix(upTo: index))
        let dateString = tempDateStr! + "-01 01:00:00";
        return dateString;
    }
    
    /**
     *  获取时间戳(秒)
     */
    static func timestamp(_ date: Date) -> String {
        let interval = date.timeIntervalSince1970;
        return String(format: "%.0f",interval);
    }
    
    /**
     *  获取时间戳(毫秒)
     */
    static func timestampMillisecond(_ date: Date) -> String {
        let interval = date.timeIntervalSince1970;
        return String(format: "%.0f",(interval * 1000));
    }
    
    /**
     *  时间的显示(将过去的时间字符串显示出来),格式必须是:"2016-06-06 12:00:00"
     */
    static func formatedElapsedTimeByString(_ dateString: String) -> String {
        
        //print("dateString的长度是===+\(dateString.characters.count)");
        let date = Date.dateFormat(dateString, format: "yyyy-MM-dd HH:mm:ss");
        if date == nil {return "传入的时间格式错误"}
        return Date.formatedElapsedTimeByDate(date!);
    }
    
    /**
     *  时间的显示(将过去的时间显示出来)
     */
    static func formatedElapsedTimeByDate(_ date: Date) -> String {
 
        let calendar = Calendar.current;
        let unitFlags:NSCalendar.Unit = [.minute, .hour, .day, .weekOfMonth, .month, .year];
        let latest = Date();
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: latest, options: NSCalendar.Options.wrapComponents)
        
        if (components.year! >= 1) {
            return Date.dateStringToDay(date)!;
            //return NSDate.stringForComponentValue(components.year, name: "年", plural: "年");
        }
        if (components.month! >= 1) {
            return Date().stringForComponentValue(components.month!, name: "个月", plural: "个月")
        }
        if (components.weekOfMonth! >= 1) {
            return Date().stringForComponentValue(components.weekOfMonth!, name: "周", plural: "周");
        }
        if (components.day! >= 1) {
            return Date().stringForComponentValue(components.day!, name: "天", plural: "天");
        }
        if (components.hour! >= 1) {
            return Date().stringForComponentValue(components.hour!, name: "小时", plural: "小时");
        }
        if (components.minute! >= 1) {
            return Date().stringForComponentValue(components.minute!, name: "分钟", plural: "分钟");
        }
        return "刚刚";
    }
    
    //MARK: - 在时间上加上一定的时间
    /**
     将时间加上以 年 为单位的时间数
     - parameter date:  时间date
     - parameter years: 年数
     - returns: date
     */
    static func dateByAddingYears(_ date: Date, years: Int) -> Date? {
        let calendar = Calendar.current;
        var components = DateComponents();
        components.year = years;
        return (calendar as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options.wrapComponents);
    }
    
    /**
     将时间加上以 月 为单位的时间数
     - parameter date:  时间date
     - parameter months: 月数
     - returns: date
     */
    static func dateByAddingMonths(_ date: Date, months: Int) -> Date? {
        let calendar = Calendar.current;
        var components = DateComponents();
        components.month = months;
        return (calendar as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options.wrapComponents);
    }
    
    /**
     将时间加上以 周 为单位的时间数
     - parameter date:  时间date
     - parameter weeks: 周数
     - returns: date
     */
    static func dateByAddingWeeks(_ date: Date, weeks: Int) -> Date? {
        let calendar = Calendar.current;
        var components = DateComponents();
        components.weekOfYear = weeks;
        return (calendar as NSCalendar).date(byAdding: components, to: date, options: NSCalendar.Options.wrapComponents);
    }
    
    /**
     将时间加上以 天 为单位的时间数
     - parameter date:  时间date
     - parameter days: 天数
     - returns: date
     */
    static func dateByAddingDays(_ date: Date, days: Int) -> Date {
        let aTimeInterval = date.timeIntervalSinceReferenceDate + Double(86400 * days) ;
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    /**
     将时间加上以 小时 为单位的时间数
     - parameter date:  时间date
     - parameter hours: 小时数
     - returns: date
     */
    static func dateByAddingHours(_ date: Date, hours: Int) -> Date {
        let aTimeInterval = date.timeIntervalSinceReferenceDate + Double(3600 * hours) ;
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    /**
     将时间加上以 分钟 为单位的时间数
     - parameter date:  时间date
     - parameter minutes: 分钟数
     - returns: date
     */
    static func dateByAddingMinutes(_ date: Date, minutes: Int) -> Date {
        let aTimeInterval = date.timeIntervalSinceReferenceDate + Double(60 * minutes) ;
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    /**
     将时间加上以 秒 为单位的时间数
     - parameter date:  时间date
     - parameter seconds: 秒数
     - returns: date
     */
    static func dateByAddingSeconds(_ date: Date, seconds: Int) -> Date {
        let aTimeInterval = date.timeIntervalSinceReferenceDate + Double(seconds) ;
        let newDate = Date(timeIntervalSinceReferenceDate: aTimeInterval);
        return newDate;
    }
    
    // MARK: -> 内部方法
    // 拼接显示的时间字符串
    func stringForComponentValue(_ componentValue: Int, name: String, plural: String) -> String {
        let timespan = componentValue == 1 ? name : plural;
        return String(format: "%ld%@%@",componentValue, timespan, "前");
        
    }
 
}
