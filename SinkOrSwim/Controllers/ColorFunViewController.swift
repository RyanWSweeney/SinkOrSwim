//
//  ColorFunViewController.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//

import UIKit

class ColorFunViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var redStepper: UIStepper!
    @IBOutlet weak var blueStepper: UIStepper!
    @IBOutlet weak var greenStepper: UIStepper!


    @IBOutlet var colorLabels: [UILabel]!
    @IBOutlet weak var brightnessLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

//         Setup initial UI states
        setupInitialUI()
    }

    private func setupInitialUI() {
        // Set initial visibility based on segmented control's selection
        redStepper.maximumValue = 255
        greenStepper.maximumValue = 255
        blueStepper.maximumValue = 255

        segmentChanged(segmentedControl)

        // Set initial values for labels
        updateColorLabels()
        updateBrightnessLabel()
        
    }

    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: // Slider selected
            brightnessSlider.isHidden = false
            brightnessLabel.isHidden = false
            redStepper.isHidden = true
            greenStepper.isHidden = true
            blueStepper.isHidden = true
            for label in colorLabels {
                    label.isHidden = true
                }
        case 1: // RGB selected
            brightnessSlider.isHidden = true
            brightnessLabel.isHidden = true
            redStepper.isHidden = false
            greenStepper.isHidden = false
            blueStepper.isHidden = false
            for label in colorLabels {
                    label.isHidden = false
                }
        default:
            break
        }
    }
    
    var currentRed: CGFloat = 0.5
    var currentGreen: CGFloat = 0.5
    var currentBlue: CGFloat = 0.5
    var currentBrightness: CGFloat = 1.0

    @IBAction func brightnessSliderChanged(_ sender: UISlider) {
//        let brightness = CGFloat(sender.value)
//
//        // Adjust the current RGB values by the brightness
//        let adjustedRed = currentRed * brightness
//        let adjustedGreen = currentGreen * brightness
//        let adjustedBlue = currentBlue * brightness
//
//        self.view.backgroundColor = UIColor(red: adjustedRed, green: adjustedGreen, blue: adjustedBlue, alpha: 1.0)
        currentBrightness = CGFloat(sender.value)
        updateBackgroundColor()
        updateBrightnessLabel()
    }

    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        currentRed = CGFloat(redStepper.value) / 255.0
        currentGreen = CGFloat(greenStepper.value) / 255.0
        currentBlue = CGFloat(blueStepper.value) / 255.0

        updateBackgroundColor()
        updateColorLabels()
    }

    
    func updateBackgroundColor() {
        let adjustedRed = currentRed * currentBrightness
        let adjustedGreen = currentGreen * currentBrightness
        let adjustedBlue = currentBlue * currentBrightness

        self.view.backgroundColor = UIColor(red: adjustedRed, green: adjustedGreen, blue: adjustedBlue, alpha: 1.0)
    }


    private func updateColorLabels() {
        let redValue = Int(redStepper.value)
        let greenValue = Int(greenStepper.value)
        let blueValue = Int(blueStepper.value)

        colorLabels[0].text = "R: \(redValue)"
        colorLabels[1].text =  "G: \(greenValue)"
        colorLabels[2].text = "B: \(blueValue)"
    }

    private func updateBrightnessLabel() {
        let brightnessValue = brightnessSlider.value
        brightnessLabel.text = String(format: "Brightness: %.2f", brightnessValue)
    }


}


    
    

