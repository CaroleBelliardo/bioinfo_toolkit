def append_valueSet(dico, key, value_set):
    if key in dico:
        dico[key] = dico[key].union(value_set)
    else:
        dico[key] = value_set
    return dico
