
function json0(){
 	var data = JSON.read("../Sample/data0.json") ;
	console.log("a = " + data.a + "\n") ;
	console.log(data) ;

	data.a += 1 ;
	data.c =  0xff ;

	var res = JSON.write("data0-out.json", data) ;
	if(res != 0){
		console.log("Failed to write JSON: " + res + "\n") ;
	}
}

json0()
