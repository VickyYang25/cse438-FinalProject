//
//  DailyItinararyPage.swift
//  Tourify
//
//  Created by 李晨曦 on 11/8/23.
//

import Foundation
import UIKit

class DailyItinararyPage: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var budget: UITextField!

    @IBOutlet weak var type: UIButton!
    
    @IBOutlet weak var style: UIButton!
    
    @IBOutlet weak var food: UIButton!
    
    
    var currentItinerary = Itinerary(budget_: 0.0, type_: "", style_: "", food_: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budget.delegate = self
        setupMenus()
    }
    
    
    func setupMenus() {
        let typeMenu = UIMenu(title: "Choose Type", children: createTypeMenuActions())
        type.menu = typeMenu
        type.showsMenuAsPrimaryAction = true
        let styleMenu = UIMenu(title: "Choose Style", children: createStyleMenuActions())
        style.menu = styleMenu
        style.showsMenuAsPrimaryAction = true
        let foodMenu = UIMenu(title: "Choose Food", children: createFoodMenuActions())
        food.menu = foodMenu
        food.showsMenuAsPrimaryAction = true
    }
    
    func createTypeMenuActions() -> [UIAction] {
        let types = ["Leisure Travel", "Business Travel", "Adventure Travel", "Cultural Travel", "Religious Travel", "Sports Travel", "Educational Travel"]
        return types.map { type in
            UIAction(title: type, handler: { [weak self] _ in
                self?.currentItinerary.type_ = type
            })
        }
    }
    
    func createStyleMenuActions() -> [UIAction] {
        let styles = ["Luxury Travel", "Budget Travel", "Backpacking", "Solo Travel", "Group Travel", "Family Travel", "Couples Travel", "Couples Travel", "Slow Travel", "Sustainable Travel", "Cruise Travel"]
        return styles.map { style in
            UIAction(title: style, handler: { [weak self] _ in
                self?.currentItinerary.style_ = style
            })
        }
    }
    
    func createFoodMenuActions() -> [UIAction] {
        let foods = ["Chinese Food", "Mexican Food", "Italian Food", "Japanese Food", "Thai Food", "Indian Food", "French Food", "Spanish Food", "Greek Food", "Turkish Food", "Vietnamese Food", "Korean Food", "Moroccan Food", "Brazilian Food", "Lebanese Food", "Ethiopian Food"]
        return foods.map { food in
            UIAction(title: food, handler: { [weak self] _ in
                self?.currentItinerary.food_ = food
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
            if textField == budget {
                print("Valid Budget Value.")
                if checkPlaceInput(input: currentText){
                    if let text = budget.text, let budgetValue = Double(text) {
                        currentItinerary.budget_ = budgetValue
                    } else {
                    
                    }

                }
                else{
                    budget.text = ""
                    let title = "Invalid Budget Input."
                    let message = "Please enter a valid value of budget."
                    let alert = generateAlert(t: title, msg: message)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        
            else{
                let title = "Invalid Input."
                let message = "Please enter a valid number."
                let alert = generateAlert(t: title, msg: message)
                self.present(alert, animated: true, completion: nil)
            }
            return true
        }
    
    
    func checkPlaceInput(input: String) -> Bool {
        if let number = Double(input) {
            return true
        }
        else {
            return false
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if budget.text == "" {
            let title = "Incomplete information."
            let message = "Budget information must be entered."
            let alert = generateAlert(t: title, msg: message)
            self.present(alert, animated: true, completion: nil)
        }
        
        else {
            print(currentItinerary.budget_ ?? 0)
            print(currentItinerary.type_ ?? "")
            print(currentItinerary.style_ ?? "")
            print(currentItinerary.food_ ?? 0)
        }
    }
    
    @IBAction func discard(_ sender: Any) {
        budget.text = ""
        currentItinerary.budget_ = 0
        currentItinerary.type_ = ""
        currentItinerary.style_ = ""
        currentItinerary.food_ = ""
        type.setTitle("Choose Type", for: .normal)
        style.setTitle("Choose Style", for: .normal)
        food.setTitle("Choose Food", for: .normal)
        
    }
    
    
}
