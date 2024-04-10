# -*- coding: utf-8 -*-
import marimo

__generated_with = "0.3.12"
app = marimo.App()


@app.cell
def __():
    import marimo as mo

    mo.md("# PyTorch Hello World")
    return (mo,)


@app.cell
def __():
    import torch

    # basic tensor
    t1 = torch.tensor([1, 2, 3])
    print("t1: one dimension tensor")
    print(f"content: {t1}")
    print(f"shape: {t1.shape}")

    return t1, torch


@app.cell
def __(torch):
    t2 = torch.tensor([[1, 2, 3], [4, 5, 6]])
    print("t2: two dimension tensor")
    print(f"content: {t2}")
    print(f"shape: {t2.shape}")
    return (t2,)


@app.cell
def __():
    return


if __name__ == "__main__":
    app.run()
