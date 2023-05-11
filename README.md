Nextflow test

to run pipeline: nextflow main.nf (run this outside of root directory so directory doesn't get cluttered)

- conf: contains additonal nextflow config files aside from the default `nextflow.config`. Need to do `includeConfig params.config` or nextflow won't find it.
- main.nf: pipeline
- modules: directory that contains all the pipeline parts
- nextflow.config: default nextflow config



