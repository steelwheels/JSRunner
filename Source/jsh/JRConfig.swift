/**
 * @file	JRConfig.swift
 * @brief	Define JRConfig class
 * @par Copyright
 *   Copyright (C) 2017 Steel Wheels Project
 */

import CoconutData
import Cobalt
import KiwiEngine
import KiwiLibrary
import Foundation

public class JRConfig: KEConfig
{
	public var scriptFiles:		Array<String>
	public var isInteractiveMode:	Bool
	public var doUseMain:		Bool

	public init(){
		scriptFiles		= []
		isInteractiveMode	= false
		doUseMain		= false
		super.init(kind: .Terminal, doStrict: true, doVerbose: false)
	}
}

public class JRCommandLineParser
{
	private var mConsole:	CNConsole

	private enum OptionId: Int {
		case Help		= 0
		case Version		= 1
		case Verbose		= 2
		case NoStrictMode	= 3
		case InteractiveMode	= 4
		case UseMain		= 5
	}

	public init(console cons: CNConsole){
		mConsole = cons
	}

	private func parserConfig() -> CBParserConfig {
		let opttypes: Array<CBOptionType> = [
			CBOptionType(optionId: OptionId.Help.rawValue,
				     shortName: "h", longName: "help",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print help message and exit program"),
			CBOptionType(optionId: OptionId.Version.rawValue,
				     shortName: nil, longName: "version",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print version information"),
			CBOptionType(optionId: OptionId.Verbose.rawValue,
				     shortName: nil, longName: "verbose",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Print vebose information for debugging"),
			CBOptionType(optionId: OptionId.NoStrictMode.rawValue,
				     shortName: nil, longName: "no-strict",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Do not use strict mode"),
			CBOptionType(optionId: OptionId.InteractiveMode.rawValue,
				     shortName: "i", longName: "interactive",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Activate interactive mode"),
			CBOptionType(optionId: OptionId.UseMain.rawValue,
				     shortName: nil, longName: "use-main",
				     parameterNum: 0, parameterType: .VoidType,
				     helpInfo: "Use \"main\" function"),
		]
		let config = CBParserConfig(hasSubCommand: false)
		config.setDefaultOptions(optionTypes: opttypes)
		return config
	}

	private func printUsage() {
		mConsole.print(string: "usage: jsrun [options] script-file1 ... (option \"-h\" for help)\n")
	}

	private func printHelpMessage() {
		mConsole.print(string: "usage: jsrun [options] script-file1 script-file2 ...\n" +
		"  [options]\n" +
		"    --help, -h             : Print this message\n" +
		"    --version              : Print version\n" +
		"    --no-strict            : Do not use strict mode (default: use strict)\n" +
		"    --use-main             : Call \"main\" function after compilation\n" +
		"    --interactive, -i      : Activate interactive mode\n" +
		"    --argument -a <string> : String to be passed as an argument\n"
		)
	}

	private func printVersionMessage() {
		let plist = CNPropertyList(bundleDirectoryName: "jstools.bundle")
		let version: String
		if let v = plist.version {
			version = v
		} else {
			version = "<Unknown>"
		}
		mConsole.print(string: "\(version)\n")
	}

	public func parseArguments(arguments args: Array<String>) -> (JRConfig, Array<String>)? {
		var config : JRConfig? = nil
		let (err, _, rets, subargs) = CBParseArguments(parserConfig: parserConfig(), arguments: args)
		if let e = err {
			mConsole.error(string: "Error: \(e.description)\n")
		} else {
			config = parseOptions(arguments: rets)
		}
		if let config = config {
			return (config, subargs)
		} else {
			return nil
		}
	}

	private func parseOptions(arguments args: Array<CBArgument>) -> JRConfig? {
		let config   = JRConfig()
		let stream   = CNArrayStream(source: args)
		while let arg = stream.get() {
			if let opt = arg as? CBOptionArgument {
				if let optid = OptionId(rawValue: opt.optionType.optionId) {
					switch optid {
					case .Help:
						printHelpMessage()
						return nil
					case .Version:
						printVersionMessage()
						return nil
					case .Verbose:
						config.doVerbose = true
					case .NoStrictMode:
						config.doStrict  = false
					case .InteractiveMode:
						config.isInteractiveMode = true
					case .UseMain:
						config.doUseMain = true
					}
				} else {
					NSLog("[Internal error] Unknown option id")
				}
			} else if let param = arg as? CBNormalArgument {
				config.scriptFiles.append(param.argument)
			} else {
				NSLog("[Internal error] Unknown object: \(arg)")
				return nil
			}
		}
		return config
	}
}