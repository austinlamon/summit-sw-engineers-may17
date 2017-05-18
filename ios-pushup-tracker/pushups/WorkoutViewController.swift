//
//  WorkoutViewController.swift
//  pushups
//
//  Created by Jared Alexander on 9/19/15.
//  Copyright © 2015 tysonsapps. All rights reserved.
//


class WorkoutViewController: UIViewController, UITextFieldDelegate {
    
    //outlets to our UI components
    @IBOutlet weak var progressButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pushupsCompletedLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!

    //initialize state vars with default values
    var pushupsCompleted = 0 {
        didSet {
            //update ui with progress
            pushupsCompletedLabel.text = String(pushupsCompleted)
        }
    }
    
    var startDate = Date()
    
    //controller lifecycle function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self

        resetUI()
    }
    
    //reset the UI to a default state
    fileprivate func resetUI(){
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        pushupsCompleted = 0
        nameTextField.text = ""
        progressButton.setTitle("Tap Nose to Start", for: UIControlState())
    }

    fileprivate func startWorkoutSession(){
        startDate = Date()
        
        //enable the stop button
        stopButton.isEnabled = true
        stopButton.alpha = 1.0
        
        //change progress button message
        progressButton.setTitle("Tap Nose to Record Pushup", for: UIControlState())
    }
    
    //creates modal message
    fileprivate func showResultMessage(_ message:String){
        //create the modal
        let messagePopup = MBProgressHUD(for: self.view)
        messagePopup?.mode = MBProgressHUDMode.customView
        messagePopup?.labelText = message
        
        //display it
        messagePopup?.show(true)
        
        //hide it (after delay)
        messagePopup?.hide(true, afterDelay: 3)
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{// callback function triggered when 'return' key pressed on keyboard
        
        //when return key pressed, dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }

}

// MARK: -- IBActions
extension WorkoutViewController {
    @IBAction func noseButtonPressed(_ sender: AnyObject) {
        //only start do new workout setup if pushup count is at 0
        if(pushupsCompleted == 0) {
            startWorkoutSession()
        }

        //increment counter
        pushupsCompleted += 1

        //speak progress
        Utilities.speakUtterance(String(pushupsCompleted))
    }

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        //create a workout session object
        let workout = Workout(name: nameTextField.text!, startDate: startDate, endDate:Date(),pushupsCompleted:pushupsCompleted)

        //speak result
        Utilities.speakUtterance("Workout stopped. \(nameTextField.text!), you just completed \(pushupsCompleted) push ups in \(workout.generateSpokenElapsedTime())")

        //speak opinion
        let speechForPushupsCompleted = Utilities.speechForPushupsCompleted(pushupsCompleted)
        Utilities.speakUtterance(speechForPushupsCompleted)

        resetUI()
    }
}

