//
//  DetailViewController.swift
//  Note
//
//  Created by Raymond on 7/07/15.
//  Copyright (c) 2015 Raymond. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
//    @IBOutlet weak var detailDescriptionLabel: UILabel!
//
//
//    var detailItem: AnyObject? {
//        didSet {
//            // Update the view.
//            self.configureView()
//        }
//    }
//
//    func configureView() {
//        // Update the user interface for the detail item.
//        if let detail: AnyObject = self.detailItem {
//            if let label = self.detailDescriptionLabel {
//                label.text = detail.description
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // self.configureView()
        textView.text = (allNotes.objectAtIndex(allNotes.count-1) as! Note).note
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        if textView.text == "" {
            allNotes.removeObjectAtIndex(allNotes.count-1)
        }
        else {
            (allNotes.objectAtIndex(allNotes.count-1) as? Note)?.note = textView.text
        }
        
        Note.saveNotes()
        noteTable?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

