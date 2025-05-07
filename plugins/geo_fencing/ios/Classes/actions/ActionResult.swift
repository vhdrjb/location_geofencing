//Made by Vahid Rajabi

import Foundation

protocol ActionResult {}

class SuccessResult: ActionResult {
    let result: Any?
    
    init(result: Any? = nil) {
        self.result = result
    }
}

class FailureResult: ActionResult {
    let error: String
    
    init(error: String) {
        self.error = error
    }
}
