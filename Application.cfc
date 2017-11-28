// CF will automatically look for an execute the Application.cfc if it exists for every request.
// You can have more than one Application.cfc files - the one used depends on the directory used.
// Only execute one Application.cfc per request.
// If no Application.cfc is found in the directory of the requested page, it will traverse the directory structure upwards 


component {
	this.name = "Lucee";
	this.mappings["/other"]= GetDirectoryFromPath( GetCurrentTemplatePath() ) & "api";
	this.datasources["sqltest"] = {
		class: 'org.gjt.mm.mysql.Driver'
		, connectionString: 'jdbc:mysql://localhost:3306/docs?useUnicode=true&characterEncoding=UTF-8&useLegacyDatetimeCode=true'
		, username: 'root'
		, password: "encrypted:ad19280193fbae4251cf85e2b2c8011317fccec63e827806b8dfd79d08477b63"
	};
	// this.mappings["/layout"]= GetDirectoryFromPath( GetCurrentTemplatePath() ) & "view" & "layout";

	public boolean function onApplicationStart() {
		// application.file = new cfcs.file();
		// application.api = new cfcs.apitest();
		// If needed for testing, move these declarations to onRequestStart() so they are refreshed on every request
		application.WEATHER_API_KEY = "f0af5f49d39b72ae6fa8f4c568c7976a";
		application.file = new cfcs.file();
		application.weather = new cfcs.weather();
		return true;
	}

	public boolean function onRequestStart() {
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

<!--- Equivalent component declaration using tag syntax 
The mappings are not included in the script syntax because they don't seem to do anything.
--->
<!--- <cfcomponent output="false">
	<cfset this.name = "Lucee">
	<!---
	Not necessary because it is declared in the Lucee admin
	<cfset this.datasources["sqltest"] = {
		class: 'org.gjt.mm.mysql.Driver'
		, connectionString: 'jdbc:mysql://localhost:3306/docs?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=round&tinyInt1isBit=true&autoReconnect=true&jdbcCompliantTruncation=true&useOldAliasMetadataBehavior=true&allowMultiQueries=true&useLegacyDatetimeCode=true'
		, username: 'root'
		, password: "encrypted:34cd36dca7785ea102ec84da4299ea789420a8f766a5752604b4b25a96e253dd"
	}>;
	--->
	<!--- This doesn't seemt to do anything...---> 
	<cfset this.mappings = StructNew() >
	<cfset this.mappings['/vLayout'] = getDirectoryFromPath(getCurrentTemplatePath()) & "view" &"layout">
	<cfset this.mappings['/vFile'] =  getDirectoryFromPath(getCurrentTemplatePath()) & "view" &"file">
	<cffunction name="onRequestStart">
		<cfset application.testing = "yeppers!">
		<cfset application.header = "Documentation Place">
	</cffunction>

	<cfset application.otherthing = "other thing">
</cfcomponent> --->
