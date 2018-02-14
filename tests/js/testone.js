const chai = require('chai');
const expect = chai.expect;

describe('my first suite', function() {
	it('should be stuff', function() {
		expect(1).to.not.equal(2);
		expect(true).to.equal(true);
		expect('mystring').to.equal('mystring');
		expect(4).to.be.at.least(3);
	})
})