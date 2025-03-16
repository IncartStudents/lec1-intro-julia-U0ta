module Boids
using Plots


mutable struct WorldState
    boid::Tuple{Float64, Float64}
    height::Float64
    width::Float64
    sep::Tuple{Float64, Float64}
    alig::Float64
    coh::Float64
    acc::Float64
    function WorldState(n_boids, width, height)
        # TODO: добавить случайные позиции для n_boids птичек вместо одной
        
        new((width,height), w, h, (0.0, 0.0), 0.0, 0.0, 0.0)
    end
end

function rad_vec(state::WorldState)
    px = state.boid[1]
    py = state.boid[2]
    pn = sqrt(px^2 + py^2)
    return pn
end

function separation(state::WorldState, stts::Vector{WorldState})
    pl = (0.0, 0.0)
    ps = (0.0, 0.0)
    for stt in stts
        pl[1] = state.boid[1] - stt.boid[1]
        pl[2] = state.boid[2] - stt.boid[2]
        s = sqrt(pl[1]^2 + pl[2]^2)
        ps = pl / s
        state.sep[1] = ps[1]
        state.sep[2] = ps[2]
    end
    return nothing
end

function update!(state::WorldState)
    state.boid = state.boid .+ 0.1
    separation(state, states)
    # TODO: реализация уравнения движения птичек

    return nothing
end

function (@main)(ARGS)
    global w = 30
    global h = 30
    n_boids = 10
    global states = [WorldState(n_boids, rand(1:w), rand(1:h)) for _ in 1:n_boids]
    anim = @animate for time = 1:100
        for state in states
            update!(state)
        end
        boids = [state.boid for state in states]
        for state in states 
            scatter(boids, xlim = (0, state.width), ylim = (0, state.height))
        end
    end
    gif(anim, "boids.gif", fps = 10)
end

export main

end

using .Boids
Boids.main("")
