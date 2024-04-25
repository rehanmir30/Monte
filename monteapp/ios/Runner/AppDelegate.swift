import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private var obscureOverlay: UIView?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        // Add observer for screen capture
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(onScreenCapture),
            name: UIScreen.capturedDidChangeNotification,
            object: nil
        )

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    @objc private func onScreenCapture() {
        guard let window = UIApplication.shared.keyWindow else { return }

        if UIScreen.main.isCaptured {
            // Screen is being captured - obscure content
            let overlay = UIView(frame: window.bounds)
            overlay.backgroundColor = UIColor(white: 0, alpha: 1) // semi-transparent black overlay
            window.addSubview(overlay)
            obscureOverlay = overlay
        } else {
            // Screen capture ended - remove overlay
            obscureOverlay?.removeFromSuperview()
            obscureOverlay = nil
        }
    }

    override func applicationWillResignActive(_ application: UIApplication) {
        // Obscure content when the app goes to the background
        obscureContent()
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        // Unobscure content when the app comes back to the foreground
        unobscureContent()
    }

    private func obscureContent() {
        guard let window = UIApplication.shared.keyWindow, obscureOverlay == nil else { return }
        let overlay = UIView(frame: window.bounds)
        overlay.backgroundColor = UIColor(white: 0, alpha: 1) // semi-transparent black overlay
        window.addSubview(overlay)
        obscureOverlay = overlay
    }

    private func unobscureContent() {
        obscureOverlay?.removeFromSuperview()
        obscureOverlay = nil
    }
}
