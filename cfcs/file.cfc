<cfcomponent output = "false" hint = "handles crud operations for files">

    <cffunction name = "init"  hint = "initializes file thingy">
        <cfargument name="datasource" type="any" required="yes" hint="datasource for queries">
        <cfset variables.dsn = arguments.datasource />
        <cfreturn this />
    </cffunction>
    
    <!--- 
    This is the old function that was used before I updated to AJAX. It relies on traditional form submission
    <cffunction name = "addFileOLD" returnType = "void" roles = "public" access = "remote" displayName = "addFile" hint = "adds a file">
        <cfargument name="title" required="yes" type="string"/>
        <cfargument name="content" required="yes" type="string"/>
        <cfargument name="parentID" required="yes" type="string"/>

        <cfquery name = "insertFile" datasource = "sqltest">
            insert into file (title, parent_id, content, date_created, date_modified)
            values(
                <cfqueryparam value="#title#" cfsqltype="cf_sql_varchar"  />,
                <cfqueryparam value="#parentID#" cfsqltype="cf_sql_integer"  />,
                <cfqueryparam value="#content#" cfsqltype="cf_sql_varchar"  />,
                NOW(),
                NOW()
            );
        </cfquery>
        <cflocation url = "/wiki">
    </cffunction>
    --->

    <cffunction name = "addFile" returnType = "string" roles = "public" access = "remote" displayName = "addFile" hint = "adds a file">
        <cfset myArguments = deserializeJSON(ToString(getHTTPRequestData().content))>

        <cftry>
            <cfquery result = "insertFile" datasource = "#variables.dsn#">
                insert into file (title, parent_id, content, date_created, date_modified)
                values(
                    <cfqueryparam value="#myArguments.title#" cfsqltype="cf_sql_varchar"  />,
                    <cfqueryparam value="#myArguments.parentID#" cfsqltype="cf_sql_integer"  />,
                    <cfqueryparam value="#myArguments.content#" cfsqltype="cf_sql_varchar"  />,
                    NOW(),
                    NOW()
                );
            </cfquery>
            <cfreturn serializeJSON({ "success": true, "fileID": #insertFile["GENERATEDKEY"]# }) />
            
            <cfcatch type = "any">
                <cfreturn serializeJSON({ "success": false, "errors": serializeJSON(#cfcatch#) }) />
            </cfcatch>
        </cftry>

    </cffunction>




    <cffunction name = "editFile" returnType = "string" roles = "public" access = "remote" displayName = "editFile" hint = "edit a file">
        <!--- 
        OLD Arguments (before using AJAX)

        <cfargument name="fileID" required="yes" type="string"/>
        <cfargument name="title" required="yes" type="string"/>
        <cfargument name="content" required="yes" type="string"/> 
        --->

        <!--- Cannot access JSON body data from arguments scope
        ref: https://stackoverflow.com/questions/5781221/coldfusion-receiving-posted-json-data-and-parsing-it
        --------------------------------------------------------------------------------------------------- --->
        <cfset myArguments = deserializeJSON(ToString(getHTTPRequestData().content))>
        
        <cfquery name = "updateFile" datasource = "#variables.dsn#">
            update file
            set title = <cfqueryparam value="#myArguments.title#" cfsqltype="cf_sql_varchar"  />,
            content = <cfqueryparam value="#myArguments.content#" cfsqltype="cf_sql_varchar"  />,
            date_modified = NOW()
            where id = <cfqueryparam value="#myArguments.fileID#" cfsqltype="cf_sql_integer"  />;
        </cfquery>
        <!--- <cflocation url = "/?fileID=#fileID#"> --->
    </cffunction>




    <cffunction name = "addTopic" returnType = "void" roles = "public" access = "remote" displayName = "addTopic" hint = "adds a topic">
        <cfargument name="title" required="yes" type="string"/>

        <cfquery name = "insertFile" datasource = "#variables.dsn#">
            insert into file (title, parent_id, content, date_created, date_modified)
            values(
                <cfqueryparam value="#title#" cfsqltype="cf_sql_varchar"  />,
                NULL,
                '',
                NOW(),
                NOW()
            );
        </cfquery>
        <cflocation url = "/wiki">
    </cffunction>




    <cffunction name = "editTopic" returnType = "string" roles = "public" access = "remote" displayName = "editTopic" hint = "edit the name of a topic">
        <!--- 
        OLD Arguments, before using AJAX

        <cfargument name="fileID" type="integer" required="yes" hint="id of the topic being updated">
        <cfargument name="title" type="string" required="yes" hint="new title of the topic"> 
        --->

        <!--- ah yes, must de-serialize json to use json post data --->
        <cfset myArguments = deserializeJSON(ToString(getHTTPRequestData().content))>
        
        <cftry>
            <cfquery name = "updateFile" datasource = "#variables.dsn#">
                update file
                set title = <cfqueryparam value="#myArguments.title#" cfsqltype="cf_sql_varchar"  />
                where id = <cfqueryparam value="#myArguments.fileID#" cfsqltype="cf_sql_integer"  />
            </cfquery>    

            <cfcatch type = "any">
                <cfreturn serializeJSON({ "success": false, "errors": "wait, what? there are errors???" }) />
            </cfcatch>
        </cftry>
        
        <cfreturn serializeJSON({ "success": true }) />
    </cffunction>



    <!--- This is just a tag-based implementation of /test.cfc?method=listFiles --->
    <cffunction name = "fileTreeReducer" returnType = "array" access = "private" hint = "helper function to reduce a query into a struct with the correct values">
        <!--- OLD: <cfargument name="all" type="array" required="no" hint="the cumulative reducer object"> --->
        <cfargument name="all" type="array" required="no" default = "#ArrayNew(1)#" hint="the cumulative reducer object">
        <cfargument name="item" type="any" required="yes" hint="the current item">
        <cfargument name="i" type="number" required="yes" hint="the index">
        <!--- 
        OLD
        <cfset all[item.id] = {
            "id": item.id,
            "title": item.title,
            "parentID": item.parent_ID,
            "date_modified": item.date_modified,
            "date_created": item.date_created,
            "children": queryReduce(this.getFiles(item.id), fileTreeReducer)
        }> --->
        <cfset throwawayValue = ArrayAppend(all, {
            "id" = item.id,
            "title" = item.title,
            "parentID" = item.parent_ID,
            "date_modified" = item.date_modified,
            "date_created" = item.date_created,
            "children" = queryReduce(this.getFiles(item.id), fileTreeReducer)
        })>
        <cfreturn all>
    </cffunction>




    <!--- can access via /cfcs/apitest.cfc?method=listFiles --->
    <cffunction name = "listFiles" returnType = "array" access = "remote" hint = "list all files">
        <cfreturn queryReduce(this.getFiles(), fileTreeReducer)>
    </cffunction>


    <!--- cffunction --->

    <cffunction name = "getFiles" returnType = "query" <!--- roles = "public" ---> access = "remote" displayName = "getFiles" hint = "get all files">
        <cfargument name="parentID" type="number" required="no" displayname="parentID" hint="ID of parent">
        <cfquery name = "topics" datasource = "#variables.dsn#">
            select *
            from file
            <cfif StructKeyExists(arguments, "parentID")>
                where parent_id = <cfqueryparam value = "#parentID#" CFSQLType = "number">
            <cfelse>
                where parent_id is null
            </cfif>
            order by title
            ;
        </cfquery>

        <cfreturn topics>
    </cffunction>




    <cffunction name = "methodForTesting" returnType = "string" roles = "public" access = "public" hint = "this is not used in the app, just for mxunit testing">
        <cfreturn "this is my test return string" />
    </cffunction>

</cfcomponent>