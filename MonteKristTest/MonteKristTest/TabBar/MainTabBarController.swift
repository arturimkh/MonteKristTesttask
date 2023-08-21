//
//  MainTabBarController.swift
//  MonteKristTest
//
//  Created by Artur Imanbaev on 07.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
    }
    private func generateTabBar(){
        viewControllers = [
            UINavigationController(rootViewController: generateVC(viewController: ViewController(),
                                                                  title: "Home",
                                                                  image: UIImage(systemName: "house"))),
            UINavigationController(rootViewController: generateVC(viewController: FavouriteViewController(),
                                                                  title: "Favourite",
                                                                  image: UIImage(systemName: "star")))
        ]
    }
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController{
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.black.cgColor
        
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .white
    }
}
