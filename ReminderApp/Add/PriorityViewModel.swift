//
//  PriorityViewModel.swift
//  ReminderApp
//
//  Created by Joy Kim on 7/9/24.
//

import Foundation

final class PriorityViewModel {
    
    var inputSegmentSelectedIndex: Observable<Int?> = Observable(nil)
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var outputLabelText = Observable("")
    var outputIndex: Observable<Int?> = Observable(nil)
    
    init() {
        
        inputSegmentSelectedIndex.bind { _ in
            self.validation()
            self.passData()
        }
        
        inputViewDidLoadTrigger.bind { _ in
            self.outputLabelText.value = "높음"
            self.outputIndex.value = 0
        }
    }
    
    private func validation() {
        
        guard let selectedIndex = inputSegmentSelectedIndex.value else {return}
        
        switch selectedIndex {
        case 0:
            outputLabelText.value = "높음"
        case 1:
            outputLabelText.value = "보통"
        case 2:
            outputLabelText.value = "낮음"
        default:
            outputLabelText.value = ""
        }
    }
    
    private func passData() {
        guard let selectedIndex = inputSegmentSelectedIndex.value else {return}
        
        outputIndex.value = selectedIndex
        
        
    }
}
