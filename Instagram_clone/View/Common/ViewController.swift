//
//  HomeViewController.swift
//  Instagram_clone
//
//  Created by Mika Urakawa on 2019/12/15.
//  Copyright © 2019 kamimi01. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTab()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // currentUserがnilならば、ログインしていない
        if Auth.auth().currentUser != nil {
            // ログインしていない時の処理
            let loginStoryborad = UIStoryboard(name: "Login", bundle: nil)
            let loginViewController = loginStoryborad.instantiateViewController(withIdentifier: "Login")
            // モーダルで表示する
            self.present(loginViewController, animated: true, completion: nil)
        }
    }
    
    func setUpTab() {
        // 画像ファイル名を指定してタブを表示する
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        // 背景色、選択時の色を選択
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        tabBarController.selectionIndicatorHeight = 3
        
        // 作成したESTabBarControllerを親のViewController（＝self）に追加する
        addChild(tabBarController)
        
        let tabBarView = tabBarController.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            ])
        
        tabBarController.didMove(toParent: self)
        
        // タブをタップした時に表示するViewControllerを設定する
        let homeStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let settingStoryboard = UIStoryboard(name: "Setting", bundle: nil)
        
        let homeViewController = homeStoryboard.instantiateViewController(withIdentifier: "Home")
        let settingViewController = settingStoryboard.instantiateViewController(withIdentifier: "Setting")
        
        tabBarController.setView(homeViewController, at: 0)
        tabBarController.setView(settingViewController, at: 2)

        // 真ん中のタブはボタンとして扱う
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
            // ボタンが押されたらImageViewControllerをモーダルで表示する
            let imageSelectStoryboard = UIStoryboard(name: "ImageSelect", bundle: nil)
            let imageViewController = imageSelectStoryboard.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController, animated: true, completion: nil)
        }, at: 1)
    }
    
}
