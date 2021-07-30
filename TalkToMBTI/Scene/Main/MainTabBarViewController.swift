//
//  MainTabBarViewController.swift
//  TalkToMBTI
//
//  Created by Panda on 2021/07/30.
//

import UIKit

class MainTabBarViewController: UIKit.UITabBarController, UITabBarControllerDelegate {
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
//    self.tabBar.backgroundColor = .clear
//    self.tabBar.barTintColor = .clear
//    self.tabBar.tintColor = .clear
//    self.tabBar.isTranslucent = true
//
//    let appearance = tabBar.standardAppearance
//    appearance.configureWithTransparentBackground()
//    appearance.backgroundEffect = .none
//    appearance.backgroundColor = .clear
//    appearance.backgroundImage = UIImage()
//    appearance.shadowImage = UIImage()
//    appearance.shadowColor = .clear
//    tabBar.standardAppearance = appearance
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    setupTabBarVCs()
    
    if let items = self.tabBar.items {
      items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
    }

    self.tabBar.itemWidth = 30.0
    self.tabBar.itemPositioning = .centered
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
//    removeTitle()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    self.tabBar.invalidateIntrinsicContentSize()
  }
  
  public func removeTitle() {
    if let tab = self.tabBar.items {
      for element in tab {
        element.title = ""
      }
    }
  }
  
  func adjustImagePosition() {
    // 기종 별 탭바 아이템 이미지 위치 조정
    switch UIScreen.main.bounds.size.height {
    case 480.0: // iphone 3,4S => 3.5 inch
    break
    case 568.0: // iphone 5, SE => 4 inch
    break
    case 667.0: // iphone 6, 6s, 7, 8 => 4.7 inch
    break
    case 736.0: // iphone 6s+ 6+, 7+, 8+ => 5.5 inch
    break
    default:
      tabBar.items?.forEach({
        $0.title = ""
//        $0.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -15, right: 0)
      })
    }
  }
  
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    print("didSelect item")
    item.title = ""
  }
  
  func setupTabBarVCs() {
//    let mainVC = MainContainerPagerViewController()
//    let mainNaviVC = UINavigationController(rootViewController: mainVC)
//
//    viewControllers = [mainNaviVC]
    adjustImagePosition()
  }
  
  func tabBarController(_ tabBarController: UITabBarController,
                        shouldSelect viewController: UIViewController) -> Bool {
    return true
  }
  
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
  }
}
