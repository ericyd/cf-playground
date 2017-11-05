<section class="doc-tree">
    <cfoutput>
        <!--- topics do not have a parent - they are at the root level --->
        <!--- <cfset topics = application.file.getFiles()>
        <ul>
            <cfloop query = "topics">
                <li class="doc-tree__topic">#topics.title# 
                    <button id="#topics.id#" class="addTopic btn--icon">
                        <cfinclude template = "/icons/iconmonstr-plus-6.svg">
                    </button>
                </li>

                <cfset items = application.file.getFiles(parentID=topics.id)>
                <cfif items.recordCount neq 0>
                    <ul>
                        <cfloop query = "items">
                            <li class="doc-tree__item">
                                <button id="#items.id#" class="fileitem">#items.title# (#DateFormat(items.date_modified, "mmm d, yyyy")#)</button>
                            </li>
                        </cfloop>
                    </ul>
                </cfif>
            </cfloop>
        </ul> --->


        <!--- utilizes the newest listFiles method
            added benefit: only requires one call --->
        <cfset files = application.file.listFiles()>
        <ul class="sidebar">
            <cfloop collection = "#files#" item = "i">
                <cfset file = files[i]>
                <li class="doc-tree__topic" data-controller-id="#file.id#">
                    <span id="file#file.id#" data-raw="#file.title#" data-controller-id="#file.id#">#file.title#</span>
                    <cfmodule
                        template = "/view/widgets/wheelnav.cfm"
                        name = "wheelnav#file.id#"
                        fileId = "#file.id#"
                        fileTitle = "#file.title#" >
                </li>

                <cfif StructKeyExists(file, "children")>
                    <ul id="file-list#file.id#">
                        <cfloop collection = "#file.children#" item = "j">
                            <cfset child = file.children[j]>
                            <!--- 
                            OLD Version, before the cfmodule
                            <li class="doc-tree__item">
                                <button id="#child.id#" class="fileitem">#child.title# (#DateFormat(child.date_modified, "mmm d, yyyy")#)</button>
                            </li> 
                            --->
                            <cfmodule template = "/view/widgets/fileListItem.cfm" name = "file-item" attributeCollection = "#child#">
                        </cfloop>
                    </ul>
                </cfif>
            </cfloop>
        </ul>
    </cfoutput>
</section>
