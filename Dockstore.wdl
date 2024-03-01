version 1.0
task viewRegion {
    input {
        File drs_uri_bam
        File drs_uri_bai
		File bam_file_name
        String region
        Int mem_gb
        Int addtional_disk_size = 100 
        Int machine_mem_size = 15
        Int disk_size = ceil(size(drs_uri_bam, "GB")) + addtional_disk_size
 

    }

	command {
		bash -c "echo ~{drs_uri_bam}; samtools; samtools view ~{drs_uri_bam} -X ~{drs_uri_bai} chrM -b -o ~{bam_file_name}_chrM.extracted.bam"
	}

	output {
		File extractedBam


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
		File bam_file_name
        String region
        Int mem_gb
    }
	call viewRegion { 
		input:
	 drs_uri_bam=drs_uri_bam,
	 drs_uri_bai=drs_uri_bai,
	 bam_file_name=bam_file_name,
	 region=region,
	 mem_gb=mem_gb 
	}
}

#		
