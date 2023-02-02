@def title = "Markdown"
@def hascode = false

@def tags = ["reporting"]

# Markdown

\toc

## Introduction

Markdown is a lightweight markup language for creating formatted documents in minutes using nothing but a plain-text editor. You can use the full range of HTML elements in Markdown and they will not be affected by a Markdown parser. Many code sharing platforms like, e.g., GitHub or GitLab as well as programming languages support Markdown. Actually, the webpage you are looking at right now was created by interweaving HTML and Markdown elements.

## Basic Syntax and Formatting

In order to show you the possibilities of formatting text with simple macros we provide the examples below.
On top you can see the plain code and below that what Markdown makes of it.

- Comments

```markdown
<!--This is a comment.-->
```

- Headers of different sizes

```markdown
# This is an <h1>

## This is an <h2>

### This is an <h3>

#### This is an <h4>

##### This is an <h5>

###### This is an <h6>
```

# This is an <h1>

## This is an <h2>

### This is an <h3>

#### This is an <h4>

##### This is an <h5>

###### This is an <h6>

- Formatting text the easy way

```markdown
_This text is in italics._
```

_This text is in italics._

```markdown
**This text is bold.**
```

**This text is bold.**

```markdown
**_This text is both._**
```

**_This text is both._**

```markdown
> This is a quotation.
> You can also add more levels to go deeper with
>
> > double `>`.
```

> This is a quotation.
> You can also add more levels to go deeper with
>
> > double `>`.

- Add a horizontal rule

```markdown
---
```

---

- Present things in (enumerated) lists

```markdown
- Item
- Another item
```

- Item
- Another item

```markdown
1. Item one
2. Item two
```

1. Item one
2. Item two

```markdown
1. Item one
2. Item two
   - Sub-item
   - Sub-item
3. Item three
```

1. Item one
2. Item two
   - Sub-item
   - Sub-item
3. Item three

Boxes below without the 'x' are unchecked HTML checkboxes.

```markdown
- [ ] First task to complete.
- [x] This task has been completed.
```

## Highlighting Code

- Formatting code inline

```markdown
`This is code.`
```

`This is code.`

- Code blocks and syntax highlighting

In GitHub Flavored Markdown, you can use a special syntax for code. Just add the programming language of your choice
after the three ticks.

````markdown
```python
def foobar(x: int = 1, y: str = "Hello") -> int:
    print(y)
    return 2 * x
end
```
````

```python
def foobar(x: int = 1, y: str = "Hello") -> int:
    print(y)
    return 2 * x
end
```

Here is an example of the `R` programming language.

````markdown
```r
jiggle <- function(x) {
    x = x + rnorm(1, sd=.1) # add a bit of (controlled) noise
    return(x)
}
```
````

```r
jiggle <- function(x) {
    x = x + rnorm(1, sd=.1) # add a bit of (controlled) noise
    return(x)
}
```

## Links and References

```markdown
[Click me!](https://www.uibk.ac.at/weiterbildung/ulg/data-science/index.html.en)
```

[Click me!](https://www.uibk.ac.at/weiterbildung/ulg/data-science/index.html.en)

Also note that

```markdown
<http://testwebsite.com/>
```

is equivalent to

```markdown
[http://testwebsite.com/](http://testwebsite.com/)
```

Navigating through your local folders and files is possible as well.

```markdown
[Go to music](/music/).
```

Before referencing headers or chapter markers you have to label them with `(label)` first.

```markdown
- [Heading](#heading)
- [Chapter](#chapter)
  - [Subchapter <h3 />](#subchapter-h3-)
```

- [Heading](#heading)
- [Chapter](#chapter)
  - [Subchapter <h3 />](#subchapter-h3-)

## Figures

Including pictures from a local or remote source can be done with

```markdown
![excel](https://miro.medium.com/max/624/1*FAzumPnvzKUDolMG7SNcHw.png)
```

![excel](https://miro.medium.com/max/624/1*FAzumPnvzKUDolMG7SNcHw.png)

## Tables

```markdown
| Col1         |   Col2   |          Col3 |
| :----------- | :------: | ------------: |
| Left-aligned | Centered | Right-aligned |
| foo          |   bar    |           baz |
```

| Col1         |   Col2   |          Col3 |
| :----------- | :------: | ------------: |
| Left-aligned | Centered | Right-aligned |
| foo          |   bar    |           baz |
