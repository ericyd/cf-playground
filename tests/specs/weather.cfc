/**
* This tests the BDD functionality in TestBox.
*/
component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	function beforeAll(){
		// print( "<h1>BDD Testing is Awesome!</h1>" );
		mockBox = new testbox.system.MockBox();
		console( "Executed beforeAll() at #now()# " );
		application.salvador = 1;
	}

	function afterAll(){
		console( "Executed afterAll() at #now()#" );
		structClear( application );
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
				// coldbox = 0;
				// coldbox++;
				// debug( "beforeEach suite: coldbox = #coldbox#" );
			});

			// after each spec in THIS suite group
			afterEach(function(){
				// foo = 0;
			});

			/**
			* it() describes a spec to test. Usually the title is prefixed with the suite name to create an expression.
			* Arguments:
			* @title The title of the spec
			* @spec A closure that represents the test to execute
			* @labels The list or array of labels this spec belongs to
			* @skip A flag that tells TestBox to skip this spec from testing if true
			*/

			it( "it works", function(){
				var expected = "expected";
				var actual = expected;
				expect( actual ).toBe( expected );
			});

			it("should be alive", function(){
				var weather = createObject("component", "cfcs.weather2");
				var expected = 'ok';
				var actual = weather.ping();
				expect( actual ).toBe( expected );
			});

			it("should require authentication", function() {
				var weather = createObject("component", "cfcs.weather2").init(apikey = "invalid");
				mockBox.prepareMock( weather );
				var myJSON = fileRead(getDirectoryFromPath(getCurrentTemplatePath()) & "/mocks/unauthorized.json");
				weather.$("callWeather", deserializeJSON(myJSON));
				var expected = "401";
				var actual = weather.getForecast().cod;
				expect( actual ).toBe( expected );
			});

			it("should set api key on init", function() {
				var key = "thistestkey";
				var weather = createObject("component", "cfcs.weather2").init(apikey = key);
				var expected = key;
				var actual = weather.apikey;
				expect( actual ).toBe( expected );
			});

			it("should get current weather", function() {
				var weather = createObject("component", "cfcs.weather2");
				mockBox.prepareMock( weather );
				var myJSON = fileRead(getDirectoryFromPath(getCurrentTemplatePath()) & "/mocks/weatherResults.json");
				weather.$("callWeather", deserializeJSON(myJSON));
				var actual = weather.getCurrentWeather("97205");
				expect(actual.cod).toBe("200");
				expect(actual)
					.toHaveKey("coord")
					.toHaveKey("wind")
					.toHaveKey("dt")
					.toHaveKey("weather")
					.toHaveKey("visibility");
			});

			it("should get forecast", function() {
				var weather = createObject("component", "cfcs.weather2");
				mockBox.prepareMock( weather );
				var myJSON = fileRead(getDirectoryFromPath(getCurrentTemplatePath()) & "/mocks/forecastResults.json");
				weather.$("callWeather", deserializeJSON(myJSON));
				var actual = weather.getForecast("10001");
				expect(actual.cod).toBe("200");
				expect(actual)
					.toHaveKey("cnt")
					.toHaveKey("city")
					.toHaveKey("list");
				expect(arrayLen(actual.list)).toBe(actual.cnt);
			});
		});
	}
}
