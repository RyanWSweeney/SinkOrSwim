//
//  TimerViewController.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/12/23.
//

import UIKit

class TimerViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopResetButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    lazy var timer: Timer? = {
            return Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                guard let self = self, let startDate = self.startDate else { return }
                let currentTime = Date()
                self.elapsedTime = currentTime.timeIntervalSince(startDate)
                self.updateTimerLabel()
            }
        }()
    var elapsedTime: TimeInterval = 0.0
    
    lazy var startDate: Date? = nil
    
    var canClick: Bool = false
    
    enum TimerState {
        case running
        case stopped
        case reset
    }

    var timerState: TimerState = .reset

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action:
            #selector(swipeFunc(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        title = "Stop Watch"
        pageControl.currentPage = 0

        updateButtonState()
        startButton.layer.cornerRadius = 12
        stopResetButton.layer.cornerRadius = 12
        pageControl.currentPageIndicatorTintColor = UIColor.black // Active dot color
        pageControl.pageIndicatorTintColor = UIColor.gray
        // Additional setup, if needed
    }
    
    
    
    @IBAction func startButtonTapped(_ sender: AnyObject) {
        if self.timerState == .running {
                // Timer is already running, so do nothing or you can pause it here
            } else if self.timerState == .stopped {
                // Timer is stopped, so resume it from where it was paused
                startDate = Date().addingTimeInterval(-elapsedTime)
                startTimer()
                self.canClick = true
            } else {
                // Timer is not running, so start it
                startDate = Date()
                startTimer()
                self.canClick = true
            }
        updateButtonState()
    }
    

    @IBAction func stopResetButtonTapped(_ sender: UIButton) {
        switch timerState {
            case .running:
                // Stop the timer
                timer?.invalidate()
                timer = nil
                timerState = .stopped
                stopResetButton.setTitle("Reset", for: .normal)
                stopResetButton.setTitleColor(.red, for: .normal)
                
            case .stopped:
                // Reset the timer
                timer?.invalidate()
                timer = nil
                timerLabel.text = "00:00" // Set the label back to 00:00
                timerState = .reset
                stopResetButton.setTitle("Stop", for: .normal)
                stopResetButton.setTitleColor(.systemGray, for: .normal)
                self.canClick = false;
                
                
            case .reset:
                if(self.canClick) {
                    // Start the timer
                    startTimer()
                    timerState = .stopped
                    stopResetButton.setTitle("Stop", for: .normal)
                    stopResetButton.setTitleColor(.systemRed, for: .normal)
                }
            }
        updateButtonState()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
                guard let self = self, let startDate = self.startDate else { return }
                let currentTime = Date()
                self.elapsedTime = currentTime.timeIntervalSince(startDate)
                self.updateTimerLabel()
            }
            RunLoop.current.add(timer!, forMode: .common)
            timerState = .running
            stopResetButton.setTitle("Stop", for: .normal)
            stopResetButton.setTitleColor(.systemRed, for: .normal)
    }


    func stopTimer() {
        timer?.invalidate()
            timer = nil
            timerState = .stopped
            stopResetButton.setTitle("Reset", for: .normal)
            stopResetButton.setTitleColor(.red, for: .normal)
    }

    func resetTimer() {
        timer?.invalidate()
           timer = nil
           timerLabel.text = "00:00"
           timerState = .reset
           stopResetButton.setTitle("Start", for: .normal)
           stopResetButton.setTitleColor(.systemBlue, for: .normal)
        updateButtonState()
    }
    
    func updateButtonState() {
        stopResetButton.isEnabled = canClick
    }


    @objc func updateTimerLabel() {
            if let startDate = startDate {
                let currentTime = Date().timeIntervalSince(startDate)
                let minutes = Int(currentTime) / 60
                let seconds = Int(currentTime) % 60
                timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
            }
        }
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            print ("swiped left")
            performSegue (withIdentifier: "timerSegueRight", sender: self)
        }
    }
}

