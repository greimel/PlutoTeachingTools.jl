module PlutoTeachingTools

# Write your package code here.

using Random # , Distributions # not sure if we need that
using Markdown
using LaTeXStrings

export hint, tip, almost, warning, danger 
export correct, still_missing, still_nothing, var_not_defined, func_not_defined, keep_working
#export keep_working_if_var_contains_substr
export TODO
export not_defined

export ingredients
export WidthOverDocs

"Hint box with arguement as text."
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]));

"Tip box with arguement as text."
tip(text) = Markdown.MD(Markdown.Admonition("tip", "Pro Tip", [text]));

"Admonition box labeled a warning with arguement as text."
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]));

"warning box with arguement as text."
warning_box(text) = Markdown.MD(Markdown.Admonition("warning", "Warning:", [text]));

"Danger box with arguement as text."
danger(text) = Markdown.MD(Markdown.Admonition("danger", "Beware!", [text]));


"Admonition box with reminder to replace missing."
still_missing(text=md"Replace `missing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Here we go!", [text]));

"Admonition box with reminder to replace nothing."
still_nothing(text=md"Replace `nothing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Here we go!", [text]));

"Admonition box with reminder that function name passed is not defined."
func_not_defined(func_name) = Markdown.MD(Markdown.Admonition("danger", "Oopsie!", [md"Make sure that you define a function called **$(Markdown.Code(string(func_name)))**"]));

"Admonition box with reminder that variable name passed is not defined."
var_not_defined(variable_name) = Markdown.MD(Markdown.Admonition("danger", "Oopsie!", [md"Make sure that you define a variable called **$(Markdown.Code(string(variable_name)))**"]));

"Admonition box with reminder that variable name passed is not defined.  (deprecated)"
not_defined(variable_name) = var_not_defined(variable_name)


"Admonition box warning that the answer isn't quite right."
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]));

#= 
# Temporarily removed since not working as intended.  
Probably @isdefined needs the module with the variable
function keep_working_if_var_contains_substr(var::Symbol,substr::String)
   if !@isdefined(var)
        var_not_defined(:var)
   else
        let
                if ismissing(var)
                        still_missing()
                elseif isnothing(var)
                        still_nothing()
                elseif occursin(substr,Markdown.plain(eval(var)))
                        keep_working(md"Make sure to update the cell setting $var.")
                end
        end
   end
end

function keep_working_if_any_false(tests)
   if !@isdefined(var)
        var_not_defined(:var)
   else
        let
                if ismissing(var)
                        still_missing()
                elseif isnothing(var)
                        still_nothing()
                elseif occursin(substr,Markdown.plain(eval(var)))
                        keep_working(md"Make sure to update the cell setting $var.")
                end
        end
   end
end
=#

yays = [md"Great!", md"Yay ❤", md"Great! 🎉", md"Well done!", md"Keep it up!", md"Good job!", md"Awesome!", md"You got the right answer!", md"Let's move on to the next section."];

"Box with random positive message."
correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]));

TODO_str = html"<span style='display: inline; font-size: 2em; color: purple; font-weight: 900;'>TODO</span>"
TODO() = TODO_str

"""
   ingredients(path) allows Pluto notebooks to include a module from another file.
It's like include, but for inside a pluto notebook.
Source: https://github.com/fonsp/Pluto.jl/issues/115
"""
function ingredients(path::String)
	# this is from the Julia source code (evalfile in base/loading.jl)
	# but with the modification that it returns the module instead of the last object
	name = Symbol(basename(path))
	m = Module(name)
	Core.eval(m,
        Expr(:toplevel,
             :(eval(x) = $(Expr(:core, :eval))($name, x)),
             :(include(x) = $(Expr(:top, :include))($name, x)),
             :(include(mapexpr::Function, x) = $(Expr(:top, :include))(mapexpr, $name, x)),
             :(include($path))))
	m
end

""" Provides checkbox to toggle full width versus narrow with column for LiveDocs """
function WidthOverDocs(enabled=false)  # From PlutoThemes.jl
	checked = enabled ? "checked" : ""
	init = enabled ? "toggle_width(document.getElementById('width-over-livedocs'))" : ""
	return HTML("""
<!-- https://github.com/fonsp/Pluto.jl/issues/400#issuecomment-695040745 -->
<input
	type="checkbox"
	id="width-over-livedocs"
	name="width-over-livedocs"
    onclick="window.plutoOptIns.toggle_width(this)"
	$(checked)>
<label for="width-over-livedocs">
	Activate bigger width - hiding live docs
</label>
<style>
	body.width-over-docs #helpbox-wrapper {
    	display: none !important;
	}
	body.width-over-docs main {
		max-width: calc(100% - 4rem);
		margin-right: 2rem;
	}
</style>
<script>
	const toggle_width = function(t) {
		t.checked
		? document.body.classList.add("width-over-docs")
		: document.body.classList.remove("width-over-docs")
	}
	window.plutoOptIns = window.plutoOptIns || {}
	window.plutoOptIns.toggle_width = toggle_width
	$(init)
</script>
""")
end

end # module
