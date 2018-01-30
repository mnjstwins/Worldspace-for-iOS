//
//  IgnoreRulesUITest.swift
//  AttestiOSAppUITests
//
//  Created by Jennifer Dailey on 1/24/18.
//  Copyright © 2018 Deque Systems Inc. All rights reserved.
//

import XCTest
import Attest

class IgnoreRulesUITest: XCTestCase {
    
    let CONTRAST_ALPHA_BLEND = "ContrastAlphaBlend 3 of 14"
        
    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        XCUIApplication().launch()
        
        // Click on a view controller
        XCUIApplication().tables.cells[CONTRAST_ALPHA_BLEND].tap() // Open Contrast Alpha Blend Demo
    }
    
    //Set up a list of Rule IDs to ignore.
    static var ignoredRuleIDs: [RuleID] = [
        RuleID.ColorContrast,
        RuleID.AccessibilityHint,
        RuleID.TouchTargetSize,
        RuleID.CustomRule
    ];
    
    //Set up a static function that utilizes the list of ignored IDs
    static func resultConsumer(attestResult: Attest.Result) {
        for ruleResult in attestResult.ruleResults {
            if (!ignoredRuleIDs.contains(ruleResult.rule.ruleId)) {
                XCTAssertEqual(Impact.Pass.name(), ruleResult.impact.name(), ruleResult.description)
            }
        }
    }
    
    //Testing using the above function as the result consumer.
    func testUISuccessfullyIgnoringRules() {
        Attest.that(portNumber:48484).isAccessible(IgnoreRulesUITest.resultConsumer)
    }
}
