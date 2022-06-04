//
//  CalenderViewController.swift
//  Bbetter_Swift
//
//  Created by 강재혁 on 2022/05/22.
//

import UIKit
import RealmSwift
import FSCalendar
import CloudKit


class CalenderViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource{
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fsCalender: FSCalendar!
  
    
    var date = dateFormatter.string(from: Date())
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat){
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: itemLabel.frame.width, height: borderWidth)
        itemLabel.addSubview(border)
    }

    
    
   
    
    
    
    private let realm = try! Realm()
 
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }()
    

    override func viewWillAppear(_ animated: Bool) {
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            if "\(item2.item)" == ""{
                itemLabel?.text! = "내용을 입력해주세요"
                itemLabel.textColor = UIColor.lightGray
            }else{
            itemLabel?.text! = "\(item2.item)"
            itemLabel.textColor = UIColor.black
        }
        }
        super.viewWillAppear(animated)
        fsCalender.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        for item2 in list{
            itemLabel?.text! = "\(item2.item)"
            itemLabel.textColor = UIColor.black
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(CalenderViewController.tapItemLabel))
        itemLabel.isUserInteractionEnabled = true
        itemLabel.addGestureRecognizer(tap)
        self.itemLabel.numberOfLines = 0
        addTopBorder(with: UIColor.black, andWidth: CGFloat(0.5))
        fsCalender.delegate = self
        fsCalender.dataSource = self
        fsCalender.scope = .month
        fsCalender.appearance.headerTitleColor = UIColor.black
        fsCalender.appearance.titleDefaultColor = .black  // 평일
       
        fsCalender.appearance.titleWeekendColor = .red
        fsCalender.appearance.selectionColor = UIColor.black
        fsCalender.appearance.todayColor = UIColor.lightGray
        fsCalender.headerHeight = 50
        fsCalender.appearance.headerMinimumDissolvedAlpha = 0.0
        fsCalender.appearance.headerDateFormat = "YYYY년 M월"
        fsCalender.appearance.headerTitleColor = .black
        fsCalender.appearance.headerTitleFont = UIFont.systemFont(ofSize: 24)
        fsCalender.appearance.weekdayTextColor = .black
     

 
        


//        itemLabel.layer.borderWidth = 1
//        datePicker.setValue(UIColor.blue, forKey: "textColor")
//        datePicker.setValue(true, forKeyPath: "backgroundColor")
      
      

    }
    
    @objc func tapItemLabel(sender:UITapGestureRecognizer){
        
        guard let vc = storyboard?.instantiateViewController(identifier: "view") as? CalenderViewViewController else{
            return
        }
        vc.dataDate = date
        
        if itemLabel?.text == "내용을 입력해주세요" {
            vc.labelItem = ""
        }else{
            vc.labelItem = itemLabel?.text ?? ""
        }
       
        
        vc.navigationItem.largeTitleDisplayMode = .never
      
        navigationController?.pushViewController(vc, animated: true)
        
     
        
        }
 

          func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
              self.date = Self.dateFormatter.string(from: fsCalender.selectedDate!)
            
              let list = realm.objects(diaryItem.self).filter("date == '\(self.date)'")
          
              
            
              
              if list.count == 0{
                  itemLabel?.text! = "내용을 입력해주세요"
                  itemLabel.textColor = UIColor.lightGray
                  
              }else{
                 
                  for item2 in list{
                      if "\(item2.item)" == ""{
                          print(item2.item)
                          itemLabel?.text! = "내용을 입력해주세요"
                          itemLabel.textColor = UIColor.lightGray
                      }else{
                      itemLabel?.text! = "\(item2.item)"
                          print(item2.item)
                          itemLabel.textColor = UIColor.black
                  }
                  }
              }
          }
    
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            
            let list2 = realm.objects(diaryItem.self)
            var dateList: [String] = []
            for item3 in list2{
               
                    dateList.append(item3.date)
                if "\(item3.item)" == ""{
                    dateList.removeAll(where: {$0 == item3.date })
                }
                
                
            }
            if dateList.contains( Self.dateFormatter.string(from: date)){
                return 1
            }
           
            return 0
            
        }
    
  
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]?{
//        let list2 = realm.objects(diaryItem.self)
//        var dateList: [String] = []
//        for item3 in list2{
//            dateList.append(item3.date)
//        }
//         if dateList.contains( Self.dateFormatter.string(from: date)){
//             return [UIColor.red]
//         }
//
//        
//
//        return nil
//     }
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventSelectionColorsFor date: Date) -> [UIColor]? {
//        let list2 = realm.objects(diaryItem.self)
//        var dateList: [String] = []
//        for item3 in list2{
//            dateList.append(item3.date)
//        }
//         if dateList.contains( Self.dateFormatter.string(from: date)){
//             return [UIColor.red]
//         }
//
//            return [UIColor.red]
//        }


          

          public func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            
          }

    
    
    @IBAction func didDatePickerValueChanged(_ sender: UIDatePicker){
        
    
       
        self.date = Self.dateFormatter.string(from: datePicker!.date)
        let list = realm.objects(diaryItem.self).filter("date == '\(date)'")
        
        if list.count == 0{
            itemLabel?.text! = "내용을 입력해주세요"
            itemLabel.textColor = UIColor.lightGray
        }else{
           
            for item2 in list{
                if "\(item2.item)" == ""{
                    itemLabel?.text! = "내용을 입력해주세요"
                    itemLabel.textColor = UIColor.lightGray
                }else{
                itemLabel?.text! = "\(item2.item)"
                    itemLabel.textColor = UIColor.black
            }
            }
        }

    }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


