////
////  FileViewController.swift
////  Example
////
////  Created by GeggHarrison, Timothy S on 3/27/19.
////  Copyright © 2019 Tim Gegg-Harrison. All rights reserved.
////
//
//import UIKit
//import SQLite3
//
//class File: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
//    
//    let PERSONCELL: String = "ItemCell"
//    
//    let dirPath: String = "\(NSHomeDirectory())/tmp"
//    let filePath: String = "\(NSHomeDirectory())/tmp/Items.txt"
//    
//    var db: OpaquePointer?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       
//       
//    }
//    
//    // Return to previous view controller when user swipes right
//    @objc func dismissViewController(_ recognizer: UISwipeGestureRecognizer) {
//        closeDB()
//        presentingViewController?.dismiss(animated: true, completion: {() -> Void in
//        })
//    }
//    
//
//    
//    private func displayDirectory() {
//        print("Absolute path for Home Directory: \(NSHomeDirectory())")
//        if let dirEnumerator = FileManager.default.enumerator(atPath: NSHomeDirectory()) {
//            while let currentPath = dirEnumerator.nextObject() as? String {
//                print(currentPath)
//            }
//        }
//    }
//    
//    private func createDirectory() {
//        print("Before directory is created...")
//        displayDirectory()
//        var isDir: ObjCBool = true
//        if FileManager.default.fileExists(atPath: dirPath, isDirectory: &isDir) {
//            if isDir.boolValue {
//                print("\(dirPath) exists and is a directory")
//            }
//            else {
//                print("\(dirPath) exists and is not a directory")
//            }
//        }
//        else {
//            print("\(dirPath) does not exist")
//            do {
//                try FileManager.default.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
//            }
//            catch {
//                print("Error creating directory \(dirPath): \(error)")
//            }
//        }
//        print("After directory is created...")
//        displayDirectory()
//    }
//    
//    private func saveToFile() {
//        do {
//            let data = try NSKeyedArchiver.archivedData(withRootObject: personList, requiringSecureCoding: false)
//            if FileManager.default.createFile(atPath: filePath,
//                                              contents: data,
//                                              attributes: nil) {
//                print("File \(filePath) successfully created")
//            }
//            else {
//                print("File \(filePath) could not be created")
//            }
//        }
//        catch {
//            print("Error archiving data: \(error)")
//        }
//    }
//    
//    private func restoreFromFile() {
//        do {
//            if let data = FileManager.default.contents(atPath: filePath) {
//                print("Retrieving data from file \(filePath)")
//                personList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Person] ?? [Person]()
//            }
//            else {
//                print("No data available in file \(filePath)")
//                personList = [Person]()
//            }
//            personTableView.reloadData()
//        }
//        catch {
//            print("Error unarchiving data: \(error)")
//        }
//    }
//    
//    private func deleteFile() {
//        do {
//            try FileManager.default.removeItem(atPath: filePath)
//        }
//        catch {
//            print("Error deleting file: \(error)")
//        }
//    }
//    
//    private func openDB() {
//        do {
//            let fileURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                .appendingPathComponent("PersonDatabase.sqlite")
//            if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
//                print("error opening database")
//            }
//            if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Person (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)", nil, nil, nil) != SQLITE_OK {
//                let errmsg = String(cString: sqlite3_errmsg(db))
//                print("error creating table: \(errmsg)")
//            }
//        }
//        catch {
//            print("Error opening database: \(error)")
//        }
//    }
//    
//    private func closeDB() {
//        sqlite3_close(db)
//    }
//    
//    func restoreFromDB() {
//        personList.removeAll()
//        
//        let queryString = "SELECT * FROM Person"
//        var stmt: OpaquePointer?
//        if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db)!)
//            print("error preparing insert: \(errmsg)")
//            return
//        }
//        while sqlite3_step(stmt) == SQLITE_ROW {
//            let id = sqlite3_column_int(stmt, 0)
//            let name = String(cString: sqlite3_column_text(stmt, 1))
//            let age = sqlite3_column_int(stmt, 2)
//            
//            personList.append(Person(id: id, name: name, age: age))
//        }
//        sqlite3_finalize(stmt)
//        
//        personTableView.reloadData()
//    }
//    
//    @objc func clearPersons() {
//        personList.removeAll()
//        
//        if sqlite3_exec(db, "DELETE FROM Person", nil, nil, nil) != SQLITE_OK {
//            let errmsg = String(cString: sqlite3_errmsg(db))
//            print("error deleting table: \(errmsg)")
//        }
//        
//        deleteFile()
//        
//        personTableView.reloadData()
//    }
//    
//    @objc func addPerson() {
//        if let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !name.isEmpty {
//            nameTextField.layer.borderWidth = 1
//            nameTextField.layer.borderColor = UIColor.black.cgColor
//            if let ageString = ageTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), !ageString.isEmpty, let age = Int32(ageString) {
//                ageTextField.layer.borderWidth = 1
//                ageTextField.layer.borderColor = UIColor.black.cgColor
//                var stmt: OpaquePointer?
//                var queryString = "SELECT * FROM Person WHERE name = '\(name)'"
//                if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
//                    let errmsg = String(cString: sqlite3_errmsg(db)!)
//                    print("error preparing select: \(errmsg)")
//                    return
//                }
//                if sqlite3_step(stmt) == SQLITE_ROW {
//                    print("\(name) already in DB")
//                    let id = sqlite3_column_int(stmt, 0)
//                    sqlite3_finalize(stmt)
//                    queryString = "UPDATE Person SET age = \(age) WHERE id = \(id)"
//                    if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
//                        let errmsg = String(cString: sqlite3_errmsg(db))
//                        print("error preparing update: \(errmsg)")
//                        return
//                    }
//                    if sqlite3_step(stmt) != SQLITE_DONE {
//                        let errmsg = String(cString: sqlite3_errmsg(db)!)
//                        print("failure updating person: \(errmsg)")
//                        return
//                    }
//                    sqlite3_finalize(stmt)
//                    for person in personList {
//                        if person.name == name {
//                            person.age = age
//                        }
//                    }
//                }
//                else {
//                    print("adding \(name) to DB")
//                    sqlite3_finalize(stmt)
//                    queryString = "INSERT INTO Person (name, age) VALUES (?,?)"
//                    if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
//                        let errmsg = String(cString: sqlite3_errmsg(db))
//                        print("error preparing insert: \(errmsg)")
//                        return
//                    }
//                    if sqlite3_bind_text(stmt, 1, name, -1, nil) != SQLITE_OK {
//                        let errmsg = String(cString: sqlite3_errmsg(db))
//                        print("failure binding name: \(errmsg)")
//                        return
//                    }
//                    if sqlite3_bind_int(stmt, 2, age) != SQLITE_OK {
//                        let errmsg = String(cString: sqlite3_errmsg(db))
//                        print("failure binding age: \(errmsg)")
//                        return
//                    }
//                    if sqlite3_step(stmt) != SQLITE_DONE {
//                        let errmsg = String(cString: sqlite3_errmsg(db)!)
//                        print("failure inserting person: \(errmsg)")
//                        return
//                    }
//                    sqlite3_finalize(stmt)
//                    queryString = "SELECT * FROM Person WHERE name = '\(name)'"
//                    if sqlite3_prepare_v2(db, queryString, -1, &stmt, nil) != SQLITE_OK {
//                        let errmsg = String(cString: sqlite3_errmsg(db)!)
//                        print("error preparing select: \(errmsg)")
//                        return
//                    }
//                    if sqlite3_step(stmt) == SQLITE_ROW {
//                        let id = sqlite3_column_int(stmt, 0)
//                        personList.append(Person(id: id, name: name, age: age))
//                    }
//                    sqlite3_finalize(stmt)
//                }
//                
//                
//                
//                saveToFile()
//                
//               
//            }
//            else {
//               
//            }
//        }
//        else {
//            
//        }
//    }
//}
//
//
//class Person: NSObject, NSCoding {
//    let TNID: String = "Person ID"
//    let TNNAME: String = "Person Name"
//    let TNAGE: String = "Person Age"
//    
//    let id: Int32
//    let name: String?
//    var age: Int32
//    
//    init(id: Int32, name: String?, age: Int32){
//        self.id = id
//        self.name = name
//        self.age = age
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        id = aDecoder.decodeInt32(forKey: TNID)
//        name = aDecoder.decodeObject(forKey: TNNAME) as? String
//        age = aDecoder.decodeInt32(forKey: TNAGE)
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(id, forKey: TNID)
//        aCoder.encode(name, forKey: TNNAME)
//        aCoder.encode(age, forKey: TNAGE)
//    }
//}
