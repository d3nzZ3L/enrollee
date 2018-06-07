//
//  StudentCalendarViewController.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 22.05.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import UIKit
import MBCalendarKit

class StudentCalendarViewController: CalendarViewController {
    var data: [Date : [CalendarEvent]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        tabBarItem.title = "Календарь"
        self.calendarView.locale = Locale.init(identifier: "ru_RU")
        let title : NSString = NSLocalizedString("Начало приема документов на все формы обучения", comment: "") as NSString
        if let date : Date = NSDate(day: 12, month: 7, year: 2018) as Date?
        {
            let event : CalendarEvent = CalendarEvent(title: title as String, andDate: date, andInfo: nil)
            self.data[date] = [event]
        }
        let title3 : NSString = NSLocalizedString("Конец приема документов на все формы обучения", comment: "") as NSString
        if let date3 : Date = NSDate(day: 26, month: 7, year: 2018) as Date?
        {
            let event3 : CalendarEvent = CalendarEvent(title: title3 as String, andDate: date3, andInfo: nil)
            self.data[date3] = [event3]
        }
        
        let title2 : NSString = NSLocalizedString("День открытых дверей кафедр ВЭ и ВЭМ", comment: "") as NSString
        if let date2 : Date = NSDate(day: 14, month: 5, year: 2018) as Date?
        {
            let event2 : CalendarEvent = CalendarEvent(title: title2 as String, andDate: date2, andInfo: nil)
            self.data[date2] = [event2]
        }
    }
    
    override func calendarView(_ calendarView: CalendarView, eventsFor date: Date) -> [CalendarEvent] {
        let eventsForDate = self.data[date] ?? []
        return eventsForDate
    }
}
