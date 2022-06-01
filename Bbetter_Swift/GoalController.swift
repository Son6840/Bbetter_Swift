//
//  GoalController.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/15.
//

import UIKit
import RealmSwift


//class customCell: UITableViewCell{
//
//    @IBOutlet weak var DdayLabel: UILabel!
//}
class ToDoListItem: Object {
    @objc dynamic var Dday: String = ""
    @objc dynamic var item: String = ""
    @objc dynamic var date: Date = Date()

}

class GoalController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var sectionA : [ToDoListItem] = []
    var sectionB : [ToDoListItem] = []
    
    @IBOutlet var table: UITableView!
   
    private var data = [ToDoListItem]()
    private let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.table.delegate = self
        self.table.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GoalTableViewCell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)as! GoalTableViewCell
        
        cell.itemLabel?.text = data[indexPath.row].item
        cell.dateLabel?.text = "\(ViewViewController.dateFormatter.string(from: data[indexPath.row].date))"
//        var config = cell.defaultContentConfiguration()
//        config.text = data[indexPath.row].item
//
//        config.secondaryText = "\(ViewViewController.dateFormatter.string(from: data[indexPath.row].date))"
//        config.secondaryTextProperties.color = UIColor.darkGray
        
        cell.DdayLabel?.text = data[indexPath.row].Dday
//
//        cell.contentConfiguration = config

//        cell.textLabel?.text = "\(data[indexPath.row].Dday) "
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = data[indexPath.row]

        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? ViewViewController else{
            return
        }
        
        vc.item = item
        vc.deletionHandler = { [weak self] in
            self?.refresh()
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Bbetter"
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    @IBAction func didTapAddButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "enter") as? EntryViewController else {
            return
        }
        vc.completionHandler = { [weak self] in
            self?.refresh()
            
        }
        
        vc.title = "목표 추가"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refresh(){
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.reloadData()
    }
            
            
            
        }


