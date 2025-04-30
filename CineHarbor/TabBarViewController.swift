import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    func setTabBar() {
        let trending = configureTabItem(
            viewControler: TrendingViewController(),
            title: "Trending",
            iconName: "video",
            tag: 1
        )
        
        let favorites = configureTabItem(
            viewControler: FavoriteViewController(),
            title: "Favoritos",
            iconName: "heart",
            tag: 2
        )
        
        tabBar.backgroundColor = .theme.barColor
        tabBar.tintColor = .label
        
        setViewControllers([trending, favorites], animated: true)
    }
    
    func configureTabItem(
        viewControler: UIViewController,
        title: String,
        iconName: String,
        tag: Int
    ) -> UINavigationController {
        let item = UINavigationController(rootViewController: viewControler)
        item.navigationBar.tintColor = .label
        item.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: iconName), tag: tag)
        return item
    }
}

