import UIKit
// 通知をimport
import UserNotifications

// UIPickerViewを使用するためのDelegateを設定
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    // 時間設定
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    var setCountNum = [0,5,10,15,20,25,30]
    

    // 回数カウント用の変数を追加
    var setCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    // PickerViewの列数を設定する
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // PickerViewの列数を設定する
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setCountNum.count
    }
    
    // PickerViewに表示する内容を設定する
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 変数展開
return "\(setCountNum[row])"

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedFruit = Int(setCountNum[row])
        print(selectedFruit)
    }
    
    @IBAction func didTapBtn(_ sender: Any) {
        setAlerm()
        let userDefault = UserDefaults.standard
        userDefault.set(setCount, forKey: "setCount")
        setCount = setCount + 1
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
