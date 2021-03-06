console.log("setup curses start") ;

let gr    = require('Graphics/Primitives') ;
let gcons = require('Graphics/Console') ;

console.visiblePrompt = false ;
console.doBuffering   = false ;
console.doEcho	      = false ;
console.setScreenMode(true) ;
console.setColor(Curses.White, Curses.Blue) ;

console.log("Press \"q\" to quit") ;

let origin = new gr.Point(5, 10) ;
let size   = new gr.Size(40, 40) ;
let frame  = new gr.Rect(origin.x, origin.y, size.width, size.height) ;
let label  = new gcons.Label(frame) ;

let key = 0 ;
while((key = console.getKey()) != null){
	let c = String.fromCharCode(key) ;
	console.log("Key : " + c) ;
	if(c == "q"){
		break ;
	}
}

console.log("Bye") ;

