<!---
  --- Forms to add and edit files.
  --- files are always children of a topic.
  --- Technically the schema for a file and topic is identical, but topics will have a parentID of null
  --- whereas files should have a parentID of an integer that corresponds to a file
  --->

<cfparam name="url.fileID" type="integer" default="0">
<cfparam name="url.parentID" type="integer" default="1">

<cfinclude template = "../layout/dsp_top.cfm">

<main class="container">
    <!--- Default: add file --->
    <cfif url.fileID eq 0>
        <h2>Add a file</h2>
        <form method="post" action="/cfcs/file.cfc?method=addFile">
            <cfoutput><input type="number" name="parentID" id="parentID" hidden="true" value="#url.parentID#" /></cfoutput>

            <label for="title">File name</label></br>
            <input id="title" name="title" type="text" />
            <br /><br />

            <label for="content">Content</label></br>
            Note: you can use <a href="http://commonmark.org/help/" target="_blank">markdown</a> to style the content.<br/>
            <textarea id="content" name="content" cols="60" rows="15" /></textarea>
            <br /><br />

            <input type="submit" value="Submit" />
            <input type="button" value="Cancel" class="cancel" data-fileid="0"/>
        </form>


    <!--- Edit file if ID is present --->
    <cfelse>
        <cfquery name = "file" datasource = "sqltest">
            select *
            from file
             where id = <cfqueryparam value = "#url.fileID#" CFSQLType = "integer">
        </cfquery>
        <cfoutput>  

            <h2>Edit file</h2>

            <!--- Metadata ---> 
            <section class="doc-preview__metadata">
                <div>
                    <strong>Created on:</strong> #DateFormat(file.date_created, "mmm dd, yyyy")#
                </div>
                <div>
                    <strong>Last modified on:</strong> #DateFormat(file.date_modified, "mmm dd, yyyy")#
                </div>
                <div>
                    <strong>Modified by:</strong> you ... right?
                </div>
            </section>
            <br /><br />

            <!--- Edit form ---> 
            <form method="post" action="/cfcs/file.cfc?method=editFile">
                <input type="number" name="fileID" value="#file.id#" hidden="true" />

                <label for="title">File name</label></br>
                <input id="title" name="title" type="text" value="#file.title#"/>
                <br /><br />

                <label for="content">Content</label></br>
                Note: you can use <a href="http://commonmark.org/help/" target="_blank">markdown</a> to style the content.<br/>
                <textarea id="content" name="content" cols="60" rows="15" />#file.content#</textarea>
                <br /><br />



                <input type="submit" value="Submit" />
                <input type="button" value="Cancel" class="cancel" data-fileid="#url.fileID#"/>
            </form>
        </cfoutput>
    </cfif>
</main>
<cfinclude template = "../layout/dsp_bottom.cfm">

<script>
    document.querySelectorAll('.cancel').forEach(function (btn) {
        btn.addEventListener('click', function(e) {
            window.location = '/?fileID=' + e.target.dataset.fileid;
        })
    })
</script>