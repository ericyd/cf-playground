ready(function() {
    document.querySelectorAll('.fileitem').forEach(function(item) {
        item.addEventListener('click', loadFile)
    })

    // Edit Topic event listener
    document.querySelectorAll('.editTopic').forEach(function(el) {
        el.addEventListener('click', function(e) {
            return replaceWithEditable(e, '#file' + e.target.dataset.fileId)
        });
    });
    document.querySelectorAll('.saveTopic').forEach(function(el) {
        el.addEventListener('click', saveTopic)
    });

    // add event listeners for topic menu buttons
    document.querySelectorAll('.wheelnav').forEach(function (el) {
        el.addEventListener('click', toggleWheel)
    })
    
    document.querySelectorAll('.addFile').forEach(function(addTopic) {
        // original page-based functionality
        // addTopic.addEventListener('click', function(e) {
        //     window.location = '/view/file/dsp_addFile.cfm?parentID=' + e.target.dataset.fileId;
        // })

        // modal- & ajax-based functionality
        addTopic.addEventListener('click', function(openModalEvent) {
            // setting a unique formID allows triggering the "add file" modal more than once per page visit
            var formid = 'addFileForm' + Math.round(Math.random() * 100000);
            picoModal({
                content: '<h2>Add a file</h2>'
                        + '<form id="'+ formid + '">'
                            + '<label for="title">File name</label></br>'
                            + '<input id="title" name="title" type="text" />'
                            + '<br /><br />'
                            
                            + '<label for="content">Content</label></br>'
                            + 'Note: you can use <a href="http://commonmark.org/help/" target="_blank">markdown</a> to style the content.<br/>'
                            + '<textarea id="content" name="content" cols="60" rows="15" /></textarea>'
                            + '<br /><br />'
                        
                            + '<input type="submit" value="Submit" />'
                            + '<input type="button" value="Cancel" class="cancel" />'
                        + '</form>'
            }).afterCreate(function(modal) {
                // attach "submit" listener
                document.getElementById(formid).addEventListener('submit', function(submitEvent) {
                    submitEvent.preventDefault();

                    // perform ajax call
                    axios.post('/cfcs/file.cfc?method=addFile', {
                        parentID: openModalEvent.target.dataset.fileId,
                        title: submitEvent.target.title.value,
                        content: submitEvent.target.content.value,
                    })
                    .then(function(response) {
                        // add a new button to the list
                        var li = createFileItem(JSON.parse(response.data).fileID, submitEvent.target.title.value, new Date())
                        var fileList = document.getElementById('file-list' + openModalEvent.target.dataset.fileId);
                        fileList.append(li);

                        modal.close();
                    })
                    .catch(handleError)
                })

                // attach "cancel" listener
                modal.modalElem().addEventListener("click", function(evt) {
                    if (evt.target && evt.target.matches(".cancel")) {
                        modal.close();
                    }
                });
            }).show();
        });
    })
})

// toggle sub-svgs of clicked button
function toggleWheel(e) {
    document.querySelectorAll('.subsvg').forEach(function (el) {
        if (e.target.dataset.controllerId === el.dataset.fileId && !el.classList.contains('show')) {
            el.classList.add('show');
        } else {
            el.classList.remove('show');
        }
    })
}


function loadFile(e) {
    axios.get('/view/file/dsp_main.cfm?fileID=' + e.target.id)
    .then(function(response) {
        document.getElementById('file').innerHTML = response.data;
        // Edit File event listener
        document.querySelector('.editFile').addEventListener('click', function(e) {
            return replaceWithEditable(e, '[data-editable]')
        });
        // Save File event listener
        document.querySelector('.saveFile').addEventListener('click', saveFile)
        
        // Hide Save button
        document.querySelector('.saveFile').style.display = 'none';
        var fileContent = document.getElementById('file-content');
        renderContent(fileContent, fileContent.dataset.raw);
    }, handleError).catch(handleError)
}



function saveFile(saveEvent) {
    /*
    TODO: Should add spinner or other saving status indicator
    */
    axios.post('/cfcs/file.cfc?method=editFile', {
        fileID: Number(document.getElementById('fileid').innerText),
        title: document.getElementById('file-title').value,
        content: document.getElementById('file-content').value,
    })
    .then(function(data) {
        replaceWithReadonly(saveEvent, '[data-editable]');
    }, handleError)
    .catch(handleError)
}


function saveTopic(saveEvent) {
    /*
    TODO: Should add spinner or other saving status indicator
    */
    axios.post('/cfcs/file.cfc?method=editTopic', {
        fileID: saveEvent.target.dataset.fileId,
        title: document.getElementById('file' + saveEvent.target.dataset.fileId).value
    })
    .then(function(data) {
        replaceWithReadonly(saveEvent, '#file' + saveEvent.target.dataset.fileId);
    }, handleError)
    .catch(handleError)
}


function createFileItem(id, title, date) {
    var monthMap = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"];
    var date = date || new Date();
    var dateString = monthMap[date.getUTCMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear();
    
    var li = document.createElement('li');
    li.classList.add('doc-tree__item');
    
    var btn = document.createElement('button');
    btn.id = id;
    btn.innerText = title + ' (' + dateString + ')'
    
    li.append(btn);
    li.addEventListener('click', loadFile)
    
    // final output looks something like this
    // <li class="doc-tree__item">
    //     <button id="41" class="fileitem">new topic 6 (Oct 13, 2017)</button>
    // </li>
    return li;
}