import pandas as pd

tabela = pd.read_excel("Cansei.xlsx", engine="openpyxl")
print(tabela)

tabela.loc[tabela["Comida"]=="banana", "Numero"] = 2

tabela.to_excel("Padrão.xlsx", index=False)