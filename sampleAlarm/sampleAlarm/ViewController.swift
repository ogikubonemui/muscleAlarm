import UIKit
// 通知をimport
import UserNotifications

// UIPickerViewを使用するためのDelegateを設定
class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    // タイマー時間の設定
    @IBOutlet weak var datePicker: UIDatePicker!
    
    // 腕立て回数の設定
    @IBOutlet weak var pickerView: UIPickerView!
    
    
    @IBOutlet weak var checkLabel: UILabel!
    
    // pickerViewに反映させる選択肢用の配列
    var setCountNum = [0,5,10,15,20,25,30]
    
    var pushUpNum = 0
    
    // 選択した回数が反映されるlabel（のちほど消す予定）
    @IBOutlet weak var label: UILabel!
    
    // 回数カウント用の変数を追加
    //    var setCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
    }
    
    // pickerViewの列数を設定する
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // pickerViewの列数を設定する
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return setCountNum.count
    }
    
    // pickerViewに表示する内容を設定する
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // 変数展開
        return "\(setCountNum[row])"
    }
    
    // pickerViewで選択した値を取り出す
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pushUpNum = Int(setCountNum[row])
        print(pushUpNum)
        let userDefault = UserDefaults.standard
        userDefault.set(pushUpNum, forKey: "pushUpNum")
    }
    
    // 登録ボタン
    @IBAction func didTapBtn(_ sender: Any) {
        setAlerm()
        let userDefault = UserDefaults.standard
        pushUpNum = userDefault.integer(forKey: "pushUpNum")
        label.text = "\(pushUpNum)"
        checkLabel.text = "登録されました"
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
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        // ここからスヌーズ用の記述
        // 通知時間インスタンス作成
        var notificationTimeDellayThree = DateComponents()
        let calendarDellayThree = Calendar.current
        notificationTimeDellayThree.hour = calendar.component(.hour, from: datePicker.date)
        print(datePicker.date)
        
        var hogeDate = calendarDellayThree.date(byAdding: .minute, value: 1, to: datePicker.date)
        print(hogeDate)
        
        notificationTimeDellayThree.minute = calendarDellayThree.component(.minute, from: hogeDate!)
        // 通知トリガーインスタンス作成
        let triggerDellayThree = UNCalendarNotificationTrigger(dateMatching: notificationTimeDellayThree, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDellayThree = UNNotificationRequest(identifier: "uuid", content: content, trigger: triggerDellayThree)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDellayThree, withCompletionHandler: nil)
        
    }
}
