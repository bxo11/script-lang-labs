function buildTower(start: Position, width: number, height: number, block: Block) {
    builder.teleportTo(start)

    for (let i = 0; i <= height - 1; i++) {
        builder.move(UP, 1)
        builder.mark()
        for (let j = 0; j <= 3; j++) {
            builder.move(FORWARD, width - 1)
            builder.turn(TurnDirection.Right)
        }
        builder.tracePath(i === 0 ? STONE : block)
    }
}

function buildRoof(start: Position, width: number, height: number) {
    let roofLayers
    builder.teleportTo(start.add(pos(width, height, 1)))
    if (width % 2 == 0) {
        roofLayers = width / 2 - 1
    } else {
        roofLayers = width / 2
    }

    for (let layer = 0; layer <= roofLayers + 1; layer++) {
        builder.mark()
        for (let k = 0; k <= 3; k++) {
            builder.move(FORWARD, width + 1 - layer * 2)
            builder.turn(TurnDirection.Left)
        }
        builder.tracePath(PLANKS_OAK)
        builder.shift(1, 1, 1)
    }
}

function buildCore(start: Position, width: number, height: number) {
    buildTower(start, width, height, STONE_BRICKS)
    buildCoreRoof(start, width, height)
    buildDoor(pos(width, 0, -7), 3, 3)
    buildFloor(start.add(pos(1, 4, -1)), width - 2, width - 2)
    buildFloor(start.add(pos(1, 8, -1)), width - 2, width - 2)
    buildLadder(start.add(pos(-1, 1, 0)), width, height)
}

function buildLadder(start: Position, width: number, height: number) {
    for (let i = 0; i < 3; i++) {
        builder.teleportTo(start.add(pos(((width - 1) / 2) + i, 0, -(width - 2))))
        builder.mark()
        builder.move(UP, height - 2)
        builder.tracePath(BRICKS)
    }

    for (let i = 0; i < 3; i++) {
        builder.teleportTo(start.add(pos(((width - 1) / 2) + i, 0, -(width - 3))))
        builder.mark()
        builder.move(UP, height - 2)
        builder.tracePath(LADDER)
    }
}

function buildFloor(start: Position, width: number, lenght: number) {
    for (let i = 0; i < width; i++) {
        builder.teleportTo(start.add(pos(i, 0, 0)))
        builder.mark()
        builder.move(FORWARD, lenght-1)
        builder.tracePath(STONE)
    }
}

function buildDoor(start: Position, width: number, height: number) {
    for (let i = 0; i < height; i++) {
        builder.teleportTo(start.add(pos(0, i, 0)))
        builder.mark()
        builder.move(RIGHT, -(width - 1))
        builder.tracePath(AIR)
    }
}

function buildBridge(start: Position, width: number, lenght: number) {
    for (let i = 0; i < width; i++) {
        builder.teleportTo(start.add(pos(i, 0, 0)))
        builder.mark()
        builder.move(FORWARD, lenght)
        builder.tracePath(PLANKS_SPRUCE)
    }

    let l = [0, width - 1]
    l.forEach((i) => {
        builder.teleportTo(start.add(pos(i, 1, 0)))
        builder.mark()
        builder.move(FORWARD, lenght)
        builder.tracePath(SPRUCE_FENCE)
    })
}

function buildCoreRoof(start: Position, width: number, height: number) {
    builder.teleportTo(start.add(pos(0, height + 1, 0)))
    for (let i = 0; i <= 4 * width; i++) {
        if (i % 2 === 0) builder.place(COBBLESTONE_SLAB)
        if (i % (width - 1) === 0 && i != 0) builder.turn(TurnDirection.Right)
        builder.move(FORWARD, 1)
    }
}

function buildMoat(start: Position, width: number, height: number) {
    for (let k = 0; k < 3; k++) {
        builder.teleportTo(start.add(pos(-5 + k, -3, 8 - k)))
        for (let i = 0; i < height; i++) {
            builder.move(UP, 1)
            builder.mark()
            for (let j = 0; j <= 3; j++) {
                builder.move(FORWARD, width - k * 2)
                builder.turn(TurnDirection.Right)
            }
            builder.tracePath(WATER)
        }
    }
}

function buildWindow(direction: number, height: number, start: Position) {
    builder.teleportTo(start)
    let start_height = 6
    builder.move(UP, start_height)

    for (let i = start_height; i <= height - 2; i++) {
        for (let j = 0; j <= 3; j++) {
            builder.move(FORWARD, 2);
            builder.mark();
            builder.move(FORWARD, 1);
            if (j === direction) builder.tracePath(GLASS);
            builder.move(FORWARD, 2)
            builder.turn(TurnDirection.Right)
        }
        builder.move(UP, 1)
    }
}

let t1_pos = pos(0, -1, -5)
let t2_pos = pos(19, -1, -5)
let tower_height = 13
let tower_width = 6
let core_width = 13
let core_height = 9

buildCore(pos(6, -1, -7), core_width, core_height)

buildTower(t1_pos, tower_width, tower_height, BRICKS)
buildRoof(t1_pos, tower_width, tower_height)
buildWindow(0, tower_height, t1_pos)
buildWindow(1, tower_height, t1_pos)
buildWindow(3, tower_height, t1_pos)

buildTower(t2_pos, tower_width, tower_height, BRICKS)
buildRoof(t2_pos, tower_width, tower_height)
buildWindow(1, tower_height, t2_pos)
buildWindow(2, tower_height, t2_pos)
buildWindow(3, tower_height, t2_pos)

buildMoat(t1_pos, 34, 3)
buildBridge(pos(10, 0, 4), 5, 4)

player.say("build-completed")