
import UIKit
// 通知デリゲート
import UserNotifications

class ViewController: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    // 回数カウント用
    @IBOutlet weak var label: UILabel!
    
    // 回数カウント用の変数を追加
    var setCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    @IBAction func didTapBtn(_ sender: Any) {
        setAlerm()
        let userDefault = UserDefaults.standard
        userDefault.set(setCount, forKey: "setCount")
    }
    
    
    @IBAction func didClickBtn(_ sender: Any) {
        setCount = setCount + 1
        label.text = String(setCount)
    }
    
    
    
    
    
}

// 通知関連の処理をこちらに
extension ViewController {
    func setAlerm() {
        // 今設定されている通知のストックを削除
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        // 通知内容の作成
        let content = UNMutableNotificationContent()
        content.title = "朝です"
        content.body = "筋トレしましょう"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "tsuuchi.caf"))
        
        // 通知時間インスタンス作成
        var notificationTime = DateComponents()
        let calendar = Calendar.current
        notificationTime.hour = calendar.component(.hour, from: datePicker.date)
        notificationTime.minute = calendar.component(.minute, from: datePicker.date)
        // 通知トリガーインスタンス作成
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        // 通知リクエストインスタンス作成
        let request = UNNotificationRequest(identifier: "uuid", content: content, trigger: trigger)
    
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
