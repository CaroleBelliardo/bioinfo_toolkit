from ete3 import Tree
from docopt import docopt
import pandas

from ete3 import Tree
from docopt import docopt
import pandas

def analyze_tree(tree_filename, full_name_studied_gene, node_support):
    global result_nohgt
    global result_hgt
    global result_complex
    global result_unknown

    # Load a tree structure from a newick file
    gene_tree = Tree(tree_filename,format=0)


    if node_support != 0:
        node_supports = []
        for node in gene_tree.traverse("preorder"):
            node_supports.append(node.support)
        if all(i <= 1 for i in node_supports):
            node_support = node_support/100
        for node in gene_tree.traverse("preorder"):
            if "@" not in node.name:
                if node.support < node_support:
                    node.delete()

    no_TOI = True
    only_TOI = True

    # Check if no_TOI or only_TOI to speed up calculations
    for node in gene_tree:
        if "@TOI" in str(node):
            no_TOI = False
        elif "EGP" not in str(node) or "StudiedOrganism" not in str(node):
            only_TOI = False


    if only_TOI:
        return "only_TOI"

    # Root the tree using the midpoint
    R = gene_tree.get_midpoint_outgroup()
    if(R != None):
        gene_tree.set_outgroup(R)

    return analysis(gene_tree, full_name_studied_gene)

def get_sister_classification(gene_tree,full_name_studied_gene,ranks):
    sister_nodes = {}
    sister_nodes["sister"]= []
    sister_nodes["ancestral"]= []
    gene_node = gene_tree.get_leaves_by_name(full_name_studied_gene)[0]
    ancestral_nodes = gene_node.get_ancestors()
    sisters_node_flag = True

    sister_children = []
    for ancestral_node in ancestral_nodes:
        if sisters_node_flag:
            children_old = ancestral_node.get_leaf_names()
            children_new = []
            for child in children_old:
                tc = child.split("@")
                if tc[-1] in ranks:
                    children_new.append(child)
                    sister_children = children_new
                    sisters_node_flag = False
            sister_nodes["sister"] = sister_children
        else:
            children_old = ancestral_node.get_leaf_names()
            children_new = []
            for child in children_old:
                tc = child.split("@")
                if tc[-1] in ranks:
                    children_new.append(child)
            for item in sister_children:
                children_new.remove(item)
            sister_nodes["ancestral"]= children_new
            if len(children_new) > 0:
                break
    sister_nodes_list = []
    #sister_nodes["sister"]=Counter(sister_nodes["sister"])
    #sister_nodes["ancestral"]=Counter(sister_nodes["ancestral"])
    sister_nodes_list = [sister_nodes["sister"], sister_nodes["ancestral"]]

    return sister_nodes_list

def classify_nodes(gene_tree,full_name_studied_gene):

    # Label leaves
    for node in gene_tree.traverse("preorder"):
        if("@" in node.name):
            if "@TOI" in node.name:
                node.name = node.name  + "@T"
            elif "@EGP" in node.name:
                node.name = node.name  + "@E"
            elif("Unknown" in node.name or "Other" in node.name or "Unclassified" in node.name):
                node.name = node.name  + "@U"
            elif full_name_studied_gene in node.name:
                pass
            elif "@StudiedOrganism" in node.name:
                node.name = node.name  + "@E"
            else:
                node.name = node.name  + "@H"

    # Label internal nodes
    for node in gene_tree.traverse("preorder"):
        if("@" not in node.name):
            if(len(node.children)>0):
                children = node.get_leaf_names()
                if len(set(children)) == 1:
                    node.name = set(children).pop()
                else:
                    node.name = node.name  + "@L"

def analysis(gene_tree, full_name_studied_gene):

    global result_nohgt
    global result_hgt
    global result_complex
    global result_unknown

    classify_nodes(gene_tree,full_name_studied_gene)
    node2labels = gene_tree.get_cached_content(store_attr="name")
    def collapsed_leaf(node):
        if len(node2labels[node]) == 1:
            return True
        else:
            return False

    list_of_ranks = ["H", "T"]
    sister_nodes_list = get_sister_classification(gene_tree,full_name_studied_gene,list_of_ranks)
    #sister clade is sister_nodes_list[0]
    #ancestral sister clade is sister_nodes_list[1]

    return(sister_nodes_list)


def analyse_node(nodes,nodeName,gene,groupeNb) :
    dataList = {'gene' : [gene], 'groupe': [groupeNb], 'nodeName' : [nodeName], 'MGY' : [0], 'IMGM': [0], 'IMGMeuk': [0] , 'Eukprot': [0],
                'IMGVR': [0], 'nr' : [0], 'taxoMetag': set(),'taxoNR': set()}

    for node in nodes:
        nodeList = node.split('@')
        Notnr=0

        for d in dataList.keys():
            if nodeList[0].endswith(d):
                tmp=dataList['taxoMetag']
                tmp.add(nodeList[1])
                dataList['taxoMetag'] = tmp
                Notnr+=1

                tmpmeta = dataList[d]
                dataList[d] = [tmpmeta[0] + 1]

        if Notnr == 0 and len(nodeList) > 0:
            tmpnr=dataList['nr']
            dataList['nr'] = [tmpnr[0] + 1]

            tmp = dataList['taxoNR']
            tmp.add(nodeList[1])
            dataList['taxoNR'] = tmp

    dataList['taxoMetag'] = [';'.join(str(e) for e in dataList['taxoMetag'])]
    dataList['taxoNR'] = [';'.join(str(e) for e in dataList['taxoNR'])]


    syster_tab = (pandas.DataFrame(dataList))
    return syster_tab


def run_node_analyse(sister_nodes_list,gene,groupeNb):
    t1 = analyse_node(sister_nodes_list[0], 'sister',gene,groupeNb)
    t2 = analyse_node(sister_nodes_list[1], 'ancestral sister',gene,groupeNb)
    merged = pandas.concat([t1,t2])
    return merged


