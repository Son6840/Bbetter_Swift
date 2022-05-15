//
//  ViewViewController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/15.
//

import UIKit
import RealmSwift

class ViewViewController: UIViewController {
    
    public var item: ToDoListItem?
    
    public var deletionHandler: (() -> Void )?
    
    @IBOutlet var itemlabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemlabel.text = item?.item
        dateLabel.text = Self.dateFormatter.string(from: item!.date)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))
    }
    
    @objc private func didTapDelete() {
        guard let myItem = self.item else{
            return
        }
        realm.beginWrite()
        realm.delete(myItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}
