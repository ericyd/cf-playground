/**
* This tests the BDD functionality in TestBox.
*/
component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		// print( "<h1>BDD Testing is Awesome!</h1>" );
		mockBox = new testbox.system.MockBox();
		
	}

	function afterAll(){
		
	}

/*********************************** BDD SUITES ***********************************/

	function run(){

		/**
		* describe() starts a suite group of spec tests.
		* Arguments:
		* @title The title of the suite, Usually how you want to name the desired behavior
		* @body A closure that will resemble the tests to execute.
		* @labels The list or array of labels this suite group belongs to
		* @asyncAll If you want to parallelize the execution of the defined specs in this suite group.
		* @skip A flag that tells TestBox to skip this suite group from testing if true
		*/
		describe( title="weather tests", body=function(){

			// before each spec in THIS suite group
			beforeEach(function(){
				// variables.service = new cfcs.file(datasource="sqltest");
				
			});

			// after each spec in THIS suite group
			afterEach(function(){
				
			});

			xit( "it works", function(){
				mockQuery = mockBox.querySim("id,title,parentID
					1 | test1 | null
					2 | test2 | null
					3 | test3 | 1");
				expected = mockQuery = mockBox.querySim("id,title,parentID
					1 | test1 | null
					2 | test2 | null");
				variables.service = new cfcs.file(datasource="scratch_embedded_app");
				var files = variables.service.getFiles();
				expect(files).toBe(expected);
			});

			xit("application setup correctly", function() {
				expect(application.prop).toBe("thisprop");
			});
		});
	}
}
