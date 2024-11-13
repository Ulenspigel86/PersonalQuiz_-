//
//  ResultViewController.swift
//  PersonalQuiz_*
//
//  Created by Артем Иванов on 28.10.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    
    @IBOutlet var visualResultLabel: UILabel!
    @IBOutlet var textResultLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        updateResult()
     }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

//MARK: Private Methods
private extension ResultViewController {
    
      func updateResult() {
         var animalTypeCount: [Animal: Int] = [:]
         var animals: [Animal] = []
         
         for answer in answers {
             animals.append(answer.animal)
         }
         
         for animal in animals {
             if let animalCount = animalTypeCount[animal] {
                 animalTypeCount.updateValue(animalCount + 1, forKey: animal)
             } else {
                 animalTypeCount[animal] = 1
             }
         }
         
         let sortedAnimals = animalTypeCount.sorted { $0.value > $1.value }
         guard let frequentlyEncounteredAnimal = sortedAnimals.first?.key else { return }
         
         updateUI(with: frequentlyEncounteredAnimal)
     }
    
      func updateUI(with animal: Animal) {
        visualResultLabel.text = "Вы - \(animal.rawValue)!"
        textResultLabel.text = animal.definition
    }
}


