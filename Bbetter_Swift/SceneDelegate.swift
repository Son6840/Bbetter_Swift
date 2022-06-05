//
//  SceneDelegate.swift
//  Bbetter_Swift
//
//  Created by 모바일인터넷과 on 2022/05/11.
//

import UIKit
import KakaoSDKAuth
import RealmSwift


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let realm = try! Realm()
    private var data = [ToDoListItem]()
    private var alarmDate:[Date] = []
    private var alarmItem:[String] = []
    let notificationCenter = UNUserNotificationCenter.current()
    
    


    
    
  
   
    var window: UIWindow?
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
            if let url = URLContexts.first?.url {
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        guard let _ = (scene as? UIWindowScene) else { return }
        data = realm.objects(ToDoListItem.self).map({ $0 })
        for item2 in data{
            alarmDate.append(item2.date)
            alarmItem.append(item2.item)
         
        }
       
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        // UserNotification 프레임워크를 이용한 로컬 알림
        UNUserNotificationCenter.current().getNotificationSettings { [self] settings in // 앱의 알람 설정 상태 확인
            print("Notification")
//            data = realm.objects(alarmDate.self).map({ $0 })
            var trigger:UNCalendarNotificationTrigger
            var request: UNNotificationRequest
            if alarmItem.count == 0{
                return
            }else{
                for i in 0...alarmItem.count-1{
                    let content = UNMutableNotificationContent()
                            content.title = "Bbetter"
                            content.body = alarmItem[i]
                    print("여기")
                    print(alarmDate[i])
                    print(alarmItem[i])
                    var dateComponets = Calendar.current.dateComponents([.year, .month, .day], from: alarmDate[i])
                   

                    dateComponets.hour = 00
                    dateComponets.minute = 00
                    trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: false)
                    request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    print("타입은?")
                    print(type(of: trigger))
                    notificationCenter.add(request) { error in
                        print(#function, error ?? "nil")
                    }
                }
            }
            
            
            
            
         
            
//            self.data = self.realm.objects(ToDoListItem.self).map({ $0 })
            
//            if settings.authorizationStatus == UNAuthorizationStatus.authorized {
//                // setting이 알람을 받는다고 한 상태가 권한을 받은 상태라면
//
//                // 1. 발송 내용 정의
//                let nContent = UNMutableNotificationContent()
//                nContent.badge = 1
//                nContent.title = "Bbetter"
//                nContent.subtitle = "준비된 내용이 아주 많아요! 얼른 다시 앱을 열어주세요."
//                nContent.body = "다시 들어와!"
//                nContent.sound = .default
//                nContent.userInfo = ["name":"홍길동"]
//
//                // 2. 발송 조건 정의
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//
//                // 3. 알림 요청 생성
//                let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
//
//                // 4. 노티피케이션 센터에 등록
//                UNUserNotificationCenter.current().add(request) { err in
//                    print("complete")
//                }
//            } else {
//                print("알림설정 X")
//            }
//        }
//
    }

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }




}

