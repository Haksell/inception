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
			row.push(new Dot())
		}
		grid.push(row)
	}
}

function draw() {
	background('black')
	for (let i = 0; i < width / CELL_SIZE; i++) {
		for (let j = 0; j < height / CELL_SIZE; j++) {
			const dot = grid[i][j]
			fill(grid[i][j].color)
			circle(
				(i + 0.5) * CELL_SIZE,
				(j + 0.5) * CELL_SIZE,
				grid[i][j].size
			)
		}
	}
	for (let i = 0; i < CHANGES; i++) {
		grid[int(random(grid.length))][int(random(grid[0].length))] = new Dot()
	}
}
