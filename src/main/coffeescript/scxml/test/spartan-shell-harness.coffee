# Copyright (C) 2011 Jacob Beard
# Released under GNU LGPL, read the file 'COPYING' for more information

#spartanLoaderForAllTests is built by make
require ["scxml/json2model","scxml/test/harness","scxml/test/report2string","scxml/test/simple-env","spartanLoaderForAllTests","logger"],(json2model,harness,report2string,SimpleEnv,testTuples,logger) ->

	jsonTests = for testTuple in testTuples
		model = json2model(testTuple.scxmlJson)

		{
			name : testTuple.name
			group : testTuple.group
			model : model
			testScript : testTuple.testScript
		}

	finish = (report) ->
		logger.info report2string report
		
		#all spartan environments support quit()
		quit report.testCount == report.testsPassed

	env = new SimpleEnv()

	harness jsonTests,env.setTimeout,env.clearTimeout,finish

	env.mainLoop()
