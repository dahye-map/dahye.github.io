$('.new-item-wrap .item-list .item').mouseover(function(){
    //$('.new-item-wrap .item-list .item .black-cover').fadeOut(200);
	$(this).find('.black-cover').fadeIn(200);
});
$('.new-item-wrap .item-list .item').mouseleave(function(){
    //$('.new-item-wrap .item-list .item .black-cover').fadeOut(200);
	$(this).find('.black-cover').fadeOut(200);
});


$(window).scroll(function(){
	var w_scroll = $(window).scrollTop();
	var detail_top = $('.detail_section').offset().top;
	if(w_scroll >= detail_top) {
		$('.detail-fixed-list').addClass('active');
	} else {
		$('.detail-fixed-list').removeClass('active');
	}
});

$('.gnb-wrap > ul > li > a').mouseover(function(){
	$(this).siblings('.depth2').stop().slideDown();
});
$('.gnb-wrap > ul > li > a').mouseleave(function(){
	$(this).siblings('.depth2').stop().slideUp();
});


$(window).load(function(){
	// 동그라미 인터랙션
	var canvas;

	var delta = [ 0, 0 ];
	var stage = [ window.screenX, window.screenY, window.innerWidth, document.innerHeight ];
	getBrowserDimensions();

	var themes = [ [ "#fff" ]];
	var theme;

	var worldAABB, world, iterations = 1, timeStep = 1 / 15;

	var walls = [];
	var wall_thickness = 200;
	var wallsSetted = false;

	var bodies, elements, text;

	var createMode = false;
	var destroyMode = false;

	var isMouseDown = false;
	var mouseJoint;
	var mouse = { x: 0, y: 0 };
	var gravity = { x: 0, y: 1 };

	var PI2 = Math.PI * 2;

	var timeOfLastTouch = 0;

	var inview = $('#main').attr("data-inview");
	// console.log(inview);
	init();
	setWalls();
	if(inview == 1){
		$('.brand-wrap').waypoint(function(direction) {
			console.log('ddddd')
			play();
			this.destroy();
		}, {
			offset: '100%'
		});
		// var waypoint = new Waypoint({
		//   element: document.getElementById('brand-wrap'),
		//   handler: function(direction) {
		//     play();
		// 	this.destroy();
		//   },
		//   offset: '100%'
		// })
	} else {
		play();
	}


	function init() {

		canvas = document.getElementById( 'canvas' );
		//
		// document.onmousedown = onDocumentMouseDown;
		// document.onmouseup = onDocumentMouseUp;
		// document.onmousemove = onDocumentMouseMove;
		// document.ondblclick = onDocumentDoubleClick;

		// document.addEventListener( 'touchstart', onDocumentTouchStart, false );
		// document.addEventListener( 'touchmove', onDocumentTouchMove, false );
		// document.addEventListener( 'touchend', onDocumentTouchEnd, false );

		window.addEventListener( 'deviceorientation', onWindowDeviceOrientation, false );

		// init box2d

		worldAABB = new b2AABB();
		worldAABB.minVertex.Set( -200, -200 );
		worldAABB.maxVertex.Set( window.innerWidth + 200, 99999 );

		world = new b2World( worldAABB, new b2Vec2( 0, 0 ), true );

		setWalls();
		reset();
	}

	function play() {

		setInterval( loop, 1000 / 40 );
	}

	function onWindowDeviceOrientation( event ) {

		if ( event.beta ) {

			gravity.x = Math.sin( event.gamma * Math.PI / 180 );
			gravity.y = Math.sin( ( Math.PI / 4 ) + event.beta * Math.PI / 180 );

		}

	}

	function createInstructions( x, y ) {

		var default_y = pageHeight-200;
		if(inview == 1){
		   default_y = $('.brand-wrap').offset().top;
		}

		var x = x || Math.random() * stage[2];
		var y = y || default_y; // -200

		var size = 126;

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

		//큰 동그라미
		graphics.fillStyle = '#00ff0000';
		graphics.beginPath();
		graphics.arc( size * .5, size * .5, size * .5, 0, PI2, true );
		graphics.closePath();
		graphics.fill();

		element.appendChild( circle );

		text = document.createElement( 'div' );
		text.onSelectStart = null;
		text.innerHTML = '<span class="custom"></span>';
		text.style.color = theme[1];
		text.style.position = 'absolute';
		text.style.left = '0px';
		text.style.top = '0px';
		text.style.fontFamily = 'Georgia';
		text.style.textAlign = 'center';
		element.appendChild(text);

		text.style.left = ((126 - text.clientWidth) / 2) +'px';
		text.style.top = ((126 - text.clientHeight) / 2) +'px';

		var b2body = new b2BodyDef();

		var circle = new b2CircleDef();
		circle.radius = size / 2;
		circle.density = 1;
		circle.friction = 0.3;
		circle.restitution = 0.3;
		b2body.AddShape(circle);
		b2body.userData = {element: element};

		b2body.position.Set( x, y );
		b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );
		bodies.push( world.CreateBody(b2body) );
	}

	function createInstructions2( x, y ) {
		var default_y = pageHeight-200;
		if(inview == 1){
		   default_y = $('.brand-wrap').offset().top;
		}

		var x = x || Math.random() * stage[2];
		var y = y || default_y; // -200

		var size = 126;

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

		//큰 동그라미
		graphics.fillStyle = '#00ff0000';
		graphics.beginPath();
		graphics.arc( size * .5, size * .5, size * .5, 0, PI2, true );
		graphics.closePath();
		graphics.fill();

		element.appendChild( circle );

		text = document.createElement( 'div' );
		text.onSelectStart = null;
		text.innerHTML = '<span class="custom2"></span>';
		text.style.color = theme[1];
		text.style.position = 'absolute';
		text.style.left = '0px';
		text.style.top = '0px';
		text.style.fontFamily = 'Georgia';
		text.style.textAlign = 'center';
		element.appendChild(text);

		text.style.left = ((126 - text.clientWidth) / 2) +'px';
		text.style.top = ((126 - text.clientHeight) / 2) +'px';

		var b2body = new b2BodyDef();

		var circle = new b2CircleDef();
		circle.radius = size / 2;
		circle.density = 1;
		circle.friction = 0.3;
		circle.restitution = 0.3;
		b2body.AddShape(circle);
		b2body.userData = {element: element};

		b2body.position.Set( x, y );
		b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );
		bodies.push( world.CreateBody(b2body) );
	}

	function createInstructions3( x, y ) {
		var default_y = pageHeight-200;
		if(inview == 1){
		   default_y = $('.brand-wrap').offset().top;
		}

		var x = x || Math.random() * stage[2];
		var y = y || default_y; // -200

		var size = 110;

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

		//큰 동그라미
		graphics.fillStyle = '#00ff0000';
		graphics.beginPath();
		graphics.arc( size * .5, size * .5, size * .5, 0, PI2, true );
		graphics.closePath();
		graphics.fill();

		element.appendChild( circle );

		text = document.createElement( 'div' );
		text.onSelectStart = null;
		text.innerHTML = '<span class="custom3"></span>';
		text.style.color = theme[1];
		text.style.position = 'absolute';
		text.style.left = '0px';
		text.style.top = '0px';
		text.style.fontFamily = 'Georgia';
		text.style.textAlign = 'center';
		element.appendChild(text);

		text.style.left = ((110 - text.clientWidth) / 2) +'px';
		text.style.top = ((110 - text.clientHeight) / 2) +'px';

		var b2body = new b2BodyDef();

		var circle = new b2CircleDef();
		circle.radius = size / 2;
		circle.density = 1;
		circle.friction = 0.3;
		circle.restitution = 0.3;
		b2body.AddShape(circle);
		b2body.userData = {element: element};

		b2body.position.Set( x, y );
		b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );
		bodies.push( world.CreateBody(b2body) );
	}

	function createInstructions4( x, y ) {
		var default_y = pageHeight-200;
		if(inview == 1){
		   default_y = $('.brand-wrap').offset().top;
		}

		var x = x || Math.random() * stage[2];
		var y = y || default_y; // -200

		var size = 110;

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

		//큰 동그라미
		graphics.fillStyle = '#00ff0000';
		graphics.beginPath();
		graphics.arc( size * .5, size * .5, size * .5, 0, PI2, true );
		graphics.closePath();
		graphics.fill();

		element.appendChild( circle );

		text = document.createElement( 'div' );
		text.onSelectStart = null;
		text.innerHTML = '<span class="custom4"></span>';
		text.style.color = theme[1];
		text.style.position = 'absolute';
		text.style.left = '0px';
		text.style.top = '0px';
		text.style.fontFamily = 'Georgia';
		text.style.textAlign = 'center';
		element.appendChild(text);

		text.style.left = ((110 - text.clientWidth) / 2) +'px';
		text.style.top = ((110 - text.clientHeight) / 2) +'px';

		var b2body = new b2BodyDef();

		var circle = new b2CircleDef();
		circle.radius = size / 2;
		circle.density = 1;
		circle.friction = 0.3;
		circle.restitution = 0.3;
		b2body.AddShape(circle);
		b2body.userData = {element: element};

		b2body.position.Set( x, y );
		b2body.linearVelocity.Set( Math.random() * 400 - 200, Math.random() * 400 - 200 );
		bodies.push( world.CreateBody(b2body) );
	}

	function createBall( x, y ) {

		if(canvas === null) return;

		// var x = x || Math.random() * stage[2];
		// var y = y ||  -200

		var size = 114; // (Math.random() * 100 >> 0) + 20;

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

	function loop() {

		if (getBrowserDimensions()) {

			setWalls();

		}

		delta[0] += (0 - delta[0]) * .5;
		delta[1] += (0 - delta[1]) * .5;

		world.m_gravity.x = gravity.x * 350 + delta[0];
		world.m_gravity.y = gravity.y * 350 + delta[1];

		mouseDrag();
		world.Step(timeStep, iterations);

		for (i = 0; i < bodies.length; i++) {

			var body = bodies[i];
			var element = elements[i];

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

	// .. BOX2D UTILS
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

		// color theme
		theme = themes[ Math.random() * themes.length >> 0 ];
		document.body.style[ 'backgroundColor' ] = theme[ 0 ];

		bodies = [];
		elements = [];

		for( i = 0; i < 1; i++ ) {
			createInstructions();
		}
		for( i = 0; i < 1; i++ ) {
			createInstructions2();
		}
		for( i = 0; i < 2; i++ ) {
			createInstructions3();
		}
		for( i = 0; i < 2; i++ ) {
			createInstructions4();
		}
	}

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

	function mouseDrag() {
		// mouse press
		if (createMode) {

			createBall( mouse.x, mouse.y );

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
	}

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

	function setWalls() {

		pageHeight = $('#main').outerHeight() + 55; // TODO : try remove main id (currently padding issue)
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

		walls[0] = createBox(world, stage[2] / 2, - wall_thickness, stage[2], wall_thickness);
		walls[1] = createBox(world, stage[2] / 2, stage[3] + wall_thickness, stage[2], wall_thickness);
		walls[2] = createBox(world, - wall_thickness, stage[3] / 2, wall_thickness, stage[3]);
		walls[3] = createBox(world, stage[2] + wall_thickness, stage[3] / 2, wall_thickness, stage[3]);

		wallsSetted = true;

	}

	// BROWSER DIMENSIONS
	function getBrowserDimensions() {

		var changed = false;

		if (stage[0] != window.screenX) {

			delta[0] = (window.screenX - stage[0]) * 50;
			stage[0] = window.screenX;
			changed = true;

		}

		if (stage[1] != window.screenY) {

			delta[1] = (window.screenY - stage[1]) * 50;
			stage[1] = window.screenY;
			changed = true;

		}

		if (stage[2] != window.innerWidth) {

			stage[2] = window.innerWidth;
			changed = true;

		}

		if (stage[3] != window.innerHeight) {

			stage[3] = window.innerHeight;
			changed = true;

		}

		return changed;

	}

});
