# -*- coding: utf-8 -*-
import marimo

__generated_with = "0.3.10"
app = marimo.App()


@app.cell
def __():
    import marimo as mo

    mo.md("""Hello World !""")
    return (mo,)


if __name__ == "__main__":
    app.run()
