# Cancer Gene Panel 

The code implements a greedy algorithm of the "set cover problem". 

The input is a 2-dimensional Boolean array where each row represents a gene while each column represents a sample. The Boolean value reflects whether the gene is mutated in the corresponding sample. 

The function CoverPanel returns the minimum set of genes which cover most (ideally all) of samples, i.e. each sample has at least one mutated gene from the panel.
