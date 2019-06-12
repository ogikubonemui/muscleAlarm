

import UIKit

class OpenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // 画面が表示されたら実行される
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(
            withDuration: 1.0, // 何秒かけて変化するか
            delay: 1.0, // 開始までの時間
            options: .curveEaseOut,
            animations: {() in
                // 画像に対する値の設定
                // 値の設定はメソッドチェーンで指定できる
                // 画像を小さくしつつ、回転させる
        },
            completion: {(Bool) in
                // アニメーション完了後の挙動
        })
        
        //　アニメーションのオプション
        // curveEaseOut 動き終わりがゆっくり
        // curveEaseIn　動き始まりがゆっくり
        // curveEaseInOUt　始めと終わりがゆっくり
        // Linear　一定速度
        UIView.animate(withDuration:0.4,
                       // 上部でdelayが1.0秒後に開始
            // 0.2秒で変化している
            // 0.1秒後に始めるため、トータル1.3秒後
            delay:1.3,
            options: .curveEaseOut,
            animations: {()in
                // 画像サイズを大きくする


        },
            completion: {(Bool) in
                // アニメーション完了後メイン画面に遷移
                self.performSegue(withIdentifier: "toMain", sender: nil)
        })
    }
}
