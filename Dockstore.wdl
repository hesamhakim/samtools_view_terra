version 1.0
task viewRegion {
    input {
        File drs_uri_bam
        File drs_uri_bai
		String file_bam_name
        String region
        Int mem_gb
        Int addtional_disk_size = 100 
        Int machine_mem_size = 15
        Int disk_size 
 

    }

	command {
		bash -c "echo samtools; samtools view ~{drs_uri_bam} -X ~{drs_uri_bai} chrM -b -o ~{file_bam_name}_chrm.bam"
	}

	output {
		File extractedBam = "~{file_bam_name}_chrm.bam"
	}

	runtime {
		docker: "quay.io/ldcabansay/samtools:latest"
		memory: mem_gb + "GB"
		disks: "local-disk " + disk_size + " HDD"
	}

	meta {
		author: "jlanej"
	}
}

workflow extractRegionWorkflow {
    input {
        File drs_uri_bam
		File drs_uri_bai
		String file_bam_name
        String region
        Int mem_gb
    }
	call viewRegion { 
		input:
	 drs_uri_bam=drs_uri_bam,
	 drs_uri_bai=drs_uri_bai,
	 file_bam_name=file_bam_name,
	 region=region,
	 mem_gb=mem_gb 
	}
	output {
		File output_bam=viewRegion.extractedBam
	}
}

#		
