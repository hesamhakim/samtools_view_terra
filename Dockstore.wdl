version 1.0
task viewRegion {
    input {
        File bam_or_cram_input
        File bam_or_cram_index
        String region
        Int mem_gb
        Int addtional_disk_size = 100 
        Int machine_mem_size = 15
   		Int disk_size = ceil(size(bam_or_cram_input, "GB")) + addtional_disk_size

    }

	command {
		bash -c "echo ~{bam_or_cram_input}; samtools; samtools view ~{bam_or_cram_input} -X ~{bam_or_cram_index} ~{region} -b -o chrM.extracted.bam"
	}

	output {
		File extractedBam = "chrM.extracted.bam"


	}

	runtime {
		docker: "quay.io/jlanej/mosdepth-docker:sha256:6c31a803fad8ed5873cbd856b057039ced23768cf260d7317c57b0f7a9663e11"
		memory: mem_gb + "GB"
		disks: "local-disk " + disk_size + " HDD"
	}

	meta {
		author: "jlanej"
	}
}

workflow extractRegionWorkflow {
    input {
        File bam_or_cram_input
		File bam_or_cram_index
        String region
        Int mem_gb
    }
	call viewRegion { 
		input:
	 bam_or_cram_input=bam_or_cram_input,
	 bam_or_cram_index=bam_or_cram_index,
	 region=region,
	 mem_gb=mem_gb 
	}
}

#		
