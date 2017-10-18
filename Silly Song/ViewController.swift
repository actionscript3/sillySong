//
//  ViewController.swift
//  Silly Song
//
//  Created by Tom Grant on 9/30/17.
//  Copyright © 2017 Tom Grant. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    
    //how is this not an array, but a string?
    private let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        
    }

    @IBAction func reset(_ sender: UITextField) {
        nameField.text = "";
        lyricsView.text = "";
    }
    
    @IBAction func displayLyrics(_ sender: UITextField) {
        //why is capitalized not a method? Ah it's an implied getter
        if let longName = sender.text?.lowercased() {
            print("NAME =", longName )
            let lyrics = lyricsForName( longName: longName, template: bananaFanaTemplate  )
            lyricsView.text = lyrics
        }
    }
    
    //personally would move this out of view controller to a utill class
    private func shortNameFromName (longName: String) -> String {
        let vowels = CharacterSet.init(charactersIn:"aeiouy")
        if let hasVowels = longName.rangeOfCharacter(from: vowels)
        {
            let shortName = longName.suffix(from: hasVowels.lowerBound)
            // is there a better way to cast a substring to a string? This seems kludgey
            return String( shortName ).lowercased()
        }
        //no change, perhaps we should throw an error? Let the user know their name does not work?
        return longName.lowercased()
    }
    
    private func lyricsForName(longName:String, template:String) -> String {
        let shortName = shortNameFromName( longName: longName )
        let lyrics = template
            .replacingOccurrences(of: "<FULL_NAME>", with: longName.capitalized)
            .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}



