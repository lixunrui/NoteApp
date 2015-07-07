//
//  MasterViewController.swift
//  Note
//
//  Created by Raymond on 7/07/15.
//  Copyright (c) 2015 Raymond. All rights reserved.
//
import UIKit

class MasterViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var _tableView: UITableView!
    //var objects = [AnyObject]()
    var searchActive:Bool = false
    var filtered:NSArray?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Note.loadNotes()
    
        println("All Notes: \(allNotes)")
        
        Note.saveNotes()
        
        noteTable = self.tableView
        
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
        allNotes.addObject(Note())
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        // transfer to detail view
        self.performSegueWithIdentifier("showDetail", sender: self)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                println("Selected Row \(indexPath.row)")
                
                if searchActive {
                    // pass the object to the detail page
                }
                else {
                    
                }
                let object = allNotes.objectAtIndex(indexPath.row) as! Note
            //(segue.destinationViewController as! DetailViewController).detailItem = object
                currentNoteIndex = indexPath.row
                
            }
            else {
                // once we clicked the +, force the index to 0
                currentNoteIndex = 0
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filtered!.count
        }
        return allNotes.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        var object : Note?
        if searchActive {
            object = filtered?.objectAtIndex(indexPath.row) as? Note
        }
        else{
            object = allNotes.objectAtIndex(indexPath.row) as? Note
        }
        cell.textLabel!.text = object?.note
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
            allNotes.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    // MARK: - Search Delegate
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true
    }
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // More about predicate
        // http://nshipster.com/nspredicate/
        var predicate = NSPredicate { (note, _) in
            var newNote = note as! Note
            
            if (newNote.note.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) != nil) {
                return true
            }
            return false
        }

        filtered = allNotes.filteredArrayUsingPredicate(predicate)
        
       //  allNotes.filterUsingPredicate(predicate)
        if filtered?.count == 0 {
            searchActive = false
        }
        else {
            searchActive = true
        }
        
        _tableView.reloadData()
        
        println("search \(searchActive)")
        println("Filted \(filtered)")
        println("Table \(allNotes)")
    }
}

