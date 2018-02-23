function Slider(range, start, connect) {
	this.values = [];
	
	this.slider = document.createElement('div');
	this.slider.id = 'slider-color';
	document.body.appendChild(this.slider);

	noUiSlider.create(this.slider, {
		'start': start,
		'connect': connect,
		'range': range,
		'behaviour': 'tap-drag' // Move handle on tap, bar is draggable
	});

	this.connect = this.slider.querySelectorAll('.noUi-connect');
	
	for(var i = 0; i < this.connect.length; i++ ) {
		this.connect[i].style.background = "#F0F0F0";
	}
	
	this.callback = ahk_func

	this.slider.noUiSlider.on('update', (function(values, handle) {
		this.values = values;
		this.callback(values);
	}).bind(this));
}

function Slider2() {
	this.values = [];
	
	this.slider = document.createElement('div');
	this.slider.id = 'slider-color';
	this.slider.style.height = '100%';
	this.slider.style.margin = '10px 100px 10px 100px';
	document.body.appendChild(this.slider);

	noUiSlider.create(this.slider, {
		start: [ 1450, 2050, 2350, 3000 ], // 4 handles, starting at...
		margin: 300, // Handles must be at least 300 apart
		limit: 600, // ... but no more than 600
		connect: true, // Display a colored bar between the handles
		direction: 'rtl', // Put '0' at the bottom of the slider
		orientation: 'vertical', // Orient the slider vertically
		behaviour: 'tap-drag', // Move handle on tap, bar is draggable
		step: 150,
		tooltips: true,
		range: {
			'min': 1300,
			'max': 3250
		},
		pips: { // Show a scale with the slider
			mode: 'steps',
			stepped: true,
			density: 4
		}
	});

	//this.connect = this.slider.querySelectorAll('.noUi-connect');
	
	//for(var i = 0; i < this.connect.length; i++ ) {
	//	this.connect[i].style.background = "#F0F0F0";
	//}
	
	//this.callback = ahk_func

	//this.slider.noUiSlider.on('update', (function(values, handle) {
	//	this.values = values;
	//	this.callback(values);
	//}).bind(this));
}
