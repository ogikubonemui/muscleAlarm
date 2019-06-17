
import UIKit
// 音楽を流す機能のインポート
import AVFoundation

class NextViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    
    
    @IBOutlet weak var label: UILabel!
    
    // 何回センサーが反応したか
    var proximityCount = 0
    var pushUpNum = 0
    
    
    @IBOutlet weak var labelSetCount: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面を読み込むと同時に音楽が再生される
        playMusic()
        
        //
        
        // 近接センサーをONにする
        UIDevice.current.isProximityMonitoringEnabled = true
        // 近接センサーが反応したときにどうするかを定義する
        NotificationCenter.default.addObserver(self, selector: #selector(proximitySensorStateDidChange), name: UIDevice.proximityStateDidChangeNotification, object: nil)
        
        let userDefault = UserDefaults.standard
        pushUpNum = userDefault.integer(forKey: "pushUpNum")
        labelSetCount.text = "\(pushUpNum)"
        
        
    }
    
    //    @IBAction func didTapBtn(_ sender: Any) {
    //        stopMusic()
    //        performSegue(withIdentifier: "toTop", sender: nil)
    //    }
    
    // センサーが反応したときにおこないたい処理
    @objc func proximitySensorStateDidChange(){
        // センサーがオンだったら
        if UIDevice.current.proximityState {
            proximityCount = proximityCount + 1
            label.text = "\(proximityCount)"
        }
        // 近接センサーでアラームを止めることを定義
        if proximityCount >= pushUpNum {
            stopMusic()
            performSegue(withIdentifier: "toTop", sender: nil)
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
