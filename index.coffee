class Game
    constructor: (io)->
        this.createGrid(io)

    createGrid: (io)->
        this.grid = new iio.Grid(0,0,50,30,20)
                        .setStrokeStyle("rgba(40, 20, 128, 0.5)")
                        .setLineWidth(1)
        io.addObj(this.grid)

$(->
    game = null
    iio.start((io)->
        game = new Game(io)
    , "gameCanvas")
)
