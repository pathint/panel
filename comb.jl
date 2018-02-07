mat = readcsv("mut_matrix.csv", Bool)
n,m = size(mat)

# Biparitie Graphs
# Essentially, this is a minimal set cover problem, which is NP-hard. 
# Two Parts: 395 Samples (Columns), 19098 Genes

#How many genes are mutated per sample
colGenes = map(j->filter(i->mat[i,j], 1:n), 1:m)
colLen = map(length, colGenes)
colLenOrdered = sort(colLen)

# How many samples are covered per genetic muta`tion
rowSamples = map(j->filter(i->mat[j,i], 1:m), 1:n)
rowLen = map(length, rowSamples)
rowLenOrdered = sort(rowLen)

# Greedy algorithm
# at each stage, choose the set that contains the largest number of uncovered elements.
function CoverPanel(mat, maxSize = 100)
    n,m = size(mat)
    panel = []
    panelCoverage = []
    remainGenes = collect(1:n)
    uncoveredSamples = collect(1:m)
    # How many samples are covered per genetic mutation
    rowSamples = map(j->filter(i->mat[j,i], 1:m), 1:n)
    rowLen = map(length, rowSamples)
    rowLenOrdered = sort(rowLen)
    # Start from the mutation with the largest coverage
    currentPos = findin(rowLen, rowLenOrdered[end-200])[1]
    currentInd = currentPos
    for i in 1:maxSize
        if length(uncoveredSamples) == 0
            break
        end
        push!(panel, currentInd)
        currentCover = sum(mat[currentInd, uncoveredSamples])
        uncoveredSamples = filter(k->!mat[currentInd, k], uncoveredSamples)
        println("Cover ", currentCover, " more samples.")
        push!(panelCoverage, currentCover)
        deleteat!(remainGenes, currentPos)
        candidateCover = map(k->sum(mat[k, uncoveredSamples]), remainGenes)
        currentPos = findin(candidateCover, maximum(candidateCover))[1]
        currentInd = remainGenes[currentPos]
    end
    if length(uncoveredSamples) > 0
        println("Uncovered Samples:", uncoveredSamples)
    end
    return panel
end

panel = CoverPanel(mat)

panel2 = CoverPanel(mat)

#Confirmation
result = map(i->sum(mat[panel,i]), 1:m)
minimum(result)

writecsv("panel.csv", panel)




