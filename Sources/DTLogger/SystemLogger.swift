//
//  SystemLogger.swift
//
//  Created by Дмитрий Данилин on 08.05.2023.
//

import Foundation
import os.log

/// Системный логгер, использующий os_log
@available(macOS 10.14, *)
public enum SystemLogger {
    enum LogLevel {
        case info
        case warning
        case error
        
        fileprivate var prefix: String {
            switch self {
            case .info:
                return "INFO ℹ️"
            case .warning:
                return "WARNING ⚠️"
            case .error:
                return "ERROR ❌"
            }
        }
    }
    
    struct LogContext {
        let file: String
        let function: String
        let line: Int
        var description: String {
            "\((file as NSString).lastPathComponent): \(line) \(function)"
        }
    }
    
    public static func info(
        _ message: String,
        showInConsole: Bool? = true,
        shouldLogContext: Bool? = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let logContext = LogContext(
            file: file,
            function: function,
            line: line
        )
        
        SystemLogger.handleLog(
            level: .info,
            message: message,
            showInConsole: showInConsole ?? false,
            shouldLogContext: shouldLogContext ?? false,
            context: logContext
        )
    }
    
    public static func warning(
        _ message: String,
        showInConsole: Bool? = true,
        shouldLogContext: Bool? = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let logContext = LogContext(
            file: file,
            function: function,
            line: line
        )
        
        SystemLogger.handleLog(
            level: .warning,
            message: message,
            showInConsole: showInConsole ?? false,
            shouldLogContext: shouldLogContext ?? false,
            context: logContext
        )
    }
    
    public static func error(
        _ message: String,
        showInConsole: Bool? = true,
        shouldLogContext: Bool? = true,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let logContext = LogContext(
            file: file,
            function: function,
            line: line
        )
        
        SystemLogger.handleLog(
            level: .error,
            message: message,
            showInConsole: showInConsole ?? false,
            shouldLogContext: shouldLogContext ?? false,
            context: logContext
        )
    }
    
    fileprivate static func handleLog(
        level: LogLevel,
        message: String,
        showInConsole: Bool,
        shouldLogContext: Bool,
        context: LogContext
    ) {
        
        if showInConsole {
            var messageComponent = [message, "=========="]
            if shouldLogContext {
                messageComponent = [message, context.description, "=========="]
            }
            
            let formattedMessage = messageComponent.joined(separator: "\n\n")
            
            guard let module = URL(fileURLWithPath: context.file).deletingPathExtension().pathComponents.last else { return }
            let osLog = OSLog(subsystem: module, category: level.prefix)
            
            switch level {
            case .info:
                os_log(.info,
                       log: osLog,
                       "%{private}@", formattedMessage)
            case .warning:
                os_log(.error,
                       log: osLog,
                       "%{private}@", formattedMessage)
            case .error:
                os_log(.fault,
                       log: osLog,
                       "%{private}@", formattedMessage)
            }
        }
    }
}
