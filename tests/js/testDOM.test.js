// must define globals (e.g. document, jquery) that are depended on by the module under test
const cheerio = require('cheerio');
const fs = require('fs');
const path = require('path');
const expect = require('chai').expect;
const myHTML = fs.readFileSync(path.resolve(__dirname, 'mockPages/samplePage1.html')).toString();
global.$ = cheerio.load(myHTML);
global.myGlobal = 1;

// define module under test
const testDOM = require('../../assets/js/testDOM');

// test suite
describe('testDOM', function() {
	it('should do something', function() {
		const actual = testDOM.myFunc();
		const expected = 3;
		expect(actual).to.equal(actual);
	});

	it('should alter globals', function() {
		testDOM.incrementGlobal();
		const expected = 2;
		expect(myGlobal).to.equal(expected);
	});

	it('should get page title', function() {
		const actual = testDOM.getPageTitle();
		const expected = 'my page title';
		expect(actual).to.equal(expected);
	})
})