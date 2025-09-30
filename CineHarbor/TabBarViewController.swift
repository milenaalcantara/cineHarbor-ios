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
        
        tabBar.tintColor = .white
        
        setViewControllers([trending, favorites], animated: true)
    }
    
    func configureTabItem(
        viewControler: UIViewController,
        title: String,
        iconName: String,
        tag: Int
    ) -> UINavigationController {
        let nav = UINavigationController(rootViewController: viewControler)
        nav.navigationBar.tintColor = .label
        
        // Garantir que a imagem esteja em modo template para receber tint
        let image = UIImage(systemName: iconName)?.withRenderingMode(.alwaysTemplate)
        nav.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        return nav
    }
}
