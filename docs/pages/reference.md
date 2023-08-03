@page reference Doxygen and MCSS reference

@tableofcontents

This page serves  as a reference on how to write special commands provided by [Doxygen](https://www.doxygen.nl/) and [MCSS](https://mcss.mosra.cz/).
Note, that Doxygen allows us to mix doxygen commands in markdown. So instead of using `.dox` extensions, we use `.md`. Make
sure to check both references for more details :

@m_div{m-button m-info} 
	<a href="https://www.doxygen.nl/manual/commands.html">
	@m_div{m-text m-big}Doxygen 
	@m_enddiv 
	@m_div{m-small} 
		references
	@m_enddiv 
	</a> 
@m_enddiv
@m_div{m-button m-primary} 
	<a href="https://mcss.mosra.cz/css/components/">
	@m_div{m-text m-big}M.CSS
	@m_enddiv 
	@m_div{m-small} 
		references
	@m_enddiv 
	</a> 
@m_enddiv

@section dox-sec Doxygen Section 

This section was obtained with :

@cb{.md}
@section dox-sec Doxygen Section 
^        ^       ^
command  name    title
@ce


# Section

this section was obtained with :

@cb{.md}
# Section
@ce


# Code blocks

By default with doxygen, use `@code{} ... @endcode` to write code blocks.

Some aliases are provided `@cb{} ... @ce`, `@cpp ... @ce` and `@cmake ... @ce`: 


# Images

Images are added with command `image` ([see doxygen ref](https://www.doxygen.nl/manual/commands.html#cmdimage)).

@image html images/cute_smiling_robot_head.png "Robot" width=5cm

`@image html images/cute_smiling_robot_head.png "Robot" width=10cm`

@m_div{m-note m-warning}
	@m_div{m-text m-big}Path@m_enddiv
	Make sure images are stored correctly. As I had a lot of trouble with it, I decided to copy 
	images to the html folder generated before building the docs. A cmake function `add_assets` is provided
	(see `docs/CMakeLists.txt`).
@m_enddiv


# Note

@m_div{m-note m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default note 
@m_enddiv

```
@m_div{m-note m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default note 
@m_enddiv
```

@m_div{m-note m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary note
@m_enddiv

```
@m_div{m-note m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary note
@m_enddiv
```

@m_div{m-note m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success note
@m_enddiv

```
@m_div{m-note m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success note
@m_enddiv
```

@m_div{m-note m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning note
@m_enddiv

```
@m_div{m-note m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning note
@m_enddiv
```

@m_div{m-note m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger note
@m_enddiv

```
@m_div{m-note m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger note
@m_enddiv
```

@m_div{m-note m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info note
@m_enddiv

```
@m_div{m-note m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info note
@m_enddiv
```

@m_div{m-note m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim note
@m_enddiv

```
@m_div{m-note m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim note
@m_enddiv
```

@m_div{m-note m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a fram note
@m_enddiv

```
@m_div{m-note m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a frame note
@m_enddiv
```


# Block

@m_div{m-block m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default block 
@m_enddiv

```
@m_div{m-block m-default}
	@m_div{m-text m-big}Default@m_enddiv
	This is a default block 
@m_enddiv
```

@m_div{m-block m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary block
@m_enddiv

```
@m_div{m-block m-primary}
	@m_div{m-text m-big}Primary@m_enddiv
	This is a primary block
@m_enddiv
```

@m_div{m-block m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success block
@m_enddiv

```
@m_div{m-block m-success}
	@m_div{m-text m-big}Success@m_enddiv
	This is a success note
@m_enddiv
```

@m_div{m-block m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning block
@m_enddiv

```
@m_div{m-block m-warning}
	@m_div{m-text m-big}WARNING@m_enddiv
	This is a warning block
@m_enddiv
```

@m_div{m-block m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger block
@m_enddiv

```
@m_div{m-block m-danger}
	@m_div{m-text m-big}Danger@m_enddiv
	This is a danger block
@m_enddiv
```

@m_div{m-block m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info block
@m_enddiv

```
@m_div{m-block m-info}
	@m_div{m-text m-big}Info@m_enddiv
	This is an info block
@m_enddiv
```

@m_div{m-block m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim block
@m_enddiv

```
@m_div{m-block m-dim}
	@m_div{m-text m-big}Dim@m_enddiv
	This is a dim block
@m_enddiv
```

@m_div{m-block m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a fram block
@m_enddiv

```
@m_div{m-block m-frame}
	@m_div{m-text m-big}Frame@m_enddiv
	This is a frame block
@m_enddiv
```

# Text 

@m_div{m-text m-big}Big@m_enddiv

```
@m_div{m-text m-big}Big@m_enddiv
```

@m_div{m-text m-small}Small@m_enddiv

```
@m_div{m-text m-small}Small@m_enddiv
```

@m_div{m-text m-tiny}Tiny@m_enddiv

```
@m_div{m-text m-tiny}Tiny@m_enddiv
```

# Label

Command `@m_class` is applied to next emphasis  !

@m_class{m-label m-warning} **warning** key.

```
@m_class{m-label m-warning} **warning** key.
```

# Others

This text contains a @m_span{m-text m-success} green @m_endspan word.

@m_class{m-code-figure}

@parblock

```
@snippet my_lib/my_lib_header.hpp features-debug-output
```

<b></b>

@m_class{m-nopad}

@code{.shell-session}
Image format is PixelFormat::RGBA8Srgb and size Vector(256, 192)
Color of the bottom-left pixel is #33b27f
@endcode

@endparblock

@m_class{m-row}

@parblock

@m_div{m-col-t-8 m-push-t-2 m-col-s-6 m-push-s-0 m-col-m-4 m-push-m-1} @m_div{m-button m-primary m-fullwidth} <a href="getting-started.html">@m_div{m-big}Getting Started@m_enddiv @m_div{m-small} bootstrap a basic project structure @m_enddiv </a> @m_enddiv @m_enddiv

@m_div{m-col-t-8 m-push-t-2 m-col-s-6 m-push-s-0 m-col-m-4 m-push-m-3} @m_div{m-button m-success m-fullwidth} <a href="examples-triangle.html">@m_div{m-big}Your First Triangle@m_enddiv @m_div{m-small} a step-by-step tutorial @m_enddiv </a> @m_enddiv @m_enddiv

@endparblock

@m_class{m-note m-dim m-text-center} @parblock
This block is rendered in a dim note.

Centered.
@endparblock

This text contains a @span{m-text m-success} green @endspan word.
