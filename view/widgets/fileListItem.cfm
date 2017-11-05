<cfoutput>
    <li class="doc-tree__item">
        <button id="#attributes.id#" class="fileitem">#attributes.title# (#DateFormat(attributes.date_modified, "mmm d, yyyy")#)</button>
    </li>
</cfoutput>