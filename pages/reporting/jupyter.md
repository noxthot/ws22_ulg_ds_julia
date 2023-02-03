@def title = "Jupyter"
@def hascode = false

@def tags = ["reporting"]

# Jupyter

\toc

## Introduction

Jupyter is a web-based interactive environment for creating and running language-agnostic HTML notebook applications. The three core programming languages **Ju**lia, **py**thon, and **R** are installed via so-called kernels. Each cell in a notebook can contain code, text (using GitHub Flavored Markdown), mathematics, plots and even images or videos. They are mainly used for creating and sharing computational documents. Jupyter offers a simple, streamlined, document-centric experience.

## Installation and Kernels

While Jupyter runs code in many programming languages, Python is a requirement for installing the Jupyter Notebook
library. After updating the integrated `pip3` package manager to the latest version with

```bash
pip3 install --upgrade pip
```

install the Jupyter Notebook package.

```bash
pip3 install jupyter
```

The `IPython` kernel comes pre-installed so you can start using Python in notebooks straight away. To run notebooks
in other languages such as Julia or R you have to install additional kernels. A full list of Jupyter kernels is
available here <https://github.com/jupyter/jupyter/wiki/Jupyter-kernels>. For instructions on how to install a new
kernel we refer to the documentation of each individual programming language.

## Basic Steps

Start the notebook server from the command line using

```bash
jupyter notebook
```

This will print some information in your terminal including the URL of the web application. By default this is <http://localhost:8888>. In the dashboard you can start, stop, and create new notebooks or list files and directories.

## Tutorial

Based on the PyTorch tutorial <https://pytorch.org/tutorials/beginner/basics/>.

## Disadvantages

- Version control
- Reproducability
- Running cells in different order
- Missing interactive elements
