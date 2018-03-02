// CF will automatically look for an execute the Application.cfc if it exists for every request.
// You can have more than one Application.cfc files - the one used depends on the directory used.
// Only execute one Application.cfc per request.
// If no Application.cfc is found in the directory of the requested page, it will traverse the directory structure upwards 


component {
	this.name = "Lucee";
	this.mappings["/other"]= GetDirectoryFromPath( GetCurrentTemplatePath() ) & "api";
	this.mappings["/testbox"]= GetDirectoryFromPath( GetCurrentTemplatePath() ) & "/testbox";
	this.datasources["sqltest"] = {
		class: 'org.gjt.mm.mysql.Driver'
		, connectionString: 'jdbc:mysql://localhost:3306/docs?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
		, username: 'root'
		, password: "encrypted:ad19280193fbae4251cf85e2b2c8011317fccec63e827806b8dfd79d08477b63"
	};

	public boolean function onApplicationStart() {
		// application.file = new cfcs.file();
		// application.api = new cfcs.apitest();
		// If needed for testing, move these declarations to onRequestStart() so they are refreshed on every request
		return true;
	}

	public boolean function onRequestStart() {
		application.weather_old = new cfcs.weather_old();
		application.file = new cfcs.file(datasource = "sqltest");
		application.WEATHER_API_KEY = "f0af5f49d39b72ae6fa8f4c568c7976a";
		application.weather = new cfcs.weather(apikey = application.WEATHER_API_KEY);
		// this.mappings["/test"]= GetDirectoryFromPath( GetCurrentTemplatePath() ) & "api";
		// WriteDump(this.mappings)
		// application.api = new api.test();
		// WriteOutput(GetCurrentTemplatePath() )
		// WriteOutput(GetDirectoryFromPath(GetCurrentTemplatePath() ))
		// WriteOutput(GetDirectoryFromPath(GetCurrentTemplatePath() ) & 'api')

		application.testing = "yeppers!";
		application.header = "Documentation Place";
		return true;
	}

	application.otherthing = "other thing";
}
