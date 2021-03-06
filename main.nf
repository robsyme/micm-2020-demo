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
    publishDir "results/sorted", mode: 'copy'

    input:
    path "unsorted_names.txt"

    output:
    path "sorted_names.txt"

    "sort ${params.reverse_sort ? "-r" : "" } unsorted_names.txt > sorted_names.txt"
}

process SpecialSort {
    publishDir "results/my_sorted", mode: 'copy'

    input:
    path "input_file.txt"

    output:
    path "sorted.txt"

    "my_special_sort.rb ${params.reverse_sort ? "--reverse" : ""} input_file.txt > sorted.txt"
}


params.reverse_sort = false

workflow {
    names = Channel.from(["Rob", "Rhalena", "Audrey", "Sophie", "Michael", "Juan", "Yujing", "Nahid"])

    names | SayHello | collectFile() | SortGreetings

    SayHello.out | collectFile() | SpecialSort
}