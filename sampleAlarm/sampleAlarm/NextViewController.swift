
import UIKit
// 音楽を流す機能のインポート
import AVFoundation

class NextViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    // 近接センサーを使用した回数がカウントアップで表示されるlabel
    @IBOutlet weak var label: UILabel!
    
    // 何回センサーが反応したか
    var cnt = 0
    
    
    // viewControllerにて設定した数値が渡されたlabel
    @IBOutlet weak var labelSetCount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面を読み込むと同時に音楽が再生される
        playMusic()
        
        // 近接センサーをONにする
        UIDevice.current.isProximityMonitoringEnabled = true
        // 近接センサーが反応したときにどうするかを定義する
        NotificationCenter.default.addObserver(self, selector: #selector(proximitySensorStateDidChange), name: UIDevice.proximityStateDidChangeNotification, object: nil)
        
        let userDefault = UserDefaults.standard
        let setCount = userDefault.string(forKey: "setCount")
        labelSetCount.text = setCount
    }
    
    @IBAction func didTapBtn(_ sender: Any) {
        stopMusic()
        performSegue(withIdentifier: "toTop", sender: nil)
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

extension NextViewController: AVAudioPlayerDelegate {
    func playMusic() {
        if let music = NSDataAsset(name: "momoclo") {
            audioPlayer = try? AVAudioPlayer(data: music.data)
            audioPlayer.delegate = self
            audioPlayer.play()
        }
    }
    func stopMusic() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
        }
    }
}
