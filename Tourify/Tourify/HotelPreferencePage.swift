//
//  HotelPreferencePage.swift
//  Tourify
//
//  Created by 李晨曦 on 11/8/23.
//

import Foundation
import UIKit

class HotelPreferencePage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var numRoom: UITextField!
    
    @IBOutlet weak var rating: UIButton!
    
    @IBOutlet weak var pool: UIButton!
    
    @IBOutlet weak var pet: UIButton!
    
    @IBOutlet weak var priceRange: UITextField!
    
    var currentHotelPreference = Hotel(numRoom_: 0, rating_: "", pool_: false, pet_: false, priceRange_: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numRoom.delegate = self
        priceRange.delegate = self
        setupMenus()
    }
    
    func setupMenus() {
        let ratingMenu = UIMenu(title: "Choose Rating", children: createRatingMenuActions())
        rating.menu = ratingMenu
        rating.showsMenuAsPrimaryAction = true
        let poolMenu = UIMenu(title: "Pool Needed?", children: createPoolMenuActions())
        pool.menu = poolMenu
        pool.showsMenuAsPrimaryAction = true
        let petMenu = UIMenu(title: "Pet Friendly?", children: createPetMenuActions())
        pet.menu = petMenu
        pet.showsMenuAsPrimaryAction = true
    }

    func createRatingMenuActions() -> [UIAction] {
        let ratings = ["1-Star", "2-Star", "3-Star", "4-Star", "5-Star"]
        return ratings.map { rating in
            UIAction(title: rating, handler: { [weak self] _ in
                self?.currentHotelPreference.rating_ = rating
            })
        }
    }
    
    func createPoolMenuActions() -> [UIAction] {
        let pools = ["true", "false"]
        return pools.map { pool in
            UIAction(title: pool, handler: { [weak self] _ in
                self?.currentHotelPreference.pool_ = (pool == "true")
            })
        }
    }
    
    func createPetMenuActions() -> [UIAction] {
        let pets = ["true", "false"]
        return pets.map { pet in
            UIAction(title: pet, handler: { [weak self] _ in
                self?.currentHotelPreference.pet_ = (pet == "true")
            })
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else {
                print("now")
                return true
            }
            guard !currentText.isEmpty else {
                return true
            }
            if textField == numRoom {
                if checkPlaceInput1(input: currentText){
                    print("Valid Number of Rooms.")
                }
                else {
                    numRoom.text = ""
                    let title = "Invalid Input Number of Rooms."
                    let message = "Please enter a valid number."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else if textField == priceRange {
                if checkPlaceInput2(input: currentText) {
                    print("Valid Price Range.")
                }
                else {
                    priceRange.text = ""
                    let title = "Invalid Price Range Input."
                    let message = "Please enter a valid price range."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                let title = "Invalid Input."
                let message = "Please enter a number."
                let alert = generateAlert(t: title, msg: message)
                self.present(alert, animated: true, completion: nil)
            }
            return true
        }
            
    
    
    func checkPlaceInput1(input: String)->Bool{
        if let number = Int(input) {
            return true
        }
        else {
            return false
        }
    }
    
    func checkPlaceInput2(input: String)->Bool {
        if let number = Double(input) {
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if numRoom.text == "" || priceRange.text == "" {
            let title = "Incomplete information."
            let message = "Information for number of rooms and acceptable price range must be entered."
            let alert = generateAlert(t: title, msg: message)
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            print(currentHotelPreference.numRoom_ ?? 0)
            print(currentHotelPreference.rating_ ?? "")
            print(currentHotelPreference.pool_ ?? false)
            print(currentHotelPreference.pet_ ?? false)
            print(currentHotelPreference.priceRange_ ?? 0.0)
        }
    }
    
    
    @IBAction func discard(_ sender: Any) {
        numRoom.text = ""
        currentHotelPreference.numRoom_ = 0
        currentHotelPreference.rating_ = ""
        currentHotelPreference.pool_ = false
        currentHotelPreference.pet_ = false
        rating.setTitle("Choose Rating", for: .normal)
        pool.setTitle("Pool Needed?", for: .normal)
        pet.setTitle("Pet Friendly?", for: .normal)
        priceRange.text = ""
    }
    
}
