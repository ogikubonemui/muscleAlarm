import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    // 何回センサーが反応したか
    var cnt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 近接センサーをONにする
        UIDevice.current.isProximityMonitoringEnabled = true
        // 近接センサーが反応したときにどうするかを定義する
        NotificationCenter.default.addObserver(self, selector: #selector(proximitySensorStateDidChange), name: UIDevice.proximityStateDidChangeNotification, object: nil)
    }
    
    
    // センサーが反応したときにおこないたい処理
    @objc func proximitySensorStateDidChange(){
        // センサーがオンだったら
        if UIDevice.current.proximityState {
            cnt = cnt + 1
            label.text = "\(cnt)"
        }
    }
}

