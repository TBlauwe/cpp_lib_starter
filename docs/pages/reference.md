@page reference Documentation's reference

@tableofcontents

This page showcase some tools at your disposal to write documentation.
They are provided by @Doxygen and @Doxygen-awesome.

We used theses pages as references :
* [Doxygen awesome example](https://jothepro.github.io/doxygen-awesome-css/class_my_library_1_1_example.html)
Most of this page was built from it. We added code blocks for easier usage.
* [Doxygen reference](https://www.doxygen.nl/manual/index.html)

@warning When referencing extern files, like images and such, make sure
to reference them as if you were in the final `html/` folder, generated
by @Doxygen. For now, the structure of the directory is flat. Meaning, all
files are in the `html/` folder.


## Hints

One the many excellent tools provided by @Doxygen-awesome.

@warning this is a warning only for demonstration purposes

```markup
@warning this is a warning only for demonstration purposes
```

@note this is a note to show that notes work. They can also include `code`:
@code{.c}
void this_looks_awesome();
@endcode

```markup
@note this is a note to show that notes work. They can also include `code`:
@code{.c}
void this_looks_awesome();
@endcode
```

@bug example bug

```markup
@bug example bug
```

@deprecated None of this will be deprecated, because it's beautiful!

```markup
@deprecated None of this will be deprecated, because it's beautiful!
```

@invariant This is an invariant

```markup
@invariant This is an invariant
```

@pre This is a precondition

```markup
@pre This is a precondition
```

@post This is a postcondition

```markup
@post This is a postcondition
```

@todo This theme is never finished!

```markup
@todo This theme is never finished!
```

@remark This is awesome!

```markup
@remark This is awesome!
```


## Tables

The table content is scrollable if the table gets too wide.

| first_column | second_column | third_column | fourth_column | fifth_column | sixth_column | seventh_column | eighth_column | ninth_column |
|--------------|---------------|--------------|---------------|--------------|--------------|----------------|---------------|--------------|
| 1            | 2             | 3            | 4             | 5            | 6            | 7              | 8             | 9            |

```markup
| first_column | second_column | third_column | fourth_column | fifth_column | sixth_column | seventh_column | eighth_column | ninth_column |
|--------------|---------------|--------------|---------------|--------------|--------------|----------------|---------------|--------------|
| 1            | 2             | 3            | 4             | 5            | 6            | 7              | 8             | 9            |
```

A table can contain images:

| Column 1                  | Column 2                                        |
|---------------------------|-------------------------------------------------|
| ![logo](cute_smiling_robot_head.png) | ← the image should not be inverted in dark-mode |

```markup
| Column 1                  | Column 2                                        |
|---------------------------|-------------------------------------------------|
| ![logo](cute_smiling_robot_head.png) | ← the image should not be inverted in dark-mode |
```

Complex [Doxygen tables](https://www.doxygen.nl/manual/tables.html) are also supported as seen in @ref multi_row "this example":

<table>
<caption id="multi_row">Complex table</caption>
<tr><th>Column 1                      <th>Column 2        <th>Column 3
<tr><td rowspan="2">cell row=1+2,col=1<td>cell row=1,col=2<td>cell row=1,col=3
<tr><td rowspan="2">cell row=2+3,col=2                    <td>cell row=2,col=3
<tr><td>cell row=3,col=1                                  <td rowspan="2">cell row=3+4,col=3
<tr><td colspan="2">cell row=4,col=1+2
<tr><td>cell row=5,col=1              <td colspan="2">cell row=5,col=2+3
<tr><td colspan="2" rowspan="2">cell row=6+7,col=1+2      <td>cell row=6,col=3
<tr>                                                      <td>cell row=7,col=3
<tr><td>cell row=8,col=1              <td>cell row=8,col=2\n
  <table>
    <tr><td>Inner cell row=1,col=1<td>Inner cell row=1,col=2
    <tr><td>Inner cell row=2,col=1<td>Inner cell row=2,col=2
  </table>
  <td>cell row=8,col=3
  <ul>
    <li>Item 1
    <li>Item 2
  </ul>
</table>

```html
<table>
<caption id="multi_row">Complex table</caption>
<tr><th>Column 1                      <th>Column 2        <th>Column 3
<tr><td rowspan="2">cell row=1+2,col=1<td>cell row=1,col=2<td>cell row=1,col=3
<tr><td rowspan="2">cell row=2+3,col=2                    <td>cell row=2,col=3
<tr><td>cell row=3,col=1                                  <td rowspan="2">cell row=3+4,col=3
<tr><td colspan="2">cell row=4,col=1+2
<tr><td>cell row=5,col=1              <td colspan="2">cell row=5,col=2+3
<tr><td colspan="2" rowspan="2">cell row=6+7,col=1+2      <td>cell row=6,col=3
<tr>                                                      <td>cell row=7,col=3
<tr><td>cell row=8,col=1              <td>cell row=8,col=2\n
  <table>
    <tr><td>Inner cell row=1,col=1<td>Inner cell row=1,col=2
    <tr><td>Inner cell row=2,col=1<td>Inner cell row=2,col=2
  </table>
  <td>cell row=8,col=3
  <ul>
    <li>Item 1
    <li>Item 2
  </ul>
</table>
```

A table can be centered with the `<center>` html tag:

<center>
| Foo         | Bar            | Baz                       | FooBar      |
|-------------|----------------|---------------------------|-------------|
| Lorem imsum | dolor sit amet | cenectetur adipisici elit | At vero eos |
</center>

```html
<center>
| Foo         | Bar            | Baz                       | FooBar      |
|-------------|----------------|---------------------------|-------------|
| Lorem imsum | dolor sit amet | cenectetur adipisici elit | At vero eos |
</center>
```


## Lists

- element 1
- element 2

1. element 1
   ```
   code in lists
   ```
2. element 2


## Code Blocks

Code blocks can be written in a markdown manner or with doxygen commands :

### Markdown code block

```cpp
auto x = "code within md fences";
```

@code{markup}
```cpp
auto x = "code within md fences";
```
@endcode

### Doxygen code block

@code{.cpp}
// code within @code block
while(true) {
   auto example = std::make_shared<Example>(5);
   example->test("test");
}
@endcode

```markup
@code{.cpp}
// code within @code block
while(true) {
   auto example = std::make_shared<Example>(5);
   example->test("test");
}
@endcode
```



## Quotes
 
> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt 
> ut labore et dolore magna aliqua. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. 
> Velit sed ullamcorper morbi tincidunt ornare. 
> 
> Lorem ipsum dolor sit amet consectetur adipiscing elit duis.
*- jothepro*

```markup
> Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt 
> ut labore et dolore magna aliqua. Vitae proin sagittis nisl rhoncus mattis rhoncus urna neque viverra. 
> Velit sed ullamcorper morbi tincidunt ornare. 
> 
> Lorem ipsum dolor sit amet consectetur adipiscing elit duis.
*- jothepro*
```

## Navigation

[Reference](https://jothepro.github.io/doxygen-awesome-css/md_docs_2extensions.html#extension-page-navigation)

<div class="section_buttons">
 
| Previous          |                              Next |
|:------------------|----------------------------------:|
| [Home](index.html) | [Bug List](bug.html) |
 
</div>

```markup
<div class="section_buttons">
 
| Previous          |                              Next |
|:------------------|----------------------------------:|
| [Home](index.html) | [Bug List](bug.html) |
 
</div>
```


## Graphviz

Embedded Graphviz graphs support dark mode and can be scrolled once they get too wide:

@dot Graphviz with a caption
digraph example {
   node [fontsize="12"];
   rankdir="LR"
   a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> k;
}
@enddot

## HTML IFrame

If you ever need to incorporate another html inside your html, you can use an [IFrame](https://developer.mozilla.org/fr/docs/Web/HTML/Element/iframe).

We provided an aliases : 

```markup
@html_frame{my_file.html, 800, 600}
```

__Arguments__ :
1. __name__ - `my_file.html` : path to an .html file
2. __width__ - `800` : IFrame's width
3. __height__ - `600` : IFrame's height


Or you can write html directly :
```markup
@htmlonly
<iframe src="my_file.html" width="800" height="600"></iframe>
@endhtmlonly
```


@warning Also, if you build documentation localy and open it in your browser,
iframes will most likely not work : `Not allowed to load local resource: ...`.
It's for security reason. To solve this, you need to run a web server.
You can use visual studio code for example, with an official extension 
called `Live Preview`.
