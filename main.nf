#!/usr/bin/env nextflow
nextflow.preview.dsl = 2

process SayHello {
    input:
    val name

    output:
    file 'out.txt'

    "echo Hello $name > out.txt"
}


workflow {
    names = Channel.from(["Rob", "Rhalena", "Audrey", "Sophie", "Michael", "Juan", "Yujing", "Nahid"])

    names | SayHello | view()
}