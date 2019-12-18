//
//  SelectGestureController.swift
//  GestureTap
//
//  Created by Dhiraj Laddha on 17/12/19.
//  Copyright © 2019 Surender Singh. All rights reserved.
//

import UIKit

class SelectGestureController: UIViewController {
    @IBOutlet var leftBarBtn: UIBarButtonItem!
    @IBOutlet var table: UITableView!
    var tableData = ["1 Finger","2 Finger","3 Finger","4 Finger","5 Finger"]
    var touchCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isLeftBarButtonShow(false)
    }
    
    private func isLeftBarButtonShow(_ show: Bool) {
        if show {
            navigationItem.leftBarButtonItems = [leftBarBtn]
            title = "Select Gesture Type"
        }else {
            navigationItem.leftBarButtonItem = nil
            title = "Test Gesture"
        }
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        isLeftBarButtonShow(false)
        tableData = ["1 Finger","2 Finger","3 Finger","4 Finger","5 Finger"]
        table.reloadData()
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gestureVC = segue.destination as? ViewController {
            gestureVC.touchCounts = touchCount
            guard let gestureType = sender as? String else { return }
            let type = gestureType.components(separatedBy: " ").first?.lowercased() ?? "right"
            switch type {
            case "right":
                gestureVC.gestureType = .right
                gestureVC.title = "Right Gesture (\(touchCount) Finger)"
                gestureVC.swipeRightGesture.isEnabled = true
            case "up":
                gestureVC.gestureType = .up
                gestureVC.title = "Up Gesture (\(touchCount) Finger)"
                gestureVC.swipeUpGesture.isEnabled = true
            case "tap":
                gestureVC.gestureType = .tap
                gestureVC.title = "Tap Gesture (\(touchCount) Finger)"
                gestureVC.tapGesture.isEnabled = true
            default: break
            }
        }
    }
}

extension SelectGestureController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel!.text = tableData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let testGesture = tableData[indexPath.row] as? String, testGesture.lowercased().contains("finger") {
            let fingerCountString = testGesture.components(separatedBy: " ").first
            touchCount = Int(fingerCountString ?? "0") ?? 0
            tableData = ["Right Swipe Gesture", "Up Swipe Gesture", "Tap Gesture"]
            isLeftBarButtonShow(true)
            table.reloadData()
        }else {
            performSegue(withIdentifier: "gesture", sender: tableData[indexPath.row])
        }
    }
}
