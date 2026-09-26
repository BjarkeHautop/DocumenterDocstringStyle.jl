"""
Opt-out markers for DocumenterDocstringStyle.jl.

Interpolate `\$(MINIMAL)`, `\$(NOSCHEMA)` or `\$(NOCHECK)` into a docstring to
relax the schema check for it. The markers render as nothing in the REPL and in
HTML, but stay visible to the checker because docstring interpolation is lazy:
the objects are kept unformatted in `Base.Docs.DocStr.text`.

This package has no dependencies, so packages under documentation can depend on
it without pulling in Documenter.
"""
module DocumenterDocstringStyleMarkers

export MINIMAL, NOSCHEMA, NOCHECK

"""
    SchemaMarker

Supertype of the docstring opt-out markers.
"""
abstract type SchemaMarker end

"""
    Minimal <: SchemaMarker

Marker type behind [`MINIMAL`](@ref).
"""
struct Minimal <: SchemaMarker end

"""
    NoSchema <: SchemaMarker

Marker type behind [`NOSCHEMA`](@ref).
"""
struct NoSchema <: SchemaMarker end

"""
    NoCheck <: SchemaMarker

Marker type behind [`NOCHECK`](@ref).
"""
struct NoCheck <: SchemaMarker end

"""
    MINIMAL

Interpolate into a docstring to check only its signature and summary.
"""
const MINIMAL = Minimal()

"""
    NOSCHEMA

Interpolate into a docstring to skip all schema checks for it. Also disables
rendering, so the docstring falls back to plain Markdown.
"""
const NOSCHEMA = NoSchema()

"""
    NOCHECK

Interpolate into a docstring to skip all schema checks for it, while still
rendering it with the configured theme. Use this for docstrings that don't
follow the schema but should still be styled, for example on functions that
are excluded from a build's checks but documented for internal use.
"""
const NOCHECK = NoCheck()

Base.Docs.formatdoc(::IO, ::Base.Docs.DocStr, ::SchemaMarker) = nothing

end
