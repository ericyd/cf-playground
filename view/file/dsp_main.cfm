<cfparam name="sanity" type="string" default="yes">
<cfparam name="url.fileID" type="integer" default=0>

<cfquery name = "file" datasource = "sqltest">
    select * 
    FROM docs.file
    where id = <cfqueryparam value="#url.fileID#" cfsqltype="cf_sql_integer" />;
</cfquery>

<section class="doc-preview">
    <cfoutput>
        <span class="displaynone" id="fileid">#file.id#</span>
        <h2><span id="file-title" data-raw="#file.title#" data-editable>#file.title#</span> 
            <button class="editFile btn--icon">
                <cfinclude template = "/icons/iconmonstr-edit-6.svg">
            </button>
            <button class="saveFile btn--icon">
                <cfinclude template = "/icons/iconmonstr-save-2.svg">
            </button>
        </h2>
        <section class="doc-preview__metadata">
            <div>
                <strong>Created on:</strong> 
                <span id="file-date-created">
                    #DateFormat(file.date_created, "mmm dd, yyyy")#
                </span>
            </div>
            <div>
                <strong>Modified on:</strong> 
                <span id="file-date-modified">
                    #DateFormat(file.date_modified, "mmm dd, yyyy")#
                </span>
            </div>
            <div>
                <strong>Modified by:</strong> 
                <span id="file-modified-by">
                    <cfif IsNull(file.modified_by) OR len(file.modified_by) eq 0>whoa... I have no idea!<cfelse>#file.modified_by#</cfif>
                </span>
            </div>
        </section>
        <p class="doc-preview__content" id="file-content" data-raw="#file.content#" data-editable>#file.content#</p>
    </cfoutput>
</section>

