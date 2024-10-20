//
//  QuestionsViewController.swift
//  YesOrNo
//
//  Created by 王宜婕 on 2024/10/14.
//

import UIKit
import AVFoundation

class QuestionsViewController: UIViewController {
    @IBOutlet weak var Question: UILabel!
    
    @IBOutlet var heart: [UIImageView]!
    @IBOutlet weak var QLabel: UILabel!
    @IBOutlet weak var light: UIImageView!
    @IBOutlet weak var ResultView: UIView!
    @IBOutlet weak var ParseLabel: UILabel!
    @IBOutlet weak var YesButton: UIButton!
    @IBOutlet weak var NoButton: UIButton!
    
    @IBOutlet weak var ResultImageView: UIImageView!
    @IBOutlet weak var ResultLabel: UILabel!
    @IBOutlet weak var EndButton: UIButton!
    
    @IBOutlet weak var NextButton: UIButton!
    var questions=[Questions]()
    var index = 0
    var heartindex = 3
    
    let player = AVPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questions=[
            Questions(text: "地球上最熱的地方是沙漠", answer: false, parse: "解析：死海附近的地方是地球上最熱的。"),
            Questions(text: "海豚是一種魚", answer: false, parse: "解析：海豚是哺乳動物，而不是魚。"),
            Questions(text: "每個人都有獨特的舌紋", answer: true, parse: "解析：舌紋的獨特性和指紋相似。"),
            Questions(text: "巧克力能讓狗中毒", answer: true, parse: "解析：巧克力對狗有毒。"),
            Questions(text: "北極熊的皮膚是白色的", answer: false, parse: "解析：將北極熊的毛剃開後會呈現黑色皮膚。"),
            Questions(text: "運動可以讓你在短時間內學會新語言", answer: false, parse: "解析：雖然運動有助於提升記憶，但學語言還是需要時間和練習。"),
            Questions(text: "牛排切開後流出的紅色液體為血水", answer: false, parse: "解析：牛排切開後流出的紅色液體不是血水，是肌紅蛋白。"),
            Questions(text: "屏東火車站比高雄火車站還要北邊", answer: true, parse: "解析：屏東火車站的地理位置在高雄火車站北邊。"),
            Questions(text: "阿拉伯數字是由阿拉伯人發明的", answer: false, parse: "解析：阿拉伯數字其實是由印度人發明的喔。"),
            Questions(text: "蜂蜜有辦法幾乎永遠不變質", answer: true, parse: "解析：蜂蜜在常溫且正確保存下，幾乎永遠不變質。"),
        ]
        questions.shuffle()
        updateUI()
        
        EndButton.isHidden = true
        NextButton.isHidden = true
        ResultImageView.layer.borderWidth = 3
        // Do any additional setup after loading the view.
    }
    
    fileprivate func nextCount() {
        YesButton.isEnabled = false
        NoButton.isEnabled = false
        if index == questions.count - 1{
            NextButton.isHidden = true
            EndButton.isHidden = false
        }else{
            NextButton.isHidden = false
        }
    }
    
    fileprivate func answerRight() {
        ResultLabel.text = "答對了!!"
        ResultImageView.image = UIImage(named: "right")
        ResultImageView.isHidden = false
        ResultLabel.isHidden = false
        ResultView.isHidden = false
        light.isHidden = false
        let url = Bundle.main.url(forResource: "rightsound", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        nextCount()
    }
    
    @IBAction func YesPressed(_ sender: Any) {
        ParseLabel.text = questions[index].parse
        if questions[index].answer{
            answerRight()
//            YesButton.setTitle("答對了", for: .normal)
        }else{
            answerWrong()
//            YesButton.setTitle("答錯了", for: .normal)
        }
 
    }
    
    fileprivate func answerWrong() {
        heart[heartindex].isHidden = true
        heartindex -= 1
        let url = Bundle.main.url(forResource: "wrongsound", withExtension: "mp3")!
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        if heartindex == 0 {
            let controller = UIAlertController(title: "life用光了", message: "再挑戰一次吧", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default){ _ in
                self.Again()
             }
            controller.addAction(okAction)
            present(controller, animated: true)
            
            
        }else {
            ResultLabel.text = "答錯了..."
            ResultImageView.image = UIImage(named: "wrong")
            ResultImageView.isHidden = false
            ResultLabel.isHidden = false
            ResultView.isHidden = false
            light.isHidden = false
            nextCount()
        }
        
    }
    
    @IBAction func NoPressed(_ sender: Any) {
        ParseLabel.text = questions[index].parse
//        nextCount()
        if !questions[index].answer{
            answerRight()
//            NoButton.setTitle("答對了", for: .normal)
        }else{
            answerWrong()
//            NoButton.setTitle("答錯了", for: .normal)
        }
    }
    
    fileprivate func updateUI() {
        Question.text = questions[index].text
        ParseLabel.text = ""
        ResultImageView.isHidden = true
        ResultLabel.isHidden = true
        ResultView.isHidden = true
        light.isHidden = true
        QLabel.text = "Q\(index+1)"
//        YesButton.setTitle("O", for: .normal)
//        NoButton.setTitle("X", for: .normal)
    }
    
    @IBAction func NextPressed(_ sender: Any) {
        if index < questions.count - 1{
            index += 1
            updateUI()
        }
        NextButton.isHidden = true
        YesButton.isEnabled = true
        NoButton.isEnabled = true
        
    }
    
    fileprivate func Again() {
        questions.shuffle()
        index = 0
        heartindex = 3
        heart[3].isHidden = false
        heart[1].isHidden = false
        heart[2].isHidden = false
        updateUI()
        EndButton.isHidden = true
        NextButton.isHidden = true
        YesButton.isEnabled = true
        NoButton.isEnabled = true
    }
    
}
#Preview{
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //withIdentifier內打入View名稱
    return storyboard.instantiateViewController(withIdentifier: "QuestionsViewController")
}


