/* cat1.js */

function cat(){
	var file = File.open("../sample/cat1.js", "r")
	if(file != null){
		var line
		console.log("*** File Start\n")
		while((line = file.getl()) != null){
			stdout.put(line)
		}
		console.log("*** File End\n")
	} else {
		console.log("Failed to open file\n")
	}
}

cat()
console.log("*** Bye\n")

