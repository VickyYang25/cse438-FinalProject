//
//  GeneralInputPage.swift
//  Tourify
//
//  Created by 顾悦平 on 11/7/23.
//
import Foundation
import UIKit
class GeneralInputPage: UIViewController,UITextFieldDelegate{
    let currentDate = Date()
    @IBOutlet weak var startDate: UIDatePicker!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var departure: UITextField!
    @IBOutlet weak var destination: UITextField!
    @IBOutlet weak var numTravelers: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startDate.minimumDate = currentDate
        endDate.minimumDate = currentDate
        departure.delegate = self
        destination.delegate = self
        numTravelers.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Get the current text in the text field
            guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
                print("now")
                return true
            }
            guard !currentText.isEmpty else {
                return true
            }
            // Call the checkPlaceInput function based on the text field
            if textField == departure {
                if checkPlaceInput(input: currentText){
                    print("Valid Place of Departure.")
                }
                else{
                    departure.text = ""
                    let title = "Invalid Departure Place Input."
                    let message = "Please enter a valid city of departure."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if textField == destination {
                if checkPlaceInput(input: currentText){
                    print("Valid Destination.")
                }
                else{
                    destination.text = ""
                    let title = "Invalid Destination Input."
                    let message = "Please enter a valid city of destination."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if textField == numTravelers{
            let num: Int? = Int(currentText)
            if let num = num{
                if num > 0{
                    print("Valid number of travelers.")
                }
                else if num == 0{
                    let title = "Invalid Input."
                    let message = "Please enter a valid number of travelers."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else{
                let title = "Invalid Input."
                let message = "Please enter a number."
                let alert = generateAlert(t: title, msg: message)
                self.present(alert, animated: true, completion: nil)
            }
        }
            return true
        }
    
    func checkPlaceInput(input: String)->Bool{
        // need to refine the regex pattern, now it allows continuous input of whitespaces, hyphens, and periods, and the combination of the three.
        let pattern = "^[a-zA-Z]{1}[a-zA-Z\\s\\-\\.]*[^\\.s]?$"
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: input.utf16.count)
        return regex?.firstMatch(in: input, options: [], range: range) != nil
    }
    
    @IBAction func goToFlight(_ sender: Any) {
        //check all inputs are filled(handle at this final confirm step)
        if startDate == nil || endDate == nil || departure == nil || destination == nil || numTravelers == nil || departure.text == "" || destination.text == "" || numTravelers.text == ""{
            let title = "Incomplete information."
            let message = "All fields are required to be filled."
            let alert = generateAlert(t: title, msg: message)
            self.present(alert, animated: true, completion: nil)
        }
        
        else if endDate.date <= startDate.date{
            let title = "Invalid Date Inputs."
            let message = "Start date should be no later than end date."
            let alert = generateAlert(t: title, msg: message)
            self.present(alert, animated: true, completion: nil)
        }
        
        else if departure.text == destination.text{
            let title = "Invalid Place Inputs."
            let message = "Place of Departure and Destination should not be the same."
            let alert = generateAlert(t: title, msg: message)
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let parseStart = dateFormatter.string(from: startDate.date)
            let parseEnd = dateFormatter.string(from: endDate.date)
            let dep = departure.text?.trimmingCharacters(in: .whitespaces)
            let des = destination.text?.trimmingCharacters(in: .whitespaces)
            info = GeneralPlan(startDate_: parseStart, endDate_: parseEnd, departure_: dep, destination_: des, numTravelers_: Int(numTravelers.text!))
            
            //check trimming of leading and trailing whitespaces
            print(info?.departure_.count ?? 0)
            
            print(info?.departure_ ?? "")
            print(info?.destination_ ?? "")
            print(info?.startDate_ ?? "")
            print(info?.endDate_ ?? "")
            print(info?.numTravelers_ ?? 0)
            //once the information from this step is all extracted, a new trip is initiated with a name. Remaining attributes will be added later
           showTripNameInput()
        }
    }
    
    @IBAction func discard(_ sender: Any) {
        startDate.date = currentDate
        endDate.date = currentDate
        departure.text = ""
        destination.text = ""
        numTravelers.text = ""
    }
    
    func showTripNameInput() {
        let alertController = UIAlertController(title: "Name Your New Trip", message: nil, preferredStyle: .alert)
        alertController.addTextField {
                textField in
                textField.placeholder = "Trip Name"
            }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {_ in
                print("User clicked Cancel")
            print(trips)
            // If the user clicks 'cancel' then reset the info.
                info = nil
            }
        let createTripAction = UIAlertAction(title: "Create Trip", style: .default) {_ in
            if let tripName = alertController.textFields?.first?.text{
                if tripName.isEmpty{
                    let title = "Failed to create your trip."
                    let message = "Please provide a name for your trip."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                    return
                }
                else{
                    //inputting a name initiates a new trip, and append this trip to the trip list
                    let newTrip = Trip(name: tripName)
                    trips.append(newTrip)
                    print("New trip created:")
                    print("Name: \(String(describing: newTrip.name))")
                    print(trips)
                }
            } else {
                print("Invalid trip name entered.")
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createTripAction)
        present(alertController, animated: true, completion: nil)
        }
}
