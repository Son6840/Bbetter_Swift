
//
//  ViewController.swift
//  HappyChuseok
//
//  Created by Kang, Su Jin (강수진) on 2020/10/01.
//  Copyright © 2020 Kang, Su Jin (강수진). All rights reserved.
//
import UIKit
import KakaoSDKAuth
import KakaoSDKUser

class KakaoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func onClickNoneLoginButton(){
        guard let vc = storyboard?.instantiateViewController(identifier: "main") as? MainViewController else{
            return
        }
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
//        navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true ,completion: nil)
    }
    @IBAction func onKakaoLoginByAppTouched(_ sender: Any) {
     // 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                        onKakaoLoginCompleted(oauthToken?.accessToken)
                    }
                }
                //카카오톡 설치되지 않은 경우 카카오 로그인 웹뷰를 띄운다.
                else{
                    UserApi.shared.loginWithKakaoAccount(prompts:[.Login]) { oauthToken, error  in
                        onKakaoLoginCompleted(oauthToken?.accessToken)
                    }
                }
                
                func onKakaoLoginCompleted(_ accessToken : String?){
                    getKakaoUserInfo(accessToken)
                    guard let vc = storyboard?.instantiateViewController(identifier: "main") as? MainViewController else{
                        return
                    }
                    vc.modalPresentationStyle = .fullScreen
                    vc.modalTransitionStyle = .crossDissolve
                    self.present(vc,animated: true,completion: nil)
                  
//                    navigationController?.pushViewController(vc, animated: true)
                    
                }
                
                func getKakaoUserInfo(_ accessToken : String?){
                    UserApi.shared.me() { [weak self] user, error in
                        
                        if error == nil {
                            let userId = String(describing: user?.id)
                            print("userID: ",userId)
                        }
                        
                    }
                }

        
    }
}
