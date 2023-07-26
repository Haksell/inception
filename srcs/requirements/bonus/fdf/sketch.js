const COLORS = ['crimson', 'dodgerblue', 'lightblue', 'limegreen']
const CELL_SIZE = 15
const CHANGES = 200

let grid = []
let gridWidth
let gridHeight

class Dot {
	constructor() {
		this.color = random(COLORS)
		this.size = random(2, CELL_SIZE)
	}
}

function setup() {
	createCanvas(windowWidth, windowHeight)
	noStroke()

	gridWidth = windowWidth / CELL_SIZE
	gridHeight = windowHeight / CELL_SIZE
	for (let i = 0; i < gridWidth; i++) {
		row = []
		for (let j = 0; j < gridHeight; j++) {
			let rand_color = random(COLORS)
			let rand_size = random(2, CELL_SIZE)
			row.push([rand_color, rand_size])
		}
		grid.push(row)
	}
}

function draw() {
	background('black')
	for (let i = 0; i < width / CELL_SIZE; i++) {
		for (let j = 0; j < height / CELL_SIZE; j++) {
			fill(grid[i][j][0])
			circle((i + 0.5) * CELL_SIZE, (j + 0.5) * CELL_SIZE, grid[i][j][1])
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
