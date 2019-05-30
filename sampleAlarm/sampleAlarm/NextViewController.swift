
import UIKit
// 音楽を流す機能のインポート
import AVFoundation

class NextViewController: UIViewController {

    var audioPlayer: AVAudioPlayer!
    
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 画面を読み込むと同時に音楽が再生される
        playMusic()
        label.text = "画面遷移完了"
    }
    
    @IBAction func didTapBtn(_ sender: Any) {
        stopMusic()
        performSegue(withIdentifier: "toTop", sender: nil)
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
