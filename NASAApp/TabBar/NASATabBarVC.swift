//
//  NASATabBarVC.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.04.2021.
//

import UIKit

class NASATabBarVC: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //guard let items = items else { return }
        
        //        items[0].title = "Title0"
        //        items[1].title = "Title1"
        //        items[2].title = "Title2"
        //        items[3].title = "Title3"
    }
    
    
    private func setupTabBar() {
        var tabBarList: [UIViewController]!
        
        let pictureNC = UINavigationController()
        let pictureOfDayVC = PictureOfDayVC()
        pictureNC.viewControllers = [pictureOfDayVC]
        let iconConfig = UIImage.SymbolConfiguration(scale: .large)
        let gearIcon = UIImage(systemName: "photo.on.rectangle.angled", withConfiguration: iconConfig)

        pictureOfDayVC.tabBarItem.title = TabBarNames.pictureOfDay
        pictureOfDayVC.tabBarItem.image = gearIcon
//        pictureOfDayVC.tabBarItem.image = UIImage(systemName: "favorite")
        pictureOfDayVC.tabBarItem.tag = 0
        
        let searchNC = UINavigationController()
        let searchVC = SearchVC()
        searchNC.viewControllers = [searchVC]
        
        let searchIcon = UIImage(systemName: "magnifyingglass", withConfiguration: iconConfig)

        searchVC.tabBarItem.title = TabBarNames.search
        searchVC.tabBarItem.image = searchIcon
//        pictureOfDayVC.tabBarItem.image = UIImage(systemName: "favorite")
        searchVC.tabBarItem.tag = 1
        
        //let storyboard2 = UIStoryboard(name: ConstantsNames.AllSitters, bundle: nil)
//        let storyboardAdverts = UIStoryboard(name: ConstantsNames.ParentsAdverts, bundle: nil)
//        let parentsAdverts = storyboardAdverts.instantiateViewController(withIdentifier: ConstantsNames.ParentsAdverts)
//
//        parentsAdverts.tabBarItem.title = TabBarNames.advertisings
//        parentsAdverts.tabBarItem.image = UIImage(named: TabBarNames.advertisingsIcon)
//        parentsAdverts.tabBarItem.tag = 1
//        // advertisings
//
//        let ordersStoryboard = UIStoryboard(name: ConstantsNames.Orders, bundle: nil)
//        let ordersVC = ordersStoryboard.instantiateViewController(withIdentifier: ConstantsNames.Orders)
//        ordersVC.tabBarItem.title = TabBarNames.ordersText
//        ordersVC.tabBarItem.image = UIImage(named: TabBarNames.ordersIcon)
//        ordersVC.tabBarItem.tag = 2
//
//        let messagesStoryboard = UIStoryboard(name: ConstantsNames.Messages, bundle: nil)
//        let messagesVC = messagesStoryboard.instantiateViewController(withIdentifier: ConstantsNames.Messages)
//        messagesVC.tabBarItem.title = TabBarNames.messagesText
//        messagesVC.tabBarItem.image = UIImage(named: TabBarNames.messagesTab)
//        messagesVC.tabBarItem.tag = 3
//
//        let profileStoryboard = UIStoryboard(name: ConstantsNames.Profile, bundle: nil)
//        let profileVC = profileStoryboard.instantiateViewController(withIdentifier: ConstantsNames.Profile)
//        profileVC.tabBarItem.title = TabBarNames.profile
//        profileVC.tabBarItem.image = UIImage(named: TabBarNames.profileIcon)
//        profileVC.tabBarItem.tag = 4
        
        tabBarList = [pictureNC, searchNC]
        viewControllers = tabBarList
    }
}
