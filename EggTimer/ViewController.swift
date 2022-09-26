import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    let eggTimes: [String : Int] = ["Soft": 5, "Medium": 7, "Hard": 12]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!

    @IBAction func hardnessSelected(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        timer.invalidate()
        // secondsRemaining = eggTimes[hardness]! * 60
        totalTime = eggTimes[hardness]! * 1
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            secondsPassed += 1;
            let percentageProgress: Float = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            titleLabel.text = "Done!"
            playSound()
            timer.invalidate()
        }
    }
    
    func playSound(){
         let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
         player = try! AVAudioPlayer(contentsOf: url!)
         player.play()
     }
}
