/* Click handlers for sidebar buttons
**************************************/

// equivalent to $(document).ready(function() {...})
function ready(fn) {
    if (document.attachEvent ? document.readyState === "complete" : document.readyState !== "loading"){
        fn();
    } else {
        document.addEventListener('DOMContentLoaded', fn);
    }
}


/* Error handling
**************************************/
function handleError(err) {
    console.log(err)
    alert(err);
}