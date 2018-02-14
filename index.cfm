<!--- <cfparam name="url.fileID" type="integer" default="0"> --->

<cfinclude template = "view/layout/dsp_top.cfm">

<cfsilent>
	<cfset variables.links = [
		{
			"name" = "Wiki",
			"href" = "wiki"
		},
		{
			"name" = "Charts",
			"href" = "charts"
		},
		{
			"name" = "Chess",
			"href" = "chess"
		},
		{
			"name" = "Trello",
			"href" = "trello"
		},
		{
			"name" = "tests",
			"href" = "tests/runner.cfm"
		}
	] />

	
	<cffunction name = "makeLink" returnType = "string" access = "public" description = "generate the html for a link">
		<cfargument name="link" type="struct" required="true" hint="Link details including `name` and `href` keys">

		<cfsetting enablecfoutputonly="true">
			<cfsavecontent variable = "local.html" >
				<cfoutput>
					<a href="#lcase(arguments.link.href)#" class="landing-link">
						<svg><text x="50%" y="50%" dy=".3em">#arguments.link.name#</text></svg>
					</a>
				</cfoutput>
			</cfsavecontent>
		</cfsetting>
		<cfreturn local.html />
	</cffunction>

	
	<cffunction name = "generateLinks" returnType = "string" access = "public" description = "generate the html for all links">
		<cfsilent>
			<cfset local.myLinks = "">
			<cfloop array = "#links#" index = "local.i">
				<cfset var link = makeLink(local.i) />
				<cfset local.myLinks &= link />
			</cfloop>
		</cfsilent>
		
		<cfreturn local.myLinks />
	</cffunction>

</cfsilent>

<main class="main--flex container">
	<cfset allLinks = generateLinks() />
	<cfoutput>
		#allLinks#
	</cfoutput>
</main>

<cfinclude template = "view/layout/dsp_bottom.cfm">