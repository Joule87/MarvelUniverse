//
//  Logger.swift
//  MarvelUniverse
//
//  Created by Julio Collado on 23/10/21.
//

import Foundation
import os.log

/// Wrapper class for os_log function
public class Logger: NSObject {
    
    /// Application layer description
    ///
    /// - view: User Experience (view/viewController) layer log
    /// - provider: Handling layer log
    /// - repository: Database and Networking layer log
    /// - model: Business Model layer log
    public enum Category: String {
        case view, presenter, repository, model
    }
    
    /// Log accessibility level
    ///
    /// - `public`: Log message will be visible in Console app
    /// - `private`: Log message won't be visible in Console app
    public enum AccessLevel: String {
        case `public`, `private`
    }
    
    /// Returns current thread name
    private var currentThread: String {
        if Thread.isMainThread {
            return "main"
        } else {
            if let threadName = Thread.current.name, !threadName.isEmpty {
                return"\(threadName)"
            } else if let queueName = String(validatingUTF8: __dispatch_queue_get_label(nil)), !queueName.isEmpty {
                return"\(queueName)"
            } else {
                return String(format: "%p", Thread.current)
            }
        }
    }
    
    /// Creates OSLog object which describes log subsystem and category
    ///
    /// - Parameter category: Category, provided predefined log category
    /// - Returns: OSLog
    private func createOSLog(category: Category) -> OSLog {
        return OSLog(subsystem: Bundle.main.bundleIdentifier ?? "-", category: category.rawValue)
    }
    
    /// Prints provided log message with help of os_log function
    ///
    /// - Parameters:
    ///   - category: Category, provided predefined log category
    ///   - access: AccessLevel, log access level
    ///   - type: OSLogType, log type level, for example, .debug, .info, .error
    ///   - message: String, provided log message
    public func log(category: Logger.Category, message: String, access: Logger.AccessLevel = Logger.AccessLevel.private, type: OSLogType = OSLogType.debug, fileName: String = #file, functionName: String = #function, lineNumber: Int = #line) {
        
        let file = (fileName as NSString).lastPathComponent
        let line = String(lineNumber)
        
        switch access {
        case .private:
            os_log("[%{private}@] [%{private}@:%{private}@ %{private}@] > %{private}@", log: createOSLog(category: category), type: type, currentThread, file, line, functionName, message)
        case .public:
            os_log("[%{public}@] [%{public}@:%{public}@ %{public}@] > %{public}@", log: createOSLog(category: category), type: type, currentThread, file, line, functionName, message)
        }
    }
}
