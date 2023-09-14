//
//  ReaderViewController.swift
//  SinkOrSwim
//
//  Created by Ryan Sweeney on 9/13/23.
//

import UIKit

class ReaderViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the text content for the UITextView
        textView.text = "In the unforgiving crucible of life, where the heat of adversity can either melt you down or forge you into something unbreakable, we uncover the astonishing depths of our true potential. I, David Goggins, stand as living proof that the human spirit is, without a doubt, unyielding. It's a truth we often forget, conveniently overshadowed by excuses, comfort zones, and the soft seduction of mediocrity. But I'm here to remind you, with every fiber of my being, that you have within you a reservoir of power so vast, it's virtually untapped.                                                              Let me tell you something: when you're faced with the colossal odds that life can throw your way, when the world, your own self-doubt, and the echoes of naysayers tell you 'no,' that's when you must summon your 'hell yes.' It's not in the moments of ease and comfort that we truly discover ourselves; it's in the crucible of suffering, the crucible of unrelenting effort, where the human spirit shines brightest.                                                          My journey, riddled with pain, suffering, and insurmountable obstacles, taught me that the path to greatness is a treacherous one. But I wouldn't have it any other way. I've learned to thrive on discomfort, to turn pain into rocket fuel, and to shatter the barriers that others deemed unbreakable. I tell you this: mediocrity is the enemy of potential. The world's greatest challenges are reserved for those who dare to rise above, who defy the limits placed upon them, and who press on even when every muscle screams 'stop.'                                                          So, I implore you, embrace the hardships, turn adversity into your ally, and transform pain into your greatest motivator. Your inner Goggins, the unstoppable force within, is waiting to be unleashed. 'Get comfortable with the uncomfortable,' for it's in that discomfort that you'll find your true self, a self capable of unimagined strength, resilience, and the unwavering power of the human spirit. The world is a crucible, my friend, and you are the raw material. Embrace the heat, emerge unbreakable, and become the absolute best version of yourself."
        
        // Configure the text color based on the current appearance mode
                if traitCollection.userInterfaceStyle == .dark {
                    textView.textColor = UIColor.white
                } else {
                    textView.textColor = UIColor.black
                }

        // Set the content size of the UIScrollView to match the UITextView's content size
            scrollView.contentSize = CGSize(width: textView.contentSize.width, height: textView.contentSize.height)


            // Enable zooming and scrolling
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 3.0 // Adjust the maximum zoom level as needed
            scrollView.zoomScale = 1.0
            textView.isEditable = false
            scrollView.isDirectionalLockEnabled = false


        
    }
    
    
}

func scrollViewDidZoom(_ scrollView: UIScrollView) {
    let offsetX = max((scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5, 0)
    let offsetY = max((scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5, 0)
    
    scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
}


extension ReaderViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return textView
    }
}


