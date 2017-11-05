// Nodelist.prototype.foreach
if (window.NodeList && !NodeList.prototype.forEach) {
    NodeList.prototype.forEach = function (callback, thisArg) {
        thisArg = thisArg || window;
        for (var i = 0; i < this.length; i++) {
            callback.call(thisArg, this[i], i, this);
        }
    };
}

// Element.prototype.replaceWith
// CharacterData.prototype.replaceWith
// DocumentType.prototype.replaceWith

// this actually still doesn't work with IE 11 ...
function ReplaceWith(Ele) {
    'use-strict'; // For safari, and IE > 10
    var parent = this.parentNode,
        i = arguments.length,
        firstIsNode = +(parent && typeof Ele === 'object');
    if (!parent) return;

    while (i-- > firstIsNode){
        if (parent && typeof arguments[i] !== 'object'){
            arguments[i] = document.createTextNode(arguments[i]);
        } 
        if (!parent && arguments[i].parentNode){
            arguments[i].parentNode.removeChild(arguments[i]);
            continue;
        }
        parent.insertBefore(this.previousSibling, arguments[i]);
    }
    if (firstIsNode) parent.replaceChild(this, Ele);
}
if (!Element.prototype.replaceWith)
    Element.prototype.replaceWith = ReplaceWith;
if (!CharacterData.prototype.replaceWith)
    CharacterData.prototype.replaceWith = ReplaceWith;
if (!DocumentType.prototype.replaceWith) 
    CharacterData.prototype.replaceWith = ReplaceWith;