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
    
    @IBOutlet weak var kaiLabel: UILabel!
    // pickerViewに反映させる選択肢用の配列
    var setCountNum = [0,10,50]
    
    var pushUpNum = 0
    
    // 選択した回数が反映されるlabel（のちほど消す予定）
    @IBOutlet weak var label: UILabel!
    
    // 回数カウント用の変数を追加
    //    var setCount = 0
    @IBOutlet weak var didTapBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        didTapBtn.layer.cornerRadius = 10.0
//        label.text = ""
//        kaiLabel.text = ""
        checkLabel.text = ""
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
    
    
    @IBAction func didClickInfo(_ sender: Any) {
        performSegue(withIdentifier: "toInfo", sender: nil)
    }
    
    // 登録ボタン
    @IBAction func didTapBtn(_ sender: Any) {
        setAlerm()
        let userDefault = UserDefaults.standard
        pushUpNum = userDefault.integer(forKey: "pushUpNum")
//        label.text = "\(pushUpNum)"
//        kaiLabel.text = "回"
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
        content.title = "時間になりました"
        content.body = "筋トレをしましょう"
        content.sound = UNNotificationSound.init(named: UNNotificationSoundName(rawValue: "tsuuchi.caf"))
        
        // 通知時間インスタンス作成
        var notificationTime = DateComponents()
        let calendar = Calendar.current
        notificationTime.hour = calendar.component(.hour, from: datePicker.date)
        notificationTime.minute = calendar.component(.minute, from: datePicker.date)
        // 通知トリガーインスタンス作成
        let trigger = UNCalendarNotificationTrigger(dateMatching: notificationTime, repeats: false)
        
        // 通知リクエストインスタンス作成
        let request = UNNotificationRequest(identifier: "uuid1", content: content, trigger: trigger)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        print(notificationTime)
        
        
        
        
        
        
        // ここからスヌーズ用の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayOne = DateComponents()
        let calendarDelayOne = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDate = calendarDelayOne.date(byAdding: .minute, value: 1, to: datePicker.date)
        notificationTimeDelayOne.hour = calendar.component(.hour, from: hogeDate!)
        notificationTimeDelayOne.minute = calendarDelayOne.component(.minute, from: hogeDate!)
        // 通知トリガーインスタンス作成
        let triggerDelayOne = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayOne, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayOne = UNNotificationRequest(identifier: "uuid2", content: content, trigger: triggerDelayOne)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayOne, withCompletionHandler: nil)
        print(notificationTimeDelayOne)
        
        // ここからスヌーズ用（2分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayTwo = DateComponents()
        let calendarDelayTwo = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateTwo = calendarDelayTwo.date(byAdding: .minute, value: 2, to: datePicker.date)
        notificationTimeDelayTwo.hour = calendar.component(.hour, from: hogeDateTwo!)
        notificationTimeDelayTwo.minute = calendarDelayTwo.component(.minute, from: hogeDateTwo!)
        // 通知トリガーインスタンス作成
        let triggerDelayTwo = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayTwo, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayTwo = UNNotificationRequest(identifier: "uuid3", content: content, trigger: triggerDelayTwo)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayTwo, withCompletionHandler: nil)
        print(notificationTimeDelayTwo)
        
    
        // ここからスヌーズ用（3分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayThree = DateComponents()
        let calendarDelayThree = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateThree = calendarDelayThree.date(byAdding: .minute, value: 3, to: datePicker.date)
        notificationTimeDelayThree.hour = calendar.component(.hour, from: hogeDateThree!)
        notificationTimeDelayThree.minute = calendarDelayThree.component(.minute, from: hogeDateThree!)
        // 通知トリガーインスタンス作成
        let triggerDelayThree = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayThree, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayThree = UNNotificationRequest(identifier: "uuid4", content: content, trigger: triggerDelayThree)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayThree, withCompletionHandler: nil)
        print(notificationTimeDelayThree)
        
        // ここからスヌーズ用（4分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayFour = DateComponents()
        let calendarDelayFour = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateFour = calendarDelayFour.date(byAdding: .minute, value: 4, to: datePicker.date)
        notificationTimeDelayFour.hour = calendar.component(.hour, from: hogeDateFour!)
        notificationTimeDelayFour.minute = calendarDelayFour.component(.minute, from: hogeDateFour!)
        // 通知トリガーインスタンス作成
        let triggerDelayFour = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayFour, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayFour = UNNotificationRequest(identifier: "uuid5", content: content, trigger: triggerDelayFour)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayFour, withCompletionHandler: nil)
        print(notificationTimeDelayFour)
        
        // ここからスヌーズ用（5分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayFive = DateComponents()
        let calendarDelayFive = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateFive = calendarDelayFive.date(byAdding: .minute, value: 5, to: datePicker.date)
        notificationTimeDelayFive.hour = calendar.component(.hour, from: hogeDateFive!)
        notificationTimeDelayFive.minute = calendarDelayFive.component(.minute, from: hogeDateFive!)
        // 通知トリガーインスタンス作成
        let triggerDelayFive = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayFive, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayFive = UNNotificationRequest(identifier: "uuid6", content: content, trigger: triggerDelayFive)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayFive, withCompletionHandler: nil)
        print(notificationTimeDelayFive)
        
        // ここからスヌーズ用（6分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelaySix = DateComponents()
        let calendarDelaySix = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateSix = calendarDelaySix.date(byAdding: .minute, value: 6, to: datePicker.date)
        notificationTimeDelaySix.hour = calendar.component(.hour, from: hogeDateSix!)
        notificationTimeDelaySix.minute = calendarDelaySix.component(.minute, from: hogeDateSix!)
        // 通知トリガーインスタンス作成
        let triggerDelaySix = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelaySix, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelaySix = UNNotificationRequest(identifier: "uuid7", content: content, trigger: triggerDelaySix)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelaySix, withCompletionHandler: nil)
        print(notificationTimeDelaySix)
        
        // ここからスヌーズ用（7分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelaySeven = DateComponents()
        let calendarDelaySeven = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateSeven = calendarDelaySeven.date(byAdding: .minute, value: 7, to: datePicker.date)
        notificationTimeDelaySeven.hour = calendar.component(.hour, from: hogeDateSeven!)
        notificationTimeDelaySeven.minute = calendarDelaySeven.component(.minute, from: hogeDateSeven!)
        // 通知トリガーインスタンス作成
        let triggerDelaySeven = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelaySeven, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelaySeven = UNNotificationRequest(identifier: "uuid8", content: content, trigger: triggerDelaySeven)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelaySeven, withCompletionHandler: nil)
        print(notificationTimeDelaySeven)
        
        // ここからスヌーズ用（8分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayEight = DateComponents()
        let calendarDelayEight = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateEight = calendarDelayEight.date(byAdding: .minute, value: 8, to: datePicker.date)
        notificationTimeDelayEight.hour = calendar.component(.hour, from: hogeDateEight!)
        notificationTimeDelayEight.minute = calendarDelayEight.component(.minute, from: hogeDateEight!)
        // 通知トリガーインスタンス作成
        let triggerDelayEight = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayEight, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayEight = UNNotificationRequest(identifier: "uuid9", content: content, trigger: triggerDelayEight)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayEight, withCompletionHandler: nil)
        print(notificationTimeDelayEight)
        
        // ここからスヌーズ用（9分後）の記述
        // 通知時間インスタンス作成
        var notificationTimeDelayNine = DateComponents()
        let calendarDelayNine = Calendar.current
        // hogeDateに遅らせた日付を代入
        let hogeDateNine = calendarDelayNine.date(byAdding: .minute, value: 9, to: datePicker.date)
        notificationTimeDelayNine.hour = calendar.component(.hour, from: hogeDateNine!)
        notificationTimeDelayNine.minute = calendarDelayNine.component(.minute, from: hogeDateNine!)
        // 通知トリガーインスタンス作成
        let triggerDelayNine = UNCalendarNotificationTrigger(dateMatching: notificationTimeDelayNine, repeats: false)
        
        // 通知リクエストインスタンス作成
        let requestDelayNine = UNNotificationRequest(identifier: "uuid10", content: content, trigger: triggerDelayNine)
        
        // 通知リクエストの申し込み
        UNUserNotificationCenter.current().add(requestDelayNine, withCompletionHandler: nil)
        print(notificationTimeDelayNine)
    }
}
