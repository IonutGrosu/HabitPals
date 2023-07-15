//
//  DateUtils.swift
//  HabitPals
//
//  Created by Ionut Grosu on 23/06/2023.
//

import Foundation


func addOrSubtractDay(day:Int)->Date{
  return Calendar.current.date(byAdding: .day, value: day, to: Date())!
}
