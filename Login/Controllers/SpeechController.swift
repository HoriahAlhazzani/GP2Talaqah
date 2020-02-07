//
//  SpeechController.swift
//  Login
//
//  Created by Atheer Alghannam on 13/06/1441 AH.
//  Copyright © 1441 Gary Tokman. All rights reserved.
//


import UIKit
import Speech


class SpeechController: UIViewController,SFSpeechRecognizerDelegate {

    var speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: Language.instance.setlanguage()))!
    
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    var recognitionTask: SFSpeechRecognitionTask?
    
    let audioEngine = AVAudioEngine()
    
    @IBOutlet weak var recordButton: UIButton!
 
    @IBOutlet weak var textView: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    override func viewDidAppear(_ animated: Bool) {
        
        speechRecognizer.delegate = self
        requestAuthorization()
    
        
    }
    
    @IBAction func recordButtonTapped() {
        
        if  audioEngine.isRunning {
            
            recognitionRequest?.shouldReportPartialResults = false
            audioEngine.inputNode.removeTap(onBus: 0)
            audioEngine.stop()
            recognitionRequest?.endAudio()
            

            recordButton.isEnabled = true
            recordButton.setTitle("Start Recording", for: [])
            
        } else {
      
            try! startRecording()
   
            recordButton.setTitle("Pause recording", for: [])
        }
    }

    
}

