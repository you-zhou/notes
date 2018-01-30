# To-Do
## Matplotlib
- [ ] plt.subplots() with sharex=True could not plot datetime64 format in all axis-x
~~~python
fig, axes = plt.subplots(nrows=math.ceil(total_graphs / graph_columns), 
                         ncols=graph_columns, figsize=(40, 100), 
                         sharex=True)
~~~
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTEwNDU2NTU2OV19
-->