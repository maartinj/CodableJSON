//
//  SingleBookViewController.swift
//  CTHelp2 Starter
//
//  Created by Stewart Lynch on 2019-06-28.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import UIKit

class SingleBookViewController: UIViewController {
    
    var book:BookItem!
    weak var delegate:ViewController?
    
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var notes: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Notification to know when to scroll the notes textview when keyboard covers text being entered
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        notes.layer.cornerRadius = 14.0
        notes.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        authorLabel.text = book.author
        notes.text = book.notes
        
        // Dismiss keyboard when tapped outsied of notes textview
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        book.notes = notes.text ?? ""
        delegate?.updateBook(book: book)
    }
    

    

    
    // Adjusts the notes textview when the keyboard is visible
    @objc func adjustForKeyboard(notification: Notification) {
        let userInfo = notification.userInfo!
        
        let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            notes.contentInset = UIEdgeInsets.zero
        } else {
            notes.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height, right: 0)
        }
        
        notes.scrollIndicatorInsets = notes.contentInset
        
        let selectedRange = notes.selectedRange
        notes.scrollRangeToVisible(selectedRange)
    }
    
    @IBAction func editBookTitleAndAuthor(_ sender: Any) {
        let alert = UIAlertController(title: "Edit Detail", message: "Change Title and Author", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Book Title"
            textField.text = self.book.title
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Author"
            textField.text = self.book.author
            textField.autocapitalizationType = .words
        }
        
        let updateAction = UIAlertAction(title: "Update", style: .default) { (action) in
            let title = alert.textFields![0] as UITextField
            let author = alert.textFields![1] as UITextField
            guard title.text != "", author.text != "" else {return}
            self.authorLabel.text = author.text!
            self.title = title.text!
            self.book.author = author.text!
            self.book.title = title.text!
            
        }
        alert.addAction(updateAction)
        present(alert,animated: true)
        
    }
}

