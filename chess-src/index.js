import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';
import { observe } from './Game';


observe(knightPosition =>
	ReactDOM.render(
		<App knightPosition={knightPosition}/>,
		document.getElementById('root')
	)
);