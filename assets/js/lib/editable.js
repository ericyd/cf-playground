/* Initialize markdown renderer
****************************************/
var md = window.markdownit();

// render markdown for content
function renderContent(element, string) {
    var result = md.render(string);
    element.innerHTML = result;
}

function replaceWithEditable(e, queryString) {
    // set default query string
    var queryString = queryString || '[data-editable]';

    // swap elements, then put focus on first matching element
    swapElements(e, true, queryString);
    document.querySelector(queryString).focus();
}

function replaceWithReadonly(e, queryString) {
    swapElements(e, false, queryString);
}

var elementMap = {
    "P": "textarea",
    "TEXTAREA": "p",
    "SPAN": "input",
    "INPUT": "span"
    // "BUTTON": "input",
    // "INPUT": "button",
};

/**
 * swap elements from read-only to editable, and vice-versa
 * @param {boolean} editing true when the elements should be swapped with inputs
 */
function swapElements(e, editing, queryString) {
    var queryString = queryString || '[data-editable]';

    document.querySelectorAll(queryString).forEach(function(oldEl) {
        var newEl = document.createElement(elementMap[oldEl.tagName]);
        // content needs some special attention since it is a textarea/markdown content vs. straight text
        if (oldEl.id === 'file-content') {
            newEl.classList.add('doc-preview__content');
            if (editing) {
                newEl.rows = 20;
                newEl.cols = 100;
                newEl.value = newEl.dataset.raw = oldEl.dataset.raw;
            } else {
                // save raw value to data-content so it is more easily retrievable later (e.g. cancelling)
                newEl.dataset.raw = oldEl.value;
                renderContent(newEl, oldEl.value);
            }
        } else {
            if (editing) {
                newEl.value = newEl.dataset.raw = oldEl.dataset.raw;
            } else {
                newEl.innerText = newEl.dataset.raw = oldEl.value;
            }
        }

        // copy classlist
        for (i = 0; i < oldEl.classList.length; i++) {
            newEl.classList.add(oldEl.classList[i]);
        }

        newEl.id = oldEl.id;
        newEl.dataset.editable = true;
        oldEl.replaceWith(newEl);
    });

    // toggle button displays

    // are we editing a file?
    if (queryString == '[data-editable]') {
        document.querySelector('.saveFile').style.display = editing ? 'inline' : 'none';
        document.querySelector('.editFile').style.display = editing ? 'none' : 'inline';
    }
    // or a topic?
    else {
        if (editing) {
            document.querySelector('.saveTopic' + e.target.dataset.fileId).classList.remove('hide');
            document.querySelector('.editTopic' + e.target.dataset.fileId).classList.add('hide');
        } else {
            document.querySelector('.saveTopic' + e.target.dataset.fileId).classList.add('hide');
            document.querySelector('.editTopic' + e.target.dataset.fileId).classList.remove('hide');
        }
    }
}