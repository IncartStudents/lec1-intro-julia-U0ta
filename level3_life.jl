
module GameOfLife
using Plots

mutable struct Life
    current_frame::Matrix{Int64}
    next_frame::Matrix{Int64}
end

function count_neighbors(cf::Matrix{Int64}, x::Int64, y::Int64)
    count = 0
    for i in -1:1
        for j in -1:1
            if i == 0 && j == 0
                continue  
            end
            nx, ny = x + i, y + j
            if nx >= 1 && nx <= n && ny >= 1 && ny <= m
                count += cf[nx, ny]
            end
        end
    end
    return count
end

function step!(state::Life)
    curr = state.current_frame
    next = state.next_frame

    #=
    TODO: вместо случайного шума
    реализовать один шаг алгоритма "Игра жизнь"
    =#
    for i in 1:n 
        for j in 1:m 
            neighbors = count_neighbors(curr, i, j)
            if curr[i,j] == 1
                if neighbors < 2 || neighbors > 3 
                    curr[i,j] = 0 
                end
            else
                if neighbors == 3
                    curr[i,j] = 1
                end
            end
        end

    end

    # Подсказка для граничных условий - тор:
    # julia> mod1(10, 30)
    # 10
    # julia> mod1(31, 30)
    # 1

    return nothing
end

function (@main)(ARGS)
    global n = 30
    global m = 30
    init = zeros(n, m)

    init[15,15] = 1
    init[15,16] = 1
    init[15,14] = 1
    init[14,15] = 1
    init[16,14] = 1
    init[16,15] = 1
    init[16,16] = 1
    init[15,17] = 1 #заполнил вручную ради забавы и красивого роста "популяции"
    game = Life(init, zeros(n, m))

    anim = @animate for time = 1:100
        step!(game)
        cr = game.current_frame
        heatmap(cr)
    end
    gif(anim, "life.gif", fps = 10)
end

export main

end

using .GameOfLife
GameOfLife.main("")
