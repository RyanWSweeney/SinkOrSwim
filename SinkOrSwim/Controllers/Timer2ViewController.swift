//
//  TimerViewController.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/12/23.
//

import UIKit


class Timer2ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopResetButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let minutesData = Array(0...59).map { String($0) }
    let secondsData = Array(0...59).map { String($0) }

    var elapsedTime: TimeInterval = 0.0
    
    var timer: Timer?
    var startDate: Date? = nil
    
    var canClick: Bool = false
    
    enum TimerState {
        case running
        case stopped
        case reset
    }

    var timerState: TimerState = .reset
    
    var selectedMinutes: Int = 0
    var selectedSeconds: Int = 0
    
    var totalSeconds: Int = 0
    
    
    override func viewDidLoad() {
            super.viewDidLoad()
            print("Loaded Timer 2 View controller")
            title = "Timer"
            
            pageControl.currentPage = 1
            let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack))
            swipeRight.direction = .right
            self.view.addGestureRecognizer(swipeRight)
            
            pickerView.delegate = self // Set the delegate
            pickerView.dataSource = self // Set the data source
            startButton.layer.cornerRadius = 12
            stopResetButton.layer.cornerRadius = 12
            canClick = false
            timerState = .reset
            pageControl.currentPageIndicatorTintColor = UIColor.black // Active dot color
            pageControl.pageIndicatorTintColor = UIColor.gray
            updateButtonState()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Loaded Timer 2 View controller")
        title = "Timer"
        
        pageControl.currentPage = 1
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeBack))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        pickerView.delegate = self // Set the delegate
        pickerView.dataSource = self // Set the data source
        startButton.layer.cornerRadius = 12
        stopResetButton.layer.cornerRadius = 12
        canClick = false
        timerState = .reset
        pickerView.isUserInteractionEnabled = true
        updateButtonState()
    }

    
    @IBAction func startButtonTapped(_ sender: AnyObject) {
        switch timerState {
        case .reset:
            // Start the timer from the initial selected value only if in reset state
            totalSeconds = selectedMinutes * 60 + selectedSeconds
            startTimer()

            // Disable the picker view
            pickerView.isUserInteractionEnabled = false
            pickerView.alpha = 0.5 // Optional: to give a visual cue that it's disabled
                
            // Set the stopResetButton title to "Stop"
            stopResetButton.setTitle("Stop", for: .normal)
            stopResetButton.setTitleColor(.systemRed, for: .normal)

        case .stopped:
            // Just resume the timer if in stopped state
            startTimer()

        default:
            break
        }
        canClick = true;
        updateButtonState()
        
    }
    
    @IBAction func stopResetButtonTapped(_ sender: UIButton) {
        switch timerState {
        case .running:
            // Pause the timer and show the reset button
            timer?.invalidate()
            timer = nil
            timerState = .stopped
            stopResetButton.setTitle("Reset", for: .normal)
            stopResetButton.setTitleColor(.red, for: .normal)

        case .stopped, .reset:
            // Reset the timer to the initial selected value and enable the picker view
            totalSeconds = selectedMinutes * 60 + selectedSeconds
            updateTimerLabel()
            timerState = .reset
                   
            // Enable the picker view
            pickerView.isUserInteractionEnabled = true
            pickerView.alpha = 1.0
        }
        updateButtonState()
    }

    
    func updateButtonState() {
        switch timerState {
        case .reset:
            stopResetButton.isEnabled = false
            stopResetButton.alpha = 0.5 // To make it visually "disabled"
        default:
            stopResetButton.isEnabled = true
            stopResetButton.alpha = 1.0
        }
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] timer in
            guard let strongSelf = self else { return }
            
            if strongSelf.totalSeconds <= 0 {
                strongSelf.timer?.invalidate()
                strongSelf.timer = nil
                strongSelf.timerState = .stopped
                strongSelf.stopResetButton.setTitle("Reset", for: .normal)
                strongSelf.stopResetButton.setTitleColor(.red, for: .normal)
                strongSelf.performSegue(withIdentifier: "endTimerSegue", sender: strongSelf)

                return
            }
            strongSelf.totalSeconds -= 1
            strongSelf.updateTimerLabel()
        }
        timerState = .running
        stopResetButton.setTitle("Stop", for: .normal)
        stopResetButton.setTitleColor(.systemRed, for: .normal)
    }


    func updateTimerLabel() {
            let minutes = totalSeconds / 60
            let seconds = totalSeconds % 60
            timerLabel.text = String(format: "%02d min %02d sec", minutes, seconds)
        }
    
    @objc func swipeBack(gesture: UISwipeGestureRecognizer) {
        print("Swipe Back Called")
        navigationController?.popViewController(animated: true)
    }
    
    //code for UIPicker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // Two components: Minutes and Seconds
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return minutesData.count // Number of minutes rows
        } else {
            return secondsData.count // Number of seconds rows
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return minutesData[row] + " min"
        } else {
            return secondsData[row] + " sec"
        }
    }

    //picker view selection function
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            selectedMinutes = row
        } else {
            selectedSeconds = row
        }
        updateTimerLabel()
    }


}

