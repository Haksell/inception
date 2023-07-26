const COLORS = ['crimson', 'dodgerblue', 'lightblue', 'limegreen']
const CELL_SIZE = 15
const ACTIVITY = 0.001

let grid = [[]]
let drawAll = true

class Dot {
	constructor() {
		this.color = random(COLORS)
		this.size = random(2, CELL_SIZE)
	}

	draw(x, y) {
		fill('black')
		square(x * CELL_SIZE, y * CELL_SIZE, CELL_SIZE)
		fill(grid[y][x].color)
		circle((x + 0.5) * CELL_SIZE, (y + 0.5) * CELL_SIZE, grid[y][x].size)
	}
}

const resizeGrid = () => {
	const newGridHeight = Math.max(1, Math.ceil(windowHeight / CELL_SIZE))
	const newGridWidth = Math.max(1, Math.ceil(windowWidth / CELL_SIZE))
	grid = Array.from({ length: newGridHeight }, (_, y) =>
		Array.from({ length: newGridWidth }, (_, x) =>
			y < grid.length && x < grid[y].length ? grid[y][x] : new Dot()
		)
	)
	resizeCanvas(windowWidth, windowHeight)
	drawAll = true
}

function setup() {
	createCanvas(windowWidth, windowHeight)
	noStroke()
	resizeGrid()
}

function draw() {
	if (drawAll) {
		for (let y = 0; y < grid.length; y++) {
			for (let x = 0; x < grid[y].length; x++) {
				grid[y][x].draw(x, y)
			}
		}
		drawAll = false
	}
	const changes = int(deltaTime * grid.length * grid[0].length * ACTIVITY)
	for (let i = 0; i < changes; ++i) {
		const y = int(random(grid.length))
		const x = int(random(grid[y].length))
		grid[y][x] = new Dot()
		grid[y][x].draw(x, y)
	}
}

function windowResized() {
	resizeGrid()
}
