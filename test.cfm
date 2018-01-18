<!-----------------------------------------------
	
------------------------------------------------>

<cfparam name="url.method" type="string" default="default">

<cfswitch expression="#url.method#">

	<!--- Get highest Partner ID --->
	<cfcase value="topPartner">
		<cfquery name="topPartner" datasource="sqltest" result="resTopPartner">
			SELECT *
			FROM file
			ORDER BY id DESC
			LIMIT 1
		</cfquery>


        
            <cfoutput>
                #serializeJSON(queryGetRow(topPartner,1))#
            </cfoutput>
        

        <cfscript>
            test = ["one", "two", "three"]
            WriteOutput(serializeJSON(queryGetRow(topPartner,1)))
        </cfscript>

	</cfcase>



	<!--- Default: tell user to include a method param --->
	<cfdefaultcase>
		<cfscript>
			msg = {"success": false, "message": "You did not specify a 'method' parameter in the URL"};
			WriteOutput(serializeJSON(msg));
		</cfscript>
	</cfdefaultcase>
</cfswitch>
