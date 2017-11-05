<!--- 
Module for a wheelnav button
attributes are accessible via the `attributes` struct
 --->


<!--- class=addTopic --->
<cfoutput>
    <div class="wheel-nav-container">

        <!--- Main open/close --->
        <button class="wheelnav btn--icon circle-icon" data-controller-id="#attributes.fileId#">
            <!--- <cfinclude template = "/icons/iconmonstr-share-1.svg"> --->
            <cfinclude template="/icons/circle-dot.svg">
        </button>

        <!--- Edit topic --->
        <!--- TODO: Implement this functionality! --->
        <button class="subsvg editTopic btn--icon editTopic#attributes.fileId#" data-file-id="#attributes.fileId#">
            <cfinclude template="/icons/iconmonstr-edit-6.svg">
        </button>
        <button class="subsvg saveTopic btn--icon hide saveTopic#attributes.fileId#" data-file-id="#attributes.fileId#">
            <cfinclude template="/icons/iconmonstr-save-2.svg">
        </button>

        <!--- Add file --->
        <button class="subsvg addFile btn--icon addFile#attributes.fileId#" data-file-id="#attributes.fileId#">
            <cfinclude template="/icons/iconmonstr-note-14.svg">
        </button>
    </div>
</cfoutput>