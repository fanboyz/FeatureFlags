
import UIKit
import FeatureFlags

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let tabController = UITabBarController()
        tabController.viewControllers = [
            createDemoViewController(),
            createFeatureFlagsController()
        ]
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.rootViewController = tabController
        window?.makeKeyAndVisible()
        return true
    }

    private func createDemoViewController() -> UIViewController {
        return UIStoryboard(name: "DemoViewController", bundle: nil).instantiateInitialViewController()!
    }

    private func createFeatureFlagsController() -> UIViewController {
        let flagsController = FeatureFlagsUI.launch(sharedFeatureFlagFile: AppFeatureFlags.instance.sharedFeatureFlagFile)
        flagsController.tabBarItem.image = UIImage(named: "flag")
        flagsController.tabBarItem.title = "Feature Flags"
        let navigationController = UINavigationController(rootViewController: flagsController)
        navigationController.title = "Feature Flags"
        return navigationController
    }
}
