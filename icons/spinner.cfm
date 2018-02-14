<!--- To find the center of a circle with two know points and a known radius:

NOTE: This is obviously not the fastest way to approach this problem - calculating on the fly - 
but it is perfectly fine for this circumstance.  The way I would want to handle this in real life is render this SVG then just copy the outer HTML
from dev tools.


q = sqrt((x2-x1)^2 + (y2-y1)^2)
x3 = (x1+x2)/2
y3 = (y1+y2)/2

first circle:

x = x3 + sqrt(r^2-(q/2)^2)*(y1-y2)/q
y = y3 + sqrt(r^2-(q/2)^2)*(x2-x1)/q  

Second Circle:

x = x3 - sqrt(r^2-(q/2)^2)*(y1-y2)/q
y = y3 - sqrt(r^2-(q/2)^2)*(x2-x1)/q   


// In javascript-speak
var x1, x2, y1, y2, x3, y3, q, x, y, r;

r = 50
x1 = 35
dx = 0;
y1 = 35
dy = 0;
x2 = x1 + 20
y2 = y1 - 20
q = Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2))
x3 = (x1+x2)/2
y3 = (y1+y2)/2

// first circle:

x = x3 + Math.sqrt(Math.pow(r,2)-Math.pow(q/2,2))*(y1-y2)/q
y = y3 + Math.sqrt(Math.pow(r,2)-Math.pow(q/2,2))*(x2-x1)/q  

console.log('first circle: ', x, y)
console.log('required offset (assuming 100x100 viewbox): ', 100 - x, 100 - y)

// Second Circle:

// x = x3 - Math.sqrt(Math.pow(r,2)-Math.pow(q/2,2))*(y1-y2)/q
// y = y3 - Math.sqrt(Math.pow(r,2)-Math.pow(q/2,2))*(x2-x1)/q  

// console.log('second circle: ', x, y)

--->

<cfscript>
viewbox = 100;
r = 55; // radius
x1 = 30;
dx = 20;
y1 = 30;
dy = -20;
x2 = x1 + dx;
y2 = y1 + dy;


q = ((x2-x1)^2 + (y2-y1)^2)^(1/2);
x3 = (x1+x2)/2;
y3 = (y1+y2)/2;

// first circle:

x = x3 + ((r^2-(q/2)^2)^(1/2))*(y1-y2)/q;
y = y3 + ((r^2-(q/2)^2)^(1/2))*(x2-x1)/q;

// Second Circle:
// x = x3 - (r^2-(q/2)^2)^(1/2)*(y1-y2)/q
// y = y3 - (r^2-(q/2)^2)^(1/2)*(x2-x1)/q  

offsetx = viewbox / 2 - x;
offsety = viewbox / 2 - y;
</cfscript>

<cfoutput>
    <svg width="1em" height="1em" viewBox="0 0 #viewbox# #viewbox#" class="spinner btn--icon">
        <svg x="#offsetx#" y="#offsety#">
            <path d='M#x1# #y1# a#r# #r# 0 1 0 #dx# #dy#' stroke-width='3px' stroke="##000" fill="none"/>
            <!--- And this will "fill" the missing section of the arc -- flags are 1 0 1 instead of 0 1 0--->
            <!--- <path d='M#x1# #y1# a#r# #r# 1 0 1 #dx# #dy#' stroke-width='10px' stroke="##888" fill="none"/> --->
        </svg>
    </svg>
</cfoutput>