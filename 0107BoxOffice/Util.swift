//
//  Util.swift
//  0107BoxOffice
//
//  Created by jh on 2021/04/02.
//

import Foundation
import UIKit




class Util: NSObject {
    
    private override init() {}
    
    
    // MARK: Alert
    // Alert
//    AppDelegate나 NSObject 클래스에서 UIAlertController를 띄우고 싶을때가 종종 있다.
//    UIAlertController를 사용할려면 뷰컨트롤러에서 present를 해야하고 최상위가 아닌 뷰컨트롤러에서 시도할 경우 아래와 같이 계층 에러가 발생한다.
//
//    (참고: viewDidLoad에서 바로 다른 뷰컨트롤러를 present를 하게 될 경우도 발생한다. 화면이 다 보여지지 않은 상태에서 다른 뷰컨트롤러를 보여준다는게 말이 안되기 때문이다.)
// https://taesulee.tistory.com/2 참고
    
    class func topViewController() -> UIViewController? {

        if let keyWindow = UIApplication.shared.keyWindow {

            if var viewController = keyWindow.rootViewController {

                while viewController.presentedViewController != nil {

                    viewController = viewController.presentedViewController!

                }

                print("topViewController -> \(String(describing: viewController))")

                return viewController

            }

        }

        return nil

    }

    
   static func showAlert(title: String, msg: String, buttonTitle: String, handler: ((UIAlertAction) -> Swift.Void)?){

          let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)

          let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)

          alertController.addAction(defaultAction)

    let vcController = self.topViewController()
    vcController!.present(alertController, animated: true, completion: nil)
    }
}

