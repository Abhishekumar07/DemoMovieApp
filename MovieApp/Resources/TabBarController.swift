//
//  TabBarController.swift
//  MovieApp
//
//  Created by Admin on 02/04/24.
//

 
import UIKit
class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var navigation: UINavigationController?
    var homeScreenViewController:HomeScreenViewController!
    var exitViewController:ExitViewController!
    
    override func viewDidLoad() {
        self.delegate = self
        self.tabBar.tintColor = .white
        self.tabBar.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.2509803922, blue: 0.3215686275, alpha: 1)
        homeScreenViewController = HomeScreenViewController()
        exitViewController = ExitViewController()
        
        homeScreenViewController.tabBarItem.image = UIImage(named: "homePage")
        homeScreenViewController.tabBarItem.selectedImage = UIImage(named: "homePage")
        homeScreenViewController.tabBarItem.title = "Home"
        
        exitViewController.tabBarItem.image = UIImage(named: "logout")
        exitViewController.tabBarItem.selectedImage = UIImage(named: "logout")
        exitViewController.tabBarItem.title = "Exit"
        
        //MARK: Adjust image insets to center the icon when the title is not shown
        homeScreenViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        exitViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        //MARK: Increase tab bar height
        self.tabBar.frame.size.height = 80
        //MARK: Customize title text attributes to adjust text size
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)
        ]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        viewControllers = [homeScreenViewController , exitViewController]
        
    }
}
