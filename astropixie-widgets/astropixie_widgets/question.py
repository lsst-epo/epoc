import ipywidgets

def show_question(questionText, rows=1):
    css = ipywidgets.HTML('<style>.widget-label{white-space:normal; overflow:auto}</style>')
    layout = ipywidgets.Layout(width='95%', height='100%')
    label = ipywidgets.Label(questionText, layout=layout)
    answer = ipywidgets.Textarea(rows=rows, layout=layout)
    box = ipywidgets.VBox(children=[css, label, answer])
    display(box)
