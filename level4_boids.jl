module Boids
using Plots

mutable struct Boid
    position::Vector{Float64}
    velocity::Vector{Float64}
end

mutable struct WorldState
    boids::Vector{Boid}
    height::Float64
    width::Float64
    visual_range::Float64
    separation_distance::Float64
    max_speed::Float64
    max_force::Float64
end

function WorldState(n_boids, width, height)
    boids = [Boid([rand() * width, rand() * height], 
                  [rand() * 2 - 1, rand() * 2 - 1]) for _ in 1:n_boids]
    WorldState(boids, height, width, 5.0, 2.0, 2.0, 0.1)
end

function distance(b1::Boid, b2::Boid)
    sqrt((b1.position[1] - b2.position[1])^2 + (b1.position[2] - b2.position[2])^2)
end

function separation(state::WorldState, boid::Boid)
    steer = [0.0, 0.0]
    count = 0
    
    for other in state.boids
        if other !== boid && distance(boid, other) < state.separation_distance
            diff = [boid.position[1] - other.position[1], 
                    boid.position[2] - other.position[2]]
            steer .+= diff
            count += 1
        end
    end
    
    if count > 0
        steer ./= count
        # Нормализация и масштабирование до максимальной силы
        len = sqrt(steer[1]^2 + steer[2]^2)
        if len > 0
            steer = steer ./ len .* state.max_force
        end
    end
    
    return steer
end

function alignment(state::WorldState, boid::Boid)
    avg_velocity = [0.0, 0.0]
    count = 0
    
    for other in state.boids
        if other !== boid && distance(boid, other) < state.visual_range
            avg_velocity .+= other.velocity
            count += 1
        end
    end
    
    if count > 0
        avg_velocity ./= count
        # Нормализация и масштабирование
        len = sqrt(avg_velocity[1]^2 + avg_velocity[2]^2)
        if len > 0
            avg_velocity = avg_velocity ./ len .* state.max_speed
            # Преобразование в силу
            avg_velocity .-= boid.velocity
            # Ограничение силы
            len = sqrt(avg_velocity[1]^2 + avg_velocity[2]^2)
            if len > state.max_force
                avg_velocity = avg_velocity ./ len .* state.max_force
            end
        end
    end
    
    return avg_velocity
end

function cohesion(state::WorldState, boid::Boid)
    center = [0.0, 0.0]
    count = 0
    
    for other in state.boids
        if other !== boid && distance(boid, other) < state.visual_range
            center .+= other.position
            count += 1
        end
    end
    
    if count > 0
        center ./= count
        desired = center .- boid.position
        # Нормализация и масштабирование
        len = sqrt(desired[1]^2 + desired[2]^2)
        if len > 0
            desired = desired ./ len .* state.max_speed
            # Преобразование в силу
            desired .-= boid.velocity
            # Ограничение силы
            len = sqrt(desired[1]^2 + desired[2]^2)
            if len > state.max_force
                desired = desired ./ len .* state.max_force
            end
        end
    else
        desired = [0.0, 0.0]
    end
    
    return desired
end

function update!(state::WorldState)
    for boid in state.boids
        sep = separation(state, boid)
        ali = alignment(state, boid)
        coh = cohesion(state, boid)
        
        # Применяем все силы
        boid.velocity .+= sep .+ ali .+ coh
        
        # Ограничиваем максимальную скорость
        len = sqrt(boid.velocity[1]^2 + boid.velocity[2]^2)
        if len > state.max_speed
            boid.velocity = boid.velocity ./ len .* state.max_speed
        end
        
        # Обновляем позицию
        boid.position .+= boid.velocity
        
        # Обработка границ 
        if boid.position[1] < 0
            boid.position[1] = state.width
        elseif boid.position[1] > state.width
            boid.position[1] = 0.0
        end
        
        if boid.position[2] < 0
            boid.position[2] = state.height
        elseif boid.position[2] > state.height
            boid.position[2] = 0.0
        end
    end
end

function main()
    width = 100.0
    height = 100.0
    n_boids = 30
    state = WorldState(n_boids, width, height)
    
    anim = @animate for time in 1:200
        update!(state)
        
        x = [boid.position[1] for boid in state.boids]
        y = [boid.position[2] for boid in state.boids]
        u = [boid.velocity[1] for boid in state.boids]
        v = [boid.velocity[2] for boid in state.boids]
        
        scatter(x, y, xlim=(0, width), ylim=(0, height), 
               legend=false, 
               markersize=4, markercolor=:blue, 
               aspect_ratio=:equal)
    end
    
    gif(anim, "boids.gif", fps=30)
end

export main

end

using .Boids
Boids.main()