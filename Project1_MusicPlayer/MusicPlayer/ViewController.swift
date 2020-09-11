//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 안유진 on 2020/07/23.
//  Copyright © 2020 Apple inc. All rights reserved.
//

import UIKit
import AVFoundation

class  ViewController: UIViewController, AVAudioPlayerDelegate {
    //MARK: Properties
    var player: AVAudioPlayer!
    var timer: Timer!
    //MARK: IBOutlets
    
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    
    override func viewDidLoad() {
            super.viewDidLoad()
            self.addViewsWithCode()//view를 코드를 통해 만들기 위해 추가해준 것
            self.initializePlayer()
        }

        // MARK: - Methods
        // MARK: Custom Method
    func initializePlayer() {
            
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else {
            print("음원 파일 에셋을 가져올 수 없습니다")
            return
        }
            
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }
            
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
    }
        
    func updateTimeLabelText(time: TimeInterval) {//TimeInterval = double형의 초. TimeInterval만큼 후의 시간을 전달해줄때 쓴다.
        let minute: Int = Int(time / 60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        //truncatingRemainder = %역할을 한다. 다만 Swift에서는 정수 % 정수만 가능하므로 TimeInterval은 double형이라서 truncatingRemainder을 쓴다.
        let milisecond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minute, second, milisecond)
        //Object-C에서는 %02ld로,Swift에서는 %02d로 표현.%02ld = 2자리를 사용하며 숫자가 들어가지 않는 자리는 0을 넣겠다는 의미.
        self.timeLabel.text = timeText
    }
    
    func makeAndFireTimer() {
        //scheduledTimer = 얼마의 기준을 가지고 동작할지 정해주는 함수.
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self](timer: Timer) in
            
            if self.progressSlider.isTracking { return }
                //isTracking = 슬라이더를 움직일때 슬라이더값에 따라 갱신해주는 함수
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
        })
        self.timer.fire()//fire()메소드를 통해 타이머를 시작해준다.
    }
    
    func invalidateTimer() {
        self.timer.invalidate()//타이머의 역할이 끝나 해제시켜주는 역할. 꼭 필요함.
        self.timer = nil
    }
        
    func addViewsWithCode() {
        self.addPlayPauseButton()//버튼추가
        self.addTimeLabel()//타임라벨추가
        self.addProgressSlider()//슬라인더 추가
    }

    func addPlayPauseButton() {

        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false//기존 오토리사징 마스크의 제약조건과의 충돌을 막기 위해 false로 설정

        self.view.addSubview(button)//서브뷰 추가

        button.setImage(UIImage(named: "button_play"), for: UIControl.State.normal)
        button.setImage(UIImage(named: "button_pause"), for: UIControl.State.selected)

        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)

        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)//버튼의 수평중앙축을 view의 수평중앙축으로 설정

        let centerY: NSLayoutConstraint
        centerY = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 0.8, constant: 0)
            //button과 view의 Y축을 동일하게. multiplier을 이용해 상대적인 비율로 높이 결정

        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5)
            //뷰 프레임의 넓이를 self.view의 50%크기로 하겠다.
        let ratio: NSLayoutConstraint
        ratio = button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1)
            //button.widthAnchor과 높이를 같이 하겠다.
        
        centerX.isActive = true//생성된 제약 적용
        centerY.isActive = true
        width.isActive = true
        ratio.isActive = true

        self.playPauseButton = button
    }

    func addTimeLabel() {
        let timeLabel: UILabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(timeLabel)

        timeLabel.textColor = UIColor.black//문자열 컬러 설정
        timeLabel.textAlignment = NSTextAlignment.center//문자열 중앙에 정렬
        timeLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)//글꼴과 호환되는 특성을 preferredFont()를 통해 얻음

        let centerX: NSLayoutConstraint
        centerX = timeLabel.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor)
            //button의 수평중앙축과 동일
        let top: NSLayoutConstraint
        top = timeLabel.topAnchor.constraint(equalTo: self.playPauseButton.bottomAnchor, constant: 8)
            //button의 바닥과 8만큼 떨어짐. 이때 하단으로 8만큼 떨어지는거라서 -8이아니라 8
        centerX.isActive = true
        top.isActive = true

        self.timeLabel = timeLabel
        self.updateTimeLabelText(time: 0)
    }

    func addProgressSlider() {
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(slider)

        slider.minimumTrackTintColor = UIColor.red

        slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: UIControl.Event.valueChanged)

        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
            //safeArea = 뷰들이(상태 바,탭 바)스크린 영역을 가리지 않는 곳. safeArea밖에 컨트롤을 배치하지 않는것이 권고사항.
        let centerX: NSLayoutConstraint
        centerX = slider.centerXAnchor.constraint(equalTo: self.timeLabel.centerXAnchor)
            
        let top: NSLayoutConstraint
        top = slider.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 8)

        let leading: NSLayoutConstraint
        leading = slider.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16)
            //leadingAnchor은 왼쪽 영역을 나타냄. safeAreaGuide의 왼쪽으로 부터 16만큼 떨어진 거리가 leading
        let trailing: NSLayoutConstraint
        trailing = slider.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
            //trailing은 오른쪽 영역
        centerX.isActive = true
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true

        self.progressSlider = slider
    }

    //     MARK: IBActions
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton) {
            
        sender.isSelected = !sender.isSelected
        //bool x, bool y //(y = !x)와 같은것
        
        if sender.isSelected {//버튼이 눌리지 않았으면 플레이
            self.player?.play()
        } else {//눌렸으면 멈춤
            self.player?.pause()
        }
            
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
        }
    }
        
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
    }
        
        
    // MARK: AVAudioPlayerDelegate
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
            
        guard let error: Error = error else {
            print("오디오 플레이어 디코드 오류발생")
            return
        }
            
        let message: String
        message = "오디오 플레이어 오류 발생 \(error.localizedDescription)"
            
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
            
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) { (action: UIAlertAction) -> Void in
                
            self.dismiss(animated: true, completion: nil)
        }
            
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
        
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {//오디오 재생이 끝났을때 초기화함수
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }
    
    
}

