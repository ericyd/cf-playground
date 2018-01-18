<!--- <cfparam name="url.fileID" type="integer" default="0"> --->

<cfinclude template = "view/layout/dsp_top.cfm">

<cfsilent>
	<cfset links = [
		'Wiki',
		'Charts',
		'Chess',
		'Trello'
	]>

	
	<cffunction name = "makeLink" returnType = "string" access = "public" description = "generate the html for a link">
		<cfargument name="linkName" type="string" required="true" hint="Name for the link (href is just lowercased)">

		<cfsetting enablecfoutputonly="true">
			<cfsavecontent variable = "local.html" >
				<cfoutput>
					<a href="#lcase(arguments.linkName)#" class="landing-link">
						<svg><text x="50%" y="50%" dy=".3em">#arguments.linkName#</text></svg>
					</a>
				</cfoutput>
			</cfsavecontent>
		</cfsetting>
		<cfreturn local.html>
	</cffunction>

	
	<cffunction name = "generateLinks" returnType = "string" access = "public" description = "generate the html for all links">
		<cfsilent>
			<cfset local.myLinks = "">
			<cfloop collection = "#links#" index = "local.i">
				<cfset link = makeLink(links[local.i]) />
				<cfset local.myLinks &= link />
			</cfloop>
		</cfsilent>
		
		<cfreturn local.myLinks>
	</cffunction>

</cfsilent>

<main class="main--flex container">
	<cfset allLinks = generateLinks() />
	<cfoutput>
		#allLinks#
	</cfoutput>
</main>


<cfinclude template = "view/layout/dsp_bottom.cfm">