//
//  ViewController.swift
//  Calendar
//
//  Created by Ting-Chun Yeh on 6/17/18.
//  Copyright © 2018 Ting-Chun Yeh. All rights reserved.
//

import UIKit
import EventKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnAddEvent: UIButton!
    
    // Create EKEventStore instance for entire app
    let database = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addEvent(_ sender: Any) {
        /*
        let eventStore:EKEventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: {(granted, error) in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = "Add event testing Title"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "This is note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let error as NSError {
                    print("error: \(error)")
                }
                print("Saved Event")
                
            } else {
                print("error \(String(describing: error))")
            }
            
            
        })
        */
        
        database.requestAccess(to: .event, completion: {(granted, error) in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                print("error \(String(describing: error))")
                
                /*
                // Assign the source type. $0 refers to Default Container
                let locals = self.database.sources.filter {$0.sourceType
                    == .local}
        
                // Saving into database can fail so run a do...catch
                guard let src = locals.first else {
                    print("failed to find local source")
                    return
                }
                // If a source is found create a new calendar
                let cal = EKCalendar(for:.event, eventStore:self.database)
                cal.source = src
                cal.title = "CoolCal"
        
                // Commit the changes
                do {
                    try self.database.saveCalendar(cal, commit:true)
                } catch {
                    print("Unsaved")
                }
        
                // Create an event after checking
                guard let cal2 = self.calendar(name:"CoolCal") else {
                    print("failed to find calendar")
                    return
                }*/
                
                
                // Must provide start and date dates
                let greg = Calendar(identifier:.gregorian)
                var comp = DateComponents(year:2018, month:6, day:20, hour:2)
                let d1 = greg.date(from:comp)!
                comp.hour = comp.hour! + 1
                let d2 = greg.date(from:comp)!
        
                // Form the event
                let ev = EKEvent(eventStore:self.database)
                ev.title = "Take a nap"
                ev.notes = "You deserve it!"
                ev.calendar = self.database.defaultCalendarForNewEvents
                (ev.startDate, ev.endDate) = (d1,d2)
        
                // Save it
                do {
                    try self.database.save(ev, span:.thisEvent, commit:true)
                } catch {
                    print("Unsaved")
                }
        
                // Set an alarm one hour before event
                let alarm = EKAlarm(relativeOffset:-3600)
        
                // Add an alarm to event
                ev.addAlarm(alarm)
            } else {
                print("error \(String(describing: error))")
            }
        })
    }
    
    // Assign the source type. $0 refers to Default Container
    func calendar(name:String ) -> EKCalendar? {
        let cals = database.calendars(for:.event)
        return cals.filter {$0.title == name}.first
    }
    
    
}

