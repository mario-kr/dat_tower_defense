class Tower
    constructor: (x, y)->


class BaseTower extends Tower


class Checkpoint extends iio.Obj
    constructor: (x, y)->
        this.setPos(x, y)


class Game
    constructor: (io)->
        this.createGrid(io)
        this.setupGrid(io)
        io.setFramerate(60)


    createGrid: (io)->
        this.grid = new iio.Grid(0,0,50,30,20)
                        .setStrokeStyle("rgba(40, 20, 128, 0.5)")
                        .setLineWidth(1)
        io.addObj(this.grid)
    setupGrid: (io)->
        this.checkpoints = []
        io.addGroup("checkpoints")
        io.addToGroup("checkpoints" ,this.checkpoints.push(new Checkpoint(1, 5)))
        io.addToGroup("checkpoints" ,this.checkpoints.push(new Checkpoint(10, 5)))
        io.addToGroup("checkpoints" ,this.checkpoints.push(new Checkpoint(10, 25)))
        io.addToGroup("checkpoints" ,this.checkpoints.push(new Checkpoint(20, 25)))
        io.addToGroup("checkpoints" ,this.checkpoints.push(new Checkpoint(20, 15)))
        io.addToGroup("checkpoints" ,this.checkpoints.push(new Checkpoint(48, 15)))

        points = []
        for i in this.checkpoints
            points.push this.grid.getCellCenter(i.pos)

        io.addGroup("overlays", -20)
        for i in [0..this.checkpoints.length-2]
            vertical = this.checkpoints[i].pos.x - this.checkpoints[i+1].pos.x == 0

            if(vertical)
                for y in [this.checkpoints[i].pos.y-1 .. this.checkpoints[i+1].pos.y+1]
                    for dx in [-1..1]
                        continue if this.grid.cells[this.checkpoints[i].pos.x + dx][y].unbuildable
                        this.grid.cells[this.checkpoints[i].pos.x + dx][y].unbuildable = true
                        cellPos = this.grid.getCellCenter(this.checkpoints[i].pos.x + dx, y)
                        io.addToGroup("overlays", new iio.Rect(cellPos.x, cellPos.y, 10)
                                                            .setFillStyle("blanchedalmond")
                                                            .setStrokeStyle("rgb(155, 135, 105)"))

            else
                for x in [this.checkpoints[i].pos.x-1 .. this.checkpoints[i+1].pos.x+1]
                    for dy in [-1..1]
                        continue if this.grid.cells[x][this.checkpoints[i].pos.y + dy].unbuildable
                        this.grid.cells[x][this.checkpoints[i].pos.y + dy].unbuildable = true
                        cellPos = this.grid.getCellCenter(x, this.checkpoints[i].pos.y + dy)
                        io.addToGroup("overlays", new iio.Rect(cellPos.x, cellPos.y, 10)
                                                            .setFillStyle("blanchedalmond")
                                                            .setStrokeStyle("rgb(155, 135, 105)"))


        io.addObj(new iio.MultiLine(points).setStrokeStyle("red").setLineWidth(1), "checkpoints")

        console.log(this.checkpoints, points)

$(->
    game = null
    iio.start((io)->
        game = new Game(io)
    , "gameCanvas")
)
