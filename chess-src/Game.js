let knightPosition = [0, 0];
let observer = null;

function emitChange() {
	observer(knightPosition);
}

export function observe(o) {
	if (observer) {
		throw new Error('Multiple observers not supported');
	}

	observer = o;
	emitChange();
}

export function moveKnight(toX, toY) {
	knightPosition = [toX, toY];
	emitChange();
}

export function canMoveKnight(squareX, squareY) {
	const [knightX, knightY] = knightPosition;
	return (
		Math.abs(squareX - knightX) == 2 && Math.abs(squareY - knightY) == 1 ||
		Math.abs(squareX - knightX) == 1 && Math.abs(squareY - knightY) == 2
	)
}