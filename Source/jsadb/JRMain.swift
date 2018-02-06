/**
 * @file	JRMain.swift
 * @brief	Define Main function
 * @par Copyright
 *   Copyright (C) 2018 Steel Wheels Project
 */

import Canary
import Foundation

private let appname = "jsadb"

public func main(arguments args: Array<String>) -> Int32
{
	let console = CNFileConsole()

	/* Parse command line arguments */
	let parser = JRCommandLineParser(console: console)
	guard let config = parser.parseArguments(arguments: Array(args.dropFirst())) else {
		return 1
	}

	/* allocate address book */
	let adb = CNAddressBook()
	var dowait = true
	while dowait {
		switch adb.authorize() {
		case .Authorized:
			dowait = false
		case .Denied:
			console.error(string: "\(appname): [Error] Authorization failed to access AddressBook database\n")
			return 1
		case .Examinating:
			console.print(string: "\(appname): Waiting authorization\n")
		case .Undetermined:
			console.error(string: "\(appname): [Error] internal error\n")
		}
	}

	switch config.command {
	case .DumpCommand:
		dump(addressBook: adb, console: console)
	case .NoCommand:
		break /* Do nothing */
	}

	return 0 // no error
}

private func dump(addressBook adb: CNAddressBook, console cons: CNConsole)
{
	if let contacts = adb.contacts() {
		let dict: Dictionary<String, Any> = ["contacts": contacts]
		let (str, err) = CNJSONFile.serialize(dictionary: dict)
		if let e = err {
			cons.error(string: "\(appname): \(e.description)\n")
		} else {
			cons.print(string: str!)
		}
	}
}



