//
//  ViewController.swift
//  CTHelp2 Starter
//
//  Created by Stewart Lynch on 2019-06-28.
//  Copyright © 2019 CreaTECH Solutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let dataSource = BookItemDataSource()
    var selectedBook:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = dataSource
        tableView.tableFooterView = UIView()
        setupNavBar()
    }
    
    func setupNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBook))
        navigationItem.rightBarButtonItem = addButton
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SingleBookViewControllerSegue" {
            let vc = segue.destination as! SingleBookViewController
            let row = tableView.indexPathForSelectedRow?.row
            let book = dataSource.book(at: row!)
            selectedBook = row!
            vc.title = book.title
            vc.book = book
            vc.delegate = self
        }
    }
    
    
    func updateBook(book:BookItem) {
        guard let selectedBook = selectedBook else {return}
        dataSource.books[selectedBook] = book
        dataSource.saveBooks()
        tableView.reloadData()
    }
    
    @objc func addBook() {
        let alert = UIAlertController(title: "New Book", message: "Add your new book", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Book Title"
            textField.autocapitalizationType = .words
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Author"
            textField.autocapitalizationType = .words
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let title = alert.textFields![0] as UITextField
            let author = alert.textFields![1] as UITextField
            guard title.text != "", author.text != "" else {return}
            self.dataSource.addBook(with: title.text!, author: author.text!)
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        present(alert,animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           performSegue(withIdentifier: "SingleBookViewControllerSegue", sender: nil)
           tableView.deselectRow(at: indexPath, animated: true)
       }
       
       func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let delete = UIContextualAction(style: .destructive, title: "Remove Book") { (action, view, actionPerformed: (Bool) -> ()) in
               self.dataSource.deleteBook(at: indexPath.row)
               self.tableView.deleteRows(at: [indexPath], with: .automatic)
               actionPerformed(true)
           }
           let config = UISwipeActionsConfiguration(actions: [delete])
           config.performsFirstActionWithFullSwipe = true
           return config
       }
    
}

