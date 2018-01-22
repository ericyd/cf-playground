import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { DragDropContext } from 'react-dnd';
import HTML5Backend from 'react-dnd-html5-backend';
import BoardSquare from './BoardSquare';
import Knight from './Knight';
import { moveKnight } from 'Game';

class Board extends Component {

	renderPiece(x, y) {
		const [knightX, knightY] = this.props.knightPosition;
		if (x === knightX && y === knightY) {
			return <Knight />;
		}
	}

	renderSquare(i) {
		const x = i % 8;
		const y = Math.floor(i / 8);

		return (
			<div
				key={i}
				style={{
					width: '12.5%',
					height: '12.5%'
				}}
			>
				<BoardSquare x={x} y={y}>
					{this.renderPiece(x, y)}
				</BoardSquare>
			</div>
		)
	}

	handleSquareClick(toX, toY) {
		moveKnight(toX, toY);
	}

	render() {
		const squares = Array.apply(null, {length: 64}).map((_, i) => this.renderSquare(i))
		return (
			<div style={{
				width: '100%',
				height: '100%',
				display: 'flex',
				flexWrap: 'wrap'
			}}>
				{squares}
			</div>
		)
	}
}

Board.propTypes = {
	knightPosition: PropTypes.arrayOf(
		PropTypes.number.isRequired
	).isRequired
};

export default DragDropContext(HTML5Backend)(Board);