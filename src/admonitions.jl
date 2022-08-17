### A Pluto.jl notebook ###
# v0.19.11

using Markdown
using InteractiveUtils

# ╔═╡ ba5353b2-68c3-439a-9633-a2086f7ca335
using HypertextLiteral

# ╔═╡ ce05e179-2dc5-4601-a285-97719331a940
using MarkdownLiteral: @mdx

# ╔═╡ d6dbf43f-3d0b-4f15-a859-663948e75b15
# ╠═╡ skip_as_script = true
#=╠═╡
using PlutoUI: TableOfContents
  ╠═╡ =#

# ╔═╡ 01488da3-a69f-43c2-a4e1-41ad198a71f7
md"""
# Foldable
"""

# ╔═╡ 6602386e-40f7-483e-b956-a2edede32144
begin
	struct Foldable{T,C}
	    title::T
	    content::C
	end

	function Base.show(io, mime::MIME"text/html", fld::Foldable)
	    show(io, mime, @htl(
			"""<details>
			      <summary>$(fld.title)</summary>
			      <p>
			      $(fld.content)
			      </p>
		       </details>
			"""
			)
		)
	end
end

# ╔═╡ 130e08d5-3538-4f05-938f-b1f126c7cec1
Foldable(@htl("<i><b>This is the teaser</b></i>"), "And these are the hidden details")

# ╔═╡ 39bfdaa8-2d8f-478b-926d-7fda27840621
Foldable(@mdx("__*This is the teaser*__"), "And these are the hidden details")

# ╔═╡ e16b48bf-2778-4b3b-8b16-fe4487048a9c
md"""
# Admonitions
"""

# ╔═╡ 49ff170d-9bbc-4d7f-a800-666ef5d0672f
"Hint box with argument as text."
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]))

# ╔═╡ 0497e2dd-95ea-4a21-a819-d60dfaa2dbaf
hint(md"This is a hint")

# ╔═╡ 1e4ba5a5-e5d7-4e7c-a180-e3939f949912
"""
Tip box with argument as text.

```julia
tip(md"This is a tip")
```
$(tip(md"This is a tip"))

"""
tip(text) = Markdown.MD(Markdown.Admonition("tip", "Tip", [text]))

# ╔═╡ c6ce0d8e-6355-4f14-8ace-0c108a923c18
"Tip box with argument as text."
protip(text, invite = "Curious to learn more?";  boxlabel = "Pro Tip") = Foldable(invite, Markdown.MD(Markdown.Admonition("tip", boxlabel, [text])) )

# ╔═╡ d0930186-2210-44d0-bc86-45d6361b4ade
protip(md"This is a pro tip")

# ╔═╡ 98507217-40ea-4eac-8440-6f30d8c52b5d
"Admonition box labeled a warning with argument as text."
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]))

# ╔═╡ 3c390e5f-462f-4339-85d5-f3a224731699
almost(md"You are almost there")

# ╔═╡ ce7fd23f-b0c1-4b98-a1ba-519f32447b6c
"warning box with argument as text."
warning_box(text) = Markdown.MD(Markdown.Admonition("warning", "Warning:", [text]))

# ╔═╡ 30add23d-dec5-41b2-a19d-9ea41fdd5550
warning_box(md"This is a warning")

# ╔═╡ c3abc457-aee7-4867-880a-ddf940c30e1f
"Danger box with argument as text."
danger(text) = Markdown.MD(Markdown.Admonition("danger", "Beware!", [text]))

# ╔═╡ ba54e894-2ff9-4780-8f21-3b7bc3e43634
danger(md"You are in danger")

# ╔═╡ 7dcec9a3-37a9-4abf-be34-b74bb58d4912
"Admonition box with reminder to replace missing."
still_missing(text=md"Replace `missing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Missing Response", [text]))

# ╔═╡ d26d10e8-ef09-462f-b85b-9f3212edf098
still_missing()

# ╔═╡ c56f68fd-87da-4c3c-a001-ac6d430a32da
"Admonition box with reminder to replace nothing."
still_nothing(text=md"Replace `nothing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Here we go!", [text]));

# ╔═╡ 5c2fc925-10a1-4169-8259-f1f841114834
still_nothing()

# ╔═╡ e54c7cf7-b41e-43b9-a80f-fb8832a9b9d0
wrong_type(text=md"Check the type of your response.") = Markdown.MD(Markdown.Admonition("danger", "Type Error", [text]))

# ╔═╡ 916402c8-61cf-43bc-b39a-46bb4035ff8b
wrong_type(var::Symbol, type::Type; text=@mdx("The type of `$(var)` should be `$(Symbol(type))`")) = Markdown.MD(Markdown.Admonition("danger", "Type Error", [text]))

# ╔═╡ 429d143c-e787-4475-b2a7-21b2bb38361c
wrong_type() 

# ╔═╡ 00751954-fec4-409a-9c8c-6f7e6b1f418b
wrong_type(:x, Float64)

# ╔═╡ 7621c1f4-a1a6-4395-8c1a-f0c020d5c1cd
"Admonition box with reminder that function name passed is not defined."
func_not_defined(func_name) = Markdown.MD(Markdown.Admonition("danger", "Oopsie!", [md"Make sure that you define a function called **$(Markdown.Code(string(func_name)))**"]))

# ╔═╡ d265d8f4-36a4-4dc5-b3fc-b13d7270d595
func_not_defined("f")

# ╔═╡ 394dbce5-ee43-4a57-9705-af83229713e5
"Admonition box with reminder that variable name passed is not defined."
var_not_defined(variable_name) = Markdown.MD(Markdown.Admonition("danger", "Oopsie!", [md"Make sure that you define a variable called **$(Markdown.Code(string(variable_name)))**"]))

# ╔═╡ 897a7e18-d6a5-496e-9934-15f9a65195a8
var_not_defined("x")

# ╔═╡ 528c915c-a750-4969-8bd5-1a0a7a75c9c2
"Admonition box with reminder that variable name passed is not defined.  (deprecated)"
not_defined(variable_name) = var_not_defined(variable_name)

# ╔═╡ 61c87025-511c-4094-afdf-028bed1ee82e
"Admonition box warning that the answer isn't quite right."
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]));

# ╔═╡ cf6a2820-74c2-42d8-b906-c412ea67306e
keep_working()

# ╔═╡ ff981b7f-261a-440c-94de-e327cac3c522
function keep_working_if_var_contains_substr(var::Symbol,str::Union{String,Markdown.MD},substr::String)
# I had to remove !@isdefined(var) due to how Pluto puts variables into different modules
# not exported, so provide function with same name in notebook
  if     ismissing(var)
         still_missing()
  elseif isnothing(var)
         still_nothing()
  else
      if typeof(str) == Markdown.MD
         str = Markdown.plain(str)
      end
      if occursin(substr,str)
         keep_working(md"Make sure to update the cell setting $var.")
      end
  end
end

# ╔═╡ afd8f673-ba49-4382-b960-dfcb57172fc4
type_isa(var, t::Union{Type,Vector{Type},Vector{DataType}}) = (any(typeof(var) .<: t))

# ╔═╡ ad467cc8-d924-4c07-8ae4-06741b28785c
type_eq(var, t::Union{Type,Vector{Type},Vector{DataType}}) = (any(typeof(var) .== t))

# ╔═╡ 2465e042-13ff-4545-a438-3b7374762bb2
# To use functions in notebook, run eval(Meta.parse(code_for_check_type_funcs)) 
code_for_check_type_funcs = """
begin
function check_type_isa(sym::Symbol, var, t::Union{Type,Vector{Type},Vector{DataType}})
   if ismissing(var)
        passed = false
        text = md"The variable \$sym is still set to missing."
        msg = still_missing(text)
   elseif !type_isa(var,t) # (any(typeof(var) .<: t))
        passed = false
        text = "The type of \$sym is not correct.  It should be <: "
        if typeof(t) <: Type
           text = text * "\$t."
        else
           text = text * "one of "
           for tt in t
              if tt == last(t)
                 text = text * " or \$t."
              else
                 text = text * " \$t,"
              end
           end
        end
        msg = Markdown.MD(Markdown.Admonition("danger", "Type Error", [Markdown.MD(text)]))
   else
        passed = true
        msg = Markdown.MD("\$sym has the correct type.")
   end
   return (;passed, msg)
end
function check_type_eq(sym::Symbol, var, t::Union{Type,Vector{Type},Vector{DataType}})
   if ismissing(var)
        passed = false
        text = md"The variable \$sym is still set to missing."
        msg = still_missing(text)
   elseif !type_eq(var, t) # (any(typeof(var) == t))
        passed = false
        if typeof(t) <: Type
           text = "The type of \$sym should be \$t."
        else
           text = "The type of \$sym should be one of "
           for tt in t
              if tt == last(t)
                 text = text * " or \$t."
              else
                 text = text * " \$t,"
              end
           end
        end
        #text = md"The type of \$sym should be \$t."
        msg = Markdown.MD(Markdown.Admonition("danger", "Type Error", [Markdown.MD(text)]))
   else
        passed = true
        msg = Markdown.MD("\$sym has the correct type.")
   end
   return (;passed, msg)
end
end
"""

# ╔═╡ 2dae8354-b032-4bcf-a599-cd58f26d67d8
yays = [md"Great!", md"Yay ❤", md"Great! 🎉", md"Well done!", md"Keep it up!", md"Good job!", md"Awesome!", md"You got the right answer!", md"Let's move on to the next part."]

# ╔═╡ 1e9d2460-dfb0-4675-b0a5-cde764da7cde
"Box with random positive message."
correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]))

# ╔═╡ ac222438-1170-40ab-8d12-4e23d5825e84
correct()

# ╔═╡ 1a4bc49b-a8ab-42d5-ba9b-fa81953727f1
TODO() = html"<span style='display: inline; font-size: 2em; color: purple; font-weight: 900;'>TODO</span>"

# ╔═╡ 9eb17f05-11eb-4d94-ae0d-55523574cd1f
TODO()

# ╔═╡ 9e58cc18-91b2-4205-a345-8981196c9ba6
function display_msg_if_fail(x; msg_pass = nothing)
   if !x.passed
      x.msg
   else
      msg_pass
   end 
end

# ╔═╡ ca701dd4-476a-457c-a414-79e19e0394e4
md"""
# Appendix
"""

# ╔═╡ f26a3ccf-03d3-4fd4-85c9-d97f10f20151
#=╠═╡
TableOfContents()
  ╠═╡ =#

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
MarkdownLiteral = "736d6165-7244-6769-4267-6b50796e6954"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.4"
MarkdownLiteral = "~0.1.1"
PlutoUI = "~0.7.39"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0-rc4"
manifest_format = "2.0"
project_hash = "c6e06890c4978968169b1f2df5ad3068381336fc"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CommonMark]]
deps = ["Crayons", "JSON", "URIs"]
git-tree-sha1 = "4cd7063c9bdebdbd55ede1af70f3c2f48fab4215"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.6"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MarkdownLiteral]]
deps = ["CommonMark", "HypertextLiteral"]
git-tree-sha1 = "0d3fa2dd374934b62ee16a4721fe68c418b92899"
uuid = "736d6165-7244-6769-4267-6b50796e6954"
version = "0.1.1"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "0044b23da09b5608b4ecacb4e5e6c6332f833a7e"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.3.2"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "8d1f54886b9037091edf146b517989fc4a09efec"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.39"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.URIs]]
git-tree-sha1 = "e59ecc5a41b000fa94423a578d29290c7266fc10"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.0"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─01488da3-a69f-43c2-a4e1-41ad198a71f7
# ╠═ba5353b2-68c3-439a-9633-a2086f7ca335
# ╠═6602386e-40f7-483e-b956-a2edede32144
# ╠═130e08d5-3538-4f05-938f-b1f126c7cec1
# ╠═39bfdaa8-2d8f-478b-926d-7fda27840621
# ╟─e16b48bf-2778-4b3b-8b16-fe4487048a9c
# ╠═49ff170d-9bbc-4d7f-a800-666ef5d0672f
# ╠═0497e2dd-95ea-4a21-a819-d60dfaa2dbaf
# ╠═1e4ba5a5-e5d7-4e7c-a180-e3939f949912
# ╠═c6ce0d8e-6355-4f14-8ace-0c108a923c18
# ╠═d0930186-2210-44d0-bc86-45d6361b4ade
# ╠═98507217-40ea-4eac-8440-6f30d8c52b5d
# ╠═3c390e5f-462f-4339-85d5-f3a224731699
# ╠═ce7fd23f-b0c1-4b98-a1ba-519f32447b6c
# ╠═30add23d-dec5-41b2-a19d-9ea41fdd5550
# ╠═c3abc457-aee7-4867-880a-ddf940c30e1f
# ╠═ba54e894-2ff9-4780-8f21-3b7bc3e43634
# ╠═7dcec9a3-37a9-4abf-be34-b74bb58d4912
# ╠═d26d10e8-ef09-462f-b85b-9f3212edf098
# ╠═c56f68fd-87da-4c3c-a001-ac6d430a32da
# ╠═5c2fc925-10a1-4169-8259-f1f841114834
# ╠═e54c7cf7-b41e-43b9-a80f-fb8832a9b9d0
# ╠═ce05e179-2dc5-4601-a285-97719331a940
# ╠═916402c8-61cf-43bc-b39a-46bb4035ff8b
# ╠═429d143c-e787-4475-b2a7-21b2bb38361c
# ╠═00751954-fec4-409a-9c8c-6f7e6b1f418b
# ╠═7621c1f4-a1a6-4395-8c1a-f0c020d5c1cd
# ╠═d265d8f4-36a4-4dc5-b3fc-b13d7270d595
# ╠═394dbce5-ee43-4a57-9705-af83229713e5
# ╠═897a7e18-d6a5-496e-9934-15f9a65195a8
# ╠═528c915c-a750-4969-8bd5-1a0a7a75c9c2
# ╠═61c87025-511c-4094-afdf-028bed1ee82e
# ╠═cf6a2820-74c2-42d8-b906-c412ea67306e
# ╠═ff981b7f-261a-440c-94de-e327cac3c522
# ╠═afd8f673-ba49-4382-b960-dfcb57172fc4
# ╠═ad467cc8-d924-4c07-8ae4-06741b28785c
# ╠═2465e042-13ff-4545-a438-3b7374762bb2
# ╠═2dae8354-b032-4bcf-a599-cd58f26d67d8
# ╠═1e9d2460-dfb0-4675-b0a5-cde764da7cde
# ╠═ac222438-1170-40ab-8d12-4e23d5825e84
# ╠═1a4bc49b-a8ab-42d5-ba9b-fa81953727f1
# ╠═9eb17f05-11eb-4d94-ae0d-55523574cd1f
# ╠═9e58cc18-91b2-4205-a345-8981196c9ba6
# ╟─ca701dd4-476a-457c-a414-79e19e0394e4
# ╠═d6dbf43f-3d0b-4f15-a859-663948e75b15
# ╠═f26a3ccf-03d3-4fd4-85c9-d97f10f20151
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
