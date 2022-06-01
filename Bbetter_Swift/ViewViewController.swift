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
    @IBOutlet var dDayLabel: UILabel!
    
    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd(E)"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        itemlabel.text = item?.item
        let nowDate = ViewViewController.dateFormatter.string(from: Date())
        dateLabel.text =  Self.dateFormatter.string(from: item!.date)
        let startDate = ViewViewController.dateFormatter.date(from: "\(nowDate)")!
        let endDate = ViewViewController.dateFormatter.date(from: "\(Self.dateFormatter.string(from: item!.date))")
        
        let interval = (endDate?.timeIntervalSince(startDate))!
        let daya = Int(interval / 86400)
        if daya < 0 {
           let daya2 = daya * -1
            dDayLabel?.text! = "D+\(daya2)"
        }else if daya == 0{
            dDayLabel?.text! = "D-DAY"
        }else{
            dDayLabel?.text! = "D-\(daya)"
        }
        
        
        
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
