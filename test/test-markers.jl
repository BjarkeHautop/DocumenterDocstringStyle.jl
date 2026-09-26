@testitem "Markers render as nothing" tags = [:unit, :fast] begin
    using DocumenterDocstringStyle: MINIMAL, NOSCHEMA, NOCHECK
    module MarkerDocs
    using DocumenterDocstringStyle: MINIMAL, NOSCHEMA, NOCHECK
    """
        f(x)

    Return `x`.

    $(MINIMAL)
    """
    f(x) = x
    """
        g(x)

    Return `x`.

    $(NOSCHEMA)
    """
    g(x) = x
    """
        h(x)

    Return `x`.

    $(NOCHECK)
    """
    h(x) = x
    end
    for f in (MarkerDocs.f, MarkerDocs.g, MarkerDocs.h)
        text = sprint(show, MIME"text/plain"(), Base.Docs.doc(f))
        @test occursin("Return", text)
        @test !occursin("Minimal", text)
        @test !occursin("NoSchema", text)
        @test !occursin("NoCheck", text)
    end
end
