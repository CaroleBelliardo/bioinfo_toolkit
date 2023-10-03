def append_valueList (dico, key, value_list):
    if key in dico:
        dico[key] = dico[key] + value_list
    else:
        dico[key] = value_list
    return dico



def append_keyDico_valueSet(dico, key,key2, value_set):
    if key in dico:
        if key2 in dico[key]:
            dico[key][key2] = dico[key][key2].union(value_set)
        else:
            dico[key][key2] = value_set
    else:
        dico[key][key2] = value_set
    return dico


