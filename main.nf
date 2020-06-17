#!/usr/bin/env nextflow
nextflow.preview.dsl = 2

process SayHello {
    input:
    val name

    output:
    file 'complicated/output/path/*.txt'

    """
    mkdir -p complicated/output/path
    sleep 3
    echo "Hi there, " $name > complicated/output/path/out.txt
    """
}

process SortGreetings {
    memory '2G'
    time '2d'
    cpus 2

    input:
    path "unsorted_names.txt"

    output:
    path "sorted_names.txt"

    "sort unsorted_names.txt > sorted_names.txt"
}


workflow {
    names = Channel.from(["Rob", "Rhalena", "Audrey", "Sophie", "Michael", "Juan", "Yujing", "Nahid"])

    names | SayHello | collectFile() | SortGreetings
}