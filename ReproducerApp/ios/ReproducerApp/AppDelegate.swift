import UIKit
import React
import React_RCTAppDelegate
import ReactAppDependencyProvider

@main
class AppDelegate: RCTAppDelegate {
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
    self.dependencyProvider = RCTAppDependencyProvider()
    self.automaticallyLoadReactNativeWindow = false
    super.application(application, didFinishLaunchingWithOptions: launchOptions)
    window = UIWindow()
    window.rootViewController = ViewController()
    window.makeKeyAndVisible()
    return true
  }
  
  override func sourceURL(for bridge: RCTBridge) -> URL? {
    self.bundleURL()
  }
  
  override func bundleURL() -> URL? {
    Bundle.main.url(forResource: "main", withExtension: "jsbundle", subdirectory: "rn_build")
  }
}


class ViewController: UIViewController {

  var reactViewController: ReactViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.view.backgroundColor = .red

    let button = UIButton()
    button.setTitle("Open React Native", for: .normal)
    button.setTitleColor(.systemBlue, for: .normal)
    button.setTitleColor(.blue, for: .highlighted)
    button.addAction(UIAction { [weak self] _ in
      guard let self else { return }
      if reactViewController == nil {
       reactViewController = ReactViewController()
      }
      present(reactViewController!, animated: true)
    }, for: .touchUpInside)
    self.view.addSubview(button)

    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
      button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
      button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
    ])
  }
}

class ReactViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let factory = (RCTSharedApplication()?.delegate as? RCTAppDelegate)?.rootViewFactory
    self.view = factory?.view(withModuleName: "ReproducerApp")
  }
}
