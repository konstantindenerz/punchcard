scope = window
scope.lab = if scope.lab then scope.lab else {}
scope.lab.util = if scope.lab.util then scope.lab.util else {} 

# Returns a delegate that can be used to invoke given callback with custom arguments on given context.
scope.lab.util.delegate = (context, callback)->
	{
		invoke: ()-> callback.apply context, arguments
	}