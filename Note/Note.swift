//
//  Note.swift
//  Note
//
//  Created by Raymond on 7/07/15.
//  Copyright (c) 2015 Raymond. All rights reserved.
//

import UIKit

// creating global vars

// *******************************************
// Save data into the UserDefaults
// *******************************************
//var allNotes : [Note] = []
//var currentNoteIndex : Int = -1
//var noteTable : UITableView?
//
//let keyAllNotes = "Notes"
//
//class Note: NSObject {
//    
//    var date : String
//    var note : String
//    
//    // override the super class NSObject
//    override init() {
//        date = NSDate().description
//        note = ""
//    }
//    
//    func dictionary() -> NSDictionary{
//        return ["note" : note, "date" : date]
//    }
//    
//    class func saveNotes(){
//        var aDictionaries : [NSDictionary] = []
//        for var i = 0; i < allNotes.count; i++ {
//            aDictionaries.append(allNotes[i].dictionary())
//        }
//        
//        NSUserDefaults.standardUserDefaults().setObject(aDictionaries, forKey: keyAllNotes)
//    }
//    
//    class func loadNotes(){
//        var defaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        var savedData:[NSDictionary]? = defaults.objectForKey(keyAllNotes) as?[NSDictionary]
//        
//        if let data = savedData {
//            for var i = 0; i < data.count; i++ {
//                var newNote = Note()
//                newNote.setValuesForKeysWithDictionary(data[i] as [NSObject : AnyObject])
//                allNotes.append(newNote);
//            }
//        }
//    }
//
//}



// *******************************************
// Save Data into a File
// *******************************************

var allNotes:NSMutableArray=[]
var currentNoteIndex = -1
var noteTable:UITableView?

let keyAllNotes = "Notes"

class Note : NSObject{
    var date:String
    var note:String
    
    override init(){
        date = NSDate().description
        note = ""
    }
    
    class func saveNotes() {
        var aDictionary:NSMutableArray=[]
        for var i=0; i < allNotes.count; i++ {
            aDictionary.addObject(allNotes[i])
        }
        
        aDictionary.writeToFile(filePath(), atomically: true) // true doesn't crash in the middle
        
    }
    
    class func loadNotes() {
        var savedData : NSArray? = NSArray(contentsOfFile: filePath())
        
        if let data:NSArray = savedData {
            for var i=0; i<data.count; i++ {
                var newNote = Note()
                newNote.setValuesForKeysWithDictionary(data[i] as! NSDictionary as [NSObject : AnyObject])
            }
        }
    }
    
    class func filePath()->String{
        var dPath : [String]? = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true) as? [String]
        
        if let directory:[String] = dPath {
            var docsDirectory : String = directory[0]
            var path = docsDirectory.stringByAppendingPathComponent("\(keyAllNotes).notes")
            println("path is \(path)")
            return path
        }
        return ""
    }
}
