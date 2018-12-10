//
//  Extention.swift
//  Shandruk Rostik MAN
//
//  Created by Andrew on 12/9/18.
//  Copyright © 2018 Shandruk. All rights reserved.
//

import Foundation

extension NSDate
{
  func hour() -> Int
  {
    //Get Hour
    let calendar = NSCalendar.current
    let components = calendar.component(.hour, from: self as Date)
    let hour = components.hour
    
    //Return Hour
    return hour
  }
  
  
  func minute() -> Int
  {
    //Get Minute
    let calendar = NSCalendar.current
    let components = calendar.components(.Minute, fromDate: self)
    let minute = components.minute
    
    //Return Minute
    return minute
  }
  
  func toShortTimeString() -> String
  {
    //Get Short Time String
    let formatter = NSDateFormatter()
    formatter.timeStyle = .ShortStyle
    let timeString = formatter.stringFromDate(self)
    
    //Return Short Time String
    return timeString
  }
}
