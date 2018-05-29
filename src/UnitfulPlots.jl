module UnitfulPlots
using Unitful
importall RecipesBase

function unit_formatter(T, num)
    string(num)*string(unit(zero(T)))
end

# 2D plots (1 recipe for shorthand form)
@recipe function f(val::AbstractVector{T}) where T<:Quantity
    yformatter := x->unit_formatter(T,x)
    ustrip(val)
end

# 2D plots (2^4-1 user recipes)
@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}
                  ) where {S<:Quantity, T<:Quantity}
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    ustrip(val), ustrip(val2)
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}
                  ) where {S<:Number, T<:Quantity}
    yformatter := x->unit_formatter(T,x)
    val, ustrip(val2)
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}
                  ) where {S<:Quantity, T<:Number}
    xformatter := x->unit_formatter(T,x)
    ustrip(val), val2
end

# 3D plots (2^8-1 user recipes)
@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Quantity, T<:Quantity, U<:Quantity}
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    zformatter := x->unit_formatter(U,x)
    ustrip(val), ustrip(val2), ustrip(val3)
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Quantity, T<:Quantity, U<:Number}
    xformatter := x->unit_formatter(S,x)
    yformatter := x->unit_formatter(T,x)
    ustrip(val), ustrip(val2), val3
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Quantity, T<:Number, U<:Quantity}
    xformatter := x->unit_formatter(S,x)
    zformatter := x->unit_formatter(U,x)
    ustrip(val), val2, ustrip(val3)
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Number, T<:Quantity, U<:Quantity}
    yformatter := x->unit_formatter(T,x)
    zformatter := x->unit_formatter(U,x)
    val, ustrip(val2), ustrip(val3)
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Quantity, T<:Number, U<:Number}
    xformatter := x->unit_formatter(S,x)
    ustrip(val), val2, val3
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Number, T<:Quantity, U<:Number}
    yformatter := x->unit_formatter(T,x)
    val, ustrip(val2), val3
end

@recipe function f(val::AbstractVector{S}, val2::AbstractVector{T}, val3::AbstractMatrix{U}
                  ) where {S<:Number, T<:Number, U<:Quantity}
    zformatter := x->unit_formatter(U,x)
    val, val2, ustrip(val3)
end

end
