
function Slider(range, start, connect) {
	this.values = [];
	
	this.slider = document.createElement('div');
	this.slider.id = 'slider-color';
	//this.slider.style.margin = '0 auto 30px';
	document.body.appendChild(this.slider);

	noUiSlider.create(this.slider, {
		'start': start,
		'connect': connect,
		'range': range
	});

	var connect = this.slider.querySelectorAll('.noUi-connect');
	var classes = ['c-1-color', 'c-2-color', 'c-3-color', 'c-4-color', 'c-5-color'];

	for(var i = 0; i < connect.length; i++ ) {
		connect[i].classList.add(classes[i]);
	}
	
	this.callback = ahk_func

	this.slider.noUiSlider.on('update', (function(values, handle) {
		this.values = values;
		this.callback(values);
	}).bind(this));
}