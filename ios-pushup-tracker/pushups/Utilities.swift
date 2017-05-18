//
//  Utils.swift
//  pushups
//
//  Created by Jared Alexander on 9/20/15.
//  Copyright © 2015 tysonsapps. All rights reserved.
//

import AVFoundation

class Utilities {
    
    //initialize speech synthesizer
    static let synthesizer = AVSpeechSynthesizer()
    
    static let voiceSettingKey = "voiceSetting"
    
    class func saveVoiceSetting(_ voice: Voice){
        let defaults = UserDefaults.standard
        defaults.set(voice.rawValue, forKey: voiceSettingKey)
    }
    
    class func fetchVoiceSetting() -> Voice {
        let defaults = UserDefaults.standard
        let voiceSettingInt: Int? = defaults.object(forKey: voiceSettingKey) as? Int
        if let voiceSettingInt = voiceSettingInt{
            let voice = Voice(rawValue: voiceSettingInt)
            if let voice = voice{
                return voice
            }
            else{
                return Voice.male
            }
        }
        else{
            return Voice.male
        }
    }
    
    class func speechForPushupsCompleted(_ pushupsCompleted: Int) -> String {
        switch(pushupsCompleted){
        case 0...1:
            return "I'm embarrassed for you."
        case 2...5:
            return "That's it?"
        case 6...15:
            return "I'm proud of you."
        case 16...25:
            return "Wow, I'm impressed!"
        default:
            return "You're a machine!"
        }
    }
        
    class func speakUtterance(_ utterance: String) {
        let utterance = AVSpeechUtterance(string: utterance)
        utterance.pitchMultiplier = fetchVoiceSetting().value
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        synthesizer.speak(utterance)
    }
}
