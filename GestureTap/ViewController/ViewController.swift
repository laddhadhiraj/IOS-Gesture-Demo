//
//  ViewController.swift
//  GestureTap
//
//  Created by Dhiraj Laddha on 09/12/19.
//  Copyright © 2019 Surender Singh. All rights reserved.
//
enum Gestures {
    case right
    case up
    case tap
}

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tapLbl: UILabel!
    @IBOutlet var swipeUpGesture: UISwipeGestureRecognizer!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var swipeRightGesture: UISwipeGestureRecognizer!
    
    private var rightSwipeCount = 0
    private var upSwipeCount = 0
    var isTimer = true
    var touchCounts = 0
    var gestureType = Gestures.tap
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapLabelText()
        setGestureTouchCount(touchCounts)
    }
    
    // tap label text setUp --
    fileprivate func tapLabelText() {
        if self.gestureType == .right {
            self.tapLbl.text = "→ Right Swipe 3 Times"
        }else if self.gestureType == .up  {
            self.tapLbl.text = "↑ Up Swipe 4 Times Fast"
        }
    }
    
    // set gesture tap count --
    private func setGestureTouchCount(_ count: Int) {
        tapGesture.numberOfTouchesRequired = count
        swipeRightGesture.numberOfTouchesRequired = count
        swipeUpGesture.numberOfTouchesRequired = count
    }
    
    // back btn tap --
    @IBAction func back(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }

    //MARK: - Swipe Gesture -
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right { // Right Direction --
            upSwipeCount = 0
            tapLbl.text = "→ Right Swipe \(2-rightSwipeCount) Times"
            if rightSwipeCount >= 2 {
                print("right swipe 3 times")
                rightSwipeCount = 0
                isTimer = true
                showAlert(title: "Congrats! You found one of our secret gestures! This was the 3-Swipe-Right gesture.")
                return
            }
            rightSwipeCount += 1
            print("right swipe")
        }else if sender.direction == .up { // Up Direction --
            rightSwipeCount = 0
            tapLbl.text = "↑ Up Swipe \(3-upSwipeCount) Times Fast"
            if upSwipeCount >= 3 {
                print("up swipe 4 times")
                upSwipeCount = 0
                isTimer = true
                showAlert(title: "Congrats! You found one of our secret gestures! This was the 4-Swipes-Up gesture.")
                return
            }
            upSwipeCount += 1
            print("up swipe")
        }
        
        if isTimer {  // reset timer --
            isTimer = false
            // start timer for 2 second
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.rightSwipeCount = 0
                self.upSwipeCount = 0
                self.isTimer = true
                self.tapLabelText()
            }
        }
    }
    //MARK: - Tap Gesture
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        showAlert(title: "Congrats! You found one of our secret gestures! This was the 5-Times-Rapid-Tap gesture.")
    }

    
    //MARK: - Show AlertView --
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

