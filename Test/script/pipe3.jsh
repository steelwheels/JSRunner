/* pipe3.jsh */

let pipe = Pipe() ;

/* Send input */
pipe.writing.put("Hello, world !!\n") ;
pipe.writing.close() ;

/* Execute thread */
(pipe, stdout, stderr) > tr [a-z] [A-Z]

