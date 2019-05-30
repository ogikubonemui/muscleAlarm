
import UIKit
// 通知機能のインポート
import UserNotifications
import AVFoundation

// 通知デリゲートの追加
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // バックグラウンド再生
        try? AVAudioSession.sharedInstance().setCategory(.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
        
        // iOS10.0以上であれば通知を許可する
        if #available(iOS 10.0, *){
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(
                options: [.badge, .sound, .alert],
                completionHandler: { (granted, err) in
                    if let e = err {
                        print("ERROR: \(e)")
                        return
                    }
                    if granted {
                        center.delegate = self
                    }
            })
        } else {
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
  // 通知からアプリが起動したときの処理
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Main.storyboardをインスタンス化
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        // IDから特定のViewControllerを取得
        let nextVC = storyboard.instantiateViewController(withIdentifier: "next")
        // ルートビューコントローラーに取り出した画面を設定
        window?.rootViewController = nextVC
        
        // この処理が終わったときに必ず呼ばなければならない処理
        completionHandler()
    }
    
}

