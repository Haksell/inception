const CELL_SIZE = 13
const CHANGES = 30
const COLORS = ['crimson', 'dodgerblue', 'lightblue', 'limegreen']

var grid = []

function setup() {
	createCanvas(windowWidth, windowHeight)
	noStroke()

	for (let i = 0; i < windowWidth / CELL_SIZE; i++) {
		row = []
		for (let j = 0; j < windowHeight / CELL_SIZE; j++) {
			let rand_color = random(COLORS)
			let rand_size = random(2, CELL_SIZE)
			row.push([rand_color, rand_size])
		}
		grid.push(row)
	}
}

function draw() {
	background('black')
	for (let i = 0; i < windowWidth / CELL_SIZE; i++) {
		for (let j = 0; j < windowHeight / CELL_SIZE; j++) {
			fill(grid[i][j][0])
			circle(
				i * CELL_SIZE + CELL_SIZE / 2,
				j * CELL_SIZE + CELL_SIZE / 2,
				grid[i][j][1]
			)
		}
	}
	for (var i = 0; i < CHANGES; i++) {
		let rand_color = random(COLORS)
		let rand_size = random(2, CELL_SIZE)
		grid[int(random(grid.length))][int(random(grid[0].length))] = [
			rand_color,
			rand_size,
		]
	}
}

function windowResized() {
	resizeCanvas(windowWidth, windowHeight)
}
