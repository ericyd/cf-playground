<!---
https://www.adobe.com/devnet/coldfusion/articles/testdriven_coldfusion_pt1.html
https://www.adobe.com/devnet/coldfusion/articles/testdriven_coldfusion_pt2.html
--->
<cfcomponent displayname = "weather2" hint = "a rerite of the weather service that can be testable">
	<cffunction name = "init" hint="initializes weather service">
		<cfargument name="apikey" type="string" required="no" default="f0af5f49d39b72ae6fa8f4c568c7976a" />
		<cfset this.apikey = arguments.apikey />
		<cfreturn this />
	</cffunction>

	<cffunction name = "getAPIKey" returnType = "string" access = "private" hint = "returns api key">
		<cfif StructKeyExists(this, "apikey")>
			<cfreturn this.apikey />
		<cfelse>
			<cfreturn "f0af5f49d39b72ae6fa8f4c568c7976a" />
		</cfif>
	</cffunction>

	<cffunction name = "ping" returnType = "string" access = "public" hint = "pings the weather service">
		<cfreturn "ok" />
	</cffunction>

	<cffunction name = "callWeather" returnType = "struct" access = "public" hint = "call weather service">
		<cfargument name="location" type="string" required="yes" />
		<cfargument name="zip" type="string" required="yes" />

		<cfhttp method="GET" charset="utf-8" url="http://api.openweathermap.org/data/2.5/#arguments.location#" result="local.res">
			<cfhttpparam type = "url" name = "appid" value = "#getAPIKey()#" />
			<cfhttpparam type = "url" name = "zip" value = "#arguments.zip#,us" />
			<cfhttpparam type = "url" name = "mode" value = "json" />
			<cfhttpparam type = "url" name = "units" value = "imperial" />
		</cfhttp>

		<cfreturn deserializeJSON(local.res.filecontent) />
	</cffunction>

	<cffunction name="getForecast" returnType = "struct" access="public" hint="gets weather forcast for zip code">
		<cfargument name="zip" type="string" required="no" default="97205" />
		<cfset arguments.location = "forecast">
		<cfreturn callWeather(argumentCollection=arguments) />
	</cffunction>

	<cffunction name = "getCurrentWeather" returnType = "struct" access = "public" hint = "gets current weather for zip">
		<cfargument name="zip" type="string" required="no" default="97205" />
		<cfset arguments.location = "weather">
		<cfreturn callWeather(argumentCollection=arguments) />
	</cffunction>

	<cffunction name="getForecastRemote" returnType = "struct" access="remote" hint="gets weather forcast for zip code remote">
		<cfreturn getForecast("97205") />
	</cffunction>

	<cffunction name="getWeatherRemote" returnType = "struct" access="remote" hint="gets weather forcast for zip code remote">
		<cfreturn getCurrentWeather("97205") />
	</cffunction>



</cfcomponent>