// how effective is testing functions that alter the dom (e.g. with jQuery)?

// if the module has no dependencies, the above pattern can be simplified to
(function (root, factory) {
    if (typeof define === 'function' && define.amd) {
        // AMD. Register as an anonymous module.
        define([], factory);
    } else if (typeof module === 'object' && module.exports) {
        // Node. Does not work with strict CommonJS, but
        // only CommonJS-like environments that support module.exports,
        // like Node.
        module.exports = factory();
    } else {
        // Browser globals (root is window)
        root.testDOM = factory();
  }
}(typeof self !== 'undefined' ? self : this, function () {

	function myFunc() {
		return 3;
	}

	function incrementGlobal() {
		myGlobal++;
	}

	function getPageTitle() {
		return $('title').text();
	}

	// Just return a value to define the module export.
	// This example returns an object, but the module
	// can return a function as the exported value.
	// these will all exist under the namespace `myModuleName`
	return {
		myFunc: myFunc,
		incrementGlobal: incrementGlobal,
		getPageTitle: getPageTitle
	};
}));