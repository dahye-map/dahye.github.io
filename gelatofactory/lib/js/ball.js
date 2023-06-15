/*
 * File       : js/jt-ball.js
 * Author     : STUDIO-JT (NICO)
 * Guideline  : JTstyle.2.0 custom (Add Mrdoob camel style)
 *
 * Ref  : https://mrdoob.com/projects/chromeexperiments/ball-pool/
 * Todo : Convert to object pattern + Add requestAnimationFrame
 *
 * SUMMARY:
 * 1) SET GLOBAL
 * 2) RUN
 * 3) INIT
 * 4) REQUEST ANIMATION
 * 5) MOUSE EVENTSL
 * 6) CREATE BOX2D SHAPES
 * 7) THE LOOP
 * 8) UTILITY
 *
 * OPTIONS:
 *
 * Data attributes option api
 * 1) debug_mode           : data-debug="0"   // show mouse for �붾쾭源�
 * 2) Fall down            : data-fall="1"    // �⑥뼱吏��� 紐⑤뱶
 * 3) Number               : data-num="6"     // 珥덇린 怨� ��
 * 3) Small screen number  : data-sm-num="4"  // 珥덇린 怨� �� small screen
 * 4) Max number           : data-max="40"    // 理쒕� 怨� ��
 * 4) Small screen Max num : data-sm-max="15"    // 理쒕� 怨� ��
 *
 * Gobal Helper
 * JtBall_destroy(); // Clear interval and physic world
 *
 */
(function($){


window.JtBall = function(){

if (!document.getElementById('jt_ball')) return;

/* **************************************** */
/* SET GLOBAL */
/* **************************************** */
var canvas = null;
var main = null;
var pageHeight = 0;
var delta = [ 0, 0 ];
var stage = [];
var worldAABB, world, iterations = 1;
var timeStep = 1 / 15;
var bodies, elements, text,bigBall;
var createMode = false;
var destroyMode = false;
var isMouseDown = false;
var mouseJoint;
var mouse = { x: 0, y: 0 };
var gravity = { x: 0, y: 1 };
var mouseBody = null;
var walls = [];
var wall_thickness = 200;
var wallsSetted = false;
var timeOfLastTouch = 0;
var ball_count = 0;
var loop_interval;
var is_mobile = $('html').hasClass('mobile');

// Options
var debug_mode, fall, ball_init_num,ball_init_num_small_screen, ball_max, ball_max_small_screen,inview;

// Constant
var PI2 = Math.PI * 2;


if(JT.is_screen(768)){
    ball_init_num = ball_init_num_small_screen;
	ball_max = ball_max_small_screen;
}

init()
run();



/* **************************************** */
/* RUN */
/* **************************************** */
function run() {

	// get dimension on run (required for barbajs)
	canvas = document.getElementById('jt_ball');
	main = document.getElementById('main');
	pageHeight = main.offsetHeight; // TODO : try remove main id (currently padding issue)
	stage = [ window.screenX, window.screenY, window.innerWidth, parseInt(pageHeight) ];

	// Options
	debug_mode = 0;
	fall = 1;
	ball_init_num = 6;
	ball_init_num_small_screen = 4;
	ball_max = 40;
	ball_max_small_screen = 15;
	inview = get_data_attr('inview',0);

    // run the fun
	init();
	setWalls();

	if(inview == 1){
	    $('#jt_ball_inview').waypoint(function(direction) {
            play();
			this.destroy();
		}, {
			offset: '100%'
		});
	}else{
	    play();
	}


}



/* **************************************** */
/* INIT */
/* **************************************** */
function init() {

	// Init events
	$('main').on( 'mousemove', onDocumentMouseMove);
	$('main').on( 'click', onDocumentClick);

	$(window).on( 'deviceorientation', onWindowDeviceOrientation);

	// orientationchange on mobile to debug admin bar triggered resize event
	if($('html').hasClass('mobile')){
	    $(window).on('orientationchange',onWindowResize);
	}else{
	    $(window).on( 'resize', onWindowResize);
	}

	// init box2d
	worldAABB = new b2AABB();
	worldAABB.minVertex.Set( -200, -200 );
	worldAABB.maxVertex.Set( window.innerWidth + 200, 99999 );

	world = new b2World( worldAABB, new b2Vec2( 0, 0 ), true );

	setWalls();

	// Reload
	reset();

}



/* **************************************** */
/* REQUEST ANIMATION */
/* **************************************** */
function play() {

	//requestAnimationFrame(loop);
	setInterval( loop, 1000 / 40 );

}



/* **************************************** */
/* MOUSE EVENTS */
/* **************************************** */

// MOUSE CLICK
function onDocumentClick(e) {

	var $target = $(e.target)

	if($target.closest('a, button, input, #global_menu_outer, #global_search_popup').length > 0) return;

	if(inview == "1" && !$target.closest('#jt_ball_inview').length > 0) return;
	//isMouseDown = true;
		mouse.x = e.pageX;
		mouse.y = e.pageY;
	if (!mouseJoint){
		if(ball_count <= (ball_max - ball_init_num)){
			createBall( mouse.x, mouse.y );
			ball_count++;
			//isMouseDown = false;
		}
	}
	return false;

}


// MOUSE MOVE
function onDocumentMouseMove( event ) {

	mouse.x = event.clientX;
	mouse.y = event.clientY + document.body.scrollTop + document.documentElement.scrollTop;

}


// DEVICE ORIENTATION
function onWindowDeviceOrientation( event ) {

	if ( event.beta ) {

		gravity.x = Math.sin( event.gamma * Math.PI / 180 );
		gravity.y = Math.sin( ( Math.PI / 4 ) + event.beta * Math.PI / 180 );

	}

}


// WINDOW RESIZE
function onWindowResize(){
	resize_delay(function(){
		window.JtBall_destroy();
		run();
	}, 250);


}

var resize_delay = (function(){
	var timer = 0;
	return function(callback, ms){
		clearTimeout (timer);
		timer = setTimeout(callback, ms);
	};
})();



/* **************************************** */
/* MOUSE ACTION */
/* **************************************** */
function mouseDrag(){
	// mouse press
	if (createMode) {

		//setTimeout(function(){
			//createMode = false;
		//},100)

	} else if (isMouseDown && !mouseJoint) {

		var body = getBodyAtMouse();

		if (body) {

			var md = new b2MouseJointDef();
			md.body1 = world.m_groundBody;
			md.body2 = body;
			md.target.Set(mouse.x, mouse.y);
			md.maxForce = 30000 * body.m_mass;
			// md.timeStep = timeStep;
			mouseJoint = world.CreateJoint(md);
			body.WakeUp();

		} else {

			createMode = true;

		}

	}

	// mouse release
	if (!isMouseDown) {

		createMode = false;
		destroyMode = false;

		if (mouseJoint) {

			world.DestroyJoint(mouseJoint);
			mouseJoint = null;

		}

	}

	// mouse move
	if (mouseJoint) {

		var p2 = new b2Vec2(mouse.x, mouse.y);
		mouseJoint.SetTarget(p2);
	}

	// mouse move
	if(!is_mobile){
		bigBall.WakeUp();
		var p2 = new b2Vec2(mouse.x, mouse.y);
		bigBallMouseJoint.SetTarget(p2);
	}

}



/* **************************************** */
/* CREATE BOX2D SHAPES */
/* **************************************** */

// MOUSE INVISIBLE BALL
function createMouse() {

    if(is_mobile) return;

	var size = 80;

	if(debug_mode){

		var element = document.createElement( 'div' );

		element.width = size;
		element.height = size;
		element.style.position = 'absolute';
		element.style.left = -200 + 'px';
		element.style.top = -200 + 'px';
		element.style.cursor = "default";

		canvas.appendChild(element);
		elements.push( element );

		var circle = document.createElement( 'canvas' );
		circle.width = size;
		circle.height = size;

		var graphics = circle.getContext( '2d' );

		graphics.fillStyle = '#ff0000';
		graphics.beginPath();
		graphics.arc( size * .5, size * .5, size * .5, 0, PI2, true );
		graphics.closePath();
		graphics.fill();

		element.appendChild( circle );

	}

	var b2body = new b2BodyDef();

	var circle = new b2CircleDef();
	circle.radius = size / 2;
	circle.density = 1;
	circle.friction = 0.3;
	circle.restitution = 0.3;
	b2body.AddShape(circle);

	if(debug_mode){
		b2body.userData = {element: element};
	}

	b2body.position.Set(mouse.x, mouse.y );
	b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );

	if(!is_mobile){
		bigBall = world.CreateBody(b2body)

		if(debug_mode){
			bodies.push( bigBall );
		}

		// Attache to the mouse
		var md = new b2MouseJointDef();
		md.body1 = world.m_groundBody;
		md.body2 = bigBall;
		md.target.Set(mouse.x, mouse.y);
		md.maxForce = 30000 * bigBall.m_mass;

		bigBallMouseJoint = world.CreateJoint(md);
	}


}


// CREATE BALL
function createBall( x, y ) {

	if(canvas === null) return;

	var default_y = pageHeight-200;

	if(inview == 1){
	   default_y = $('#jt_ball_inview').offset().top - (Math.random() * -200);
	}else if(fall == 1){
	   default_y = (Math.random() * -200);
	}

	var x = x || Math.random() * stage[2];
	var y = y || default_y; // -200

	var size = 114; // (Math.random() * 100 >> 0) + 20;
	if(JT.is_screen(768)){
	    size = 70;
	}

	var element = document.createElement("span");
	element.width = size;
	element.height = size;
	element.style.position = 'absolute';
	element.style.left = -200 + 'px';
	element.style.top = -200 + 'px';
	element.style.width = size + 'px';
	element.style.height = size + 'px';
	element.style.WebkitTransform = 'translateZ(0)';
	element.style.MozTransform = 'translateZ(0)';
	element.style.OTransform = 'translateZ(0)';
	element.style.msTransform = 'translateZ(0)';
	element.style.transform = 'translateZ(0)';

	canvas.appendChild(element);

	elements.push( element );

	var b2body = new b2BodyDef();

	var circle = new b2CircleDef();
	circle.radius = size >> 1;
	circle.density = 1;
	circle.friction = 0.3;
	circle.restitution = 0.3;
	b2body.AddShape(circle);
	b2body.userData = {element: element};

	b2body.position.Set( x, y );
	b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );
	bodies.push( world.CreateBody(b2body) );
}


// SET WALLS
function setWalls() {

	pageHeight = main.offsetHeight; // TODO : try remove main id (currently padding issue)
	stage = [ window.screenX, window.screenY, window.innerWidth, parseInt(pageHeight) ];

	if (wallsSetted) {

		world.DestroyBody(walls[0]);
		world.DestroyBody(walls[1]);
		world.DestroyBody(walls[2]);
		world.DestroyBody(walls[3]);

		walls[0] = null;
		walls[1] = null;
		walls[2] = null;
		walls[3] = null;
	}

    //createBox(world, x, y, width, height, fixed)
	walls[0] = createBox(world, stage[2] / 2, - wall_thickness, stage[2], wall_thickness);
	walls[1] = createBox(world, stage[2] / 2, stage[3] + wall_thickness, stage[2], wall_thickness);
	walls[2] = createBox(world, - wall_thickness, stage[3] / 2, wall_thickness, stage[3]);
	walls[3] = createBox(world, stage[2] + wall_thickness, stage[3] / 2, wall_thickness, stage[3]);

	wallsSetted = true;

}



/* **************************************** */
/* THE LOOP */
/* **************************************** */
function loop() {

	delta[0] += (0 - delta[0]) * .5;
	delta[1] += (0 - delta[1]) * .5;

	world.m_gravity.x = gravity.x * 80 + delta[0]; //350
	world.m_gravity.y = gravity.y * 80 + delta[1]; //350

	mouseDrag();
	world.Step(timeStep, iterations);

	for (i = 0; i < bodies.length; i++) {

		var body = bodies[i];
		var element = elements[i];

		// Update balls position
		element.style.left = (body.m_position0.x - (element.width >> 1)) + 'px';
		element.style.top = (body.m_position0.y - (element.height >> 1)) + 'px';

		var style = 'rotate(' + (body.m_rotation0 * 57.2957795) + 'deg) translateZ(0)';
		element.style.WebkitTransform = style;
		element.style.MozTransform = style;
		element.style.OTransform = style;
		element.style.msTransform = style;
		element.style.transform = style;

	}

}


/* **************************************** */
/* UTILITY */
/* **************************************** */

// RESET
function reset() {

	var i;

	if ( bodies ) {

		for ( i = 0; i < bodies.length; i++ ) {

			var body = bodies[ i ]
			canvas.removeChild( body.GetUserData().element );
			world.DestroyBody( body );
			body = null;
		}
	}


	bodies = [];
	elements = [];

	createMouse();


	for( i = 0; i < ball_init_num; i++ ) {

		createBall();

	}

}



// CREATE BOX
function createBox(world, x, y, width, height, fixed) {

	if (typeof(fixed) == 'undefined') {

		fixed = true;

	}

	var boxSd = new b2BoxDef();

	if (!fixed) {

		boxSd.density = 1.0;

	}

	boxSd.extents.Set(width, height);

	var boxBd = new b2BodyDef();
	boxBd.AddShape(boxSd);
	boxBd.position.Set(x,y);

	return world.CreateBody(boxBd);

}


// GET BODY ON CLICK
function getBodyAtMouse() {

	// Make a small box.
	var mousePVec = new b2Vec2();
	mousePVec.Set(mouse.x, mouse.y);

	var aabb = new b2AABB();
	aabb.minVertex.Set(mouse.x - 1, mouse.y - 1);
	aabb.maxVertex.Set(mouse.x + 1, mouse.y + 1);

	// Query the world for overlapping shapes.
	var k_maxCount = 10;
	var shapes = new Array();
	var count = world.Query(aabb, shapes, k_maxCount);
	var body = null;

	for (var i = 0; i < count; ++i) {

		if (shapes[i].m_body.IsStatic() == false) {

			if ( shapes[i].TestPoint(mousePVec) ) {

				body = shapes[i].m_body;
				break;

			}

		}

	}

	return body;

}




// Get data attribut or set default if not exist
function get_data_attr(data_key, default_val){

	if(typeof $(canvas).data(data_key) == "undefined"){
		return default_val;
	}else{
		return $(canvas).data(data_key);
	}

}




/* **************************************** */
/* API */
/* **************************************** */
window.JtBall_destroy = function(){

	// Clear body
	if ( bodies ) {

		for ( i = 0; i < bodies.length; i++ ) {

			var body = bodies[ i ]
			canvas.removeChild( body.GetUserData().element );
			world.DestroyBody( body );
			body = null;
		}
	}
	bodies = [];
	elements = [];

	// Clear canvas
	canvas = null
    // clear event
	$('main').off( 'mousemove', onDocumentMouseMove);
	$('main').off( 'click', onDocumentClick);

	$(window).off( 'deviceorientation', onWindowDeviceOrientation);
	$(window).off( 'resize', onWindowResize);

	// destroy loop
	//cancelAnimationFrame(loop);
	clearInterval(loop_interval);

}


window.JtBall_setwalls = function(){

	setWalls();

}




} // END JtBall

})(jQuery);
