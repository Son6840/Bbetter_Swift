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
    private let floatingButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 60  , height: 60))
        
        button.backgroundColor = .black
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
//        button.layer.shadowRadius = 10
//        button.layer.shadowOpacity = 0.3
        //corner Radius
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data = realm.objects(ToDoListItem.self).map({ $0 })
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.table.delegate = self
        self.table.dataSource = self
        view.addSubview(floatingButton)
        floatingButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
//        addButton.layer.cornerRadius = addButton.layer.frame.width/2
//        addButton.frame.size.width = 50
//        addButton.frame.size.height = 50
//        addButton.layer.zPosition = 999

        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        floatingButton.frame = CGRect(x: Int(view.frame.size.width) - 70, y: Int(view.frame.size.height) - 100, width:60, height: 60)
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
        cell.contentView.isUserInteractionEnabled = false
//
//        cell.contentConfiguration = config

//        cell.textLabel?.text = "\(data[indexPath.row].Dday) "
        //ㅇㅇㅇ
        
        return cell
        
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        let row = data[indexPath.row]
//        let height = CGFloat(50 + (row.count/30)*20)
//        
//        tableView.estimatedRowHeight = 50
//        tableView.rowHeight = UITableView.automaticDimension
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
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
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        // 오른쪽에 만들기
//
//
//        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
//            print("삭제 클릭 됨")
//
//            success(true)
//        }
//        delete.backgroundColor = .systemRed
//
//        //actions배열 인덱스 0이 오른쪽에 붙어서 나옴
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           
           if editingStyle == .delete {
               
               data.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
               
           } else if editingStyle == .insert {
               
           }
       }
    
//    @objc private func didTapDelete() {
//        guard let myItem = self.item else{
//            return
//        }
//        realm.beginWrite()
//        realm.delete(myItem)
//        try! realm.commitWrite()
//        
//        deletionHandler?()
//        navigationController?.popToRootViewController(animated: true)
//        
//    }

    
    @objc private func didTapAddButton() {
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


