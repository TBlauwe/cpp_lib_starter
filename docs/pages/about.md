@mainpage Cpp library starter

@tableofcontents

Welcome to the documentation for the template repository [cpp_library_starter](https://github.com/TBlauwe/cpp_lib_starter).

If you want to see how to use this repository as a template, see [README.md](https://github.com/TBlauwe/cpp_lib_starter#cpp-library-starter-project).

This page is mostly a showcase of how the generated documentation will look like.
But it is also a reference on how to write special commands provided by [Doxygen](https://www.doxygen.nl/) and [MCSS](https://mcss.mosra.cz/).
Note, that Doxygen allows us to mix doxygen commands in markdown. So instead of using `.dox` extensions, we use `.md`. Make
sure to check both references for more details :

@m_div{m-button m-primary} 
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


@section References

This section was obtained with :

@cb{.md}
@section reference References
^         ^         ^
command   name      title
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