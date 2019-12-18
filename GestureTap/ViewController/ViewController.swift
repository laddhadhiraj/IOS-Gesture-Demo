//
//  ViewController.swift
//  GestureTap
//
//  Created by Dhiraj Laddha on 09/12/19.
//  Copyright © 2019 Surender Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var rightSwipeCount = 0
    private var upSwipeCount = 0
    var isTimer = true
    @IBOutlet var rightSwipeLbl: UILabel!
    @IBOutlet var upSwipeLbl: UILabel!
    @IBOutlet var tapLbl: UILabel!
    @IBOutlet var userGuideImg: UIImageView!
    @IBOutlet var swipeUpGesture: UISwipeGestureRecognizer!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet var swipeRightGesture: UISwipeGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.isMultipleTouchEnabled = false
    }
    
    //MARK: - Swipe Gesture -
    @IBAction func swipe(_ sender: UISwipeGestureRecognizer) {
        if userGuideImg.isHidden == false {
            return
        }
        
        if sender.direction == .right { // Right Direction --
            upSwipeCount = 0
            rightSwipeLbl.text = "Right Swipe \(2-rightSwipeCount) Times"
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
            upSwipeLbl.text = "Up Swipe \(3-upSwipeCount) Times Fast"
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.rightSwipeCount = 0
                self.upSwipeCount = 0
                self.isTimer = true
                self.rightSwipeLbl.text = "Right Swipe 3 Times"
                self.upSwipeLbl.text = "Up Swipe 4 Times Fast"
            }
        }
    }
    //MARK: - Tap Gesture
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        if userGuideImg.isHidden == false {
            return
        }
        showAlert(title: "Congrats! You found one of our secret gestures! This was the 5-Times-Rapid-Tap gesture.")
    }
    
    //MARK: - Tap to start -
    @IBAction func tapToStart(_ sender: UIButton) {
        userGuideImg.isHidden = true
        sender.isHidden = true
    }
    
    @IBAction func fingersTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select finger touch count", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "1", style: .default, handler: { (action) in
            print("1 Finger Touch on View")
            self.showAlert(title: "Now you can swipe, tap with 1 finger")
            self.setGestureTouchCount(1)
        }))
        alert.addAction(UIAlertAction(title: "2", style: .default, handler: { (action) in
            print("2 Finger Touch on View")
            self.showAlert(title: "Now you can swipe, tap with 2 fingers")
            self.setGestureTouchCount(2)
        }))
        alert.addAction(UIAlertAction(title: "3", style: .default, handler: { (action) in
            print("3 Finger Touch on View")
            self.showAlert(title: "Now you can swipe, tap with 3 fingers")
            self.setGestureTouchCount(3)
        }))
        alert.addAction(UIAlertAction(title: "4", style: .default, handler: { (action) in
            print("4 Finger Touch on View")
            self.showAlert(title: "Now you can swipe, tap with 4 fingers")
            self.setGestureTouchCount(4)
        }))
        alert.addAction(UIAlertAction(title: "5", style: .default, handler: { (action) in
            print("5 Finger Touch on View")
            self.showAlert(title: "Now you can swipe, tap with 5 fingers")
            self.setGestureTouchCount(5)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    private func setGestureTouchCount(_ count: Int) {
        tapGesture.numberOfTouchesRequired = count
        swipeRightGesture.numberOfTouchesRequired = count
        swipeUpGesture.numberOfTouchesRequired = count
    }
    
    //MARK: - Show AlertView --
    private func showAlert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // Detect Touch count --
    /*
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchCount = event?.touches(for: view)?.count
        print("\(touchCount ?? 0) finger touch on screen")
        showAlert(title: "\(touchCount ?? 0) finger touch on screen")
    }*/
}

