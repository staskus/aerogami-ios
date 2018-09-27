//
//  Logger.swift
//  TravelKit
//
//  Created by Povilas Staskus on 9/27/18.
//  Copyright © 2018 Povilas Staskus. All rights reserved.
//

import Foundation
import CocoaLumberjack

public class Logger {
    
    public enum Context: Int {
        case data = 70
        case api = 80
        case feature = 100
        case app = 140
        case domain = 200
    }
    
    public enum Level: Int {
        case debug
        case info
        case warning
        case error
    }
    
    public let context: Context
    
    // Available loggers
    public static var data = Logger(context: .data)
    public static var api = Logger(context: .api)
    public static var feature = Logger(context: .feature)
    public static var app = Logger(context: .app)
    public static var domain = Logger(context: .domain)
    
    // Available handlers
    public static var handlers: [LoggerHandler] = [LumberJackHandler()]
    
    private init(context: Context) {
        self.context = context
    }
    
    public func debug(_ message: @autoclosure () -> String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line) {
        
        Logger.handlers.forEach { (handler) in
            handler.log(
                message(),
                file: file,
                function: function,
                line: line,
                context: self.context,
                level: .debug
            )
        }
    }
    
    public func info(_ message: @autoclosure () -> String,
                     file: StaticString = #file,
                     function: StaticString = #function,
                     line: UInt = #line) {
        
        Logger.handlers.forEach { (handler) in
            handler.log(
                message(),
                file: file,
                function: function,
                line: line,
                context: self.context,
                level: .info
            )
        }
    }
    
    public func warning(_ message: @autoclosure () -> String,
                        file: StaticString = #file,
                        function: StaticString = #function,
                        line: UInt = #line) {
        
        Logger.handlers.forEach { (handler) in
            handler.log(
                message(),
                file: file,
                function: function,
                line: line,
                context: self.context,
                level: .warning
            )
        }
    }
    
    public func error(_ message: @autoclosure () -> String,
                      file: StaticString = #file,
                      function: StaticString = #function,
                      line: UInt = #line) {
        
        Logger.handlers.forEach { (handler) in
            handler.log(
                message(),
                file: file,
                function: function,
                line: line,
                context: self.context,
                level: .error
            )
        }
    }
}

public protocol LoggerHandler {
    func log(_ message: String,
             file: StaticString,
             function: StaticString,
             line: UInt,
             context: Logger.Context,
             level: Logger.Level
    )
}

class LumberJackHandler: LoggerHandler {
    func log(_ message: String,
             file: StaticString,
             function: StaticString,
             line: UInt,
             context: Logger.Context,
             level: Logger.Level) {
        
        switch level {
        case .debug:
            DDLogDebug(
                message,
                level: defaultDebugLevel,
                context: context.rawValue,
                file: file,
                function: function,
                line: line
            )
        case .info:
            DDLogInfo(
                message,
                level: defaultDebugLevel,
                context: context.rawValue,
                file: file,
                function: function,
                line: line
            )
        case .warning:
            DDLogWarn(
                message,
                level: defaultDebugLevel,
                context: context.rawValue,
                file: file,
                function: function,
                line: line
            )
        case .error:
            DDLogError(
                message,
                level: defaultDebugLevel,
                context: context.rawValue,
                file: file,
                function: function,
                line: line
            )
        }
    }
}
